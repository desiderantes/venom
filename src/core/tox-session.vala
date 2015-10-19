/* -*- Mode: vala; tab-width: 4; intend-tabs-mode: t -*- */
/* tox-session.c
 * tox-session.vala
 * This file is part of Venom
 * Copyright (C) 2015 Venom authors
 * Venom is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Venom is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
using ToxCore;
using GLib;
using Gee;

namespace Venom{
	public class ToxSession : GLib.Object{
	
		private ToxCore.Tox? handle;
		private ToxCore.Options? options;
		private bool running = false;
		private bool is_connected = false;
		private static string default_dht_host = "urotukok.net";
		private static uint8 default_dht_pubkey[ToxCore.PUBLIC_KEY_SIZE] = {0x00,0x95,
			0xFC,0x11,0xA6,0x24,0xEE,0xF1,0xF3,0x52,0x7D,0x36,0x7D,0xC0,0xAC,0xD1,0x0A,
			0xC8,0x32,0x9C,0x99,0x31,0x95,0x13};
		private static uint16 default_dht_port = 33445;
		private GLib.Cancellable cancellable;
		private Gee.HashMap<uint32, Contact> contact_map;
		private DHTNode[] servers;
		public OwnProfile own_profile;
		public ToxSession( Gee.HashMap<uint32, Contact> contact_map, uint8[]? savedata = null, bool encrypted = false){
			try{
				options = ToxCore.Options.create();
			}catch (ToxCore.OptionError err){
				GLib.error(err.message);
			}
			assert(options != null);
			this.contact_map = contact_map;
			options.ipv6_enabled = true;
			options.savedata_data = savedata;
			options.savedata_type= savedata==null ? SavedataType.NONE : ( encrypted? SavedataType.SECRET_KEY : SavedataType.TOX_SAVE);
			try{
				handle = Tox.create(options);	
			} catch(ConstructError err){
				GLib.error(err.message);
			}
			assert(handle!=null);
			cancellable = new GLib.Cancellable();
			cancellable.connect(()=>{
				running = false;
				is_connected = false;
			});
			init_profile();
			init_contacts();
			init_callbacks();
			
			bootstrap();
			
		}
		
		public void bootstrap(){
			lock(handle){
				foreach(DHTNode node in servers){
					try{
						handle.bootstrap(node.ipv4 ?? (node.ipv6 ?? "localhost"), node.port, node.pubkey);
					}catch (BootstrapError err){
						GLib.warning(err.message);
					}
				}
			}
		}
		
		public async void run(){
			running = true;
			is_connected = true;
			while(!cancellable.is_cancelled()){
				lock(handle) {
					handle.iterate();
				}
				Thread.usleep(handle.iteration_interval()*1000);
			}
			yield;
		}
		
		public void stop(){
			cancellable.cancel();
		}
		
		public void init_profile(){
			lock(handle){
				own_profile.address = bin2str(handle.get_address());
				own_profile.user_status = handle.status;
				own_profile.name = handle.get_name();
				own_profile.name.normalize();
				own_profile.status=handle.get_status_message();
			}
		}
		
		public void init_contacts(){
			lock(handle){
				uint32[] friend_arr =handle.get_friend_list();
				foreach (uint32 num in friend_arr){
					Contact contact;
					try{
						contact = new Contact(num, handle.get_friend_public_key(num));
						
					}catch (FriendGetError err){
						GLib.error(err.message);
					}
					try{
						contact.last_seen = new DateTime.from_unix_utc((int64)handle.get_friend_last_online(num));
					}catch(FriendGetError err){
						GLib.error(err.message);
					}
					try{
						contact.name = handle.get_friend_name(num);
					}catch(FriendGetError err){
						GLib.error(err.message);
					}
					try{
						contact.status_message = handle.get_friend_status_message(num);
					}catch(FriendGetError err){
						GLib.error(err.message);
					}
					contact_map.set(num,contact);				
				}
			}
		}	
		public void init_callbacks(){
			handle.connection_status_callback(this.connection_status_cb);
			handle.friend_name_callback(this.friend_name_cb);
			handle.friend_status_callback(this.friend_status_cb);
			handle.friend_status_message_callback(this.friend_status_message_cb);
			handle.friend_connection_status_callback(this.friend_connection_status_cb);
			handle.friend_typing_callback(this.friend_typing_cb);
			handle.friend_read_receipt_callback(this.read_receipt_cb);
		}
		
		/*
		 * :: Callbacks
		 */
		public void connection_status_cb(Tox handle, ConnectionStatus connection_status){
			this.running= connection_status != ConnectionStatus.NONE;
			this.own_profile.connection_status = connection_status;
		}
	
		public void friend_name_cb(Tox handle, uint32 friend_number, uint8[] name_array){
			contact_map.get(friend_number).name = ToxCore.arr2str(name_array);
			
			
		}
		
		public void friend_status_cb(Tox handle, uint32 friend_number, UserStatus status){
			contact_map.get(friend_number).user_status = status;
		}
		
		public void friend_status_message_cb(Tox handle, uint32 friend_number, uint8[] message_array){
			contact_map.get(friend_number).status_message = ToxCore.arr2str(message_array);
		}
		
		public void friend_connection_status_cb(Tox handle, uint32 friend_number, ConnectionStatus status){
			contact_map.get(friend_number).connection_status = status;
		}
		
		public void friend_typing_cb(Tox handle, uint32 friend_number, bool is_typing){
			contact_map.get(friend_number).is_typing = is_typing;
		}
		
		public void read_receipt_cb(Tox handle, uint32 friend_number, uint32 message_id){
	
		}
		
	}
}


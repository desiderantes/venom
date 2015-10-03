/* -*- Mode: vala; tab-width: 4; intend-tabs-mode: t -*- */
/* contact.c
 * contact.vala
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
using GLib;
using ToxCore;

namespace Venom{
	public class Contact : GLib.Object{
	
		private uint8[] _address = new uint8[ToxCore.ADDRESS_SIZE];
		public uint8[] address{get{
									return this._address;
								}}
		public string name{get;set;default = "";}
		public uint32 friend_number{get;private set;}
		public string status_message{get;set; default = "";}
		public DateTime last_seen{get;set;}
		public UserStatus user_status{get;set;default = UserStatus.NONE;}
		public ConnectionStatus connection_status{get;set;}
		public Gdk.Pixbuf? avatar{get;set;}
		public string alias{get;set;default="";}
		public bool is_typing{get;set;default=false;}
		public bool is_silenced{get;set;default=false;}
		
		
		public Contact(uint8[ToxCore.ADDRESS_SIZE] address, uint32 friend_number){
			this._address = address;
			this.friend_number = friend_number;
		}
		
	}

}

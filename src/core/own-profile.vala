/* -*- Mode: vala; tab-width: 4; intend-tabs-mode: t -*- */
/* own-profile.c
 * own-profile.vala
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
	public class OwnProfile : GLib.Object{
		public string name{get;set;}
		public string status{get;set;}
		public Gdk.Pixbuf? avatar{get;set;}
		public string address;
		public ToxCore.UserStatus user_status{get;set;}
		
		
		private OwnProfile(){
			this.name="Doodaloo";
			this.status="Forking you big repo with my dongle";
			try{
				this.avatar = new Gdk.Pixbuf.from_file_at_scale("dongle.png", 48, 48, true);
			}catch(Error err){
				GLib.error(err.message);
			}
		}
		
		
	}


}

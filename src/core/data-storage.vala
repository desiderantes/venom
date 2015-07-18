/* -*- Mode: vala; tab-width: 4; intend-tabs-mode: t -*- */
/* data-storage.c
 * data-storage.vala
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
namespace Venom{
	public class DataStorage : GLib.Object{
		public static string TOX_PATH = "";
		public static void load_convarsations(){
		
		}
		
		public static DHTNode[] get_servers(){
			Gee.ArrayList<DHTNode> servers = new Gee.ArrayList<DHTNode>();
			Json.Parser parser = new Json.Parser ();
			try {
				parser.load_from_file (data);

				// Get the root node:
				Json.Node node = parser.get_root ();
				unowned Json.Array array = node.get_object().get_member("servers").get_object().
				foreach (unowned Json.Node item in array.get_elements ()) {
					unowned Json.Object obj = item.get_object ();
					DHTNode server = new DHTNode (obj.get_string_member ("pubkey"), obj.get_string_member ("ipv4"), obj.get_string_member ("ipv6"), (uint16)obj.get_int_member ("port"), obj.get_string_member ("owner"));
					servers.add(server);
				}
			} catch (Error e) {
				GLib.error ("Unable to parse the string: %s\n", e.message);
			}
		}		
	}
}

/* -*- Mode: vala; tab-width: 4; intend-tabs-mode: t -*- */
/* dht-node.c
 * dht-node.vala
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
	public class DHTNode : GLib.Object{
		public uint8[ToxCore.PUBLIC_KEY_SIZE] pubkey;
		public string? ipv4;
		public string? ipv6;
		public uint16 port;
		public string owner;
		public DHTNode(string pubkey, string? ipv4, string? ipv6, uint16 port, string owner){
			this.host = host;
			this.port = port;
			this.pubkey = str2bin(pubkey);
			this.owner = owner; 
		}
	}
 
}

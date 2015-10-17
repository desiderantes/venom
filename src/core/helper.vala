/* -*- Mode: vala; tab-width: 4; intend-tabs-mode: t -*- */
/* helper.c
 * helper.vala
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
	
	
	public uint8[] str2bin(string address_string)requires(address_string.data.length %2 == 0){
		var data = address_string.to_utf8();
		int i =0;
		int j = 0;
		var retval = new uint8[data.length /2];
		for( i = 0; i < data.length; i+=2, j++){
			char c = data[i];
			int val1 = c.xdigit_value() << 4;
			c = data[i+1];
			val1+= c.xdigit_value();
			retval[j] =(uint8) val1;
		}
		return retval;
	}
	
	public string bin2str(uint8[] address){
		var sb = new StringBuilder();
		
		foreach( uint8 data in address){
			string str = "%02x".printf(data);
			sb.append(str);
		}
		var retval = (string) sb.data;
		retval.up();
		return retval;		
	}
		
}

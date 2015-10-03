/* -*- Mode: vala; tab-width: 4; intend-tabs-mode: t -*- */
/* client-window.c
 * client-window.vala
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
	
	[GtkTemplate (ui = "/chat/tox/venom/ui/client-window.ui")]
	public class ClientWindow : Gtk.ApplicationWindow{
	
		[GtkChild]
		private Gtk.Image avatar_image;
		[GtkChild]
		private Gtk.Label username_label;
		[GtkChild]
		private Gtk.Button userstatus_button;
		[GtkChild]
		private Gtk.ComboBox status_combobox;
		[GtkChild]
		private Gtk.Spinner status_spinner;
		
		private Gtk.ComboBoxText status_filter;
		private Gtk.ComboBoxText conversation_filter;
		[GtkChild]
		private Gtk.SearchEntry contacts_search;

		[GtkChild]
		private Gtk.Button add_button;
		[GtkChild]
		private Gtk.Button groupchat_button;
		[GtkChild]
		private Gtk.Button filetransfer_button;
		[GtkChild]
		private Gtk.MenuButton options_button;
		[GtkChild]
		private Gtk.MenuButton avatar_button;
		[GtkChild]
		private Gtk.Box main_box;
		[GtkChild]
		private Gtk.Stack conversation_stack;
		[GtkChild]
		private Gtk.StackSwitcher view_changer;
		private Gtk.Popover userstatus_popover;
		private Gtk.Popover add_contact_popover;
		private Gtk.Popover preferences_popover;
		private OwnProfile profile;
		
		public ClientWindow(VenomApp app){
			
			this.set_application(app);
			setup_lists();
			
			this.profile = OwnProfile.instance;
			
			setup_profile();
		}
		
		private void setup_lists(){
			
			
		}
		
		private void setup_profile(){
			username_label.set_text(profile.name);
			userstatus_button.label= profile.status;
			avatar_image.set_from_pixbuf(profile.avatar);
		}
		
		public void search_text_changed () {
			var text = contacts_search.get_text ();

			if (text == "")
				return;

		}
		
	}

}

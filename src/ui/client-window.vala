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
	
	[GtkTemplate (ui = "/im/tox/venom/ui/client-window.ui")]
	public class ClientWindow : Gtk.ApplicationWindow{
	
		private Gtk.StatusIcon tray_icon;
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
		[GtkChild]
		private Gtk.ComboBoxText statusfilter_combobox;
		[GtkChild]
		private Gtk.SearchEntry contacts_searchentry;

		[GtkChild]
		private Gtk.Button add_button;
		[GtkChild]
		private Gtk.Button groupchat_button;
		[GtkChild]
		private Gtk.Button filetransfer_button;
		[GtkChild]
		private Gtk.Button preferences_button;
		[GtkChild]
		private Gtk.ScrolledWindow contactstack_container;
		[GtkChild]
		private Gtk.Revealer conversation_revealer;
		private Gtk.Stack conversation_stack;
		private Gtk.StackSwitcher contact_list;
		private Gtk.Popover userstatus_popover;
		private Gtk.Popover add_contact_popover;
		private Gtk.Popover preferences_popover;
		
		public ClientWindow(VenomApp app){
			this.set_application(app);
			contactstack_container.add(contact_list);
			conversation_revealer.add(conversation_stack);
			conversation_stack = new Gtk.Stack();
			conversation_stack.add(new ConversationWidget());
			contact_list = new Gtk.StackSwitcher();
			contact_list.set_stack(conversation_stack);
		}
		
	}

}

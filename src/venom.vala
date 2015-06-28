/* -*- Mode: vala; tab-width: 4; intend-tabs-mode: t -*- */
/* venom.c
 * venom.vala
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
	public class Options : Object{
		public static string? datafile = null;
		public static bool offline = false;
		public static bool version = false;
		public static bool no_single = false;
		public const OptionEntry[] option_entries = {
	    	{ "file", 'f', 0, OptionArg.FILENAME, ref datafile, 
				_("Set the location of the tox data file"), "<file>" },
			{ "offline" , 0  , 0, OptionArg.NONE, ref offline, 
				_("Start in offline mode"), null },
			{ "version" , 0, 0, OptionArg.NONE, ref version, 
				_("Display version number"), null },
			{ "no-single" , 0, 0, OptionArg.NONE, ref no_single, 
				_("Start as another instance even if there is a current instance running"), null },
			{ null }
		};
		public Options(){
			opt_context = new OptionContext ("Venom");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (entries, "venom");
			opt_context.add_group(Gtk.get_option_group(true));
		
	}
	
	
	public class Venom : Gtk.Application{
		
		private Options opts;
		public Venom () {
			Object(
				application_id: "im.tox.venom",
				flags: GLib.ApplicationFlags.HANDLES_OPEN
			);
			opts = new Options();
		}
        
		public Venom.with_options(Options opt){
			Object(
				application_id: "im.tox.venom",
				flags: GLib.ApplicationFlags.HANDLES_OPEN
			);
			opts = opt;
		}
		protected override void startup() {
			add_action_entries(app_entries, this);
			base.startup();
		}
		protected override void activate() {
			hold();
			var window = get_contact_list_window();
			window.incoming_message.connect(show_notification_for_message);
			window.incoming_group_message.connect(show_notification_for_message);
			window.incoming_action.connect(show_notification_for_message);
			window.incoming_group_action.connect(show_notification_for_message);
			window.present();
			release();
		}

		protected override void open(GLib.File[] files, string hint) {
			hold();
			get_contact_list_window().present();
			//FIXME allow names without tox:// prefix on command line
			contact_list_window.add_contact(files[0].get_uri());
			release();
		}    

		public static int main (string[] args) {
			GLib.Intl.textdomain(Config.GETTEXT_PACKAGE);
			GLib.Intl.bindtextdomain(Config.GETTEXT_PACKAGE, Config.PACKAGE_LOCALE_DIR);
			Environment.set_application_name(Config.GETTEXT_PACKAGE);
			Gtk.init(ref args);
			Gst.init(ref args);
			Options opts = new Options();
			try {
				opts.parse (args);
			} catch (OptionError e) {
				stdout.printf ("error: %s\n", e.message);
				stdout.printf (
				               _("Run '%s --help' to see a full list of available command line options.\n"),
				               args[0]);
				return 0;
			}

			if (opts.version) {
				stdout.printf("Venom (%s) - a Gtk+ Tox client ", Config.VERSION);
				stdout.printf("Copyright © Venom authors, see AUTHORS file for a complete list");
				return 0;
			}

			var venom = new Venom.with_options(opts);
			return venom.run();

		}
	}
}

/* -*- Mode: vala; tab-width: 4; intend-tabs-mode: t -*- */
/* venom-app.c
 * venom-app.vala
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
		public string? datafile;
		public bool offline;
		public bool version;
		public bool no_single;
		public OptionContext opt_context;
		public OptionEntry entries[5];
		public Options(){
			datafile=null;
			offline=false;
			version=false;
			no_single=false;
			entries[0] = { "file", 'f', 0, OptionArg.FILENAME, ref datafile, 
							_("Run using an specific tox data file"), "<file>" };
			entries[1]=	{ "offline" , 0  , 0, OptionArg.NONE, ref offline, 
							_("Start in offline mode"), null };
			entries[2]=	{ "version" , 0, 0, OptionArg.NONE, ref version, 
						_("Display version number"), null };
			entries[3] =	{ "no-single" , 0, 0, OptionArg.NONE, ref no_single, 
						_("Start as another instance even if there is a current instance running"), null };
			entries[4] = {null};
			
			opt_context = new OptionContext ("Venom");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (entries, "venom");
			opt_context.add_group(Gtk.get_option_group(true));
		}
		public void parse(string[] args)throws OptionError{
			try{
				opt_context.parse(ref args);
			}catch(OptionError e){
				throw e;
			}
		}
	}
	;
	
	public class VenomApp : Gtk.Application{
		private ClientWindow window;
		private Options opts;
		private ToxSession tox_session;
		public VenomApp () {
			Object(
				application_id: "im.tox.venom",
				flags: GLib.ApplicationFlags.HANDLES_OPEN
			);
			opts = new Options();
		}
        
		public VenomApp.with_options(Options opt){
			Object(
				application_id: "im.tox.venom",
				flags: GLib.ApplicationFlags.HANDLES_OPEN
			);
			opts = opt;
		}
		protected override void startup() {
			
			var action = new GLib.SimpleAction ("quit", null);
			action.activate.connect (quit);
			add_action (action);
			add_accelerator ("<Ctrl>Q", "app.quit", null);
			action = new GLib.SimpleAction ("add-contact", null);
			//action.activate.connect ();
			add_action (action);
			add_accelerator ("<Ctrl>A", "app.add-contact", null);
			
			Gtk.Settings.get_default().gtk_application_prefer_dark_theme=true;
			base.startup();
		}
		protected override void activate() {
			hold();
			if(window == null){
				window = new ClientWindow(this);
			}
			window.present();
			release();
		}

		protected override void open(GLib.File[] files, string hint) {
			hold();
			window.present();
			//FIXME allow names without tox:// prefix on command line
			foreach(File file in files){
				
			}
			release();
		}    

		public static int main (string[] args) {
			GLib.Intl.textdomain(Config.GETTEXT_PACKAGE);
			Environment.set_application_name(Config.EXEC_NAME);
			Gtk.init(ref args);
			//Gst.init(ref args);
			Options opts = new Options();
			try {
				opts.parse (args);
			} catch (OptionError e) {
				stdout.printf ("error: %s\n", e.message);
				stdout.printf (
					_("Run '%s --help' to see a full list of available command line options.\n"),
					Config.EXEC_NAME);
				return 0;
			}

			if (opts.version) {
				stdout.printf("Venom (%s) - a Gtk+ Tox client ", Config.VERSION);
				stdout.printf("Copyright © Venom authors, see AUTHORS file for a complete list");
				return 0;
			}

			var venom = new VenomApp.with_options(opts);
			return venom.run();

		}
	}
}

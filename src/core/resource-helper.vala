using GLib;

namespace Venom {
	public class ResourceHelper : Object {
		private static ResourceHelper _instance = null;
		private HashTable<string, Gdk.Pixbuf?> avatar_resources;
		public static ResourceHelper instance{
			get{
				if(_instance == null){
					lock(_instance){
						if(_instance == null){
							_instance = new ResourceHelper();
						}			
					}
				}
				return _instance;
			}
		}
		
		
		private ResourceHelper(){
			this.avatar_resources = new HashTable<string, Gdk.Pixbuf?>();
		}
		
		public unowned Gdk.Pixbuf? get_avatar_buf(string contact_address){
			if(avatar_resources.get(contact_address) == null){
				string path = GLib.Path.build_filename(GLib.Environment.get_user_config_dir(), "tox", "avatar", contact_address + ".png");
				Gdk.Pixbuf? pixbuf;
				try {
					pixbuf = new Gdk.Pixbuf.from_file(path);
				} catch(Error e){
					warning("Unable to load avatar for contact" + contact_address);
					return null;
				}
				avatar_resources.set(contact_address, pixbuf);
				return pixbuf;
			}
		}

	}

}

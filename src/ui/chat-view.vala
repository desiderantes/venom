
namespace Venom{
	public class ChatView : Gtk.TextView{
	
		public override bool button_press_event(Gdk.EventButton evt){
			int bx;
			int by;

			if (evt.button != 1 || buffer == null) {
				return base.button_press_event(evt);
			}

			Gtk.TextIter iter;
			window_to_buffer_coords(Gtk.TextWindowType.TEXT, (int)evt.x, (int)evt.y, out bx, out by);
			this.get_iter_at_location(out iter, bx, by);
			foreach (var tag in iter.get_tags()) {
				string uri = tag.get_data("_uri");
				if (uri != null) {
					try {
					AppInfo.launch_default_for_uri(uri, null);
					} catch (Error e) {
						warning("Unable to launch URI: %s", e.message);
					}
				break;
				}
			}
			return base.button_press_event(evt);
		}
	
	}

}

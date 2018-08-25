/*
* Copyright (c) 2018 FriendOfEntropy (https://github.com/FriendOfEntropy/postapocrpgtools)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU LESSER GENERAL PUBLIC 
* LICENSE as published by the Free Software Foundation; either
* version 3 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: FriendOfEntropy <FriendOfEntropy@gmail.com>
*/

namespace PostApocRPGTools { 

	public class Application : Gtk.Application {
		public static GLib.Settings settings;

		private MainWindow? mainWindow = null;

		construct {
			application_id = "com.github.friendofentropy.postapocrpgtools";
			//  settings = new Settings ("com.github.friendofentropy.postapocrpgtools");
		}

		public static int main (string[] args) {
			Gtk.init(ref args);
			Application app = new Application ();
			return app.run (args);
		}

		public override void activate () {
			if (mainWindow != null) {
				mainWindow.present ();
			} 
			else {
				mainWindow = new MainWindow ();
 
				//  int window_x = settings.get_int ("window-x");
				//  int window_y = settings.get_int ("window-y");

				//  if (window_x != -1 ||  window_y != -1) {
				//  	mainWindow.move (window_x, window_y);
				//  }

				add_window (mainWindow);
				mainWindow.show_all ();
			}

			SimpleAction quitAction = new SimpleAction ("quit", null);

			add_action (quitAction);
			set_accels_for_action ("app.quit", {"Escape"});

			quitAction.activate.connect (() => {
				if (mainWindow != null) {
					mainWindow.destroy ();
				}
			});			
		}

		public static bool supports_gtk_322 () {
			return Gtk.check_version (3, 22, 0) == null;
		}

	}
}
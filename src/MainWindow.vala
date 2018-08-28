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

using Granite;
using PostApocRPGTools.Views;

namespace PostApocRPGTools { 

	public static void set_widget_visible (Gtk.Widget widget, bool visible) {
		if (visible) {
			widget.no_show_all = false;
			widget.show_all ();
		} 
		else {
			widget.no_show_all = true;
			widget.hide ();
		}
}

	public class MainWindow : Gtk.Window {
		private Widgets.SourceList mainMenuSourceList; 
		private Gtk.Stack stack;

		private CharacterGeneratorView characterGeneratorView;

		private const string MAIN_GRID_ID = "main-grid";

		construct {
			mainMenuSourceList = new Widgets.SourceList ();
			mainMenuSourceList.item_selected.connect (on_item_selected);

			var leftBar = new Gtk.Grid ();
			leftBar.attach (mainMenuSourceList, 0, 0, 1, 1);
			//sidebar.attach (action_bar, 0, 1, 1, 1);

			var characterCategory = new Widgets.SourceList.ExpandableItem ("Characters");
			//var diceCategory = new Widgets.SourceList.ExpandableItem ("Dice");

			var mutantItem = new Widgets.SourceList.Item ("Mutant");
			try {
				mutantItem.icon = new Gdk.Pixbuf.from_resource("/data/icons/mainmenu/biohazard.png");
			}
			catch (Error er) {
				//mutantItem.name = er.message;
			}

			characterCategory.add (mutantItem);
			
			//  var diceItem = new Widgets.SourceList.Item ("Dice");
			//  diceCategory.add (diceItem);   
			//  diceItem.selectable = false;     

			//  var rangeItem = new Widgets.SourceList.Item ("Range");
			//  diceCategory.add (rangeItem); 
			//  rangeItem.selectable = false;

			//  try {
			//  	diceItem.icon = new Gdk.Pixbuf.from_resource("/data/icons/mainmenu/rollingdice.png");
			//  }
			//  catch (Error er) {
			//  	//mutantItem.name = er.message;
			//  }
			
			//  try {
			//  	rangeItem.icon = new Gdk.Pixbuf.from_resource("/data/icons/mainmenu/d20.png");
			//  }
			//  catch (Error er) {
			//  	//mutantItem.name = er.message;
			//  }

			var root = mainMenuSourceList.root;
			root.add (characterCategory);
			//root.add (diceCategory);

			characterGeneratorView = new CharacterGeneratorView ();

			var paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
			paned.width_request = 250;
			paned.position = 240;
			paned.hexpand = true;
			paned.pack1 (leftBar, false, false);
			paned.pack2 (characterGeneratorView, true, false);

			var mainGrid = new Gtk.Grid ();
			mainGrid.attach (new Gtk.Separator (Gtk.Orientation.HORIZONTAL), 0, 0, 1, 1);
			mainGrid.attach (paned, 0, 1, 1, 1);
			mainGrid.show_all ();	

			stack = new Gtk.Stack ();
			stack.add_named (mainGrid, MAIN_GRID_ID);
			stack.transition_type = Gtk.StackTransitionType.CROSSFADE;

			add (stack);

		}

		public MainWindow () {
			Object (
				title: Constants.APP_NAME,
				width_request: 1000,
				height_request: 700
			);
	
		}

		private void on_item_selected (Widgets.SourceList.Item? item)  {
			if (item != null ) {
				// prep children
			}
		}

	}
}

				//  string[] resourceArray = resources_enumerate_children ("/data/icons", ResourceLookupFlags.NONE);				
				//  StringBuilder sb = new StringBuilder();
				//  foreach (string resName in resourceArray) {
				//  	sb.append(resName + "\n");
				//  }
				//  Gtk.MessageDialog msg = new Gtk.MessageDialog (this, Gtk.DialogFlags.MODAL, Gtk.MessageType.WARNING, Gtk.ButtonsType.OK_CANCEL, sb.str);
				//  msg.response.connect ((response_id) => {
				//  	msg.destroy();
				//  });
				//  msg.show ();
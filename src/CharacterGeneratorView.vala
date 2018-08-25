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

using Gtk;
using WebKit;
using Granite;

namespace PostApocRPGTools {
	public class CharacterGeneratorView : Gtk.Box {
		public signal void generated ();
		public signal void saved ();

		private WebView webView = new WebView ();
		private Gtk.Button saveButton;
		private Gtk.Button rollButton;
		private ScrolledWindow scrolledWindow;
		private Widgets.Toast toast;
		private Gtk.Overlay overlay;
		private Gtk.Label errorLabel;
		private Gtk.InfoBar errorInfoBar;
		private Gtk.SizeGroup sizeGroup;
		private Gtk.Box buttonBox;
		private Gtk.Box bottomBox;
		private unowned Gtk.Container content;

		construct {
			webView = new WebView ();
			webView.expand = true;
			
			scrolledWindow = new ScrolledWindow (null, null);
			scrolledWindow.expand = true;
			scrolledWindow.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
			scrolledWindow.add (this.webView);
			
			toast = new Widgets.Toast ("");
			toast.halign = Gtk.Align.END;

			overlay = new Gtk.Overlay ();
			overlay.expand = true;
			overlay.add (scrolledWindow);
			overlay.add_overlay (toast);

			errorLabel = new Gtk.Label (null);
			errorLabel.wrap = true;
			errorLabel.wrap_mode = Pango.WrapMode.WORD_CHAR;
			errorLabel.show_all ();

			errorInfoBar = new Gtk.InfoBar ();
			errorInfoBar.message_type = Gtk.MessageType.ERROR;
			errorInfoBar.show_close_button = true;
			errorInfoBar.response.connect (() => set_widget_visible (errorInfoBar, false));
			set_widget_visible (errorInfoBar, false);

			//content = errorInfoBar.get_content_area ();
			//content.add (errorLabel);

			rollButton = new Gtk.Button.with_label (_("Roll"));
			rollButton.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
			rollButton.sensitive = true;
			rollButton.clicked.connect (() => roll_mutant.begin ());

			saveButton = new Gtk.Button.with_label (_("Save"));
			//saveButton.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
			saveButton.sensitive = false;
			saveButton.clicked.connect (() => save.begin ());

			sizeGroup = new Gtk.SizeGroup (Gtk.SizeGroupMode.HORIZONTAL);
			sizeGroup.add_widget (rollButton);
			sizeGroup.add_widget (saveButton);


			buttonBox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
			buttonBox.margin = 6;
			buttonBox.pack_start (rollButton, false, false);
			buttonBox.pack_end (saveButton, false, false);

			bottomBox = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
			bottomBox.hexpand = true;
			bottomBox.add (new Gtk.Separator (Gtk.Orientation.HORIZONTAL));
			bottomBox.add (buttonBox);			


			orientation = Gtk.Orientation.VERTICAL;

			pack_start (errorInfoBar, false, false);
			pack_start (overlay, true, true);
			pack_end (bottomBox, false, false);

		}

		public async void save (bool silent = false) {
			try {
				toast.title = _("Changes successfully saved");
				saveButton.get_style_context ().remove_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
				saveButton.sensitive = false;
				rollButton.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
				toast.send_notification ();
			}
			catch (Error e) {
				set_widget_visible (errorInfoBar, true);
				errorLabel.label = _("Unable to save changes: %s".printf (e.message));
			}
		}

		public async void roll_mutant (bool silent = false) {
			try {
				File resource = File.new_for_uri ("resource:///data/test.html");
				if (resource.query_exists ()) {
					uint8[] contents;
					string etag_out;
					resource.load_contents (null, out contents, out etag_out);
					webView.load_html((string) contents, null);
					saveButton.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
					saveButton.sensitive = true;
					rollButton.get_style_context ().remove_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
				}
			}
			catch (Error e) {
				set_widget_visible (content, true);
				errorLabel.label = _("Error generating mutant: %s".printf (e.message));
			}
		}

	}
}
using Gtk;
using Gee;
//using Gsl;
using WebKit;
using Granite;
//using RPGCore;
//using GXml;


public class Application : Gtk.ApplicationWindow {
    private Gtk.Button rollButton;
    private WebView web_view;
    private Widgets.SourceList source_list;

    public Application () {

        // Prepare Gtk.Window:
        this.title = "My Gtk.TextView";
        this.window_position = Gtk.WindowPosition.CENTER;
        this.destroy.connect (Gtk.main_quit);
        this.set_default_size (800, 600);

        var character_category = new Widgets.SourceList.ExpandableItem ("Characters");
        var dice_category = new Widgets.SourceList.ExpandableItem ("Dice");

        var mutant_item = new Widgets.SourceList.Item ("Mutant");
        character_category.add (mutant_item);

        var dice_item = new Widgets.SourceList.Item ("Dice");
        dice_category.add (dice_item);        

        var range_item = new Widgets.SourceList.Item ("Range");
        dice_category.add (range_item);        

        source_list = new Widgets.SourceList ();

        var root = source_list.root;
        root.add (character_category);
        root.add (dice_category);

        Gtk.Grid webKitGrid = new Gtk.Grid();  // Create a table.
        web_view = new WebView ();
        web_view.hexpand = true;
        web_view.vexpand = true;
        var scrolled_window = new ScrolledWindow (null, null);
        scrolled_window.hexpand = true;
        scrolled_window.vexpand = true;        
        scrolled_window.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        scrolled_window.add (this.web_view);
        webKitGrid.attach(scrolled_window, 0, 0, 5, 5);

        rollButton = new Gtk.Button.with_label ("Roll");
        rollButton.hexpand = false;
        rollButton.vexpand = false;
        rollButton.margin = 10;
        rollButton.clicked.connect (on_rollButton_clicked);
        webKitGrid.attach(rollButton, 2, 5, 1, 1);

        var pane = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
        pane.pack1 (source_list, false, false);
        pane.pack2 (webKitGrid, true, false);

        this.add (pane);
    }

    public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
    }

    private void on_rollButton_clicked () {
      File resource;
      resource = File.new_for_uri ("resource:///data/test.html");
      if (resource.query_exists ()) {
        try {
          uint8[] contents;
          string etag_out;
          resource.load_contents (null, out contents, out etag_out);
          this.web_view.load_html((string) contents, null);
        } 
        catch (Error e) {
          print ("Error: %s\n", e.message);
        }
      } 
      else {
          print ("Could not find resource file\n");
      }
    }
}
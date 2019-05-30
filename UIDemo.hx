
import com.chaos.data.DataProvider;
import com.chaos.drawing.Draw;
import com.chaos.drawing.icon.ArrowRightIcon;
import com.chaos.drawing.icon.StopIcon;
import com.chaos.form.ui.InputField;
import com.chaos.form.ui.RadioButtonList;
import com.chaos.ui.Alert;
import com.chaos.ui.Button;
import com.chaos.ui.CheckBoxGroup;
import com.chaos.ui.ComboBox;
import com.chaos.ui.TextInput;
//import com.chaos.ui.Interface.IButton;
import com.chaos.ui.data.ComboBoxObjectData;
import com.chaos.ui.data.ItemPaneObjectData;
import com.chaos.ui.data.ListObjectData;
import com.chaos.ui.data.MenuItemObjectData;
import com.chaos.ui.event.WindowEvent;
import com.chaos.ui.ItemPane;
import com.chaos.ui.Label;
import com.chaos.ui.ListBox;
import com.chaos.ui.Menu;
import com.chaos.ui.ProgressBar;
import com.chaos.ui.ProgressSlider;
import com.chaos.ui.RadioGroup;
import com.chaos.ui.ScrollBar;
import com.chaos.ui.ScrollContent;
import com.chaos.ui.ScrollPane;
import com.chaos.ui.Slider;
import com.chaos.ui.TabPane;
import com.chaos.ui.ToggleButtonLite;
import com.chaos.ui.ToolTip;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.Window;
import com.chaos.utils.ThreadManager;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.text.TextField;

/**
 * ...
 * @author Erick Feiling
 */
class UIDemo extends Sprite
{
    public var OFFSET : Int = 20;
    
    public var GANGSTA_TEXT : String = "Lorem fizzle dolizzle own yo' amizzle, consectetuer adipiscing gangster. Nullizzle sapizzle fo shizzle, uhuh ... yih! shut the shizzle up, suscipizzle quis, you son of a bizzle vel, arcu. Pellentesque for sure its fo rizzle. Sizzle erizzle. Dang izzle dolizzle dapibus the bizzle tempus shizznit. Maurizzle pellentesque nibh et turpis. Pimpin' in i saw beyonces tizzles and my pizzle went crizzle. Pellentesque eleifend rhoncizzle nisi. In yippiyo break yo neck, yall platea dictumst. The bizzle dapibizzle. Curabitur daahng dawg shut the shizzle up, pretizzle own yo', mattizzle ac, eleifend check it out, nunc. Rizzle suscipizzle. Integer gangsta black purus.\n\nCurabitizzle doggy i'm in the shizzle for sure nisi that's the shizzle mollizzle. Suspendisse potenti. Morbi da bomb. Vivamizzle neque. Crizzle orci. Cras pimpin' brizzle, interdizzle uhuh ... yih!, phat sit amet, stuff izzle, shizzlin dizzle. Pellentesque things. That's the shizzle daahng dawg mi, volutpizzle in, sagittis sizzle, funky fresh semper, i saw beyonces tizzles and my pizzle went crizzle. Bizzle its fo rizzle ipsum. Break it down volutpizzle felis vel uhuh ... yih!. Crizzle ma nizzle justo hizzle purus sodales ornare. Shiz venenatizzle check it out et funky fresh. Nunc sizzle. Suspendisse dizzle placerizzle mah nizzle. Curabitur yippiyo dang. Nunc shizzlin dizzle, leo eu dapibus hendrerizzle, ipsum get down get down fo shizzle sem, in aliquet magna pimpin' luctizzle pede. Fo shizzle a nisl. Class aptent cool dizzle pot ass boom shackalack conubia nostra, pizzle inceptos hymenaeos. Aliquam interdizzle, neque nizzle break yo neck, yall fo, phat orci its fo rizzle leo, shit semper things i saw beyonces tizzles and my pizzle went crizzle dizzle sizzle.";
    
    public var button : Button;
    public var iconButton : Button;
    public var iconTextButton : Button;
    
    public var list : ListBox;
    
    public var combo : ComboBox;
    public var progressBar : ProgressBar;
    public var progressSlider : ProgressSlider;
    public var toggleButton : ToggleButton;
    public var checkBoxGroup : CheckBoxGroup;
    public var radioButtonGroup : RadioGroup;
    public var label : Label;
    public var inputBox : TextInput;
    public var alertButton : Button;
    public var showWindowButton : Button;
    public var window : Window;
    public var tabPane : TabPane;
    public var scrollBar : ScrollBar;
    public var scrollPane :ScrollPane;
    public var itemPane : ItemPane;
    public var menu : Menu;
	
	public var alertBox:Sprite;
    
    public function new()
    {
        super();
		
		if (null != stage)
			init();
		else
		addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
    }
    
    private function init(e : Event = null) : Void
    {
        removeEventListener(Event.ADDED_TO_STAGE, init);
        
        // Standard Button
        button = new Button("Button", 100, 20);
        button.x = button.y = 20;
        
        // Button with Right Arrow(Play Icon) and no text
        iconButton = new Button("Icon", 100, 20);
        iconButton.x = button.x;
        iconButton.y = button.y + button.height + 20;
        iconButton.iconDisplay = true;
        iconButton.setIcon(new ArrowRightIcon(10, 10));
        iconButton.showLabel = false;
        
        iconTextButton = new Button("Text", 100, 20);
        iconTextButton.x = iconButton.x;
        iconTextButton.y = iconButton.y + iconButton.height + OFFSET;
        iconTextButton.setIcon(new StopIcon(10, 10));
        iconTextButton.iconDisplay = true;
        iconTextButton.imageOffSetX = 10;
        iconTextButton.imageOffSetY = 5;
        
        alertButton = new Button("Alert Box", 100, 20);
        alertButton.x = iconTextButton.x;
        alertButton.y = iconTextButton.y + iconTextButton.height + OFFSET;
        alertButton.addEventListener(MouseEvent.CLICK, onAlertButton, false, 0, true);
		
        // List
        list = new ListBox();
        list.addItem(new ListObjectData("Erick", "E"));
        list.addItem(new ListObjectData("Nick", "N"));
        list.addItem(new ListObjectData("Bobby", "B"));
        list.addItem(new ListObjectData("Danny", "D"));
        list.addItem(new ListObjectData("Thomas", "T"));
        
        list.x = button.x + button.width + OFFSET;
        list.y = button.y;
        
        // ComboBox
        combo = new ComboBox(100, 20);
        combo.x = list.x + list.width + OFFSET;
        combo.y = list.y;
        
        combo.addItem(new ComboBoxObjectData("Windows"));
        combo.addItem(new ComboBoxObjectData("MacOS"));
        combo.addItem(new ComboBoxObjectData("Linux"));
        
        // ProgressBar
        progressBar = new ProgressBar();
        progressBar.percent = 50;
        progressBar.x = combo.x;
        progressBar.y = combo.y + combo.height + OFFSET;
        
        // ProgressSlider
        progressSlider = new ProgressSlider();
        progressSlider.x = progressBar.x;
        progressSlider.y = progressBar.y + progressBar.height + OFFSET;
        
        // Toggle Button
        toggleButton = new ToggleButtonLite();
        toggleButton.x = progressSlider.x;
        toggleButton.y = progressSlider.y + progressSlider.height + OFFSET;
        
        // Looking for shapes so type casting
        toggleButton.setNormalState(cast(Draw.Square(100, 30, 0xCCCCCC), Shape));
        toggleButton.setOverState(cast(Draw.Square(100, 30, 0x999999), Shape));
        toggleButton.setDownState(cast(Draw.Square(100, 30, 0x666666), Shape));
        toggleButton.setDisableState(cast(Draw.Square(100, 30, 0x000000), Shape));
        
        toggleButton.width = 100;
        toggleButton.height = 30;
        
        // Check Box Group
        checkBoxGroup = new CheckBoxGroup("checkGroup");
        checkBoxGroup.createCheckBox("Check1", "CheckBox 1");
        checkBoxGroup.createCheckBox("Check2", "CheckBox 2");
        checkBoxGroup.createCheckBox("Check3", "CheckBox 3");
        
        checkBoxGroup.x = toggleButton.x + toggleButton.width + 20;
        checkBoxGroup.y = combo.y;
        
        // Radio Buttion Group
        // Use the UIStyleManager class to adjust the radio buton label and dot if need bet
        radioButtonGroup = new RadioGroup("radioButtonGroup");
        
        radioButtonGroup.createRadioButton("Radio1", "Radio 1");
        radioButtonGroup.createRadioButton("Radio2", "Radio 2");
        radioButtonGroup.createRadioButton("Radio3", "Radio 3");
        
        radioButtonGroup.x = checkBoxGroup.x;
        radioButtonGroup.y = checkBoxGroup.y + checkBoxGroup.height + 20;
        
        // Label and Tool-Tip
        label = new Label("Label");
        label.height = 40;
        label.x = radioButtonGroup.x;
        label.y = radioButtonGroup.y + radioButtonGroup.height + OFFSET;
        
        
        // Input Box
        inputBox = new InputField();
        inputBox.defaultString("Type Here");
        inputBox.x = label.x + label.width + OFFSET;
        inputBox.y = label.y;  
		
		// Show button for Windows
        showWindowButton = new Button("Show Window", 100, 20);
        showWindowButton.x = inputBox.x + inputBox.width + OFFSET;
        showWindowButton.y = inputBox.y;
        showWindowButton.addEventListener(MouseEvent.CLICK, onShowWindowClick, false, 0, true);
        
        window = new Window(200, 200);
		
        // Center window on the screen using bitshifting
        window.x = (stage.stageWidth / 2) - (window.width / 2);
        window.y = (stage.stageHeight / 2) - (window.height / 2);
        window.windowFocusColor = window.windowTitleFocusColor = 0x999999;
        window.addEventListener(WindowEvent.WINDOW_CLOSE_BTN, onHideWindow, false, 0, true);
        window.addEventListener(WindowEvent.WINDOW_MIN_BTN, onHideWindow, false, 0, true);
        
        window.visible = false;
        
        // Tab Pane
        tabPane = new TabPane(300, 200);
        tabPane.x = alertButton.x;
        tabPane.y = alertButton.y + alertButton.height + OFFSET;
        tabPane.addItem("One", new Label("One"));
        tabPane.addItem("Two", new Label("Two"));
        tabPane.addItem("Three", new Label("Three"));
        
        // Box for Tool-tip
		
        // Setting the stage because isn't on stage already
        ToolTip.displayArea = this;
		UIStyleManager.TOOLTIP_BUBBLE_LOC_Y = -10;
		
        var toolTipBox : MovieClip = new MovieClip();
        var toolBox : Shape = cast(Draw.Square(100, 20, 0), Shape);
        
        ToolTip.followMouse = true;
        ToolTip.attach(toolTipBox, "Look a Tool-tip", 100, 100, 0, 0x666666);		
		
        toolTipBox.x = showWindowButton.x + showWindowButton.width + OFFSET;
        toolTipBox.y = showWindowButton.y;
        toolTipBox.addChild(toolBox);
        
        scrollBar = new ScrollBar();
        
        var dummyText : TextField = new TextField();
        dummyText.width = 200;
        dummyText.height = 75;
        dummyText.x = checkBoxGroup.x + checkBoxGroup.width + OFFSET;
        dummyText.y = checkBoxGroup.y;
        dummyText.multiline = true;
        dummyText.wordWrap = true;
        dummyText.text = GANGSTA_TEXT;
        
        var scrollContent : ScrollContent = new ScrollContent(dummyText, scrollBar);
        
        scrollPane = new ScrollPane(300, 200);
        scrollPane.x = tabPane.x + tabPane.width + OFFSET;
        scrollPane.y = tabPane.y;
        
        // This time creating bitmap shapes
        var bitmap1 : DisplayObject = cast(Draw.Square(600, 300, 0xFF0000, 1, true), Bitmap);
        var bitmap2 : DisplayObject = cast(Draw.Square(600, 300, 0x00FF00, 1, true), Bitmap);
        var bitmapHolder : MovieClip = new MovieClip();
        
        // Add them to a bitmap holder and moving the second bitmap down
        bitmapHolder.addChild(bitmap1);
        bitmapHolder.addChild(bitmap2);
        bitmap2.y = bitmap1.y + bitmap1.height;
        
		
        // This is how you add an item to the scrollPane
        scrollPane.source = bitmapHolder;
        
        itemPane = new ItemPane(300, 200);
		
        itemPane.addItem(new ItemPaneObjectData("Item 1", "1"));
        itemPane.addItem(new ItemPaneObjectData("Item 2", "2"));
        itemPane.addItem(new ItemPaneObjectData("Item 3", "3"));
        itemPane.addItem(new ItemPaneObjectData("Item 4", "4"));
        itemPane.addItem(new ItemPaneObjectData("Item 5", "5"));
        itemPane.itemWidth = 150;
        itemPane.itemHeight = 100;
        
        itemPane.x = scrollPane.x + scrollPane.width + OFFSET;
        itemPane.y = scrollPane.y;
        
        // Menu System
        var menuData : DataProvider = new DataProvider();
        var subMenuData : DataProvider = new DataProvider();
        subMenuData.addItem(new MenuItemObjectData("Sub Item 1"));
        subMenuData.addItem(new MenuItemObjectData("Sub Item 2"));
        subMenuData.addItem(new MenuItemObjectData("Sub Item 3"));
        
        menuData.addItem(new MenuItemObjectData("Top Level", "0", subMenuData));
        menu = new Menu(100, 100, menuData);
        menu.menuSubDefaultColor = menu.menuDefaultColor = 0xCCCCCC;
        menu.x = tabPane.x;
        menu.y = tabPane.y + tabPane.height + OFFSET;
        
        ThreadManager.stage = stage;
        Slider.sliderEventMode = Slider.TIMER_MODE;
        
        addChild(button.displayObject);
        addChild(iconButton.displayObject);
        addChild(iconTextButton.displayObject);
        addChild(list.displayObject);
        
        addChild(progressBar.displayObject);
        addChild(progressSlider.displayObject);
        addChild(toggleButton.displayObject);
        addChild(combo.displayObject);
        addChild(checkBoxGroup.displayObject);
        addChild(radioButtonGroup.displayObject);
        addChild(label.displayObject);
        addChild(toolTipBox);
        addChild(inputBox.displayObject);
        addChild(alertButton.displayObject);
        addChild(showWindowButton.displayObject);
        addChild(tabPane.displayObject);
        addChild(scrollBar.displayObject);
        addChild(dummyText);
        addChild(scrollPane.displayObject);
        
        addChild(itemPane.displayObject);
        addChild(menu.displayObject);
        addChild(window.displayObject);
    }
    
    private function onHideWindow(event : WindowEvent) : Void
    {
        window.visible = false;
    }
    
    private function onShowWindowClick(event : MouseEvent) : Void
    {
        window.visible = true;
    }
    
    private function onAlertButton(event : MouseEvent) : Void
    {
        alertBox = Alert.create("This is a Message Box", "Alert Box", [Alert.OK], null, null, onAlertButtonClick);
        addChild(alertBox);
    }
	
	function onAlertButtonClick(event:Event) 
	{
		if (null != alertBox.parent)
		{
			trace(cast(event.currentTarget, Button).name);
		}
	}
}


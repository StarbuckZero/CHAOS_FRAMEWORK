
import com.chaos.data.DataProvider;
import com.chaos.ui.ScrollTextContent;

import com.chaos.drawing.icon.ArrowRightIcon;
import com.chaos.drawing.icon.StopIcon;
import com.chaos.form.ui.InputField;
import com.chaos.form.ui.RadioButtonList;
import com.chaos.ui.Alert;
import com.chaos.ui.Button;
import com.chaos.ui.CheckBoxGroup;
import com.chaos.ui.ComboBox;
import com.chaos.ui.TextInput;
import com.chaos.utils.CompositeManager;
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
import com.chaos.ui.RadioButtonGroup;
import com.chaos.ui.ScrollBar;
import com.chaos.ui.ScrollContentBase;
import com.chaos.ui.ScrollPane;
import com.chaos.ui.Slider;
import com.chaos.ui.TabPane;
import com.chaos.ui.ToggleButton;
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
    public var radioButtonGroup : RadioButtonGroup;
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
        button = new Button({"text":"Button", "width":100, "height":20, "x":20, "y":20});
        
        // Button with Right Arrow(Play Icon) and no text
		iconButton = new Button({"text":"Icon", "width":100, "height":20, "showLabel":false, "x":button.x, "y": (button.y + button.height + 20)});
        iconButton.setIcon(CompositeManager.displayObjectToBitmap(new ArrowRightIcon({"width":10, "height":10, "baseColor":0xFFFFFF})));
        iconButton.draw();
		
        iconTextButton = new Button({"text":"Text", "width":100, "height":20, "x":iconButton.x, "y":(iconButton.y + iconButton.height + OFFSET), "imageOffSetX":10, "imageOffSetY":5});
        iconTextButton.setIcon(CompositeManager.displayObjectToBitmap(new StopIcon({"width":10, "height":10})));
        iconTextButton.draw();
		
        alertButton = new Button({"text":"Alert Box", "width": 100, "height":20,"x":iconTextButton.x,"y":(iconTextButton.y + iconTextButton.height + OFFSET)});
        alertButton.addEventListener(MouseEvent.CLICK, onAlertButton, false, 0, true);
		
        // List
		var listData:Array<Dynamic> = new Array<Dynamic>();
		listData.push({"text":"Erick", "value":"1"});
		listData.push({"text":"Nick", "value":"2"});
		listData.push({"text":"Bobby", "value":"3"});
		listData.push({"text":"Tim", "value":"4"});
		listData.push({"text":"Danny", "value":"5"});
		listData.push({"text":"Andy", "value":"6"});
		listData.push({"text":"Zack", "value":"7"});
		
        list = new ListBox({"width":100, "height":100, "x":(button.x + button.width + OFFSET), "y":button.y, "data":listData});
        
        // ComboBox
		var comboData:Array<Dynamic> = new Array<Dynamic>();
		comboData.push({"text":"Windows 10", "value":"1"});
		comboData.push({"text":"MaxOS X", "value":"2"});
		comboData.push({"text":"iOS", "value":"3"});
		comboData.push({"text":"Ubuntu Linux", "value":"4"});
		comboData.push({"text":"Android", "value":"5"});
		comboData.push({"text":"Haiku OS", "value":"6"});
		
        combo = new ComboBox({"width":100, "height":20, "x":(list.x + list.width + OFFSET), "y":list.y, "data":comboData});
        
        // ProgressBar
        progressBar = new ProgressBar({"width":100,"height":20,"percent":50,"x":combo.x,"y":(combo.y + combo.height + OFFSET)});
        
        // ProgressSlider
        progressSlider = new ProgressSlider({"width":100,"height":20,"x":progressBar.x,"y":(progressBar.y + progressBar.height + OFFSET)});
        
        // Toggle Button
        toggleButton = new ToggleButton({"width":100, "height":30,"x":progressSlider.x,"y":(progressSlider.y + progressSlider.height + OFFSET)});
        
        // Check Box Group
		var checkBoxData:Array<Dynamic> = new Array<Dynamic>();
		checkBoxData.push({"name":"Check1", "text":"CheckBox 1"});
		checkBoxData.push({"name":"Check2", "text":"CheckBox 2"});
		checkBoxData.push({"name":"Check3", "text":"CheckBox 3"});
		
        checkBoxGroup = new CheckBoxGroup({"name":"checkGroup", "width":300, "height":30,"background":false, "x":(toggleButton.x + toggleButton.width + 20), "y":combo.y, "data":checkBoxData});
        
        // Radio Buttion Group
		var radioButtonData:Array<Dynamic> = new Array<Dynamic>();
		radioButtonData.push({"name":"Radio1", "text":"Radio 1"});
		radioButtonData.push({"name":"Radio2", "text":"Radio 2"});
		radioButtonData.push({"name":"Radio3", "text":"Radio 3"});
		
		
        // Use the UIStyleManager class to adjust the radio buton label and dot if need bet
        radioButtonGroup = new RadioButtonGroup({"name":"radioButtonGroup", "width":300, "height":30, "background":false, "data":radioButtonData, "x":checkBoxGroup.x, "y":(checkBoxGroup.y + checkBoxGroup.height + 20)});
        
        // Label and Tool-Tip
        label = new Label({"text":"Label", "width":50, "height":20,"x":radioButtonGroup.x,"y":radioButtonGroup.y + radioButtonGroup.height + OFFSET });
        
        
        // Input Box
        inputBox = new TextInput({"defaultString":"Type Here", "width":100, "height":20, "x":(label.x + label.width + OFFSET),"y":label.y});
		
		// Show button for Windows
        showWindowButton = new Button({"text":"Show Window", "width":100, "height":20, "x":(inputBox.x + inputBox.width + OFFSET), "y":inputBox.y});
        showWindowButton.addEventListener(MouseEvent.CLICK, onShowWindowClick, false, 0, true);
        
        window = new Window({"width":200, "height":200, "windowColor": 0x999999, "windowTitleColor": 0x999999, "Label":{"text":"Window"}});
		window.x = ((stage.stageWidth / 2) - (window.width / 2));
		window.y = ((stage.stageHeight / 2) - (window.height / 2));
		//window.textLabel.text = "Window";
		
		
        // Attach events
        window.closeButton.addEventListener(MouseEvent.CLICK, onHideWindow, false, 0, true);
        window.minButton.addEventListener(MouseEvent.CLICK, onHideWindow, false, 0, true);
        
		// Hide Window for button press
        window.visible = false;
        
        // Tab Pane
        tabPane = new TabPane({"width":300, "height":200,"x":alertButton.x,"y":(alertButton.y + alertButton.height + OFFSET)});
        tabPane.addItem("One", new Label({"text":"One", "width":100, "height":20}));
        tabPane.addItem("Two", new Label({"text":"Two", "width":100, "height":20}));
		tabPane.addItem("Three", new Label({"text":"Three", "width":100, "height":20}));
		
        
        // Box for Tool-tip
		
        // Setting the stage because isn't on stage already
        ToolTip.displayArea = this;
		UIStyleManager.TOOLTIP_BUBBLE_LOC_Y = -10;
		
        var toolTipBox : MovieClip = new MovieClip();
        var toolBox : Shape = new Shape();
		
		toolBox.graphics.beginFill(0x666666);
		toolBox.graphics.drawRect(0, 0, 100, 20 );
		toolBox.graphics.endFill();
        
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
        
        var scrollContent : ScrollTextContent = new ScrollTextContent(dummyText, scrollBar);
        
        scrollPane = new ScrollPane({"width":300, "height":200, "x":(tabPane.x + tabPane.width + OFFSET), "y":tabPane.y});
        
        // This time creating bitmap shapes
        var shape1 : Shape = new Shape(); //cast(Draw.Square(600, 300, 0xFF0000, 1, true), Bitmap);
        var shape2 : Shape = new Shape(); //cast(Draw.Square(600, 300, 0x00FF00, 1, true), Bitmap);
		
		shape1.graphics.beginFill(0xFF0000);
		shape2.graphics.beginFill(0x00FF00);
		
		shape1.graphics.drawRect(0, 0, 600, 300);
		shape2.graphics.drawRect(0, 0, 600, 300);
		
		shape1.graphics.endFill();
		shape2.graphics.endFill();
		
        var shapeHolder : MovieClip = new MovieClip();
        
        // Add them to a bitmap holder and moving the second bitmap down
        shapeHolder.addChild(shape1);
        shapeHolder.addChild(shape2);
        shape1.y = shape2.y + shape1.height;
        
		
        // This is how you add an item to the scrollPane
        scrollPane.source = shapeHolder;
        
		
		var itemData:Array<Dynamic> = new Array<Dynamic>();
		itemData.push({"text":"Item 1", "value":"1"});
		itemData.push({"text":"Item 2", "value":"2"});
		itemData.push({"text":"Item 3", "value":"3"});
		itemData.push({"text":"Item 4", "value":"4"});
		itemData.push({"text":"Item 5", "value":"5"});
		
		
        itemPane = new ItemPane({"width":300, "height":200, "itemWidth":150, "itemHeight":100 , "x": (scrollPane.x + scrollPane.width + OFFSET), "y":scrollPane.y, "data":itemData});
		
        // Menu System
		var subMenuData:Array<Dynamic> = new Array<Dynamic>();
		
		subMenuData.push({"text":"Sub Item 1", "value":"1-1"});
		subMenuData.push({"text":"Sub Item 2", "value":"1-2"});
		subMenuData.push({"text":"Sub Item 3", "value":"1-3"});
		
		
		var menuData:Array<Dynamic> = new Array<Dynamic>();
		menuData.push({"text":"Top Level", "value":"0", "data":subMenuData});
		
        var menu:Menu = new Menu({"name":"PeopleMenu", "width":100, "height":40, "border":true, "subBorder":true, "textColor":0xFFFFFF, "subNormalLineColor":0, "x":tabPane.x, "y":(tabPane.y + tabPane.height + OFFSET), "direction":"horizontal", "data":menuData});
		
		
        
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
        
        addChild(itemPane);
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


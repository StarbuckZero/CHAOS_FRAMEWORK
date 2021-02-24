package com.chaos.engine.plugin;

import com.chaos.ui.data.BaseObjectData;
import com.chaos.engine.CommandDispatch;
import com.chaos.form.FormBuilder;
import com.chaos.form.ui.CheckBoxList;
import com.chaos.form.ui.DateField;
import com.chaos.form.ui.DropDownMenu;
import com.chaos.form.ui.EmailField;
import com.chaos.form.ui.InputField;
import com.chaos.form.ui.PasswordField;
import com.chaos.form.ui.PhoneNumberField;
import com.chaos.form.ui.RadioButtonList;
import com.chaos.form.ui.Select;
import com.chaos.form.ui.TextLabel;
import com.chaos.form.classInterface.IFormBuilder;
import com.chaos.form.ui.classInterface.IFormUI;

import com.chaos.media.DisplayImage;
import com.chaos.ui.event.ComboBoxEvent;
import com.chaos.ui.event.GridPaneEvent;
import com.chaos.ui.event.MenuEvent;
import com.chaos.ui.event.SliderEvent;
import com.chaos.ui.event.WindowEvent;
import com.chaos.ui.ScrollPolicy;
import com.chaos.ui.Alert;
import com.chaos.ui.CheckBox;
import com.chaos.ui.CheckBoxGroup;
import com.chaos.ui.ComboBox;
import com.chaos.ui.Label;
import com.chaos.ui.TextInput;
import com.chaos.ui.ToolTip;
import com.chaos.ui.ListBox;
import com.chaos.ui.RadioButtonGroup;
import com.chaos.ui.Button;
import com.chaos.ui.ToggleButton;
import com.chaos.ui.RadioButton;
import com.chaos.ui.ScrollBar;
import com.chaos.ui.ItemPane;
import com.chaos.ui.Slider;
import com.chaos.ui.GridPane;
import com.chaos.ui.Menu;
import com.chaos.ui.TabPane;
import com.chaos.ui.ScrollPane;
import com.chaos.ui.Window;
import com.chaos.ui.WindowManager;
import com.chaos.ui.ProgressBar;
import com.chaos.ui.BaseUI;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.layout.GridCellLayout;
import com.chaos.ui.classInterface.IRadioButtonGroup;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IToggleButton;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.IListBox;
import com.chaos.ui.classInterface.ICheckBoxGroup;
import com.chaos.ui.classInterface.IComboBox;
import com.chaos.ui.classInterface.IItemPane;
import com.chaos.ui.classInterface.ITextInput;
import com.chaos.ui.classInterface.ILabel;

import com.chaos.ui.classInterface.ISlider;
import com.chaos.ui.classInterface.IGridPane;
import com.chaos.ui.classInterface.IMenu;
import com.chaos.ui.classInterface.ITabPane;

import com.chaos.ui.classInterface.IWindow;
import com.chaos.ui.classInterface.IScrollPane;
import com.chaos.ui.classInterface.IScrollBar;
import com.chaos.ui.classInterface.IProgressBar;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.ui.data.ComboBoxObjectData;
import com.chaos.ui.data.ListObjectData;
import com.chaos.ui.data.ItemPaneObjectData;
import com.chaos.ui.data.MenuItemObjectData;
import com.chaos.data.DataProvider;
import com.chaos.utils.ThreadManager;
import com.chaos.utils.classInterface.ITask;
import com.chaos.utils.data.TaskDataObject;
import com.chaos.engine.CommandCentral;
import com.chaos.engine.EngineTypes;
import com.chaos.engine.Global;
import com.chaos.engine.loader.ThemeLoader;
import com.chaos.utils.Debug;
import com.chaos.utils.Utils;

import openfl.display.Sprite;
import openfl.display.DisplayObject;
import openfl.events.EventDispatcher;
import openfl.display.Bitmap;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.events.FocusEvent;
import openfl.events.MouseEvent;
import openfl.events.ProgressEvent;

/**
* All of the UI elements
* @author Erick Feiling
*/
class CoreUIFrameworkPlugin
{
    
    
    private static var winManagers : Dynamic = {};
    
    private var _eventDispatcher : EventDispatcher = new EventDispatcher();
    
    public function new()
    {
    }
    
    // Core UI Classes
    public static function initialize() : Void
    {
        
        CommandCentral.addCommand(Button.TYPE, createButton);  //Event  
        CommandCentral.addCommand(ToggleButton.TYPE, createToggleButton);  //Event  
        CommandCentral.addCommand(RadioButton.TYPE, createRadioButton);  //Event  
        CommandCentral.addCommand(CheckBox.TYPE, createCheckBox);  //Event  
        CommandCentral.addCommand(ComboBox.TYPE, createComboBox);  //Event  
        CommandCentral.addCommand(ListBox.TYPE, createListBox);  //Event  
        CommandCentral.addCommand(ItemPane.TYPE, createItemPane);  //Event  
        CommandCentral.addCommand(Label.TYPE, createLabel);  //Event  
        CommandCentral.addCommand(TextInput.TYPE, createTextInput);  //Event  
        CommandCentral.addCommand(Alert.TYPE, createAlertBox);
        CommandCentral.addCommand(Slider.TYPE, createSlider);  //Event  
        CommandCentral.addCommand(GridPane.TYPE, createGridPane);  //Event  
        CommandCentral.addCommand(Menu.TYPE, createMenu);  //Event  
        CommandCentral.addCommand(TabPane.TYPE, createTabPane);  //Event  
        CommandCentral.addCommand(ScrollPane.TYPE, createScrollPane);  // Not needed  
        CommandCentral.addCommand(Window.TYPE, createWindow);  //Event  
        CommandCentral.addCommand(WindowManager.TYPE, createWindowManager);  // Not needed  
        CommandCentral.addCommand(ToolTip.TYPE, updateToolTip);  // Not needed  
        CommandCentral.addCommand(ProgressBar.TYPE, createProgressBar);
        CommandCentral.addCommand(FormBuilder.TYPE, createForm);  // Not needed  
        
        // Theme
        CommandCentral.addCommand(EngineTypes.LOAD_THEME, loadTheme);
        CommandCentral.addCommand(EngineTypes.SET_THEME, setTheme);
        
        // Get Object
        CommandCentral.addCommand(EngineTypes.GET_ITEM, getItem);
        CommandCentral.addCommand(EngineTypes.REMOVE_ITEM, removeItem);
        
        // Data
        CommandCentral.addCommand(EngineTypes.DATA_UPDATE, updateItemData);
    }
    
    
    private static function loadTheme(data : Dynamic) : Dynamic
    {
        
        if (Reflect.hasField(data,"url"))
            ThemeLoader.load(Reflect.field(data,"url"));

        return null;
    }
    
    
    private static function setTheme(data : Dynamic) : Dynamic
    {
        ThemeLoader.setTheme(data);

        return null;
    }
    
    private static function getItem(data : Dynamic) : Dynamic
    {
        return Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name"));
    }
    
    private static function removeItem(data : Dynamic) : Dynamic
    {
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name"));
        
        if (Std.is(displayObj, IBaseUI))
            CommandDispatch.removeAllEvents(try cast(displayObj, IBaseUI) catch(e:Dynamic) null);
        
        
        if (Std.is(displayObj, IBaseContainer))
            CoreCommandPlugin.removeContainerEvents(try cast(displayObj, IBaseContainer) catch(e:Dynamic) null);
        
        if (null != displayObj.parent)
            return displayObj.parent.removeChild(displayObj);
        
        return null;
    }
    
    private static function updateToolTip(data : Dynamic) : Dynamic
    {
        if (data.exists("text") && data.exists("attach"))
        {
            var objWidth : Int =  Reflect.hasField(data,"width") ? Reflect.field(data,"width") : -1;
            var objHeight : Int = Reflect.hasField(data,"height") ? Reflect.field(data,"height") : -1;
            var objTextColor : Int = Reflect.hasField(data,"textColor") ? Reflect.field(data,"textColor") : -1;
            var border : Bool = Reflect.hasField(data,"border") ? Reflect.field(data,"border") : false;
            var borderColor : Int = Reflect.hasField(data,"borderColor") ? Reflect.field(data,"borderColor") : -1;
            var backgroundColor : Int =  Reflect.hasField(data,"backgroundColor") ? Reflect.field(data,"backgroundColor") : -1;
            
            if (Reflect.hasField(data,"delay"))
                ToolTip.delay = Reflect.field(data,"delay");
            
            if (Reflect.hasField(data,"followMouse"))
                ToolTip.followMouse = Reflect.field(data,"followMouse");
                        
            ToolTip.attach( Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"attach")), Reflect.field(data,"text"), objWidth, objHeight, objTextColor, backgroundColor, border, borderColor);
        }
        
        if (Reflect.hasField(data,"remove"))
            ToolTip.remove(Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"remove")));

        return null;
    }
    
    private static function updateItemData(data : Dynamic) : Dynamic
    {
        // var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, data.name);
        
        // if (null != displayObj && data.exists("items") && data.items.length > 0)
        // {
        //     if (Std.is(displayObj, ItemPane))
        //     {
        //         var itemPane : IItemPane = try cast(displayObj, ItemPane) catch(e:Dynamic) null;
        //         var itemData : DataProvider<TaskDataObject> = itemPane.dataProvider;
                
        //         if (data.exists("append") && !data.append)
        //         {
        //             itemPane.dataProvider.removeAll();
        //         }
                
        //         // Add items in the background
        //         ThreadManager.createTaskManager(ItemPane.TYPE, displayArea);
        //         ThreadManager.addTask(ItemPane.TYPE, new TaskDataObject("item" + itemPane.name, 0, data.items.length, null, updateItemPaneData, data, itemPane, itemData));
        //     }
        //     else if (Std.is(displayObj, List))
        //     {
        //         var listBox : IListBox = cast(displayObj, ListBox);
        //         var listData : DataProvider<ListObjectData> = listBox.dataProvider;
                
        //         if (data.exists("append") && !data.append)
        //         {
        //             listBox.dataProvider.removeAll();
        //         }
                
        //         // Add items in the background
        //         ThreadManager.createTaskManager(ListBox.TYPE, displayArea);
        //         ThreadManager.addTask(ListBox.TYPE, new ListObjectData("list" + listBox.name, 0, data.items.length, null, updateListBoxData, data, listBox, listData));
        //     }
        //     else if (Std.is(displayObj, ComboBox))
        //     {
        //         var comboBox : IComboBox = try cast(displayObj, ComboBox) catch(e:Dynamic) null;
        //         var comboData : DataProvider<ComboBoxObjectData> = comboBox.dataProvider;
                
        //         if (data.exists("append") && !data.append)
        //         {
        //             comboBox.dataProvider.removeAll();
        //         }
                
        //         // Add items in the background
        //         ThreadManager.createTaskManager(ComboBox.TYPE, displayArea);
        //         ThreadManager.addTask(ComboBox.TYPE, new ComboBoxObjectData("combo" + comboBox.name, 0, data.items.length, null, updateComboBoxData, data, comboBox, comboData));
        //     }
            
        //     return displayObj;
        // }
        
        return null;
    }
    
    private static function createForm(data : Dynamic) : Dynamic
    {
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name"));
        
        if (null != displayObj && Std.is(displayObj, FormBuilder))
        {
            //setFormBuilder(data, try cast(displayObj, FormBuilder) catch(e:Dynamic) null);
            return displayObj;
        }
        else
        {
            var form : IFormBuilder = new FormBuilder();
            
            // setFormBuilder(data, form);
            
            // Add items in the background
            // if (data.exists("items") && data.items.length > 0)
            // {
            //     ThreadManager.createTaskManager(FormBuilder.TYPE, displayArea);
            //     ThreadManager.addTask(FormBuilder.TYPE, new TaskDataObject("formBuilder_" + form.name, 0, data.items.length, null, updateFormData, data, form));
            // }
            
            CoreCommandPlugin.displayUpdate(form, data);

            return form;
        }

    }
    
    private static function createProgressBar(data : Dynamic) : Dynamic
    {
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name"));
        
        if (null != displayObj && Std.is(displayObj, Window))
        {
            CoreCommandPlugin.setComponentData(data, cast(displayObj, IBaseUI));
            
            return displayObj;
        }
        else
        {

            if(!Reflect.hasField(data,"width"))
                Reflect.setField(data,"width",100);
    
            if(!Reflect.hasField(data,"height"))
                Reflect.setField(data,"height",40);
            
            var progress : IProgressBar = new ProgressBar(data);
            
            // Add to display
            CoreCommandPlugin.displayUpdate(progress, data);
            
            
            CommandDispatch.attachEvent(progress, ProgressEvent.PROGRESS);
            CommandDispatch.attachEvent(progress, Event.COMPLETE);
            
            return progress;
        }
        
        return null;
    }
    
    private static function createWindowManager(data : Dynamic) : Dynamic
    {
        if(!Reflect.hasField(data,"width"))
            Reflect.setField(data,"width",400);

        if(!Reflect.hasField(data,"height"))
            Reflect.setField(data,"height",300);

    
        var newWindowManagerHolder : IBaseContainer = new BaseContainer(data);
        var windowManager : WindowManager = new WindowManager();
        windowManager.name = "window_manager";
        
        newWindowManagerHolder.background = false;
        
        Reflect.setField(winManagers, Std.string(newWindowManagerHolder.name), windowManager);
        
        (try cast(newWindowManagerHolder.content, Sprite) catch(e:Dynamic) null).addChildAt(windowManager, 0);
        
        return windowManager;
    }
    
    private static function createWindow(data : Dynamic) : Dynamic
    {
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name"));
        
        if (null != displayObj && Std.is(displayObj, Window))
        {
            CoreCommandPlugin.setComponentData(data, cast(displayObj, IBaseUI));

            return displayObj;
        }
        else
        {
            if(!Reflect.hasField(data,"width"))
                Reflect.setField(data,"width",400);
    
            if(!Reflect.hasField(data,"height"))
                Reflect.setField(data,"height",300);
    
            
            var window : IWindow = new Window(data);
            
            if (data.exists("manager"))
            {
                if (winManagers.exists(data.manager))
                {
                    cast(Reflect.field(winManagers, Std.string(data.manager)), WindowManager).addChild(window.displayObject);
                }
                else
                {
                    Debug.print("[UIFrameworkPlugin::createWindow] Couldn't find window manager by the name of " + data.manager + ".");
                }
            }
            
            // Add to display
            CoreCommandPlugin.displayUpdate(window, data);
            
            CommandDispatch.attachEvent(window, WindowEvent.WINDOW_CLOSE_BTN);
            CommandDispatch.attachEvent(window, WindowEvent.WINDOW_MAX_BTN);
            CommandDispatch.attachEvent(window, WindowEvent.WINDOW_MIN_BTN);
            CommandDispatch.attachEvent(window, WindowEvent.WINDOW_RESIZE);
            
            CommandDispatch.attachEvent(window, MouseEvent.MOUSE_UP);
            
            return window;
        }
        
        return null;
    }
    
    private static function createTabPane(data : Dynamic) : Dynamic
    {
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name"));
        
        if (null != displayObj && Std.is(displayObj, TabPane))
        {
            CoreCommandPlugin.setComponentData(data, cast(displayObj, IBaseUI));
            return displayObj;
        }
        else
        {
            if(!Reflect.hasField(data,"width"))
                Reflect.setField(data,"width",400);
    
            if(!Reflect.hasField(data,"height"))
                Reflect.setField(data,"height",300);
            
            var tabPane : ITabPane = new TabPane(data);
            
            // Add to display
            CoreCommandPlugin.displayUpdate(tabPane, data);
            CommandDispatch.attachEvent(tabPane, Event.CHANGE);
            
            return tabPane;
        }
        
        return null;
    }
    
    private static function createScrollPane(data : Dynamic) : Dynamic
    {
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, data.name);
        
        if (null != displayObj && Std.is(displayObj, ScrollPane))
        {
            CoreCommandPlugin.setComponentData(data, cast(displayObj, IBaseUI));
            return displayObj;
        }
        else
        {
            
            if(!Reflect.hasField(data,"width"))
                Reflect.setField(data,"width",400);
    
            if(!Reflect.hasField(data,"height"))
                Reflect.setField(data,"height",300);

            var scrollPane : IScrollPane = new ScrollPane(data);
            
            CoreCommandPlugin.displayUpdate(scrollPane, data);
            
            return scrollPane;
        }
        
        return null;
    }
    
    private static function createButton(data : Dynamic) : Dynamic
    {
        // {"Button":{"name":"myButton","text":"Button","width":100,"height":100,"enabled":true,"iconURL":"icon.png"}}
        
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name"));
        
        if (displayObj != null && Std.is(displayObj, Button))
        {
            CoreCommandPlugin.setComponentData(data, cast(displayObj, IBaseUI));
            
            return displayObj;
        }
        else
        {

            if(!Reflect.hasField(data,"width"))
                Reflect.setField(data,"width",100);
    
            if(!Reflect.hasField(data,"height"))
                Reflect.setField(data,"height",30);
            
            var button : IButton = new Button(data);
            
            CommandDispatch.attachEvent(button, MouseEvent.CLICK);
            CoreCommandPlugin.displayUpdate(button, CoreCommandPlugin.getDisplayObject(data));
            
            return button;
        }
        
        return null;
    }
    
    private static function createToggleButton(data : Dynamic) : Dynamic
    {
        
        if(!Reflect.hasField(data,"width"))
            Reflect.setField(data,"width",100);

        if(!Reflect.hasField(data,"height"))
            Reflect.setField(data,"height",30);

        var toggleBtn : IToggleButton = new ToggleButton(data);
        
        CoreCommandPlugin.displayUpdate(toggleBtn, CoreCommandPlugin.getDisplayObject(data));
        CommandDispatch.attachEvent(toggleBtn, MouseEvent.CLICK);
        
        return toggleBtn;
    }
    
    
    private static function createMenu(data : Dynamic) : Dynamic
    {
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name") );
        
        if (null != displayObj && Std.is(displayObj, Menu))
        {
            CoreCommandPlugin.setComponentData(data, cast(displayObj, IBaseUI));

            return displayObj;
        }
        else
        {
            
            if(!Reflect.hasField(data,"width"))
                Reflect.setField(data,"width",100);
    
            if(!Reflect.hasField(data,"height"))
                Reflect.setField(data,"height",100);
            
            // Do check for in data obj reverse
            var menu : IMenu = new Menu(data);
            
            
            CoreCommandPlugin.displayUpdate(menu, CoreCommandPlugin.getDisplayObject(data));
            CommandDispatch.attachEvent(menu, MenuEvent.MENU_BUTTON_CLICK);
            
            return menu;
        }
        
        return null;
    }
    
    private static function createGridPane(data : Dynamic) : Dynamic
    {
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name") );
        
        if (null != displayObj && Std.is(displayObj, GridPane))
        {
            CoreCommandPlugin.setComponentData(data, cast(displayObj, IBaseUI));

            return displayObj;
        }
        else
        {

            if(!Reflect.hasField(data,"width"))
                Reflect.setField(data,"width",100);
    
            if(!Reflect.hasField(data,"height"))
                Reflect.setField(data,"height",20);
            
            var gridPane : IGridPane = new GridPane(data);
                        
            CoreCommandPlugin.displayUpdate(gridPane, CoreCommandPlugin.getDisplayObject(data));
            
            CommandDispatch.attachEvent(gridPane, GridPaneEvent.SELECT);
            CommandDispatch.attachEvent(gridPane, GridPaneEvent.CHANGE);
            
            gridPane.draw();
            
            return gridPane;
        }
        
        return null;
    }
    
    private static function createSlider(data : Dynamic) : Dynamic
    {
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name") );
        
        if (null != displayObj && Std.is(displayObj, Slider))
        {
            CoreCommandPlugin.setComponentData(data, cast(displayObj, IBaseUI));

            return displayObj;
        }
        else
        {

            if(!Reflect.hasField(data,"width"))
                Reflect.setField(data,"width",100);
    
            if(!Reflect.hasField(data,"height"))
                Reflect.setField(data,"height",20);
            
            var slider : ISlider = new Slider(data);

            CoreCommandPlugin.displayUpdate(slider, data);
            CommandDispatch.attachEvent(slider, SliderEvent.CHANGE);
            
            return slider;
        }
        
        return null;
    }
    
    private static function createAlertBox(data : Dynamic) : Dynamic
    {
        // Must have everything
        // if (data.exists("message") && data.exists("title") && null != displayArea)
        // {
        //     var alertBoxIcon : DisplayImage = new DisplayImage();
        //     var windowIcon : DisplayImage = new DisplayImage();
            
        //     if (data.exists("alertBoxIcon"))
        //     {
        //         alertBoxIcon.setImage(CoreCommandPlugin.getImage(data.alertBoxIcon));
        //     }
            
        //     if (data.exists("windowIcon"))
        //     {
        //         windowIcon.setImage(CoreCommandPlugin.getImage(data.windowIcon));
        //     }
            
        //     var alert : Sprite = Alert.create(data.message, data.title, ((data.exists("button"))) ? data.button : null, ((null != alertBoxIcon.image)) ? alertBoxIcon : null, ((null != windowIcon.image)) ? windowIcon : null, onAlertButtonClick);
            
        //     displayArea.addChild(alert);
        //     return alert;
        // }
        
        // setAlertBox(data);
        
        
        return null;
    }
    
    private static function createLabel(data : Dynamic) : Dynamic
    {
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name") );
        
        if (null != displayObj && Std.is(displayObj, Label))
        {
            CoreCommandPlugin.setComponentData(data, cast(displayObj, IBaseUI));
            return displayObj;
        }
        else
        {
            if(!Reflect.hasField(data,"width"))
                Reflect.setField(data,"width",100);
    
            if(!Reflect.hasField(data,"height"))
                Reflect.setField(data,"height",20);
            
            var label : ILabel = new Label(data);
            
            
            CoreCommandPlugin.displayUpdate(label, data);
            CommandDispatch.attachEvent(label, MouseEvent.CLICK);
            
            return label;
        }
        
        return null;
    }
    
    private static function createTextInput(data : Dynamic) : Dynamic
    {
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name") );
        
        if (null != displayObj && Std.is(displayObj, TextInput))
        {
            CoreCommandPlugin.setComponentData(data, cast(displayObj, IBaseUI));

            return displayObj;
        }
        else
        {
            if(!Reflect.hasField(data,"width"))
                Reflect.setField(data,"width",100);
    
            if(!Reflect.hasField(data,"height"))
                Reflect.setField(data,"height",20);            
            
            var label : ITextInput = new TextInput(data);
            
            CoreCommandPlugin.displayUpdate(label, data);
            
            
            CommandDispatch.attachEvent(label, FocusEvent.FOCUS_IN);
            CommandDispatch.attachEvent(label, FocusEvent.FOCUS_OUT);
            
            return label;
        }
        
        return null;
    }
    
    
    
    
    
    private static function createRadioButton(data : Dynamic) : Dynamic    
    {
        //{"RadioButton":{"name":"radioButtonGroup","group":"groupName","width":200,"height":300,"items":[{"name":"Radio2","text":"Radio 1","selected":false},{"name":"Radio2","text":"Radio 2","selected":false},{"name":"Radio3","text":"Radio 3","selected":false}]}}
        
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name"));
        
        if (null != displayObj)
        {
            //TODO: Make sure this is no longer the case later.
            Debug.print("[UIFrameworkPlugin::createRadioButton] Must remove and add back in.");
            return null;
        }
        
        if(!Reflect.hasField(data,"width"))
            Reflect.setField(data,"width",100);

        if(!Reflect.hasField(data,"height"))
            Reflect.setField(data,"height",30);
        
        if(!Reflect.hasField(data,"group"))
            Reflect.setField(data,"group", Reflect.field(data,"group"));
        else
            Reflect.setField(data,"group", "radioButtonGroup");

        var radioGroup : IRadioButtonGroup = new RadioButtonGroup( data );
        
        CoreCommandPlugin.displayUpdate(radioGroup, CoreCommandPlugin.getDisplayObject(data));
        CommandDispatch.attachEvent(radioGroup, Event.CHANGE);
        
        return radioGroup;
    }
    
    private static function createCheckBox(data : Dynamic) : Dynamic
    {
        //{"CheckBox":{"name":"checkBoxGroup","group":"checkGroup","width":200,"height":300,"items":[{"name":"check1","text":"Check 1","selected":false},{"name":"check2","text":"Check 2","selected":true},{"name":"check3","text":"Check 3","selected":false}]}}
        
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name"));
        
        if (null != displayObj)
        {
            //TODO: Make sure this is no longer the case later.
            Debug.print("[UIFrameworkPlugin::createCheckBox] Must remove and add back in.");
            return null;
        }

        if(!Reflect.hasField(data,"width"))
            Reflect.setField(data,"width",100);

        if(!Reflect.hasField(data,"height"))
            Reflect.setField(data,"height",30);
        
        var checkGroup : ICheckBoxGroup = new CheckBoxGroup(data);
        
        CoreCommandPlugin.displayUpdate(checkGroup, data);
        CommandDispatch.attachEvent(checkGroup, Event.CHANGE);
        
        return checkGroup;
    }
    
    private static function createComboBox(data : Dynamic) : Dynamic
    {
        // {"ComboBox":{"name":"OSDropDown","width":100,"height":20,"items":[{"id":1,"text":"Linux","value":"Linux","selected":false},{"id":2,"text":"Windows","value":"Win","selected":false},{"id":3,"text":"Mac","value":"OSX","selected":false}]}}
        
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name"));
        
        if (null != displayObj && Std.is(displayObj, ComboBox))
        {
            CoreCommandPlugin.setComponentData(data, cast(displayObj, IBaseUI));
            
            return displayObj;
        }
        else
        {
            
            if(!Reflect.hasField(data,"width"))
                Reflect.setField(data,"width",100);
    
            if(!Reflect.hasField(data,"height"))
                Reflect.setField(data,"height",40);

            var comboBox : IComboBox = new ComboBox(data);
                        
            CoreCommandPlugin.displayUpdate(comboBox, data);
            CommandDispatch.attachEvent(comboBox, ComboBoxEvent.CHANGE);
            
            return comboBox;
        }
        
        return null;
    }
    
    private static function createListBox(data : Dynamic) : Dynamic
    {
        // {"List":{"name":"OSDropDown","width":100,"height":20,"items":[{"id":1,"text":"Linux","value":"Linux","selected":false},{"id":2,"text":"Windows","value":"Win","selected":false},{"id":3,"text":"Mac","value":"OSX","selected":false}]}}

        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, data.name);
        
        if (null != displayObj && Std.is(displayObj, List))
        {
            CoreCommandPlugin.setComponentData(data, cast(displayObj, IBaseUI));
            
            return displayObj;
        }
        else
        {
            if(!Reflect.hasField(data,"width"))
                Reflect.setField(data,"width",100);
    
            if(!Reflect.hasField(data,"height"))
                Reflect.setField(data,"height",40);
            
            var listBox : IListBox = new ListBox(data);
            
            CoreCommandPlugin.displayUpdate(listBox, data);
            CommandDispatch.attachEvent(listBox, Event.CHANGE);
            
            return listBox;
        }
        
        return null;
    }
    
    private static function createItemPane(data : Dynamic) : Dynamic    
    {
        // {"ItemPane":{"name":"ImageGallery","width":400,"height":300,"items":[{"id":1,"text":"Photo 1","value":"1","tooltip":"Photo 1","selected":false},{"id":2,"text":"Photo 2","value":"2","tooltip":"Photo 2","selected":false},{"id":3,"text":"Photo 3","tooltip":"Photo 2","value":"3","selected":false}]}}
        
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, data.name);
        
        if (null != displayObj && Std.is(displayObj, ItemPane))
        {
            CoreCommandPlugin.setComponentData(data, cast(displayObj, IBaseUI));
            
            return displayObj;
        }
        else
        {
            if(!Reflect.hasField(data,"width"))
                Reflect.setField(data,"width",100);
    
            if(!Reflect.hasField(data,"height"))
                Reflect.setField(data,"height",40);
            
            var itemPane : IItemPane = new ItemPane(data);
            
            CoreCommandPlugin.displayUpdate(itemPane, data);
            CommandDispatch.attachEvent(itemPane, Event.CHANGE);
            
            return itemPane;
        }
        
        return null;
    }
    

    
    private static function setAlertBox(data : Dynamic) : Void
    {
        // if (data.exists("tintAlpha"))
        // {
        //     Alert.tintAlpha = data.tintAlpha;
        // }
        
        // if (data.exists("tintBackgroundColor"))
        // {
        //     Alert.tintBackgroundColor = data.tintBackgroundColor;
        // }
        
        // if (data.exists("alignWindowToCenter"))
        // {
        //     Alert.alignWindowToCenter = data.alignWindowToCenter;
        // }
    }
    
    
    private static function updateFormData(task : ITask, data : Dynamic, formBuilder : IFormBuilder) : Void
    {
        // var item : Dynamic = data.items[task.index - 1];
        
        // var element : IFormUI;
        // var elementName : String = "";
        // var i : Int = 0;
        // var elementData : Dynamic;
        
        // // Get name of item
        // for (index in Reflect.fields(item))
        // {
        //     elementName = index;
        // }
        
        // elementData = Reflect.field(item, Std.string(index));
        
        // // Figure out if it's a special case
        // if (elementName == "Select" || elementName == "DropDownMenu" || elementName == "CheckBoxList" || elementName == "RadioButtonList")
        // {
        //     if (elementName == "Select")
        //     {
        //         var selectWidth : Float = ((elementData.exists("width"))) ? as3hx.Compat.parseFloat(elementData.width) : 100;
        //         var selectHeight : Float = ((elementData.exists("height"))) ? as3hx.Compat.parseFloat(elementData.height) : 100;
        //         var selectData : DataProvider = new DataProvider();
                
        //         if (elementData.exists("items") && elementData.items.length > 0)
        //         {
        //             for (i in 0...elementData.items.length)
        //             {
        //                 selectData.addItem(new ListObjectData(elementData.items.text, elementData.items.value, elementData.items.selected));
        //             }
        //         }
                
        //         element = new Select(selectWidth, selectHeight, selectData);
        //     }
        //     else if (elementName == "DropDownMenu")
        //     {
        //         var downDropWidth : Float = ((elementData.exists("width"))) ? as3hx.Compat.parseFloat(elementData.width) : -1;
        //         var downDropHeight : Float = ((elementData.exists("height"))) ? as3hx.Compat.parseFloat(elementData.height) : -1;
        //         var downDropData : DataProvider = new DataProvider();
                
        //         if (elementData.exists("items") && elementData.items.length > 0)
        //         {
        //             for (i in 0...elementData.items.length)
        //             {
        //                 downDropData.addItem(new ComboBoxObjectData(elementData.items.text, elementData.items.value, elementData.items.selected));
        //             }
        //         }
                
        //         element = new DropDownMenu(downDropWidth, downDropHeight, downDropData);
        //     }
        //     else if (elementName == "CheckBoxList")
        //     {
        //         var checkBoxData : Dynamic = elementData;
        //         var checkGroup : CheckBoxList = new CheckBoxList(((checkBoxData.exists("group"))) ? checkBoxData.group : "checkBoxGroup");
                
        //         checkGroup.width = ((checkBoxData.exists("width"))) ? as3hx.Compat.parseFloat(checkBoxData.width) : 100;
        //         checkGroup.height = ((checkBoxData.exists("height"))) ? as3hx.Compat.parseFloat(checkBoxData.height) : 30;
                
        //         for (i in 0...checkBoxData.items.length)
        //         {
        //             var checkData : Dynamic = checkBoxData.items[i];
        //             var checkSelected : Bool = ((checkData.exists("selected"))) ? checkData.selected : false;
                    
        //             if (checkData.exists("name") && checkData.exists("text"))
        //             {
        //                 checkGroup.createCheckBox(checkData.name, checkData.text, checkSelected);
        //             }
        //         }
                
        //         element = try cast(checkGroup, IFormUI) catch(e:Dynamic) null;
        //         CoreCommandPlugin.setBaseElementUI(checkBoxData, checkGroup);
        //     }
        //     else if (elementName == "RadioButtonList")
        //     {
        //         var radioButtonData : Dynamic = elementData;
        //         var radioGroup : IRadioGroup = new RadioButtonList(((radioButtonData.exists("group"))) ? radioButtonData.group : "radioButtonGroup");
                
        //         radioGroup.width = ((radioButtonData.exists("width"))) ? as3hx.Compat.parseFloat(data.width) : 100;
        //         radioGroup.height = ((radioButtonData.exists("height"))) ? as3hx.Compat.parseFloat(data.height) : 30;
                
        //         for (i in 0...radioButtonData.items.length)
        //         {
        //             var radioData : Dynamic = radioButtonData.items[i];
        //             var radioSelected : Bool = ((radioData.exists("selected"))) ? radioData.selected : false;
                    
        //             if (radioData.exists("name") && radioData.exists("text"))
        //             {
        //                 radioGroup.createRadioButton(radioData.name, radioData.text, radioSelected);
        //             }
        //         }
                
        //         element = try cast(radioGroup, IFormUI) catch(e:Dynamic) null;
        //         CoreCommandPlugin.setBaseElementUI(radioButtonData, radioGroup);
        //     }
        // }
        // else
        // {
        //     var FormClass : Class<Dynamic> = getFormClass(elementName);
        //     element = Type.createInstance(FormClass, []);
            
        //     if (Std.is(element, TextInput))
        //     {
        //         setInputElement(elementData, try cast(element, TextInput) catch(e:Dynamic) null);
        //     }
        //     else if (Std.is(element, Label))
        //     {
        //         CoreCommandPlugin.setLabelElement(elementData, try cast(element, Label) catch(e:Dynamic) null);
        //     }
        // }
        
        
        // var formObjName : String = ((elementData.exists("name"))) ? elementData.name : "Element" + task.index;
        // var formObjLabel : String = ((elementData.exists("name"))) ? elementData.name : "Element" + task.index;
        
        // if (data.exists("element") && data.element[task.index - 1] != null)
        // {
        //     var elementObj : Dynamic = data.element[task.index - 1];
            
        //     if (elementObj.exists("labelName"))
        //     {
        //         formObjLabel = elementObj.labelName;
        //     }
            
        //     if (elementObj.exists("elementName"))
        //     {
        //         formObjName = elementObj.elementName;
        //     }
        // }
        
        // formBuilder.addFormElement(formObjLabel, formObjName, element, ((item.exists("layout"))) ? getCellLayout(item.layout) : null, ((item.exists("params"))) ? item.params : null);
    }
    
    
    private static function getFormClass(type : String) : Dynamic
    {
        switch (type)
        {
            case "CheckBoxList":
                return CheckBoxList;
            
            case "DateField":
                return DateField;
            
            case "DropDownMenu":
                return DropDownMenu;
            
            case "EmailField":
                return EmailField;
            
            case "InputField":
                return InputField;
            
            case "PasswordField":
                return PasswordField;
            
            case "PhoneNumberField":
                return PhoneNumberField;
            
            case "RadioButtonList":
                return RadioButtonList;
            
            case "Select":
                return Select;
            
            case "TextLabel":
                return TextLabel;
            default:
                Debug.print("[CoreFrameworkPlugin::getFormClass] Did not find type " + type + " using TextLabel.");
                return TextLabel;
        }
        
        return null;
    }
    
    private static function getCellLayout(layout : String) : Dynamic
    {
        switch (layout.toUpperCase())
        {
            case "FIT":
                return GridCellLayout.FIT;
            
            case "HORIZONTAL":
                return GridCellLayout.HORIZONTAL;
            
            case "VERTICAL":
                return GridCellLayout.VERTICAL;
            default:
                return GridCellLayout.FIT;
        }
        
        
        return null;
    }
    
    private static function onAlertButtonClick(event : MouseEvent) : Void
    {
        if(Std.is(event.currentTarget,DisplayObject))
        {
            var displayObj:DisplayObject = cast(event.currentTarget, DisplayObject);

            CommandDispatch.dispatch(Alert.TYPE, "click", {button :displayObj.name});
        }

    }
}


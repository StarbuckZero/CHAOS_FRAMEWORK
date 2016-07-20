package com.chaos.ui;

	import com.chaos.data.DataProvider;
	import com.chaos.media.DisplayImage;
	import com.chaos.ui.Button;
	import com.chaos.ui.UIBitmapManager;
	import com.chaos.ui.UIDetailLevel;
	import com.chaos.ui.UIStyleManager;
	import com.chaos.ui.Window;
	import com.chaos.ui.event.WindowEvent;
	import com.chaos.ui.classInterface.IButton;
	import com.chaos.ui.classInterface.IButton;
	import com.chaos.ui.classInterface.IWindow;
	import com.chaos.utils.Utils;
	import haxe.Constraints.Function;
	import openfl.display.Bitmap;
	import openfl.display.DisplayObject;
	import openfl.display.Shape;
	import openfl.display.Sprite;
	import openfl.display.StageAlign;
	import openfl.events.Event;
	import openfl.events.MouseEvent;
	import openfl.text.TextFormatAlign;
	
class Alert
{
    public static var positiveButtonOverColor(get, set) : Int;
    public static var positiveButtonDownColor(get, set) : Int;
    public static var negativeButtonNormalColor(get, set) : Int;
    public static var negativeButtonOverColor(get, set) : Int;
    public static var negativeButtonDownColor(get, set) : Int;
    public static var neutralButtonNormalColor(get, set) : Int;
    public static var neutralButtonOverColor(get, set) : Int;
    public static var neutralButtonDownColor(get, set) : Int;
    public static var windowTitleFocusColor(get, set) : Int;
    public static var windowFocusColor(get, set) : Int;
    public static var windowUnFocusColor(get, set) : Int;
    public static var windowTitleUnFocusColor(get, set) : Int;
    public static var detail(get, set) : String;
	
	/** The type of UI Element */ 
	public static inline var TYPE : String = "Alert";
	/** For displaying the Cancel button */ 
	public static inline var CANCEL : String = "cancel"; 
	/** For displaying the Ok button */ 
	public static inline var OK : String = "ok"; 
	/** For displaying the Yes button */
	public static inline var YES : String = "yes"; 
	/** For displaying the No button */
	public static inline var NO : String = "no";
	/** For displaying the Maybe button */
	public static inline var MAYBE : String = "maybe";
	/** For non-modal mode */ 
	public static inline var NONMODAL : String = "nonmodal"; 
	/** Default background color */
	public static var DEFAULT_BACKGROUND : Int = 0xFFFFFF; 
	/** Default background color title area  */
	public static var DEFAULT_TITLE_BACKGROUND : Int = 0xCCCCCC; 
	/** Default width */ 
	public static var DEFAULT_WIDTH : Float = 310;  
	/** Default height */
	public static var DEFAULT_HEIGHT : Float = 180;
	/** The label offset on the x axis */  
	public static var LABEL_OFFSET_X : Int = 35;
	/** The label offset on the y axis */ 
	public static var LABEL_OFFSET_Y : Int = 40; 
	/** The icon offset on the x axis */
	public static var ICON_OFFSET_X : Int = 30;
	/** The icon offset on the y axis */ 
	public static var ICON_OFFSET_Y : Int = 40;
	/** The icon width */ 
	public static var ICON_SIZE_WIDTH : Int = 60;
	/** The icon height */
	public static var ICON_SIZE_HEIGHT : Int = 60;
	/** The button(s) offset on the x axis */ 
	public static var BUTTON_OFFSET_X : Int = 30;
	/** The button(s) offset on the y axis */
	public static var BUTTON_OFFSET_Y : Int = 25;
	/** The amount of buttons before switching to a smaller size */
	public static var SMALL_BUTTON_COUNT : Int = 3;
	/** The smaller size that the alert box switch too */
	public static var SMALL_BUTTON_WIDTH : Int = 60;
	/** The smaller size that the alert box switch too */
	public static var SMALL_BUTTON_HEIGHT : Int = 20;
	/** Set the size of the middle area */ 
	public static var ALERT_TOP_SIZE : Int = 20;
	/** Set the size of the middle area */  
	public static var ALERT_MIDDLE_SIZE : Int = 0;
	/** Set the size of the bottom area */
	public static var ALERT_BOTTOM_SIZE : Int = 0;
	/** Set if you want to user to be able to grab the text*/
	public static var ALERT_LABEL_TEXT_SELECTABLE : Bool = false;
	
	private static var _windowList : DataProvider = new DataProvider();
	private static var _windowCount : Int = 0;
	private static var _cancelBtnLabel : String = "Cancel";
	private static var _okBtnLabel : String = "OK";
	private static var _yesBtnLabel : String = "Yes";
	private static var _noBtnLabel : String = "No";
	private static var _maybeBtnLabel : String = "Maybe";
	private static var alertHolder : Sprite = null;
	private static var backgroundBlock : Shape = null;
	private static var _buttonWidth : Float = 30;
	private static var _buttonHeight : Float = 10;
	private static var _centerWindow : Bool = false;
	private static var _buttonLocation : String = "";
	private static var _labelLocation : String = "";
	private static var _enabledCloseButton : Bool = false;
	private static var _backgroundColor : Int = 0xFFFFFF;
	private static var _windowTitleFocusColor : Int = 0xCCCCCC;
	private static var _windowTitleUnFocusColor : Int = 0x333333;
	private static var _windowFocusColor : Int = 0xFFFFFF;
	private static var _windowUnFocusColor : Int = 0xCCCCCC;
	private static var _windowTopLeftImageURL : String = "";
	private static var _windowTopMiddleImageURL : String = "";
	private static var _windowTopRightImageURL : String = "";
	private static var _windowTopLeftImage : Bitmap = null;
	private static var _windowTopMiddleImage : Bitmap = null;
	private static var _windowTopRightImage : Bitmap = null;
	private static var _windowMiddleLeftImageURL : String = "";
	private static var _windowMiddleLeftImage : Bitmap = null;
	private static var _windowMiddleRightImageURL : String = "";
	private static var _windowMiddleRightImage : Bitmap = null;
	private static var _windowBottomLeftImageURL : String = "";
	private static var _windowBottomMiddleImageURL : String = "";
	private static var _windowBottomRightImageURL : String = "";
	private static var _windowBottomLeftImage : Bitmap = null;
	private static var _windowBottomMiddleImage : Bitmap = null;
	private static var _windowBottomRightImage : Bitmap = null;
	private static var _backgroundImageURL : String = "";
	private static var _backgroundImage : Bitmap = null;
	private static var _closeButtonNormalColor : Int = 0xCCCCCC;
	private static var _closeButtonOverColor : Int = 0x666666;
	private static var _closeButtonDownColor : Int = 0x333333;
	private static var _closeButtonDisableColor : Int = 0x999999;
	private static var _closeButtonNormalURL : String = "";
	private static var _closeButtonOverURL : String = "";
	private static var _closeButtonDownURL : String = "";
	private static var _closeButtonDisableURL : String = "";
	private static var _closeButtonNormalBitmap : Bitmap = null;
	private static var _closeButtonOverBitmap : Bitmap = null;
	private static var _closeButtonDownBitmap : Bitmap = null;
	private static var _closeButtonDisableBitmap : Bitmap = null;
	private static var _positiveButtonNormalColor : Int = 0xCCCCCC;
	private static var _positiveButtonOverColor : Int = 0x666666;
	private static var _positiveButtonDownColor : Int = 0x333333;
	private static var _positiveButtonNormalURL : String = "";
	private static var _positiveButtonOverURL : String = "";
	private static var _positiveButtonDownURL : String = "";
	private static var _positiveButtonNormalBitmap : Bitmap = null;
	private static var _positiveButtonOverBitmap : Bitmap = null;
	private static var _positiveButtonDownBitmap : Bitmap = null;
	private static var _negativeButtonNormalColor : Int = 0xCCCCCC;
	private static var _negativeButtonOverColor : Int = 0x666666;
	private static var _negativeButtonDownColor : Int = 0x333333;
	private static var _negativeButtonNormalURL : String = "";
	private static var _negativeButtonOverURL : String = "";
	private static var _negativeButtonDownURL : String = "";
	private static var _negativeButtonNormalBitmap : Bitmap = null;
	private static var _negativeButtonOverBitmap : Bitmap = null;
	private static var _negativeButtonDownBitmap : Bitmap = null;
	private static var _neutralButtonNormalColor : Int = 0xCCCCCC;
	private static var _neutralButtonOverColor : Int = 0x666666;
	private static var _neutralButtonDownColor : Int = 0x333333;
	private static var _neutralButtonNormalURL : String = "";
	private static var _neutralButtonOverURL : String = "";
	private static var _neutralButtonDownURL : String = "";
	private static var _neutralButtonNormalBitmap : Bitmap = null;
	private static var _neutralButtonOverBitmap : Bitmap = null;
	private static var _neutralButtonDownBitmap : Bitmap = null;
	private static var _tintBackgroundColor : Int = 0x000000;
	private static var _tintAlpha : Float = .5;
	private static var _qualityMode : String = UIDetailLevel.HIGH;
	
	private function new()
    {
		
      
	}
		/**
		 * Return an array with all the windows that were created
		 */
		
		static public function get_windowList() : DataProvider 
		{
			return _windowList; 
		} 
		 
		/**
		* Set the Alert pop-up button width
		* 
		* @param value Set the width of the button(s) used in the alert box
		* 
		*/  
		static public function set_buttonWidth(value : Float) : Float 
		{
			_buttonWidth = value;
			return value;
		}
		
		/**
		*
		* @return Returns the width
		*/ 
		static public function get_buttonWidth() : Float
		{
			return _buttonWidth;
		} 
		
		/**
		* Set the Alert pop-up button height
		* 
		* @param value Set the height of the button(s) used in the alert box
		* 
		*/
		public static function set_buttonHeight(value : Float) : Float
		{
			_buttonHeight = value;
			return value;
		}
		
		/**
		*
		* @return Returns the height
		*/
		
		public static function get_buttonHeight() : Float
		{
			return _buttonHeight;
		}
		 
		/**
		* Set the label for the button
		* 
		* @param value The new label you want to use
		* 
		*/
		public static function set_cancelLabel(value : String) : String
		{
			_cancelBtnLabel = value;
			return value;
		}
		
		/**
		*
		* @return Returns the label
		*/ 
		
		public static function get_cancelLabel() : String 
		{
			return _cancelBtnLabel;
			
		}
		
		/**
		* Set the label for the button
		* 
		* @param value The new label you want to use
		* 
		*/
		public static function set_okLabel(value : String) : String
		{
			_okBtnLabel = value;
			return value; 
		}
		
		/**
		*
		* @return Returns the label
		*/  
		
		public static function get_okLabel() : String 
		{
			return _okBtnLabel;
			
		}
		
		/**
		* Set the label for the button
		* 
		* @param value The new label you want to use
		* 
		*/
		
		public static function set_yesLabel(value : String) : String
		{
			_yesBtnLabel = value;
			return value;
		}
		
		/**
		*
		* @return Returns the label
		*/
		public static function get_yesLabel() : String
		{
			return _yesBtnLabel;
			
		}
		
		/**
		* Set the label for the button
		* 
		* @param value The new label you want to use
		* 
		*/
		
		public static function set_noLabel(value : String) : String
		{
			_noBtnLabel = value;
			return value;
			
		}
		
		/**
		*
		* @return Returns the label
		*/ 
		public static function get_noLabel() : String 
		{
			return _noBtnLabel;
			
		}
		
		/**
		* Set the label for the button
		* 
		* @param value The new label you want to use
		* 
		*/
		public static function set_maybeLabel(value : String) : String
		{
			_maybeBtnLabel = value;
			return value;
		} 
		
		/**
		*
		* @return Returns the label
		*/  
		public static function get_maybeLabel() : String
		{
			return _maybeBtnLabel;
		}
    
		/**
		* The background tint color for when window pops up.
		* 
		* @param value The color being used
		* 
		*/
		
		public static function set_tintBackgroundColor(value : Int) : Int
		{
			_tintBackgroundColor = value;
			return value;
		}
		
		/**
		*
		* @return Return the color being used
		*/
		
		public static function get_tintBackgroundColor() : Int
		{
			return _tintBackgroundColor;
			
		}
		
		/**
		* The background tint alpha for when window pops up.
		* 
		* @param value The number you want to set the background tint alpha to. Settings must be from 0 to 1.
		* @default .5
		*
		*/ 
		
		public static function set_tintAlpha(value : Float) : Float 
		{
			_tintAlpha = value;
			return value;
			
		}
		
		/**
		*
		* @return Return the alpha being used
		*/ 
		
		public static function get_tintAlpha() : Float
		{
			return _tintAlpha;
		} 
		
		/**
		* If you want the alert box to be centered on the screen
		* 
		* @param value True if you want the alert box to be center and false if not
		* 
		*/  
		
		public static function set_alignWindowToCenter(value : Bool) : Bool 
		{
			_centerWindow = value;
			return value;
		}
		
		/**
		*
		* @return Return true if the window is or will be centered and false if not
		*/ 
		
		public static function get_alignWindowToCenter() : Bool 
		{
			return _centerWindow;
			
		} 
		
		/**
		* Set where the buttons will be placed. The button(s) can only be placed on the left or right side.
		*
		* @param value Set the location of the button(s). Can only passed "left" or "right" as a value.
		*
		* @default left 
		*/
		
		public static function set_buttonLocation(value : String) : String
		{  
			// Check to see where to put the buttons  
			if (value.toLowerCase() == "left" || value.toLowerCase() == "right") 
			{
				_buttonLocation = value;
			}
			else
			{
				_buttonLocation = "left";
				
			}
			
			return _buttonLocation;
		}
		
		/**
		*
		* @return Return where the button(s) are or will be placed on the window
		*/
		
		public static function get_buttonLocation() : String 
		{
			return _buttonLocation;
		} 
		
		/**
		 * Set where to place the label on the window
		 * 
		 * @default center
		 */ 
		
		public function set_labelLocation(value : String) : String 
		{
			_labelLocation = value;
			return value;
		}
		
		/**
		 * Return where the label is being placed
		 */
		
		public function get_labelLocation() : String
		{
			return _labelLocation;
		}
		
		/**
		* Set the color of the Alert background
		* 
		* @param value The color that you want to set the scroll pane background to
		* 
		*/
		
		public static function set_backgroundColor(value : Int) : Int
		{
			_backgroundColor = value;
			return value;
		}
		
		/**
		*
		* @return Returns the color
		*/
		
		public static function get_backgroundColor() : Int
		{
			return _backgroundColor;
		} 
		
		/**
		* Enable or disable the close button on the window
		* 
		* @param value If true then the close button will enable and if false the button will be disable.
		* 
		*/ 
		
		public static function set_enabledCloseButton(value : Bool) : Bool 
		{
			_enabledCloseButton = value;
			return value;
		}
		
		/**
		*
		* @return Return true if the button is being shown and false if not
		*/
		public static function get_enabledCloseButton() : Bool 
		{
			return _enabledCloseButton; 
		}
		
		/**
		* Set the close button default color
		* 
		* @param value Set the default color on the button
		* 
		*/
		public static function set_closeButtonNormalColor(value : Int) : Int
		{
			_closeButtonNormalColor = value;
			return value;
		}
		
		/**
		*
		* @return Return the button color
		*/
		public static function get_closeButtonNormalColor() : Int 
		{
			return _closeButtonNormalColor; 
		}
		
		/**
		* Set the close button over state color
		* 
		* @param value Set the over state color on the button
		* 
		*/
		public static function set_closeButtonOverColor(value : Int) : Int
		{
			_closeButtonOverColor = value;
			return value;
		}
		
		/**
		*
		* @return Return the button color
		*/
		public static function get_closeButtonOverColor() : Int 
		{
			return _closeButtonOverColor; 
		}
		
		/**
		* Set the close button down state color
		* 
		* @param value Set the over state color on the button
		* 
		*/
		public static function set_closeButtonDownColor(value : Int) : Int 
		{
			_closeButtonDownColor = value;
			return value;
		}
		
		/**
		*
		* @return Return the button color
		*/
		
		public static function get_closeButtonDownColor() : Int 
		{
			return _closeButtonDownColor; 
		}
		
		/**
		* Set the close button disable state color
		* 
		* @param value Set the disable state color on the button
		* 
		*/
		public static function set_closeButtonDisableColor(value : Int) : Int 
		{
			_closeButtonDisableColor = value;
			return value;
		}
		
		/**
		*
		* @return Return the button color
		*/
		
		public static function get_closeButtonDisableColor() : Int 
		{
			return _closeButtonDisableColor; 
		}
		
		/**
		* This is for setting an image to the close button default state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a URL file path.
		*
		*/
		
		public static function setCloseButtonImage(value : String) : Void 
		{
			_closeButtonNormalURL = value; 
		}
		
		/**
		* This is for setting an image to the close button default state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a Bitmap being pass
		*
		*/
		
		public static function setCloseButtonBitmap(value : Bitmap) : Void 
		{
			_closeButtonNormalBitmap = value; 
		}
		
		/**
		* This is for setting an image to the close button roll over state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a URL file path.
		*
		*/  
		public static function setCloseOverButtonImage(value : String) : Void 
		{
			_closeButtonOverURL = value;
		}
		
		/**
		* This is for setting an image to the close button roll over state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a Bitmap being pass
		*
		*/
		
		public static function setCloseOverButtonBitmap(value : Bitmap) : Void 
		{
			_closeButtonOverBitmap = value; 
		}
	
		
		/**
		* This is for setting an image to the close button press down state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a URL file path.
		*
		*/
		public static function setCloseDownButtonImage(value : String) : Void
		{
			_closeButtonDownURL = value;
		} 
		
		/**
		* This is for setting an image to the close button roll press state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a Bitmap being pass
		*
		*/
		public static function setCloseDownButtonBitmap(value : Bitmap) : Void 
		{
			_closeButtonDownBitmap = value; 
		}
		
		/**
		* This is for setting an image to the close button disable state. It is best to set an image that can be tiled.
		*
		* @param value Set the image based on a URL file path.
		*
		*/
		public static function setCloseDisableButtonImage(value : String) : Void 
		{
			_closeButtonDisableURL = value; 
		} 
		
		/**
		* This is for setting an image to the button disable state. It is best to set an image that can be tiled.
		* 
		* @param value Set the image based on a Bitmap being pass
		*
		*/
		
		public static function setCloseDisableButtonBitmap(value : Bitmap) : Void 
		{
			_closeButtonDisableBitmap = value;
		}
		
		/**
		* Set the positive button default color
		* 
		* @param value Set the default color on the button
		* 
		*/
		private static function set_PositiveButtonNormalColor(value : Int) : Int {
			_positiveButtonNormalColor = value;
			return value; 
		}
		
		/**
		*
		* @return Return the button color
		*/
		private static function get_PositiveButtonNormalColor() : Int
		{
			return _positiveButtonNormalColor;
		}
		
		/**
		* Set the positive button over state color
		* 
		* @param value Set the over state color on the button
		* 
		*/
		private static function set_positiveButtonOverColor(value : Int) : Int 
		{
			_positiveButtonOverColor = value;
			return value; 
		}
		
		/**
		*
		* @return Return the button color
		*/
		
		private static function get_positiveButtonOverColor() : Int 
		{
			return _positiveButtonOverColor; 
		} 
		
		/**
		* Set the positive button down state color
		* 
		* @param value Set the over state color on the button
		* 
		*/
		private static function set_positiveButtonDownColor(value : Int) : Int 
		{
			_positiveButtonDownColor = value;
			return value;
		}
		
		/**
		*
		* @return Return the button color
		*/
		
		private static function get_positiveButtonDownColor() : Int 
		{
			return _positiveButtonDownColor; 
		}
		
		/**
		* This is for setting an image to the positive button default state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a URL file path.
		*
		*/ 
		
		public static function setPositiveButtonImage(value : String) : Void 
		{
			_positiveButtonNormalURL = value; 
		}  
		
		
		/**
		* This is for setting an image to the positive button default state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a Bitmap being pass
		*
		*/
		
		public static function setPositiveButtonBitmap(value : Bitmap) : Void
		{
			_positiveButtonNormalBitmap = value; 
		}  
		
		/**
		* This is for setting an image to the positive button roll over state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a URL file path.
		*
		*/
		
		public static function setPositiveOverButtonImage(value : String) : Void { _positiveButtonOverURL = value; }
		
		/**
		* This is for setting an image to the positive button roll over state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a Bitmap being pass
		*
		*/
		
		public static function setPositiveOverButtonBitmap(value : Bitmap) : Void { _positiveButtonOverBitmap = value; } 
		
		/**
		* This is for setting an image to the positive button press down state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a URL file path.
		*
		*/
		
		public static function setPositiveDownButtonImage(value : String) : Void { _positiveButtonDownURL = value; }  
		
		/**
		* This is for setting an image to the positive button roll press state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a Bitmap being pass
		*
		*/
		public static function setPositiveDownButtonBitmap(value : Bitmap) : Void { _positiveButtonDownBitmap = value; } 
		
		/**
		* Set the negative button default color
		* 
		* @param value Set the default color on the button
		* 
		*/
		
		private static function set_negativeButtonNormalColor(value : Int) : Int { _negativeButtonNormalColor = value; return value; } 
		
		/**
		*
		* @return Return the button color
		*/
		
		private static function get_negativeButtonNormalColor() : Int { return _negativeButtonNormalColor; }
		
	
		/**
		* Set the positive button over state color
		* 
		* @param value Set the over state color on the button
		* 
		*/
		private static function set_negativeButtonOverColor(value : Int) : Int { _negativeButtonOverColor = value; return value; } 
		
		/**
		*
		* @return Return the button color
		*/
		
		private static function get_negativeButtonOverColor() : Int { return _negativeButtonOverColor; }
		
		/**
		* Set the positive button down state color
		* 
		* @param value Set the over state color on the button
		* 
		*/ 
		
		private static function set_negativeButtonDownColor(value : Int) : Int { _negativeButtonDownColor = value; return value; }  
		
		
		/**
		*
		* @return Return the button color
		*/
		
		private static function get_negativeButtonDownColor() : Int { return _negativeButtonDownColor; }
		
	
		/**
		* This is for setting an image to the negative button default state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a URL file path.
		*
		*/ 
		
		public static function setNegativeButtonImage(value : String) : Void { _negativeButtonNormalURL = value; } 
		
		/**
		* This is for setting an image to the negative button default state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a Bitmap being pass
		*
		*/
		
		public static function setNegativeButtonBitmap(value : Bitmap) : Void { _negativeButtonNormalBitmap = value; }
		
	
		/**
		* This is for setting an image to the negative button roll over state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a URL file path.
		*
		*/
		
		public static function setNegativeOverButtonImage(value : String) : Void { _negativeButtonOverURL = value; }  
		
		/**
		* This is for setting an image to the negative button roll over state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a Bitmap being pass
		*
		*/
		
		public static function setNegativeOverButtonBitmap(value : Bitmap) : Void { _negativeButtonOverBitmap = value; } 
		
		/**
		* This is for setting an image to the negative button press down state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a URL file path.
		*
		*/
		
		public static function setNegativeDownButtonImage(value : String) : Void{_negativeButtonDownURL = value;}
	
		/**
		* This is for setting an image to the negative button roll press state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a Bitmap being pass
		*
		*/
		public static function setNegativeDownButtonBitmap(value : Bitmap) : Void { _negativeButtonDownBitmap = value; } 
		
		/**
		* Set the neutral button default color
		* 
		* @param value Set the default color on the button
		* 
		*/
		
		private static function set_neutralButtonNormalColor(value : Int) : Int { _neutralButtonNormalColor = value; return value; }
		
	
		/**
		*
		* @return Return the button color
		*/
		
		private static function get_neutralButtonNormalColor() : Int { return _neutralButtonNormalColor; } 
		
		/**
		* Set the neutral button over state color
		* 
		* @param value Set the over state color on the button
		* 
		*/
		
		private static function set_neutralButtonOverColor(value : Int) : Int { _neutralButtonOverColor = value; return value; }
		
		
		/**
		*
		* @return Return the button color
		*/
		
		private static function get_neutralButtonOverColor() : Int { return _neutralButtonOverColor; }
		
	
		/**
		* Set the neutral button down state color
		* 
		* @param value Set the over state color on the button
		* 
		*/
		
		private static function set_neutralButtonDownColor(value : Int) : Int { _negativeButtonDownColor = value; return value; }
		
	
		/**
		*
		* @return Return the button color
		*/
		private static function get_neutralButtonDownColor() : Int { return _negativeButtonDownColor; } 
		
		/**
		* This is for setting an image to the neutral button default state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a URL file path.
		*
		*/
		public static function setNeutralButtonImage(value : String) : Void { _neutralButtonNormalURL = value; }
		
		/**
		* This is for setting an image to the neutral button default state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a Bitmap being pass
		*
		*/
		public static function setNeutralButtonBitmap(value : Bitmap) : Void { _neutralButtonNormalBitmap = value; }
		
	
		/**
		* This is for setting an image to the neutral button roll over state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a URL file path.
		*
		*/
		public static function setNeutralOverButtonImage(value : String) : Void { _neutralButtonOverURL = value; } 
		
		/**
		* This is for setting an image to the neutral button roll over state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a Bitmap being pass
		*
		*/
		public static function setNeutralOverButtonBitmap(value : Bitmap) : Void { _neutralButtonOverBitmap = value; } 
		
		/**
		* This is for setting an image to the neutral button press down state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a URL file path.
		*
		*/
		public static function setNeutralDownButtonImage(value : String) : Void { _neutralButtonDownURL = value; } 
		
	
		/**
		* This is for setting an image to the neutral button roll press state. It is best to set an image that can be tiled. 
		*
		* @param value Set the image based on a Bitmap being pass
		*
		*/
		public static function setNeutralDownButtonBitmap(value : Bitmap) : Void { _neutralButtonDownBitmap = value; }
		
	
		/**
		* Set the color of the alert title area once the user select
		* 
		* @param value The color you want to set the window to
		* 
		*/
	
		private static function set_windowTitleFocusColor(value : Int) : Int { _windowTitleFocusColor = value; return value; } 
		
		
	
		/**
		*
		* @return Return the color of the window
		*/
		private static function get_windowTitleFocusColor() : Int { return _windowTitleFocusColor; } 
		
	
		/**
		* Set the color of the alert window
		* 
		* @param value The color you want to set the window to
		* 
		*/
		private static function set_windowFocusColor(value : Int) : Int { _windowFocusColor = value; return value; } 
		
	
		/**
		 * @return Return the color of the window
		 */
	
		private static function get_windowFocusColor() : Int { return _windowFocusColor; }
	
	
		/**
		* Set the color of the alert window mid area
		* 
		* @param value The color you want to set the window to
		* 
		*/  
	
		private static function set_windowUnFocusColor(value : Int) : Int { _windowUnFocusColor = value; return value; }
		
		
		/**
		 * @return Return the color of the window
		 */
		
		private static function get_windowUnFocusColor() : Int { return _windowUnFocusColor; }
		 
		/**
		* Set the color of the alert title area once it is unfocused
		* 
		* @param value The color you want to set the window to
		* 
		*/
	
		private static function set_windowTitleUnFocusColor(value : Int) : Int { _windowTitleUnFocusColor = value; return value; }
		
	
		/**
		*
		* @return Return the color of the alert title area for it's unfocus state
		*/
		private static function get_windowTitleUnFocusColor() : Int{return _windowTitleUnFocusColor;}
	
		/**
		* This set an image to the upper top left corner of the alert based on a URL
		*
		* @param value The URL path to the image you want to use
		*
		*/
		public static function setWindowTopLeft(value : String) : Void{_windowTopLeftImageURL = value;} 
	
		/**
		* This set an image to the middle of the window based on a URL
		*
		* @param value The URL path to the image you want to use
		*
		*/
		public static function setWindowTopMiddle(value : String) : Void { _windowTopMiddleImageURL = value; }
		
		/**
		* This set an image to the upper top right corner of the window based on a URL
		*
		* @param value The URL path to the image you want to use
		*
		*/
		public static function setWindowTopRight(value : String) : Void { _windowTopRightImageURL = value; }
		
		/**
		* This set an image to the upper top left corner of the window based on a bitmap
		*
		* @param value The bitmap image you want to use
		*
		*/
		public static function setWindowTopLeftImage(value : Bitmap) : Void { _windowTopLeftImage = value; } 
		
		/**
		* This set an image to the middle of the window based on a bitmap
		*
		* @param value The bitmap image you want to use
		*
		*/
		public static function setWindowTopMiddleImage(value : Bitmap) : Void { _windowTopMiddleImage = value; }
		
		/**
		* This set an image to the upper top right corner of the window based on a bitmap
		*
		* @param value The bitmap image you want to use
		*
		*
		*/
		public static function setWindowTopRightImage(value : Bitmap) : Void { _windowTopRightImage = value; }  
		
	
		/**
		* This set an image to the right side of the window based on a URL
		*
		* @param value The URL path to the image you want to use
		*
		*/
	
		public static function setWindowMiddleRight(value : String) : Void { _windowMiddleRightImageURL = value; } 
	
	
		/**
		* This set an image to the left middle side of the window based on a URL
		*
		* @param value The URL path to the image you want to use
		*
		*/
		public static function setWindowMiddleLeft(value : String) : Void { _windowMiddleLeftImageURL = value; } 
		
		/**
		* This set an image to the right middle side of the window based on a bitmap
		*
		* @param value The bitmap image you want to use
		*
		*
		*/
		public static function setWindowMiddleRightImage(value : Bitmap) : Void { _windowMiddleRightImage = value; } 
	
		/**
		* This set an image to the left side of the window based on a bitmap
		*
		* @param value The bitmap image you want to use
		*
		*
		*/
		public static function setWindowMiddleLeftImage(value : Bitmap) : Void { _windowMiddleLeftImage = value; }
	
		/**
		* This set an image to the bottom lower left corner of the window based on a URL
		*
		* @param value The URL path to the image you want to use
		*
		*/
	
		public static function setWindowBottomLeft(value : String) : Void { _windowBottomLeftImageURL = value; }
	
	
		/**
		* This set an image to the bottom mid area of the window based on a URL
		*
		* @param value The URL path to the image you want to use
		*
		*/
	
		public static function setWindowBottomMiddle(value : String) : Void { _windowBottomMiddleImageURL = value; }  
		
	
		/**
		* This set an image to the bottom lower right corner of the window based on a URL
		*
		* @param value The URL path to the image you want to use
		*
		*/  public static function setWindowBottomRight(value : String) : Void{_windowBottomRightImageURL = value;
    } 
		/**
		* This set an image to the bottom lower left corner of the window based on a bitmap
		*
		* @param value The bitmap image you want to use
		*
		*/
		public static function setWindowBottomLeftImage(value : Bitmap) : Void { _windowBottomLeftImage = value; }
	
	
		/**
		* This set an image to the bottom mid area of the window based on a bitmap
		*
		* @param value The bitmap image you want to use
		*
		*/
		
		public static function setWindowBottomMiddleImage(value : Bitmap) : Void { _windowBottomMiddleImage = value; }
		
	
		/**
		* This set an image to the bottom lower right corner of the window based on a bitmap
		*
		* @param value The bitmap image you want to use
		*
		*/
	
		public static function setWindowBottomRightImage(value : Bitmap) : Void { _windowBottomRightImage = value; } 
		
	
		/**
		* This is for setting an image to the Alert background.
		*
		* @param value Set the image based on a URL file path.
		*
		*/
	
		public static function setBackground(value : String) : Void { _backgroundImageURL = value; }  
	
	
		/**
		* This is for setting an image to the Alert. It is best to set an image that can be tile. 
		*
		* @param value Set the image based on a Bitmap being pass
		*
		*/  
		public static function setBackgroundBitmap(value : Bitmap) : Void { _backgroundImage = value; } 
	
		/**
		* Set the level of detail on the Alert. This degrade the combo box with LOW, MEDIUM and HIGH settings.
		* Use the the UIDetailLevel class to change the settings.
		*
		* LOW - Remove all filters and bitmap images. 
		* MEDIUM - Remove all filters but leaves bitmap images with image smoothing off.
		* HIGH - Enable and show all filters plus display bitmap images if set
		*
		* @param value Send the value "low","medium" or "high"
		* @see com.chaos.ui.UIDetailLevel
		*/
		private static function set_detail(value : String) : String  
		{
			_qualityMode = value; 
			return value; 
		}  
	
	
		/**
		*
		* @return Return low, medium or high as string.
		*
		* @see com.chaos.ui.UIDetailLevel
		*/
		
		private static function get_detail() : String 
		{ 
			return _qualityMode;
		}
		
	
		/**
		* This is for setting an image to the Alert. It is best to set an image that can be tile. 
		*
		* @param strMessage The message that will be display in the alert.
		* @param strTitle The window title area text.
		* @param buttonArray The button(s) that will be displayed in the alert window.
		* @param alertBoxIcon The icon that you wan to use when the alert is created.
		* @param alertWindowIcon The window icon
		* @param callBackFunc The function that will be called once user click a button. You can figure out which button the user pressed based on the button name.
		* @param defaultLabelButton The button that will be used if nothing was passed in the buttonArray param
		*
		* @return The alert box that can be added to the stage or DisplayObject of your choice.
		*/
		
		public static function create(strMessage : String = "No Message", strTitle : String = "Alert Box", buttonArray : Array<String> = null, alertBoxIcon : DisplayImage = null, alertWindowIcon : DisplayImage = null, callBackFunc : Dynamic = null, defaultLabelButton : String = "") : Sprite 
		{
			// Setup AlertBox Holder  
			if (null == alertHolder) 
			{
				alertHolder = new Sprite();
				alertHolder.name = "chaos_alertHolder";
			}
			
			
			// Setup background block 
			if (null == backgroundBlock) 
			{
				backgroundBlock = new Shape();
				backgroundBlock.name = "chaos_alert_background";
				
				// Place background tint before window 
				alertHolder.addChild(backgroundBlock);
			}
         
		
		// If it doesn't have a listen then add one  
		if (!backgroundBlock.hasEventListener(Event.ADDED_TO_STAGE))
		backgroundBlock.addEventListener(Event.ADDED_TO_STAGE, setupTintStageEvent, false, 0, false);
		
		updateAlertBox();
		var window : Window = new Window();
		
		if (null != alertWindowIcon) 
		window.setIconBitmap(alertWindowIcon.image);
		
		window.name = "window_" + _windowCount;
		
		_windowList.addItem(window);
		_windowCount++;
		
		var label : Label = new Label();
		label.name = "textlabel";
		
		var buttonHolderClip : Sprite = new Sprite();
		buttonHolderClip.name = "buttonHolder";
		
		var holderClip : Sprite = new Sprite();
		holderClip.name = "alertContent";
		
		var useTextFormat : Bool = false;
		
		if ("" != UIStyleManager.WINDOW_TITLE_TEXT_FONT)
			window.textLabel.font = UIStyleManager.WINDOW_TITLE_TEXT_FONT;useTextFormat = true;
		
		if ( -1 != UIStyleManager.WINDOW_TITLE_TEXT_SIZE)
			window.textLabel.size = UIStyleManager.WINDOW_TITLE_TEXT_SIZE; useTextFormat = true;
			
		if (null != UIStyleManager.WINDOW_TITLE_TEXT_EMBED)
		window.textLabel.setEmbedFont(UIStyleManager.WINDOW_TITLE_TEXT_EMBED);
		
		if ( -1 != UIStyleManager.WINDOW_TITLE_TEXT_COLOR)
		window.textLabel.textColor = UIStyleManager.WINDOW_TITLE_TEXT_COLOR;
		
		// Setup Window
		window.addEventListener(Event.ADDED_TO_STAGE, setupWindowStageEvent, false, 0, true);
		window.scrollPane.mode = ScrollPolicy.OFF;
		window.windowMiddleSize = ALERT_MIDDLE_SIZE;
		window.windowBottomLeftSize = ALERT_BOTTOM_SIZE;
		window.windowBottomMiddleSize = ALERT_BOTTOM_SIZE;
		window.windowBottomRightSize = ALERT_BOTTOM_SIZE;
		window.windowTopLeftSize = ALERT_TOP_SIZE;
		window.windowTopMiddleSize = ALERT_TOP_SIZE;
		window.windowTopRightSize = ALERT_TOP_SIZE;
		window.setWindowTitle(strTitle);
		window.width = DEFAULT_WIDTH;
		window.height = DEFAULT_HEIGHT;
		window.resize = false; 
		
		// Setup colors for window & check and setup bitmap/image if needed  
		window.windowTitleFocusColor = (( -1 == UIStyleManager.ALERT_TITLE_AREA_COLOR)) ? _windowTitleFocusColor : UIStyleManager.ALERT_TITLE_AREA_COLOR;
		window.windowTitleUnFocusColor = (( -1 == UIStyleManager.ALERT_TITLE_AREA_UNFOCUS_COLOR)) ? _windowTitleUnFocusColor : UIStyleManager.ALERT_TITLE_AREA_UNFOCUS_COLOR;
		window.windowFocusColor = (( -1 == UIStyleManager.ALERT_WINDOW_FOCUS_COLOR)) ? _windowFocusColor : UIStyleManager.ALERT_WINDOW_FOCUS_COLOR;
		window.windowUnFocusColor = (( -1 == UIStyleManager.ALERT_WINDOW_UNFOCUS_COLOR)) ? _windowUnFocusColor : UIStyleManager.ALERT_WINDOW_UNFOCUS_COLOR;
		window.scrollPane.backgroundColor = (( -1 == UIStyleManager.ALERT_BACKGROUND_COLOR)) ? _backgroundColor : UIStyleManager.ALERT_BACKGROUND_COLOR;
		
		if ("" != UIStyleManager.ALERT_ICON_LOCATION)
			window.iconLocation = UIStyleManager.ALERT_ICON_LOCATION;
		
		if ("" != UIStyleManager.ALERT_BUTTON_LOCATION)   
			window.buttonLocation = UIStyleManager.ALERT_BUTTON_LOCATION;
		
		if ("" != UIStyleManager.ALERT_LABEL_LOCATION)
			window.labelLocation = UIStyleManager.ALERT_LABEL_LOCATION;
		
		// Setting Bitmaps if need be
		initSkin(window);
		
		// This is just in cause the settings are going go be switched out loading image from URL
		setupAlertTheme(window);
		setCloseButtonTheme(window);
		
		// Only show close button if need be will never show min and max button for AlertBox
		window.showCloseButton = _enabledCloseButton;
		window.showMaxButton = false;
		window.showMinButton = false;
		
		// Just in case it's going to be set locally  
		if ("" != _buttonLocation)
		window.buttonLocation = _buttonLocation;
		
		if ("" != _buttonLocation)
		window.labelLocation = _buttonLocation;
		
		
		
		//var removeWin:Function = function( event:Event ):Void
		//{
		//	removeAlertWindow(window, null, removeWin, callBackFunc);
		//}
		//
		//removeAlertWindow(window, null, removeWin, callBackFunc);
		//
		//window.addEventListener(WindowEvent.WINDOW_CLOSE_BTN, removeWin, false, 0);
		//
		if (null != callBackFunc)
			window.addEventListener(WindowEvent.WINDOW_CLOSE_BTN, callBackFunc, false, 5, false);
		
		// Setup Label loc  
		label.text = strMessage;
		label.align = ((label.textField.numLines <= 2)) ? TextFormatAlign.CENTER : TextFormatAlign.LEFT;
		label.width = DEFAULT_WIDTH - (LABEL_OFFSET_X / 2);
		label.height = (DEFAULT_HEIGHT / 2);
		label.textField.multiline = true;
		label.textField.wordWrap = true;
		label.textField.selectable = ALERT_LABEL_TEXT_SELECTABLE;
		label.x = LABEL_OFFSET_X;
		label.y = (DEFAULT_HEIGHT / 2) - window.windowTopMiddleSize - LABEL_OFFSET_Y;
		
		
		holderClip.addChild(label);
		
		
		// If there is a need for a scrollbar then add one  
		if (label.textField.textHeight > label.height)
		{
			var scroll : ScrollBar = new ScrollBar();
			var newScrollContent : ScrollContent = new ScrollContent(label.textField, scroll);
			scroll.direction = ScrollBarDirection.VERTICAL;
			holderClip.mouseChildren = true;
			holderClip.addChild(scroll);
			scroll.y = label.y;
        }
		
		// Check and Setup Icon if need be  
		if (alertBoxIcon != null) 
		{ 
			// If Icon is loaded just draw it if not wait for it to load  
			if (alertBoxIcon.loaded) 
			{
				var iconImage : Sprite = new Sprite();
				iconImage.graphics.beginBitmapFill(alertBoxIcon.image.bitmapData, null, true);
				iconImage.graphics.drawRect(0, 0, alertBoxIcon.image.bitmapData.width, alertBoxIcon.image.bitmapData.height);
				iconImage.graphics.endFill();
				iconImage.width = ICON_SIZE_WIDTH;
				iconImage.height = ICON_SIZE_HEIGHT;
				iconImage.x = ICON_OFFSET_X;
				iconImage.y = (DEFAULT_HEIGHT / 2) - window.windowTopMiddleSize - ICON_OFFSET_Y;
				label.width = DEFAULT_WIDTH - ICON_SIZE_WIDTH - LABEL_OFFSET_X - BUTTON_OFFSET_X;
				label.x = ICON_SIZE_WIDTH + LABEL_OFFSET_X;
				holderClip.addChild(iconImage);
			}
        }
        else
		{
			// Setup an event so soon as image is done loading  
			alertBoxIcon.onImageComplete = function() : Void
			{
				var iconImage : Sprite = new Sprite();
				iconImage.graphics.beginBitmapFill(alertBoxIcon.image.bitmapData, null, true);
				iconImage.graphics.drawRect(0, 0, alertBoxIcon.image.bitmapData.width, alertBoxIcon.image.bitmapData.height);
				iconImage.graphics.endFill();
				iconImage.width = ICON_SIZE_WIDTH;
				iconImage.height = ICON_SIZE_HEIGHT;
				iconImage.x = ICON_OFFSET_X;
				iconImage.y = (DEFAULT_HEIGHT / 2) - window.windowTopMiddleSize - ICON_OFFSET_Y;
				label.width = DEFAULT_WIDTH - ICON_SIZE_WIDTH - LABEL_OFFSET_X - BUTTON_OFFSET_X;
				label.x = ICON_SIZE_WIDTH + LABEL_OFFSET_X;
				holderClip.addChild(iconImage);
				alertBoxIcon.onImageComplete = null;
            };
			
        }
          
		// Look into hiding modal block  
		var hasModal : Bool = modalCheck(buttonArray);
		backgroundBlock.visible = ((hasModal)) ? false : true; 
		
		// Check to see if buttons passed if not then create default button  
		if (buttonArray != null) 
		{  // Drop count by 1 if have Modal flag in list  
			var buttonCount : Int = ((hasModal)) ? buttonArray.length - 1 : buttonArray.length;
			
			for (i in 0...buttonArray.length - 1 + 1)
			{ 
				// Turn off background shape  
				if (Alert.NONMODAL != buttonArray[i]) 
				{
					// Grab button and place it in holder  
					var tempButton : Button = createAlertButton(buttonArray[i]);
					buttonHolderClip.addChild(tempButton);
					
					//var buttonRemoveWin : Function = function(event : MouseEvent) : Void
					//{
					//	removeAlertWindow(window, tempButton, buttonRemoveWin, callBackFunc);
					//	tempButton.removeEventListener(MouseEvent.CLICK, buttonRemoveWin);
					//	
					//	if (null != callBackFunc)
					//	tempButton.removeEventListener(MouseEvent.CLICK, callBackFunc);
					//	buttonRemoveWin = null;
                    //}
					//
					//tempButton.addEventListener(MouseEvent.CLICK, buttonRemoveWin, false, 0);
					
					if (null != callBackFunc)
					tempButton.addEventListener(MouseEvent.CLICK, callBackFunc, false, 5, false); 
					
					// Size done buttons if 3 buttons or more  ;
					if (buttonCount >= SMALL_BUTTON_COUNT) 
					{
						tempButton.width = SMALL_BUTTON_WIDTH;
						tempButton.height = SMALL_BUTTON_HEIGHT;
                    }
					
					// Show close button if using cancel button  
					if (tempButton.name == CANCEL)
					window.showCloseButton = true;
					
					tempButton.x = ((buttonHolderClip.numChildren == 1)) ? BUTTON_OFFSET_X : tempButton.width + buttonHolderClip.getChildAt(buttonHolderClip.numChildren - 2).x + BUTTON_OFFSET_X;
                }
            }
        }
        else 
		{
			var defaultButton : Button = createAlertButton(defaultLabelButton);
			buttonHolderClip.addChild(defaultButton);
        }
		
		// Set button holder loc and add to holder  
		buttonHolderClip.x = ((window.width - buttonHolderClip.width) / 2) - BUTTON_OFFSET_X;
		buttonHolderClip.y = DEFAULT_HEIGHT - window.windowTopMiddleSize - window.windowBottomMiddleSize - BUTTON_OFFSET_Y; holderClip.addChild(buttonHolderClip);
		
		// Place movieclip in window  
		window.scrollPane.source = holderClip;
		alertHolder.addChild(window);
		return alertHolder;
    }
	
	private static function setCloseButtonTheme(window : Window) : Void
	{
		window.closeButtonNormalColor = (( -1 == UIStyleManager.ALERT_CLOSE_BUTTON_NORMAL_COLOR)) ? _closeButtonNormalColor : UIStyleManager.ALERT_CLOSE_BUTTON_NORMAL_COLOR;
		window.closeButtonOverColor = (( -1 == UIStyleManager.ALERT_CLOSE_BUTTON_OVER_COLOR)) ? _closeButtonOverColor : UIStyleManager.ALERT_CLOSE_BUTTON_OVER_COLOR;
		window.closeButtonDownColor = (( -1 == UIStyleManager.ALERT_CLOSE_BUTTON_DOWN_COLOR)) ? _closeButtonDownColor : UIStyleManager.ALERT_CLOSE_BUTTON_DOWN_COLOR;
		window.closeButtonDisableColor = ((-1 == UIStyleManager.ALERT_CLOSE_BUTTON_DISABLE_COLOR)) ? _closeButtonDisableColor : UIStyleManager.ALERT_CLOSE_BUTTON_DISABLE_COLOR;  // All images for close button  if (_closeButtonNormalURL != "")             window.setCloseButtonImage(_closeButtonNormalURL);if (_closeButtonOverURL != "")             window.setCloseOverButtonImage(_closeButtonOverURL);if (_closeButtonDownURL != "")             window.setCloseDownButtonImage(_closeButtonDownURL);if (_closeButtonDisableURL != "")             window.setCloseDisableButtonImage(_closeButtonDisableURL)  // All images for close button that are bitmaps  ;if (_closeButtonNormalBitmap != null)             window.setCloseButtonBitmap(_closeButtonNormalBitmap);if (_closeButtonOverBitmap != null)             window.setCloseOverButtonBitmap(_closeButtonOverBitmap);if (_closeButtonDownBitmap != null)             window.setCloseDownButtonBitmap(_closeButtonDownBitmap);if (_closeButtonDisableBitmap != null)             window.setCloseDisableButtonBitmap(_closeButtonDisableBitmap);
    }
	
	private static function setupAlertTheme(window : Window) : Void
	{ 
		// Top
		if (_windowTopLeftImageURL != "")
		window.setWindowTopLeft(_windowTopLeftImageURL);
		
		if (_windowTopMiddleImageURL != "")
		window.setWindowTopMiddle(_windowTopMiddleImageURL);
		
		if (_windowTopRightImageURL != "")  
		window.setWindowTopRight(_windowTopRightImageURL);
		
		// Mid 
		if (_windowMiddleLeftImageURL != "")
		window.setWindowMiddleLeft(_windowMiddleLeftImageURL);
		
		if (_windowMiddleRightImageURL != "")
		window.setWindowMiddleRight(_windowMiddleRightImageURL);
		
		// Bottom  
		if (_windowBottomLeftImageURL != "")   
		window.setWindowTopLeft(_windowBottomLeftImageURL);
		
		if (_windowBottomMiddleImageURL != "")
		window.setWindowTopMiddle(_windowBottomMiddleImageURL);
		
		if (_windowBottomRightImageURL != "")
		window.setWindowTopRight(_windowBottomRightImageURL);
		
		// Background
		if (_backgroundImageURL != "")
		window.scrollPane.setBackgroundImage(_backgroundImageURL);
		
		// Top
		
		// Apply already loaded bitmaps  
		if (_windowTopLeftImage != null) 
		window.setWindowTopLeftImage(_windowTopLeftImage);
		
		if (_windowTopMiddleImage != null)
		window.setWindowTopMiddleImage(_windowTopMiddleImage);
		
		if (_windowTopRightImage != null)
		window.setWindowTopRightImage(_windowTopRightImage);
		
		// Mid  
		
		if (_windowMiddleLeftImage != null)
		window.setWindowMiddleLeftImage(_windowMiddleLeftImage);
		
		if (_windowMiddleRightImage != null)
		window.setWindowMiddleRightImage(_windowMiddleRightImage);
		
		// Bottom  
		if (_windowBottomLeftImage != null)
		window.setWindowBottomLeftImage(_windowBottomLeftImage);
		
		if (_windowBottomMiddleImage != null)
		window.setWindowBottomMiddleImage(_windowBottomMiddleImage);
		
		if (_windowBottomRightImage != null)
		window.setWindowBottomRightImage(_windowBottomRightImage);
		
		// Hide 
		if (_backgroundImage != null)
		window.scrollPane.setBackgroundBitmap(_backgroundImage);
    }
	
	
	private static function initSkin(window : Window) : Void
	{
		// Top
		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_TOP_LEFT)) 
		window.setWindowTopLeftImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_TOP_LEFT));
		
		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_TOP_MIDDLE)) 
		window.setWindowTopMiddleImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_TOP_MIDDLE));
		
		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_TOP_RIGHT))  
		window.setWindowTopRightImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_TOP_RIGHT));
		
		// Middle
		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_MIDDLE_LEFT))
		window.setWindowMiddleLeftImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_MIDDLE_LEFT));
		
		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_MIDDLE_RIGHT))
		window.setWindowMiddleRightImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_MIDDLE_RIGHT));
		
		// Bottom  
		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_BOTTOM_LEFT))
		window.setWindowBottomLeftImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_BOTTOM_LEFT));
		
		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_BOTTOM_MIDDLE))
		window.setWindowBottomMiddleImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_BOTTOM_MIDDLE));
		
		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_BOTTOM_RIGHT))
		window.setWindowBottomRightImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_BOTTOM_RIGHT));
		
		// Background  
		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_BACKGROUND)) 
		window.scrollPane.setBackgroundBitmap(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_BACKGROUND));
		
		// Pattern Overlay - Every mask layer has to be cloned because you can't use the same display object.
		//if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_TOP_PATTERN_OVERLAY) && null != UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_TOP_PATTERN_LEFT_MASK) && null != UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_TOP_PATTERN_CENTER_MASK) && null != UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_TOP_PATTERN_RIGHT_MASK))
		//{
		//	var topLeftMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_TOP_PATTERN_LEFT_MASK));
		//	var topCenterMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_TOP_PATTERN_CENTER_MASK));
		//	var topRightMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_TOP_PATTERN_RIGHT_MASK));
		//	window.setWindowTopPattern(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_TOP_PATTERN_OVERLAY), topLeftMask, topCenterMask, topRightMask);
        //}
		//
		//if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_MIDDLE_PATTERN_OVERLAY) && null != UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_MIDDLE_PATTERN_LEFT_MASK) && null != UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_MIDDLE_PATTERN_RIGHT_MASK))
		//{
		//	var middleLeftMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_MIDDLE_PATTERN_LEFT_MASK));
		//	var middleRightMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_MIDDLE_PATTERN_RIGHT_MASK));
		//	
		//	window.setWindowMiddlePattern(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_MIDDLE_PATTERN_OVERLAY), middleLeftMask, middleRightMask);
        //}
		//
		//if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_BOTTOM_PATTERN_OVERLAY) && null != UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_BOTTOM_PATTERN_LEFT_MASK) && null != UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_BOTTOM_PATTERN_CENTER_MASK) && null != UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_BOTTOM_PATTERN_RIGHT_MASK))
		//{
		//	var bottomLeftMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_BOTTOM_PATTERN_LEFT_MASK));
		//	var bottomCenterMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_BOTTOM_PATTERN_CENTER_MASK));
		//	var bottomRightMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Alert.TYPE, UIBitmapManager.ALERT_BOTTOM_PATTERN_RIGHT_MASK));
		//	
		//	window.setWindowBottomPattern(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_BOTTOM_PATTERN_OVERLAY), bottomLeftMask, bottomCenterMask, bottomRightMask);
        //} 
		
		// All images for close button that are bitmaps 
		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_NORMAL))  
		window.setCloseButtonBitmap(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_NORMAL));
		
		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_OVER)) 
		window.setCloseOverButtonBitmap(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_OVER));
		
		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_DOWN))
		window.setCloseDownButtonBitmap(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_DOWN));
		
		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_DISABLE))  
		window.setCloseDisableButtonBitmap(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_DISABLE));
		
    }
	
	private static function removeAlertWindow(window : IWindow, button : IButton, removeWinFunc : Dynamic->Void, callBackFunc : Dynamic->Void = null) : Void
	{
		var oldWindow : IWindow = try cast(_windowList.removeItem(window), IWindow) catch (e:Dynamic) null;
		
		if (null != oldWindow && null != oldWindow.parent) 
		oldWindow.parent.removeChild(window.displayObject);
		
		if (null != button && button.hasEventListener(MouseEvent.CLICK)) 
		{
			if (null != callBackFunc) 
			button.removeEventListener(MouseEvent.CLICK, callBackFunc);
			button.removeEventListener(MouseEvent.CLICK, removeWinFunc);
			
        }
		
		if (null != window && window.hasEventListener(WindowEvent.WINDOW_CLOSE_BTN)) 
		{
			if (null != callBackFunc)  
			window.removeEventListener(MouseEvent.CLICK, callBackFunc);
			
			window.removeEventListener(MouseEvent.CLICK, removeWinFunc);
			
        } 
		
		// Remove background if no more windows are left in the list
		if (_windowList.length == 0) 
		{
			backgroundBlock.graphics.clear();
			backgroundBlock.removeEventListener(Event.ADDED_TO_STAGE, setupTintStageEvent);
        }
		
    }
	
	private static function createAlertButton(buttonType : String) : Button
	{
		var tempButton : Button = new Button();

        switch (buttonType)
        {case Alert.OK:tempButton.label = (("" == UIStyleManager.ALERT_OK_TEXT)) ? _okBtnLabel : UIStyleManager.ALERT_OK_TEXT;tempButton.name = OK;setButtonType("positive", tempButton);case Alert.CANCEL:tempButton.label = (("" == UIStyleManager.ALERT_CANCEL_TEXT)) ? _cancelBtnLabel : UIStyleManager.ALERT_CANCEL_TEXT;tempButton.name = CANCEL;setButtonType("negative", tempButton);case Alert.YES:tempButton.label = (("" == UIStyleManager.ALERT_YES_TEXT)) ? _yesBtnLabel : UIStyleManager.ALERT_YES_TEXT;tempButton.name = YES;setButtonType("positive", tempButton);case Alert.NO:tempButton.label = (("" == UIStyleManager.ALERT_NO_TEXT)) ? _noBtnLabel : UIStyleManager.ALERT_NO_TEXT;tempButton.name = NO;setButtonType("negative", tempButton);case Alert.MAYBE:tempButton.label = (("" == UIStyleManager.ALERT_MAYBE_TEXT)) ? _noBtnLabel : UIStyleManager.ALERT_MAYBE_TEXT;tempButton.name = MAYBE;setButtonType("neutral", tempButton);default:tempButton.label = (("" == UIStyleManager.ALERT_OK_TEXT)) ? _okBtnLabel : UIStyleManager.ALERT_OK_TEXT;tempButton.name = OK;setButtonType("positive", tempButton);
        }return tempButton;
    }
	
	private static function setButtonType(strType : String, button : Button) : Void
	{
		if ("positive" == strType.toLowerCase()) 
		{
			button.buttonColor = (( -1 == UIStyleManager.ALERT_POSITIVE_BUTTON_NORMAL_COLOR)) ? _positiveButtonNormalColor : UIStyleManager.ALERT_POSITIVE_BUTTON_NORMAL_COLOR;
			button.buttonOverColor = (( -1 == UIStyleManager.ALERT_POSITIVE_BUTTON_OVER_COLOR)) ? _positiveButtonOverColor : UIStyleManager.ALERT_POSITIVE_BUTTON_OVER_COLOR;
			button.buttonDownColor = (( -1 == UIStyleManager.ALERT_POSITIVE_BUTTON_DOWN_COLOR)) ? _positiveButtonDownColor : UIStyleManager.ALERT_POSITIVE_BUTTON_DOWN_COLOR;
			
			if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_POSITIVE_BUTTON_NORMAL))   
			button.setBackgroundBitmap(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_POSITIVE_BUTTON_NORMAL));
			
			if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_POSITIVE_BUTTON_OVER)) 
			button.setOverBackgroundBitmap(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_POSITIVE_BUTTON_OVER));
			
			if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_POSITIVE_BUTTON_DOWN))
			button.setDownBackgroundBitmap(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_POSITIVE_BUTTON_DOWN));
			
			// All images for positive button
			if (_positiveButtonNormalURL != "")
			button.setBackgroundImage(_positiveButtonNormalURL);
			
			if (_positiveButtonOverURL != "") 
			button.setOverBackgroundImage(_positiveButtonOverURL);
			
			if (_positiveButtonDownURL != "")  
			button.setDownBackgroundImage(_positiveButtonDownURL);
			
			// All images for positive button that are bitmaps 
			if (_positiveButtonNormalBitmap != null)
			button.setBackgroundBitmap(_positiveButtonNormalBitmap);
			
			if (_positiveButtonOverBitmap != null)
			button.setOverBackgroundBitmap(_positiveButtonOverBitmap);
			
			if (_positiveButtonDownBitmap != null)
			button.setDownBackgroundBitmap(_positiveButtonDownBitmap);
        }
        else if ("negative" == strType.toLowerCase())
		{
			button.buttonColor = (( -1 == UIStyleManager.ALERT_NEGATIVE_BUTTON_NORMAL_COLOR)) ? _negativeButtonNormalColor : UIStyleManager.ALERT_NEGATIVE_BUTTON_NORMAL_COLOR;
			button.buttonOverColor = (( -1 == UIStyleManager.ALERT_NEGATIVE_BUTTON_OVER_COLOR)) ? _negativeButtonOverColor : UIStyleManager.ALERT_NEGATIVE_BUTTON_OVER_COLOR;
			button.buttonDownColor = (( -1 == UIStyleManager.ALERT_NEGATIVE_BUTTON_DOWN_COLOR)) ? _negativeButtonDownColor : UIStyleManager.ALERT_NEGATIVE_BUTTON_DOWN_COLOR;
			
			if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_NORMAL))   
			button.setBackgroundBitmap(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_NORMAL));
			
			if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_OVER)) 
			button.setOverBackgroundBitmap(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_OVER));
			
			if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_DOWN))
			button.setDownBackgroundBitmap(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_DOWN));
			
			// All images for negative button  
			if (_negativeButtonNormalURL != "") 
			button.setBackgroundImage(_negativeButtonNormalURL);
			
			if (_negativeButtonOverURL != "") 
			button.setOverBackgroundImage(_negativeButtonOverURL);
			
			if (_negativeButtonDownURL != "") 
			button.setDownBackgroundImage(_negativeButtonDownURL);
			
			// All images for negative button that are bitmaps  
			if (_negativeButtonNormalBitmap != null)
			button.setBackgroundBitmap(_negativeButtonNormalBitmap);
			
			if (_negativeButtonOverBitmap != null)
			button.setOverBackgroundBitmap(_negativeButtonOverBitmap);
			
			if (_negativeButtonDownBitmap != null)
			button.setDownBackgroundBitmap(_negativeButtonDownBitmap);
        }
        else if ("neutral" == strType.toLowerCase())
		{
			button.buttonColor = (( -1 == UIStyleManager.ALERT_NEUTRAL_BUTTON_NORMAL_COLOR)) ? _neutralButtonNormalColor : UIStyleManager.ALERT_NEUTRAL_BUTTON_NORMAL_COLOR;
			button.buttonOverColor = (( -1 == UIStyleManager.ALERT_NEUTRAL_BUTTON_OVER_COLOR)) ? _neutralButtonOverColor : UIStyleManager.ALERT_NEUTRAL_BUTTON_OVER_COLOR;
			button.buttonDownColor = (( -1 == UIStyleManager.ALERT_NEUTRAL_BUTTON_DOWN_COLOR)) ? _neutralButtonDownColor : UIStyleManager.ALERT_NEUTRAL_BUTTON_DOWN_COLOR;
			
			if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEUTRAL_BUTTON_DOWN)) 
			button.setBackgroundBitmap(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEUTRAL_BUTTON_DOWN));
			
			if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_OVER)) 
			button.setOverBackgroundBitmap(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEUTRAL_BUTTON_OVER));
			
			if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_DOWN))    
			button.setDownBackgroundBitmap(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEUTRAL_BUTTON_DOWN));
			
			// All images for neutral button  
			if (_neutralButtonNormalURL != "") 
			button.setBackgroundImage(_neutralButtonNormalURL);
			
			if (_neutralButtonOverURL != "") 
			button.setOverBackgroundImage(_neutralButtonOverURL);
			
			if (_neutralButtonDownURL != "")   
			button.setDownBackgroundImage(_neutralButtonDownURL);
			
			// All images for neutral button that are bitmaps
			if (_neutralButtonNormalBitmap != null)
			button.setBackgroundBitmap(_negativeButtonNormalBitmap);
			
			if (_neutralButtonOverBitmap != null) 
			button.setOverBackgroundBitmap(_negativeButtonOverBitmap);
			
			if (_neutralButtonDownBitmap != null) 
			button.setDownBackgroundBitmap(_negativeButtonDownBitmap);
        }
    }
	
	private static function modalCheck(buttonArray : Array<String>) : Bool
	{
		for (i in Reflect.fields(buttonArray))
		{
			if (Alert.NONMODAL == i)
			return true;
        }
		
		return false;
    }
	
	private static function updateAlertBox(event : Event = null) : Void
	{
		backgroundBlock.graphics.clear();
		
		if (null == backgroundBlock.stage) 
		return;
		
		backgroundBlock.graphics.beginFill(_tintBackgroundColor, _tintAlpha);
		backgroundBlock.graphics.drawRect(0, 0, backgroundBlock.stage.stageWidth, backgroundBlock.stage.stageHeight);
		backgroundBlock.graphics.endFill();
		
		if (_centerWindow)
		{
			for (i in 0..._windowList.length)
			{
				var window : Window = _windowList.getItemAt(i);
				window.x = (window.stage.stageWidth / 2) - (window.width / 2);
				window.y = (window.stage.stageHeight / 2) - (window.height / 2);
            }
        }
    }
	
	private static function setupWindowStageEvent(event : Event) : Void 
	{
		event.currentTarget.stage.align = StageAlign.TOP_LEFT;
		event.currentTarget.x = (event.currentTarget.stage.stageWidth >> 1) - (event.currentTarget.width >> 1);
		event.currentTarget.y = (event.currentTarget.stage.stageHeight >> 1) - (event.currentTarget.height >> 1);
    }
	
	private static function setupTintStageEvent(event : Event) : Void
	{ 
		// Remove old event  
		var backgroundBlock : Shape = (try cast(event.currentTarget, Shape) catch (e:Dynamic) null);
		
		backgroundBlock.removeEventListener(Event.ADDED_TO_STAGE, setupTintStageEvent);
		backgroundBlock.stage.align = StageAlign.TOP_LEFT;
		backgroundBlock.stage.addEventListener(Event.RESIZE, updateAlertBox, false, 0, true);
		backgroundBlock.graphics.clear();
		backgroundBlock.graphics.beginFill(_tintBackgroundColor, _tintAlpha);
		backgroundBlock.graphics.drawRect(0, 0, backgroundBlock.stage.stageWidth, backgroundBlock.stage.stageHeight);
		backgroundBlock.graphics.endFill();
    }
	

}

package com.chaos.ui;

import com.chaos.data.DataProvider;
import com.chaos.media.DisplayImage;
import com.chaos.ui.Button;
import com.chaos.ui.UIBitmapManager;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.Window;
import com.chaos.ui.data.AlertObjectData;

import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.IWindow;
import openfl.display.BitmapData;

import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextFormatAlign;

/**
 * AlertBox system that blocks whatever that is in the background
 */
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

	private static var _alertList : DataProvider<AlertObjectData> = new DataProvider<AlertObjectData>();

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
	private static var _windowTitleColor : Int = 0xCCCCCC;
	private static var _windowTitleUnFocusColor : Int = 0x333333;
	private static var _windowFocusColor : Int = 0xFFFFFF;
	private static var _windowUnFocusColor : Int = 0xCCCCCC;

	private static var _windowTopLeftImage : BitmapData = null;
	private static var _windowTopMiddleImage : BitmapData = null;
	private static var _windowTopRightImage : BitmapData = null;

	private static var _windowMiddleLeftImage : BitmapData = null;

	private static var _windowMiddleRightImage : BitmapData = null;

	private static var _windowBottomLeftImage : BitmapData = null;

	private static var _windowBottomMiddleImage : BitmapData = null;
	private static var _windowBottomRightImage : BitmapData = null;

	private static var _backgroundImage : BitmapData = null;

	private static var _closeButtonNormalColor : Int = 0xCCCCCC;
	private static var _closeButtonOverColor : Int = 0x666666;
	private static var _closeButtonDownColor : Int = 0x333333;
	private static var _closeButtonDisableColor : Int = 0x999999;

	private static var _closeButtonNormalBitmap : BitmapData = null;
	private static var _closeButtonOverBitmap : BitmapData = null;
	private static var _closeButtonDownBitmap : BitmapData = null;
	private static var _closeButtonDisableBitmap : BitmapData = null;

	private static var _positiveButtonNormalColor : Int = 0xCCCCCC;
	private static var _positiveButtonOverColor : Int = 0x666666;
	private static var _positiveButtonDownColor : Int = 0x333333;
	private static var _positiveButtonNormalURL : String = "";
	private static var _positiveButtonOverURL : String = "";
	private static var _positiveButtonDownURL : String = "";
	private static var _positiveButtonNormalBitmap : BitmapData = null;
	private static var _positiveButtonOverBitmap : BitmapData = null;
	private static var _positiveButtonDownBitmap : BitmapData = null;

	private static var _negativeButtonNormalColor : Int = 0xCCCCCC;
	private static var _negativeButtonOverColor : Int = 0x666666;
	private static var _negativeButtonDownColor : Int = 0x333333;
	private static var _negativeButtonNormalBitmap : BitmapData = null;
	private static var _negativeButtonOverBitmap : BitmapData = null;
	private static var _negativeButtonDownBitmap : BitmapData = null;

	private static var _neutralButtonNormalColor : Int = 0xCCCCCC;
	private static var _neutralButtonOverColor : Int = 0x666666;
	private static var _neutralButtonDownColor : Int = 0x333333;
	private static var _neutralButtonNormalBitmap : BitmapData = null;
	private static var _neutralButtonOverBitmap : BitmapData = null;
	private static var _neutralButtonDownBitmap : BitmapData = null;

	private static var _tintBackgroundColor : Int = 0x000000;
	private static var _tintAlpha : Float = .5;

	private function new()
	{

	}
	/**
	 * Return an array with all the windows that were created
	 */

	static public function get_windowList() : DataProvider<AlertObjectData>
	{
		return _alertList;
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
			_buttonLocation = value;
		else
			_buttonLocation = "left";

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
	* @param value Set the image based on a Bitmap being pass
	*
	*/

	public static function setCloseButtonImage(value : BitmapData) : Void
	{
		_closeButtonNormalBitmap = value;
	}



	/**
	* This is for setting an image to the close button roll over state. It is best to set an image that can be tiled.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/

	public static function setCloseOverButtonImage(value : BitmapData) : Void
	{
		_closeButtonOverBitmap = value;
	}



	/**
	* This is for setting an image to the close button roll press state. It is best to set an image that can be tiled.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	public static function setCloseDownButtonImage(value : BitmapData) : Void
	{
		_closeButtonDownBitmap = value;
	}



	/**
	* This is for setting an image to the button disable state. It is best to set an image that can be tiled.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/

	public static function setCloseDisableButtonImage(value : BitmapData) : Void
	{
		_closeButtonDisableBitmap = value;
	}

	/**
	* Set the positive button default color
	*
	* @param value Set the default color on the button
	*
	*/
	private static function set_PositiveButtonNormalColor(value : Int) : Int
	{
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
	* @param value Set the image based on a Bitmap being pass
	*
	*/

	public static function setPositiveButtonImage(value : BitmapData) : Void
	{
		_positiveButtonNormalBitmap = value;
	}


	/**
	* This is for setting an image to the positive button roll over state. It is best to set an image that can be tiled.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/

	public static function setPositiveOverButtonImage(value : BitmapData) : Void { _positiveButtonOverBitmap = value; }


	/**
	* This is for setting an image to the positive button roll press state. It is best to set an image that can be tiled.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	public static function setPositiveDownButtonImage(value : BitmapData) : Void { _positiveButtonDownBitmap = value; }

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
	* @param value Set the image based on a Bitmap being pass
	*
	*/

	public static function setNegativeButtonImage(value : BitmapData) : Void { _negativeButtonNormalBitmap = value; }


	/**
	* This is for setting an image to the negative button roll over state. It is best to set an image that can be tiled.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/

	public static function setNegativeOverButtonImage(value : BitmapData) : Void { _negativeButtonOverBitmap = value; }


	/**
	* This is for setting an image to the negative button roll press state. It is best to set an image that can be tiled.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	public static function setNegativeDownButtonImage(value : BitmapData) : Void { _negativeButtonDownBitmap = value; }

	/**
	* Set the neutral button default color
	*
	* @param value Set the default color on the button
	*
	*/

	private static function set_neutralButtonNormalColor(value : Int) : Int
	{
		_neutralButtonNormalColor = value;
		return value;
	}

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
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	public static function setNeutralButtonImage(value : BitmapData) : Void { _neutralButtonNormalBitmap = value; }



	/**
	* This is for setting an image to the neutral button roll over state. It is best to set an image that can be tiled.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	public static function setNeutralOverButtonImage(value : BitmapData) : Void { _neutralButtonOverBitmap = value; }


	/**
	* This is for setting an image to the neutral button roll press state. It is best to set an image that can be tiled.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	public static function setNeutralDownButtonImage(value : BitmapData) : Void { _neutralButtonDownBitmap = value; }

	/**
	* Set the color of the alert title area once the user select
	*
	* @param value The color you want to set the window to
	*
	*/

	private static function set_windowTitleFocusColor(value : Int) : Int { _windowTitleColor = value; return value; }

	/**
	*
	* @return Return the color of the window
	*/
	private static function get_windowTitleFocusColor() : Int { return _windowTitleColor; }

	/**
	* Set the color of the alert window
	*
	* @param value The color you want to set the window to
	*
	*/
	private static function set_windowFocusColor(value : Int) : Int
	{
		_windowFocusColor = value;
		return value;
	}

	/**
	 * @return Return the color of the window
	 */

	private static function get_windowFocusColor() : Int
	{
		return _windowFocusColor;
	}

	/**
	* Set the color of the alert window mid area
	*
	* @param value The color you want to set the window to
	*
	*/

	private static function set_windowUnFocusColor(value : Int) : Int
	{
		_windowUnFocusColor = value;
		return value;
	}

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
	private static function get_windowTitleUnFocusColor() : Int {return _windowTitleUnFocusColor;}

	/**
	* This set an image to the upper top left corner of the window based on a bitmap
	*
	* @param value The bitmap image you want to use
	*
	*/
	public static function setWindowTopLeftImage(value : BitmapData) : Void { _windowTopLeftImage = value; }

	/**
	* This set an image to the middle of the window based on a bitmap
	*
	* @param value The bitmap image you want to use
	*
	*/
	public static function setWindowTopMiddleImage(value : BitmapData) : Void { _windowTopMiddleImage = value; }

	/**
	* This set an image to the upper top right corner of the window based on a bitmap
	*
	* @param value The bitmap image you want to use
	*
	*
	*/
	public static function setWindowTopRightImage(value : BitmapData) : Void { _windowTopRightImage = value; }


	/**
	* This set an image to the right middle side of the window based on a bitmap
	*
	* @param value The bitmap image you want to use
	*
	*
	*/
	public static function setWindowMiddleRightImage(value : BitmapData) : Void { _windowMiddleRightImage = value; }

	/**
	* This set an image to the left side of the window based on a bitmap
	*
	* @param value The bitmap image you want to use
	*
	*
	*/
	public static function setWindowMiddleLeftImage(value : BitmapData) : Void { _windowMiddleLeftImage = value; }


	/**
	* This set an image to the bottom lower left corner of the window based on a bitmap
	*
	* @param value The bitmap image you want to use
	*
	*/
	public static function setWindowBottomLeftImage(value : BitmapData) : Void { _windowBottomLeftImage = value; }

	/**
	* This set an image to the bottom mid area of the window based on a bitmap
	*
	* @param value The bitmap image you want to use
	*
	*/

	public static function setWindowBottomMiddleImage(value : BitmapData) : Void { _windowBottomMiddleImage = value; }

	/**
	* This set an image to the bottom lower right corner of the window based on a bitmap
	*
	* @param value The bitmap image you want to use
	*
	*/

	public static function setWindowBottomRightImage(value : BitmapData) : Void { _windowBottomRightImage = value; }



	/**
	* This is for setting an image to the Alert. It is best to set an image that can be tile.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	public static function setBackgroundBitmap(value : BitmapData) : Void { _backgroundImage = value; }

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

	public static function create(strMessage : String = "No Message", strTitle : String = "Alert Box", buttonArray : Array<String> = null, alertBoxIcon : BitmapData = null, alertWindowIcon : BitmapData = null, callBackFunc : Dynamic = null, defaultLabelButton : String = "") : Sprite
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
		var buttonList:Array<IButton> = new Array<IButton>();

		if (null != alertWindowIcon)
			window.setIcon(alertWindowIcon);

		window.name = "window_" + _windowCount;
		_windowCount++;

		var label : Label = new Label();
		label.name = "textlabel";

		var buttonHolderClip : Sprite = new Sprite();
		buttonHolderClip.name = "buttonHolder";

		var holderClip : Sprite = new Sprite();
		holderClip.name = "alertContent";

		var useTextFormat : Bool = false;

		if (UIStyleManager.hasStyle(UIStyleManager.WINDOW_TITLE_TEXT_FONT))
		{
			window.textLabel.font = UIStyleManager.getStyle(UIStyleManager.WINDOW_TITLE_TEXT_FONT);
			useTextFormat = true;
		}

		if ( UIStyleManager.hasStyle(UIStyleManager.WINDOW_TITLE_TEXT_SIZE))
		{
			window.textLabel.size = UIStyleManager.getStyle(UIStyleManager.WINDOW_TITLE_TEXT_SIZE);
			useTextFormat = true;
		}

		if (UIStyleManager.hasStyle(UIStyleManager.WINDOW_TITLE_TEXT_EMBED))
			window.textLabel.setEmbedFont(UIStyleManager.getStyle(UIStyleManager.WINDOW_TITLE_TEXT_EMBED));

		if (UIStyleManager.hasStyle(UIStyleManager.WINDOW_TITLE_TEXT_COLOR))
			window.textLabel.textColor = UIStyleManager.getStyle(UIStyleManager.WINDOW_TITLE_TEXT_COLOR);

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

		window.textLabel.text = strTitle;

		window.width = DEFAULT_WIDTH;
		window.height = DEFAULT_HEIGHT;
		window.resize = false;

		// Setup colors for window & check and setup bitmap/image if needed
		window.windowTitleColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_TITLE_AREA_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_TITLE_AREA_COLOR) : _windowTitleColor;
		window.windowColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_WINDOW_FOCUS_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_WINDOW_FOCUS_COLOR) : _windowFocusColor;
		window.scrollPane.backgroundColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_BACKGROUND_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_BACKGROUND_COLOR) : _backgroundColor;

		if (UIStyleManager.hasStyle(UIStyleManager.ALERT_ICON_LOCATION))
			window.iconLocation = UIStyleManager.getStyle(UIStyleManager.ALERT_ICON_LOCATION);

		if (UIStyleManager.hasStyle(UIStyleManager.ALERT_BUTTON_LOCATION))
			window.buttonLocation = UIStyleManager.getStyle(UIStyleManager.ALERT_BUTTON_LOCATION);

		if (UIStyleManager.hasStyle(UIStyleManager.ALERT_LABEL_LOCATION))
			window.labelLocation = UIStyleManager.getStyle(UIStyleManager.ALERT_LABEL_LOCATION);

		// Setting Bitmaps if need be
		initSkin(window);

		// This is just in cause the settings are going go be switched out loading image from URL
		setupAlertTheme(window);
		setCloseButtonTheme(window);

		// Only show close button if need be will never show min and max button for AlertBox
		window.closeButton.visible = _enabledCloseButton;
		window.minButton.visible = window.maxButton.visible = false;
		

		// Just in case it's going to be set locally
		if ("" != _buttonLocation)
			window.buttonLocation = _buttonLocation;

		if ("" != _buttonLocation)
			window.labelLocation = _buttonLocation;

		// To handle to close window
		window.closeButton.addEventListener(MouseEvent.CLICK, onButtonClickEvent, false, 0);

		//if (null != callBackFunc)
		//window.addEventListener(WindowEvent.WINDOW_CLOSE_BTN, callBackFunc, false, 5, true);

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
		label.draw();

		holderClip.addChild(label);

		// If there is a need for a scrollbar then add one
		if (label.textField.textHeight > label.height)
		{
			var scroll : ScrollBar = new ScrollBar();

			scroll.slider.direction = ScrollBarDirection.VERTICAL;
			holderClip.mouseChildren = true;
			holderClip.addChild(scroll);
			scroll.draw();
			
			scroll.y = label.y;
		}

		// Check and Setup Icon if need be
		if (alertBoxIcon != null)
		{
			var iconImage : Sprite = new Sprite();
			iconImage.graphics.beginBitmapFill(alertBoxIcon, null, true);
			iconImage.graphics.drawRect(0, 0, alertBoxIcon.width, alertBoxIcon.height);
			iconImage.graphics.endFill();
			
			iconImage.width = ICON_SIZE_WIDTH;
			iconImage.height = ICON_SIZE_HEIGHT;
			
			iconImage.x = ICON_OFFSET_X;
			iconImage.y = (DEFAULT_HEIGHT / 2) - window.windowTopMiddleSize - ICON_OFFSET_Y;
			label.width = DEFAULT_WIDTH - ICON_SIZE_WIDTH - LABEL_OFFSET_X - BUTTON_OFFSET_X;
			label.x = ICON_SIZE_WIDTH + LABEL_OFFSET_X;
			
			holderClip.addChild(iconImage);			
		}

		// Look into hiding modal block
		var hasModal : Bool = modalCheck(buttonArray);
		backgroundBlock.visible = ((hasModal)) ? false : true;

		// Check to see if buttons passed if not then create default button
		if (buttonArray != null)
		{
			// Drop count by 1 if have Modal flag in list
			var buttonCount : Int = ((hasModal)) ? buttonArray.length - 1 : buttonArray.length;

			for (i in 0 ... buttonArray.length - 1 + 1)
			{
				// Turn off background shape
				if (Alert.NONMODAL != buttonArray[i])
				{
					// Grab button and place it in holder
					var tempButton : Button = createAlertButton(buttonArray[i]);
					buttonHolderClip.addChild(tempButton);
					buttonList.push(tempButton);

					// To remove alert box
					tempButton.addEventListener(MouseEvent.CLICK, onButtonClickEvent, false, 0, true);

					if (null != callBackFunc)
						tempButton.addEventListener(MouseEvent.CLICK, callBackFunc, false, 5, true);

					// Size done buttons if 3 buttons or more
					if (buttonCount >= SMALL_BUTTON_COUNT)
					{
						tempButton.width = SMALL_BUTTON_WIDTH;
						tempButton.height = SMALL_BUTTON_HEIGHT;
					}

					// Show close button if using cancel button
					if (tempButton.name == CANCEL)
						window.closeButton.visible = true;

					tempButton.x = ((buttonHolderClip.numChildren == 1)) ? BUTTON_OFFSET_X : tempButton.width + buttonHolderClip.getChildAt(buttonHolderClip.numChildren - 2).x + BUTTON_OFFSET_X;
					tempButton.draw();
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
		buttonHolderClip.y = DEFAULT_HEIGHT - window.windowTopMiddleSize - window.windowBottomMiddleSize - BUTTON_OFFSET_Y;
		holderClip.addChild(buttonHolderClip);

		// Place movieclip in window
		window.scrollPane.source = holderClip;
		alertHolder.addChild(window);
		
		window.draw();
		window.scrollPane.refreshPane();
		
		var alertData:AlertObjectData = new AlertObjectData(window, buttonList, callBackFunc);
		_alertList.addItem(alertData);

		return alertHolder;
	}

	private static function onButtonClickEvent( event:Event ): Void
	{
		// Figure out what button was clicked
		var button:IButton = cast(event.currentTarget, IButton);

		// Start searching array objects
		for (i in 0 ... _alertList.length)
		{

			var alertObj:AlertObjectData = cast(_alertList.getItemAt(i), AlertObjectData);
			var buttonList:Array<IButton> = alertObj.buttonList;

			// Look for button in button list
			for (j in 0... buttonList.length)
			{

				// Once button is found remove window
				if (buttonList[j] == button)
				{

					var oldWindow:IWindow = cast(_alertList.removeItem(alertObj),AlertObjectData).window;

					// Remove window out of display
					if (null != oldWindow && null != oldWindow.parent)
						oldWindow.parent.removeChild(oldWindow.displayObject);

					// Remove all events
					for (a in 0... buttonList.length)
					{
						if (null != alertObj.callBack)
							buttonList[a].removeEventListener(MouseEvent.CLICK, alertObj.callBack);

						buttonList[a].removeEventListener(MouseEvent.CLICK, onButtonClickEvent);
					}
				}

			}

		}

		// Remove background if no more windows are left in the list
		if (_alertList.length == 0)
		{
			backgroundBlock.graphics.clear();
			backgroundBlock.removeEventListener(Event.ADDED_TO_STAGE, setupTintStageEvent);
		}

	}

	private static function setCloseButtonTheme(window : Window) : Void
	{
		window.closeButton.defaultColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_CLOSE_BUTTON_NORMAL_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_CLOSE_BUTTON_NORMAL_COLOR) : _closeButtonNormalColor;
		window.closeButton.overColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_CLOSE_BUTTON_OVER_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_CLOSE_BUTTON_OVER_COLOR) : _closeButtonOverColor;
		window.closeButton.downColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_CLOSE_BUTTON_DOWN_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_CLOSE_BUTTON_DOWN_COLOR) : _closeButtonDownColor;
		window.closeButton.disableColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_CLOSE_BUTTON_DISABLE_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_CLOSE_BUTTON_DISABLE_COLOR) : _closeButtonDisableColor;
		
		// All images for close button that are bitmaps 
		if (_closeButtonNormalBitmap != null)
			window.closeButton.setDefaultStateImage(_closeButtonNormalBitmap);
		
		if (_closeButtonOverBitmap != null)
			window.closeButton.setOverStateImage(_closeButtonOverBitmap);
		
		if (_closeButtonDownBitmap != null)
			window.closeButton.setDownStateImage(_closeButtonDownBitmap);
		
		if (_closeButtonDisableBitmap != null)
			window.closeButton.setDisableStateImage(_closeButtonDisableBitmap);
	}

	private static function setupAlertTheme(window : Window) : Void
	{

		// Background
		//if (_backgroundImageURL != "")
		//window.scrollPane.setBackgroundImage(_backgroundImageURL);

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
		//if (_backgroundImage != null)
		//	window.scrollPane.setBackgroundBitmap(_backgroundImage);
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
			window.scrollPane.setBackgroundImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_BACKGROUND));

		// All images for close button that are bitmaps
		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_NORMAL))
			window.closeButton.setDefaultStateImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_NORMAL));

		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_OVER))
			window.closeButton.setOverStateImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_OVER));

		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_DOWN))
			window.closeButton.setDownStateImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_DOWN));

		if (null != UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_DISABLE))
			window.closeButton.setDisableStateImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_CLOSE_BUTTON_DISABLE));

	}

	private static function createAlertButton(buttonType : String) : Button
	{
		var tempButton : Button = new Button({"width":100,"height":20});

		switch (buttonType)
		{
			case Alert.OK:
				tempButton.text = (("" == UIStyleManager.ALERT_OK_TEXT)) ? _okBtnLabel : UIStyleManager.ALERT_OK_TEXT;
				tempButton.name = OK;
				setButtonType("positive", tempButton);

			case Alert.CANCEL:
				tempButton.text = (("" == UIStyleManager.ALERT_CANCEL_TEXT)) ? _cancelBtnLabel : UIStyleManager.ALERT_CANCEL_TEXT;
				tempButton.name = CANCEL;
				setButtonType("negative", tempButton);

			case Alert.YES:
				tempButton.text = (("" == UIStyleManager.ALERT_YES_TEXT)) ? _yesBtnLabel : UIStyleManager.ALERT_YES_TEXT;
				tempButton.name = YES;
				setButtonType("positive", tempButton);

			case Alert.NO:
				tempButton.text = (("" == UIStyleManager.ALERT_NO_TEXT)) ? _noBtnLabel : UIStyleManager.ALERT_NO_TEXT;
				tempButton.name = NO;
				setButtonType("negative", tempButton);

			case Alert.MAYBE:
				tempButton.text = (("" == UIStyleManager.ALERT_MAYBE_TEXT)) ? _noBtnLabel : UIStyleManager.ALERT_MAYBE_TEXT;
				tempButton.name = MAYBE;
				setButtonType("neutral", tempButton);

			default:
				tempButton.text = (("" == UIStyleManager.ALERT_OK_TEXT)) ? _okBtnLabel : UIStyleManager.ALERT_OK_TEXT;
				tempButton.name = OK;
				setButtonType("positive", tempButton);
		}

		tempButton.draw();
		
		return tempButton;
	}

	private static function setButtonType(strType : String, button : Button) : Void
	{
		if ("positive" == strType.toLowerCase())
		{
			button.defaultColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_POSITIVE_BUTTON_NORMAL_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_POSITIVE_BUTTON_NORMAL_COLOR) : _positiveButtonNormalColor;
			button.overColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_POSITIVE_BUTTON_OVER_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_POSITIVE_BUTTON_OVER_COLOR) : _positiveButtonOverColor;
			button.downColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_POSITIVE_BUTTON_DOWN_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_POSITIVE_BUTTON_DOWN_COLOR) : _positiveButtonDownColor;

			if (UIBitmapManager.hasUIElement(Alert.TYPE, UIBitmapManager.ALERT_POSITIVE_BUTTON_NORMAL))
				button.setDefaultStateImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_POSITIVE_BUTTON_NORMAL));

			if (UIBitmapManager.hasUIElement(Alert.TYPE, UIBitmapManager.ALERT_POSITIVE_BUTTON_OVER))
				button.setOverStateImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_POSITIVE_BUTTON_OVER));

			if (UIBitmapManager.hasUIElement(Alert.TYPE, UIBitmapManager.ALERT_POSITIVE_BUTTON_DOWN))
				button.setDownStateImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_POSITIVE_BUTTON_DOWN));

			// All images for positive button that are bitmaps
			if (_positiveButtonNormalBitmap != null)
				button.setDefaultStateImage(_positiveButtonNormalBitmap);

			if (_positiveButtonOverBitmap != null)
				button.setOverStateImage(_positiveButtonOverBitmap);

			if (_positiveButtonDownBitmap != null)
				button.setDownStateImage(_positiveButtonDownBitmap);
		}
		else if ("negative" == strType.toLowerCase())
		{
			button.defaultColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_NEGATIVE_BUTTON_NORMAL_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_NEGATIVE_BUTTON_NORMAL_COLOR) : _negativeButtonNormalColor;
			button.overColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_NEGATIVE_BUTTON_OVER_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_NEGATIVE_BUTTON_OVER_COLOR) : _negativeButtonOverColor;
			button.downColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_NEGATIVE_BUTTON_DOWN_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_NEGATIVE_BUTTON_DOWN_COLOR) : _negativeButtonDownColor;

			if (UIBitmapManager.hasUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_NORMAL))
				button.setDefaultStateImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_NORMAL));

			if (UIBitmapManager.hasUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_OVER))
				button.setOverStateImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_OVER));

			if (UIBitmapManager.hasUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_DOWN))
				button.setDownStateImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_DOWN));

			// All images for negative button that are bitmaps
			if (_negativeButtonNormalBitmap != null)
				button.setDefaultStateImage(_negativeButtonNormalBitmap);

			if (_negativeButtonOverBitmap != null)
				button.setOverStateImage(_negativeButtonOverBitmap);

			if (_negativeButtonDownBitmap != null)
				button.setDownStateImage(_negativeButtonDownBitmap);
		}
		else if ("neutral" == strType.toLowerCase())
		{
			button.defaultColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_NEUTRAL_BUTTON_NORMAL_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_NEUTRAL_BUTTON_NORMAL_COLOR) : _neutralButtonNormalColor;
			button.overColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_NEUTRAL_BUTTON_OVER_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_NEUTRAL_BUTTON_OVER_COLOR) : _neutralButtonOverColor;
			button.defaultColor = UIStyleManager.hasStyle(UIStyleManager.ALERT_NEUTRAL_BUTTON_DOWN_COLOR) ? UIStyleManager.getStyle(UIStyleManager.ALERT_NEUTRAL_BUTTON_DOWN_COLOR) : _neutralButtonDownColor;

			if (UIBitmapManager.hasUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEUTRAL_BUTTON_DOWN))
				button.setDefaultStateImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEUTRAL_BUTTON_DOWN));

			if (UIBitmapManager.hasUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_OVER))
				button.setOverStateImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEUTRAL_BUTTON_OVER));

			if (UIBitmapManager.hasUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEGATIVE_BUTTON_DOWN))
				button.setDownStateImage(UIBitmapManager.getUIElement(Alert.TYPE, UIBitmapManager.ALERT_NEUTRAL_BUTTON_DOWN));

			// All images for neutral button that are bitmaps
			if (_neutralButtonNormalBitmap != null)
				button.setDefaultStateImage(_negativeButtonNormalBitmap);

			if (_neutralButtonOverBitmap != null)
				button.setOverStateImage(_negativeButtonOverBitmap);

			if (_neutralButtonDownBitmap != null)
				button.setDownStateImage(_negativeButtonDownBitmap);
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
			for (i in 0..._alertList.length)
			{
				var window : Window = cast(cast(_alertList.getItemAt(i), AlertObjectData).window,Window);
				window.x = (window.stage.stageWidth / 2) - (window.width / 2);
				window.y = (window.stage.stageHeight / 2) - (window.height / 2);
			}
		}
	}

	private static function setupWindowStageEvent(event : Event) : Void
	{
		var window:Window = cast(event.currentTarget, Window);

		window.stage.align = StageAlign.TOP_LEFT;
		window.x = (window.stage.stageWidth / 2) - (window.width / 2);
		window.y = (window.stage.stageHeight / 2) - (window.height / 2);
		
	}

	private static function setupTintStageEvent(event : Event) : Void
	{
		// Remove old event
		var backgroundBlock : Shape = cast(event.currentTarget, Shape);

		backgroundBlock.removeEventListener(Event.ADDED_TO_STAGE, setupTintStageEvent);
		backgroundBlock.stage.align = StageAlign.TOP_LEFT;
		backgroundBlock.stage.addEventListener(Event.RESIZE, updateAlertBox, false, 0, true);
		backgroundBlock.graphics.clear();
		backgroundBlock.graphics.beginFill(_tintBackgroundColor, _tintAlpha);
		backgroundBlock.graphics.drawRect(0, 0, backgroundBlock.stage.stageWidth, backgroundBlock.stage.stageHeight);
		backgroundBlock.graphics.endFill();
	}

}

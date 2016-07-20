package com.chaos.utils;

/**
 * Checks string to make sure it's the correct format
 * @author Erick Feiling
 */
	
class Validator
{

	public function new() 
	{
		
	}
	

		/**
		 * Checks to see if string is an e-mail or not
		 *
		 * @param	value A string with the e-mail address in it
		 *
		 * @return True if it's a valid format and false if not
		 */
		
		static public function isValidEmail(value:String):Bool
		{
			var emailExp:EReg = ~/^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			return emailExp.match(value);
		}
		
		/**
		 * Checks to see if string is an US number or not
		 *
		 * @param	value The screen you want to check
		 *
		 * @return True if it's a valid number and false if not
		 */
		
		static public function isValidPhoneNumber(value:String):Bool
		{
			var phoneRegExp:EReg = ~/^((\+\d{1,3}(-| )?\(?\d\)?(-| )?\d{1,3})|(\(?\d{2,3}\)?))(-| )?(\d{3,4})(-| )?(\d{4})(( x| ext)\d{1,5}){0,1}$/i;
			return phoneRegExp.match(value);
		}
		
		/**
		 * Validates data in the following formats 10-26-1981, 10/26/1981 and 10.26.1981
		 *
		 * @param	value Formated string with date
		 *
		 * @return True if valid and false if not
		 */
		
		static public function isValidDate(value:String):Bool
		{
			var dataExp:EReg = ~/(0[1-9]|1[012])[\/|-|\.](0[1-9]|[12][0-9]|3[01])[\/|-|\.](19|20)[0-9]{2}/i;
			return dataExp.match(value);
		}
		
		/**
		 * Check to see if string is valid number
		 * @param	value A string with number value
		 * @return True if it is a number and false if not
		 */
		
		static public function isValidNumber(value:String):Bool
		{
			var regNum:EReg = ~/[0-9]/;
			return regNum.match(value);
		}	
	
}
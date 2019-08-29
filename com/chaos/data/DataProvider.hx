package com.chaos.data;



/**
* For holding a collection of objects.
*/


class DataProvider<T>
{
    public var length(get, never) : Int;
    public var dataArray(get, never) : Array<Dynamic>;
	private var _dataArray : Array<T>; 
	
	/**
	 * The DataProvider classes is an array with a very simple layer wrapped around it
	 * @param	newDataArray The new array filled with values or data of some kind
	 */

	public function new(newDataArray : Array<T> = null)
    {
		if (null != newDataArray)
			_dataArray = newDataArray;
		else
			_dataArray = new Array<T>();
    }
	
	/**
	 * Returns the length of the data provider
	 */  
	
	private function get_length() : Int
	{
		return _dataArray.length;
    } 
	
	/**
	 * Appends an item to the end of the data provider.
	 *
	 * @param item Appends an item to the end of the data provider.
	 *
	 */  
	
	public function addItem(item : T) : Void
	{
		_dataArray.push(item);
    }
	
	/**
	 * Removes the specified item from the
	 *
	 * @param item  Item to be removed.
	 *
	 */
	public function removeItem(item : T) : T
	{
		_dataArray.remove(item);
		return item;
    }
	
	/**
	 * Adds an item at given index
	 *
	 * @param	item
	 * @param	index
	 */
	
	public function addItemAt(item : T, index : Int) : Void
	{
		_dataArray.insert(index, item);
		
    }
	
	/**
	 * Removes the item at the specified index
	 *
	 * @param index  The index at which the item is to be added.
	 */  
	
	public function removeItemAt(index : Int) : Array<T>
	{
		return _dataArray.splice(index, 1);
    }
	
	/**
	 * Remove all items out of the list
	 */ 
	
	public function removeAll() : Void
	{
		_dataArray = new Array<T>();
    }
	
	/**
	 * Returns the item at the specified index.
	 *
	 * @param value Location of the item to be returned.
	 * @return The item at the specified index.
	 */
	
	public function getItemAt(index : Int) : T
	{
		if (_dataArray[index] != null)
		return _dataArray[index];
		
		return null;
    } 
	
	/**
	 *
	 * Get item index
	 *
	 * @param	item
	 * @return
	 */ 
	
	public function getItemIndex(item : T) : Int
	{
		
		return Lambda.indexOf(_dataArray, item);
    }
	
	/**
	 * Replaces an existing item with a new item
	 *
	 * @param newItem The item to be replaced.
	 * @param oldItem The replacement item.
	 */
	
	public function replaceItem(newItem : T, oldItem : T) : Void
	{
		if (Lambda.indexOf(_dataArray, oldItem) != -1)  
			_dataArray[Lambda.indexOf(_dataArray, oldItem)] = newItem;
    }
	
	/**
	 * Replaces the item at the specified index
	 *
	 * @param newItem The replacement item.
	 * @param index The replacement item.
	 */
	
	public function replaceItemAt(newItem : T, index : Int) : T
	{
		if (_dataArray[index] == newItem) 
		{
			var removeObj : Dynamic;
			
			removeObj = _dataArray[index];
			_dataArray[index] = newItem;
			
			return removeObj;
        }
		
		return null;
    }
	
	/**
	 * Return the array that is used inside the object
	 */
	
	private function get_dataArray() : Array<T>
	{
		return _dataArray;
    }
}
﻿/**
 * The ScrollingList is a list component that can scroll its elements. It can instantiate list items by itself or use existing list items on the stage. A ScrollIndicator or ScrollBar component can also be attached to this list component to provide scoll feedback and control. This component is populated via a DataProvider. The dataProvider is assigned via code, as shown in the example below:
<i>scrollingList.dataProvider = ["item1", "item2", "item3", "item4", ];</i>

	<b>Inspectable Properties</b>
	A MovieClip that derives from the ScrollingList component will have the following inspectable properties:<ul>
	<li><i>visible</i>: Hides the component if set to false. This does not hide the attached scrollbar or any external list item renderers.</li>
	<li><i>disabled</i>: Disables the component if set to true. This does disable both the attached scrollbar and the list items (both internally created and external renderers).</li>
	<li><i>itemRenderer</i>: The symbol name of the ListItemRenderer. Used to create list item instances internally. Has no effect if the rendererInstanceName property is set.</li>
	<li><i>rendererInstanceName</i>: Prefix of the external list item renderers to use with this ScrollingList component. The list item instances on the stage must be prefixed with this property value. If this property is set to the value ‘r’, then all list item instances to be used with this component must have the following values: ‘r1’, ‘r2’, ‘r3’,… The first item should have the number 1.</li>
	<li><i>scrollBar</i>: Instance name of a ScrollBar component on the stage or a symbol name. If an instance name is specified, then the ScrollingList will hook into that instance. If a symbol name is specified, an instance of the symbol will be created by the ScrollingList.</li>
	<li><i>margin</i>: The margin between the boundary of the list component and the list items created internally. This value has no effect if the rendererInstanceName property is set. This margin also affects the automatically generated scrollbar.</li>
	<li><i>rowHeight</i>: The height of list item instances created internally. This value has no effect if the rendererInstanceName property is set.</li>
	<li><i>paddingTop:</i>Extra padding at the top for the list items. This value has no effect if the rendererInstanceName property is set. Does not affect the automatically generated scrollbar.</li>
	<li><i>paddingBottom:</i>Extra padding at the bottom for the list items. This value has no effect if the rendererInstanceName property is set. Does not affect the automatically generated scrollbar.</li>
	<li><i>paddingLeft:</i>Extra padding on the left side for the list items. This value has no effect if the rendererInstanceName property is set. Does not affect the automatically generated scrollbar.</li>
	<li><i>paddingRight:</i>Extra padding on the right side for the list items. This value has no effect if the rendererInstanceName property is set. Does not affect the automatically generated scrollbar.</li>
	<li><i>thumbOffsetTop:</i>Scrollbar thumb top offset. This property has no effect if the list does not automatically create a scrollbar instance.</li>
	<li><i>thumbOffsetBottom:</i>Scrollbar thumb bottom offset. This property has no effect if the list does not automatically create a scrollbar instance.</li>
	<li><i>thumbSizeFactor:</i>Page size factor for the scrollbar thumb. A value greater than 1.0 will increase the thumb size by the given factor. This positive value has no effect if a scrollbar is not attached to the list.
	<li><i>enableInitCallback</i>: If set to true, _global.CLIK_loadCallback() will be fired when a component is loaded and _global.CLIK_unloadCallback will be called when the component is unloaded. These methods receive the instance name, target path, and a reference the component as parameters.  _global.CLIK_loadCallback and _global.CLIK_unloadCallback should be overriden from the game engine using GFx FunctionObjects.</li>
	<li><i>soundMap</i>: Mapping between events and sound process. When an event is fired, the associated sound process will be fired via _global.gfxProcessSound, which should be overriden from the game engine using GFx FunctionObjects.</li></ul>
	
	<b>States</b>
	The ScrollingList component supports three states based on its focused and disabled properties. <ul>
	<li>default or enabled state.</li>
	<li>focused state, that typically highlights the component’s border area.</li>
	<li>disabled state.</li></ul>
	
	<b>Events</b>
	All event callbacks receive a single Object parameter that contains relevant information about the event. The following properties are common to all events. <ul>
	<li><i>type</i>: The event type.</li>
	<li><i>target</i>: The target that generated the event.</li></ul>
		
	The events generated by the ScrollingList component are listed below. The properties listed next to the event are provided in addition to the common properties.<ul>
	<li><i>show</i>: The component’s visible property has been set to true at runtime.</li>
	<li><i>hide</i>: The component’s visible property has been set to false at runtime.</li>
	<li><i>focusIn</i>: The component has received focus.</li>
	<li><i>focusOut</i>: The component has lost focus.</li>
	<li><i>change</i>: The selected index has changed.<ul>
		<li><i>index</i>: The new selected index. Number type. Values 0 to number of list items minus 1. </li></ul></li>
	<li><i>itemPress</i>: The list item has been pressed down.<ul>
		<li><i>renderer</i>: The list item that was pressed. CLIK Button type.</li>
		<li><i>item</i>: The data associated with the list item. This value is retrieved from the list’s DataProvider. AS2 Object type.</li>
		<li><i>index</i>: The index of the list item relative to the list’s DataProvider. Values 0 to number of list items minus 1. </li>
		<li><i>controllerIdx</i>: The index of the mouse cursor used to generate the event (applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</li></ul></li>
	<li><i>itemClick</i>: A list item has been clicked.<ul>
		<li><i>renderer</i>: The list item that was clicked. CLIK Button type. </li>
		<li><i>item</i>: The data associated with the list item. This value is retrieved from the list’s DataProvider. AS2 Object type.</li>
		<li><i>index</i>: The index of the list item relative to the list’s DataProvider. Values 0 to number of list items minus 1. </li>
		<li><i>controllerIdx</i>: The index of the mouse cursor used to generate the event (applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</li></ul></li>
	<li><i>itemDoubleClick</i>: The mouse cursor has been double clicked.<ul>
		<li><i>renderer</i>: The list item was double clicked. CLIK Button type. </li>
		<li><i>item</i>: The data associated with the list item. This value is retrieved from the list’s DataProvider. AS2 Object type.</li>
		<li><i>index</i>: The index of the list item relative to the list’s DataProvider. Values 0 to number of list items minus 1. </li>
		<li><i>controllerIdx</i>: The index of the mouse cursor used to generate the event (applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</li></ul></li>
	<li><i>itemRollOver</i>: The mouse cursor has rolled over a list item.<ul>
		<li><i>renderer</i>: The list item that was rolled over.CLIK Button type. </li>
		<li><i>item</i>: The data associated with the list item. This value is retrieved from the list’s DataProvider. AS2 Object type.</li>
		<li><i>index</i>: The index of the list item relative to the list’s DataProvider. Values 0 to number of list items minus 1. </li>
		<li><i>controllerIdx</i>: The index of the mouse cursor used to generate the event (applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</li></ul></li>
	<li><i>itemRollOut</i>: The mouse cursor has rolled out of a list item.<ul>
		<li><i>renderer</i>: The list item that was rolled out of.CLIK Button type. </li>
		<li><i>item</i>: The data associated with the list item. This value is retrieved from the list’s DataProvider. AS2 Object type.</li>
		<li><i>index</i>: The index of the list item relative to the list’s DataProvider.Values 0 to number of list items minus 1. </li>
		<li><i>controllerIdx</i>: The index of the mouse cursor used to generate the event (applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</li></ul></li></ul>
 */

/**********************************************************************
 Copyright (c) 2009 Scaleform Corporation. All Rights Reserved.

 Portions of the integration code is from Epic Games as identified by Perforce annotations.
 Copyright © 2010 Epic Games, Inc. All rights reserved.
 
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/

import flash.external.ExternalInterface; 
import flash.geom.Rectangle;
import gfx.controls.CoreList;
import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;
import gfx.utils.Constraints;

[InspectableList("disabled", "visible", "itemRenderer", "inspectableScrollBar", "rowHeight", "inspectableRendererInstanceName", "margin", "paddingTop", "paddingBottom", "paddingLeft", "paddingRight", "thumbOffsetBottom", "thumbOffsetTop", "thumbSizeFactor", "enableInitCallback", "soundMap", "wrapping")]
class gfx.controls.ScrollingList extends CoreList {
	
// Constants:

// Public Properties:
	/** 
	 * Determines how focus "wraps" when the end or beginning of the component is reached.
	 	<ul>
		<li>"normal": The focus will leave the component when it reaches the end of the data</li>
		<li>"wrap": The selection will wrap to the beginning or end.</li>
		<li>"stick": The selection will stop when it reaches the end of the data.</li>
		<li>"refuse": The selection will refuse to change if it is asked to go off of the end of the data</li>
		</ul>
	 */
	[Inspectable(type="String", enumeration="normal,wrap,stick,refuse", defaultValue="normal")]
	public var wrapping:String = "normal";
	/** Determines if the "rowCount" property is applied directly, or converted by the component. ScrollingList does not use autoRowCount, but includes it for consistency. **/
	public var autoRowCount:Boolean = false;
	
// Private Properties:
	private var _rowHeight:Number;
	private var _scrollPosition:Number = 0;
	private var _rowCount:Number;
	private var totalRenderers:Number = 0;
	[Inspectable(name="scrollBar", type="String")]
	private var inspectableScrollBar:Object;
	private var autoScrollBar:Boolean = false; // Determines if the scrollbar has been auto-created for this component
	
	[Inspectable(defaultValue="1", verbose=1)]
	private var margin:Number = 1;
	[Inspectable(defaultValue="0", verbose=1)]
	private var paddingTop:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var paddingBottom:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var paddingLeft:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var paddingRight:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var thumbOffsetTop:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var thumbOffsetBottom:Number = 0;
	[Inspectable(defaultValue="1.0", verbose=1)]
	private var thumbSizeFactor:Number = 1.0;
	
	//Whether or not this list has a selectable item in it
	private var bHasASelectableItem:Boolean = false;

// UI Elements:
	private var _scrollBar:MovieClip;


// Initialization:
	/**
	 * The constructor is called when a ScrollingList or a sub-class of ScrollingList is instantiated on stage or by using {@code attachMovie()} in ActionScript. This component can <b>not</b> be instantiated using {@code new} syntax. When creating new components that extend ScrollingList, ensure that a {@code super()} call is made first in the constructor.
	 */
	public function ScrollingList() { 
		super();
	}
	
// Public Methods:	
	/**
	 * The component to use to scroll the list. The {@code scrollBar} can be set as a library linkage ID, an instance name on the stage relative to the component, or a reference to an existing ScrollBar elsewhere in the application. The automatic behaviour in this component only supports a vertical scrollBar, positioned on the top right, the entire height of the component.
	 * @see ScrollBar
	 * @see ScrollIndicator
	 */
	public function get scrollBar():Object { return _scrollBar; }
	public function set scrollBar(value:Object):Void {	
		if (!initialized) { 
			inspectableScrollBar = value;
			return;
		}
		
		if (_scrollBar != null) {
			_scrollBar.removeEventListener("scroll", this, "handleScroll");
			_scrollBar.removeEventListener("change", this, "handleScroll");
			_scrollBar.focusTarget = null;
			if (autoScrollBar) { _scrollBar.removeMovieClip(); } // Clean up auto-created scrollbars only!
		}
		
		autoScrollBar = false; // Reset
		if (typeof(value) == "string") {
			_scrollBar = MovieClip(_parent[value.toString()]); // Outside reference by name
			if (_scrollBar == null) {
				_scrollBar = container.attachMovie(value.toString(), "_scrollBar", 1000, {offsetTop:thumbOffsetTop, offsetBottom:thumbOffsetBottom}); // Created using linkage
				if (_scrollBar != null) { 
					autoScrollBar = true;
					//if (_scrollBar.scale9Grid == null) { _scrollBar.scale9Grid = new Rectangle(0,16,1,1); }
				}
			}
		} else { // Outside reference
			_scrollBar = MovieClip(value);
		}
		
		invalidate(); // Redraw to reset scrollbar bounds, even if there is no scrollBar.
		
		if (_scrollBar == null) { return; }
		
		// Now that we have a scrollBar, lets set it up.
		if (_scrollBar.setScrollProperties != null) {
			_scrollBar.addEventListener("scroll", this, "handleScroll");
		} else {
			_scrollBar.addEventListener("change", this, "handleScroll");
		}
		_scrollBar.focusTarget = this;
		_scrollBar.tabEnabled = false;
		updateScrollBar();
	}
	
	/**
	 * The height of each item in the list.  When set to {@code null} or 0, the default height of the renderer symbol is used.
	 */
	[Inspectable(defaultValue="0")]
	public function get rowHeight():Number { return _rowHeight; }
	public function set rowHeight(value:Number):Void {
		if (value == 0) { value = null; }
		_rowHeight = value;
		invalidate();
	}
	
	/**
	 * The vertical scroll position of the list.
	 */
	public function get scrollPosition():Number { return _scrollPosition; }
	public function set scrollPosition(value:Number):Void {
		value = Math.max(0, Math.min(_dataProvider.length-totalRenderers, Math.round(value)));
		if (_scrollPosition == value) { return; }
		_scrollPosition = value;
		invalidateData();
		updateScrollBar();
	}
	
	/**
	 * The selected index of the {@code dataProvider}.  The {@code itemRenderer} at the {@code selectedIndex} will be set to {@code selected=true}.
	 */
	public function get selectedIndex():Number { return _selectedIndex; }
	public function set selectedIndex(value:Number):Void {
		if (value == _selectedIndex) { return; }
		var renderer:MovieClip = getRendererAt(_selectedIndex);
		if (renderer != null) {
            renderer.selected = false; // Only reset items in range			
		}
		super.selectedIndex = value;
		if (totalRenderers == 0) { return; }
		renderer = getRendererAt(_selectedIndex);
		if (renderer != null) {			
			renderer.selected = true; // Item is in range. Just set it.            
		} else {
			scrollToIndex(_selectedIndex); // Will redraw
		    getRendererAt(_selectedIndex).displayFocus = true;						
		}
	}

	[Inspectable(defaultValue="false", verbose="1")]
	public function get disabled():Boolean { return _disabled; }
	public function set disabled(value:Boolean):Void { 
		super.disabled = value;
		if (initialized) { setState(); }
	}	
	
	/**
	 * Scroll the list to the specified index.  If the index is currently visible, the position will not change. The scroll position will only change the minimum amount it has to to display the item at the specified index.
	 * @param index The index to scroll to.
	 */
	public function scrollToIndex(index:Number):Void {
		if (totalRenderers == 0) { return; }
		if (index >= _scrollPosition && index < _scrollPosition + totalRenderers) {
			return;
		} else if (index < _scrollPosition) {
			scrollPosition = index;
		} else {
			scrollPosition = index - (totalRenderers-1);
		}
	}
	
	/**
	 * The amount of visible rows.  Setting this property will immediately change the height of the component to accomodate the specified amount of rows. The {@code rowCount} property is not stored or maintained.
	 */
	public function get rowCount():Number { return totalRenderers; }
	public function set rowCount(value:Number):Void {
		var h:Number = _rowHeight;
		if (h == null) {
			var item:MovieClip = renderers[0];
			if (item == null) {
				item = createItemRenderer(0);
				if (item == null) { return; }
				h = item._height; // It would be preferable to use the height property instead. however due to asyncronous loading, we can not.
				item.removeMovieClip();
			} else {
				h = item.height;
			}
			if (h == null || h == 0) { return; }
		}
		
		height = (h * value) + (margin * 2) + paddingTop + paddingBottom;
	}
	
	public function invalidateData():Void {
		_scrollPosition = Math.min(Math.max(0, _dataProvider.length - totalRenderers), _scrollPosition);
		selectedIndex = Math.min(_dataProvider.length-1, _selectedIndex);
		_dataProvider.requestItemRange(_scrollPosition, Math.min(_dataProvider.length-1, _scrollPosition+totalRenderers-1), this, "populateData");
		// Set pending items to "waiting" state.
	}
	
	public function handleInput(details:InputDetails, pathToFocus:Array):Boolean
	{		
		// Pass on to renderer first.
		if (pathToFocus == null) { pathToFocus = []; }
		var renderer:MovieClip = getRendererAt(_selectedIndex);
		if (renderer != null && renderer.handleInput != null) {
			var handled:Boolean = renderer.handleInput(details, pathToFocus.slice(1));
			if (handled) { return true; }
		}
		
		var keyPress:Boolean = (details.value == "keyDown" || details.value == "keyHold");
		var nav:String = details.navEquivalent;
		
		var nextDelta:Number;
		
		var foundNextIndex:Boolean = false;
		var nextIndex:Number = _selectedIndex;
		// If the _selectedIndex is out of bounds, the list will still accept it as a valid selectedIndex. However, if we're set to wrap/refuse/stick we need
		// to ensure that we're able to eventually reach a valid index when searching below.
		if (wrapping && wrapping != "normal")
		{
			if (nextIndex > dataProvider.length-1) {
				nextIndex = dataProvider.length-1
			}
			else if (nextIndex < 0)
			{
				nextIndex = 0;
			}
		}

		switch (nav) {
			case NavigationCode.DOWN:
				nextDelta = 1;
				break;
			case NavigationCode.UP:
				nextDelta = -1;
				break;
			case NavigationCode.HOME:
				//start one in front of the beginning and move forward
				nextIndex = -1;
				nextDelta = 1;
				break;
			case NavigationCode.END:
				//start one off the end and go backwards
				nextIndex = _dataProvider.length;
				nextDelta = -1;
				break;
			case NavigationCode.PAGE_DOWN:
				//start one above where you expect to be going and iterate forward on a one by one basis
				nextDelta = 1;
				nextIndex = _selectedIndex + totalRenderers - 1;
				break;
			case NavigationCode.PAGE_UP:
				//start one below where you expect to be going and iterate backward on a one by one basis
				nextDelta = -1;
				nextIndex = _selectedIndex - totalRenderers + 1;
				break;
		}
		
		//Delta was not set, means the key was not handled.
		if (nextDelta == null )
			return false;
		//If the key was handled but it is not key down, just eat it.
		if (!keyPress)
			return true;
		//If we do not have any selectable items...
		if (bHasASelectableItem == false)
		{
			//If wrapping is enabled, just return
			if (wrapping == "stick" || wrapping == "wrap" || wrapping == "refuse")
			{
				return true;
			}
			else // Otherwise, don't handle it.
			{
				return false;
			}
		}
		
		do
		{
			nextIndex = nextIndex + nextDelta;
			
			//Did we go off the end?
			if (nextIndex >= _dataProvider.length)
			{
				if (wrapping == "stick")
				{
					//Find the last selectable thing
					nextIndex = _dataProvider.length;
					nextDelta = -1;
				}
				else if (wrapping == "wrap")
				{
					//Back to the beginning
					nextIndex = 0;
				} 
				else if (wrapping == "refuse")
				{
					//Refuse to move
					nextIndex = _selectedIndex;
				}
				else 
				{
					//We will move out of this object, so we will not handle it.
					return false;
				}
			}
			//Are we before the beginning?
			else if (nextIndex < 0)
			{
				if (wrapping == "stick")
				{
					//Find the first selectable thing
					nextIndex = -1;
					nextDelta = 1;
				} 
				else if (wrapping == "wrap")
				{
					//Go to the end
					nextIndex = _dataProvider.length-1;
				}
				else if (wrapping == "refuse")
				{
					//Refuse to move
					nextIndex = _selectedIndex;
				}
				else 
				{
					//We will move out of this object, so we will not handle it.
					return false;
				}
			}
			
			//Cannot be off of the list.
			//Also, cannot be unselectable or have an undefined data provider
			if (nextIndex >= 0 && nextIndex < _dataProvider.length && _dataProvider[nextIndex] != undefined &&
				(_dataProvider[nextIndex].unselectable == undefined || 
				 _dataProvider[nextIndex].unselectable == false) )
			{
				foundNextIndex = true;
			}
		} while (!foundNextIndex)
		
		if (selectedIndex != nextIndex) { selectedIndex = nextIndex; }
		
		return true;
	}
		
	public function get availableWidth():Number { 
		return autoScrollBar ? __width - _scrollBar._width : __width;
	}		
		
	/** @exclude */
	public function toString():String {
		return "[Scaleform ScrollingList " + _name + "]";
	}
	
// Private Methods:
	private function configUI():Void {
		super.configUI();
		if (inspectableScrollBar != '' && inspectableScrollBar != null) {
			scrollBar = inspectableScrollBar;
			inspectableScrollBar = null;
		}		
	}
	
	private function draw():Void {
		if (sizeIsInvalid) { 
			_width = __width;
			_height = __height;
		}
		
		if (externalRenderers) {
			totalRenderers = renderers.length;
		} else {
			container._xscale = 10000 / _xscale; // Counter scale the list items.
			container._yscale = 10000 / _yscale;
			var h:Number = _rowHeight;
			if (h == null) {
				var temp:MovieClip = createItemRenderer(99);
                temp.enableInitCallback = false;
				h = temp._height;
				temp.removeMovieClip();
			}
			var vertPadding:Number = (margin * 2) + paddingTop + paddingBottom;
			totalRenderers = Math.max(0, (__height - vertPadding + 0.05) / h >> 0);
				
			drawRenderers(totalRenderers);
			drawLayout(availableWidth, h);
		}
		updateScrollBar();
		invalidateData();
		setState();
		
		super.draw();
	}
	
	private function drawLayout(rendererWidth:Number, rendererHeight:Number):Void {
		var horizPadding:Number = paddingLeft + paddingRight + (margin * 2);
		rendererWidth = rendererWidth - horizPadding;
		var arrayLength = renderers.length;
		for (var i:Number = 0; i < arrayLength; i++) {
			var renderer:MovieClip = renderers[i];
			renderer._x = margin + paddingLeft;
			renderer._y = (i * rendererHeight) + margin + paddingTop;
			renderer.setSize(rendererWidth, rendererHeight);
		}
		drawScrollBar();
	}
	
	private function drawScrollBar():Void {
		if (!autoScrollBar) { return; }
		_scrollBar._x = __width - _scrollBar._width - margin;
		_scrollBar._y = margin;
		_scrollBar.height = __height - (margin * 2);
	}
	
	private function changeFocus():Void {
		super.changeFocus();
		setState();
		var renderer:MovieClip = getRendererAt(_selectedIndex);
		if (renderer != null) {
			renderer.displayFocus = _focused;
		}		
	}
	
	private function populateData(data:Array):Void {
		bHasASelectableItem = false;
		var arrayLength = renderers.length;
		for (var i:Number = 0; i < arrayLength; i++) {
			var dataObject:Object = data[i];
			var renderer:MovieClip = renderers[i];
			var index:Number = _scrollPosition + i;
			renderer.setListData(index, itemToLabel(dataObject), _selectedIndex == index); //LM: Consider passing renderer position also. (Support animation)
			renderer.setData(dataObject);
			//If something was already selectable, or this item is selectable, then there exists a selectable item in the list.
			bHasASelectableItem = bHasASelectableItem || ( dataObject && dataObject.unselectable != true );
		}
		updateScrollBar();
	}
	
	// The scrollBar changes
	private function handleScroll(event:Object):Void {
		var newPosition:Number = event.target.position;
		if (isNaN(newPosition)) { return; }
		scrollPosition = newPosition;
	}
	
	// The data/size changes
	private function updateScrollBar():Void {		
		var max:Number = Math.max(0, dataProvider.length-totalRenderers);
		if (_scrollBar.setScrollProperties != null) {
			_scrollBar.setScrollProperties(totalRenderers*thumbSizeFactor, 0, max);
		} else {
			_scrollBar.minimum = 0;
			_scrollBar.maximum = max;
		}
		_scrollBar.position = _scrollPosition;
		_scrollBar.trackScrollPageSize = Math.max(1, totalRenderers);
	}
	
	private function getRendererAt(index:Number):MovieClip {
		return renderers[index - _scrollPosition];
	}
	
	private function scrollWheel(delta:Number):Void {
		if (_disabled) { return; }
		var pageScrollSize = (_scrollBar != undefined) ? _scrollBar.pageScrollSize : 1;
		scrollPosition = _scrollPosition - (delta * pageScrollSize);
	}
	
	private function setState():Void {
		tabEnabled = focusEnabled = !_disabled;
		gotoAndPlay(_disabled ? "disabled" : _focused ? "focused" : "default");		
		if (_scrollBar) { 
			_scrollBar.disabled = _disabled; 
			_scrollBar.tabEnabled = false;
		}
		var arrayLength:Number = renderers.length;
		for (var i:Number = 0; i < arrayLength; i++) {
			var renderer:MovieClip = renderers[i];
			renderer.disabled = _disabled;
			renderer.tabEnabled = false;
		}
	}

}
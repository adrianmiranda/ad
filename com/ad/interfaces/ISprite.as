package com.ad.interfaces {
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.ui.ContextMenu;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface ISprite extends IDisplayObject {
		// PROXY SPRITE PROPERTIES
		function get buttonMode():Boolean;
		function set buttonMode(value:Boolean):void;
		function get dropTarget():DisplayObject;
		function get graphics():Graphics;
		function get hitArea():Sprite;
		function set hitArea(value:Sprite):void;
		function get soundTransform():SoundTransform;
		function set soundTransform(value:SoundTransform):void;
		function get useHandCursor():Boolean;
		function set useHandCursor(value:Boolean):void;
		// PROXY SPRITE FUNCTIONS
		function startDrag(lockCenter:Boolean = false, bounds:Rectangle = null):void;
		function stopDrag():void;
		// PROXY DISPLAY OBJECT CONTAINER PROPERTIES
		function get mouseChildren():Boolean;
		function set mouseChildren(value:Boolean):void;
		function get numChildren():int;
		function get tabChildren():Boolean;
		function set tabChildren(value:Boolean):void;
		// PROXY DISPLAY OBJECT CONTAINER FUNCTIONS
		function addChild(child:DisplayObject):DisplayObject;
		function addChildAt(child:DisplayObject, index:int):DisplayObject;
		function areInaccessibleObjectsUnderPoint(point:Point):Boolean;
		function contains(child:DisplayObject):Boolean;
		function getChildAt(index:int):DisplayObject;
		function getChildByName(name:String):DisplayObject;
		function getChildIndex(child:DisplayObject):int;
		function getObjectsUnderPoint(point:Point):Array;
		function removeChild(child:DisplayObject):DisplayObject;
		function removeChildAt(index:int):DisplayObject;
		function setChildIndex(child:DisplayObject, index:int):void;
		function swapChildren(child1:DisplayObject, child2:DisplayObject):void;
		function swapChildrenAt(index1:int, index2:int):void;
		// PROXY INTERACTIVE OBJECT PROPERTIES
		function get contextMenu():ContextMenu;
		function set contextMenu(value:ContextMenu):void;
		function get doubleClickEnabled():Boolean;
		function set doubleClickEnabled(value:Boolean):void;
		function get focusRect():Object;
		function set focusRect(value:Object):void;
		function get mouseEnabled():Boolean;
		function set mouseEnabled(value:Boolean):void;
		function get tabEnabled():Boolean;
		function set tabEnabled(value:Boolean):void;
		function get tabIndex():int;
		function set tabIndex(ivalue:int):void;
	}
}
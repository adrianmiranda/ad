package com.ad.ui {
	import flash.errors.IllegalOperationError;
	import flash.display.InteractiveObject;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.events.EventDispatcher;
	import flash.events.ContextMenuEvent;
	import flash.utils.getQualifiedClassName;
	
	[Event(name = 'ContextMenuEvent.MENU_ITEM_SELECT', type = 'flash.events.ContextMenuEvent')]
	[Event(name = 'ContextMenuEvent.MENU_SELECT', type = 'flash.events.ContextMenuEvent')]
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class ContextMenuManager extends EventDispatcher {
		protected var target:InteractiveObject;
		protected var menu:ContextMenu;
		
		public function ContextMenuManager(target:InteractiveObject, hideBuiltInItems:Boolean = true) {
			this.target = target;
			this.menu = new ContextMenu();
			if(hideBuiltInItems) this.menu.hideBuiltInItems();
			this.target.contextMenu = this.menu;
			this.menu.addEventListener(ContextMenuEvent.MENU_SELECT, passEvent);
		}
		
		public function add(caption:String,	handler:Function, separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true):ContextMenuItem {
			var result:ContextMenuItem = createItem(caption, handler, separatorBefore, enabled, visible);
			this.menu.customItems.push(result);
			return result;
		}
		
		public function insert(id:*, caption:String, handler:Function, separatorBefore:Boolean = false,	enabled:Boolean = true,	visible:Boolean = true):ContextMenuItem {
			var result:ContextMenuItem = createItem(caption, handler, separatorBefore, enabled, visible);
			var index:int = id is String ? getIndexByCaption(id) : id as int;
			(this.menu.customItems as Array).splice(index, 0, result);
			return result;
		}
		
		protected function createItem(caption:String, handler:Function, separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true):ContextMenuItem {
			var result:ContextMenuItem = new ContextMenuItem(caption, separatorBefore, enabled, visible);
			result.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, handler);
			result.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, passEvent);
			return result;
		}
		
		public function remove(id:*):void {
			if(id is String) {
				id = this.getIndexByCaption(id);
			}
			this.menu.customItems.splice(id as Number, 1);
		}
		
		public function hideBuiltInItems():void {
			this.menu.hideBuiltInItems();
		}
		
		public function getItem(id:*):ContextMenuItem {
			if(id is String) {
				id = this.getIndexByCaption(id);
			}
			return this.menu.customItems[id];
		}
		
		protected function getIndexByCaption(caption:String):int {
			for (var id:uint = 0; id < this.menu.customItems.length; id++) {
				if(this.menu.customItems[id].caption == caption) {
					return id;
				}
			}
			return -1;
		}
		
		public function get customItems():Array {
			return this.menu.customItems;
		}
		
		public function get builtInItems():ContextMenuBuiltInItems {
			return this.menu.builtInItems;
		}
		
		public function get contextMenu():ContextMenu {
			return this.menu;
		}
		
		protected function passEvent(event:ContextMenuEvent):void {
			super.dispatchEvent(event.clone());
		}
	}
}
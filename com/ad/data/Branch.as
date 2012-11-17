package com.ad.data 
{
	import com.ad.common.getClassName;
	
	public final class Branch
	{
		protected var _vars:Object;
		
		public function Branch(vars:Object)
		{
			this._vars = {};
			if (vars)
			{
				for (var property:String in vars)
				{
					this._vars[property] = vars[property];
				}
			}
		}
		
		public function id(value:String):Branch
		{
			return this.setParameter('id', value);
		}
		
		public function tag(value:String):Branch
		{
			return this.setParameter('tag', value);
		}
		
		public function url(value:String):Branch
		{
			return this.setParameter('url', value);
		}
		
		public function caste(value:String):Branch
		{
			return this.setParameter('caste', value);
		}
		
		public function layer(value:String):Branch
		{
			return this.setParameter('layer', value);
		}
		
		public function menu(value:Boolean):Branch
		{
			return this.setParameter('menu', value);
		}
		
		public function contextMenu(value:Boolean):Branch
		{
			return this.setParameter('contextMenu', value);
		}
		
		public function window(value:String):Branch
		{
			return this.setParameter('window', value);
		}
		
		public function level(value:uint):Branch
		{
			return this.setParameter('level', value);
		}
		
		public function external(value:Boolean):Branch
		{
			return this.setParameter('external', value);
		}
		
		public function standard(value:Boolean):Branch
		{
			return this.setParameter('standard', value);
		}
		
		public function mistake(value:Boolean):Branch
		{
			return this.setParameter('mistake', value);
		}
		
		public function param(property:String, value:*):Branch
		{
			return this.setParameter(property, value);
		}
		
		protected function setParameter(name:String, propertyValue:*):Branch
		{
			if (propertyValue == null)
			{
				delete this._vars[name];
			}
			else
			{
				this._vars[name] = propertyValue;
			}
			return this;
		}
		
		public function get vars():Object
		{
			return this._vars;
		}
		
		/** @private **/
		public function get isADVars():Boolean
		{
			return true;
		}
		
		public function toString():String
		{
			return '[' + getClassName(this) + ' ' + this._vars.id + ']';
		}
	}
}
package 
{
	import com.ad.utils.Cleaner;

	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public final class SlideContainer
	{
		private var _container:DisplayObjectContainer;
		private var _cA:Sprite = new Sprite();
		private var _cB:Sprite = new Sprite();
		private var _lC:Sprite;
		private var _cC:Sprite;

		public function SlideContainer(container:DisplayObjectContainer)
		{
			_container = container;
			_container.addChild(this._cA);
			_container.addChild(this._cB);
			this._lC = this._cA;
			this._cC = this._cB;
		}

		public function get containerOut():Sprite {
			return this._lC;
		}

		public function get containerIn():Sprite {
			return this._cC;
		}

		override public function addChild(child:DisplayObject):DisplayObject {
			Cleaner.removeChildrenOf(this._lC);
			if (this._cC == this._cB) {
				this._lC = this._cB;
				this._cC = this._cA;
			} else {
				this._lC = this._cA;
				this._cC = this._cB;
			}
			_container.swapChildren(this._cB, this._cA);
			var holder:DisplayObject = this._cC.addChild(child);
			return holder;
		}
	}
}
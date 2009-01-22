package actionScript.portfolios.diagramm.animation
{
	import actionScript.portfolios.diagramm.*;
	
	import mx.effects.Tween;
	import mx.effects.effectClasses.TweenEffectInstance;
	public class RingAnimationInstance extends TweenEffectInstance	
	{
		public var angleTo:Number;
  
        public function RingAnimationInstance(targetObj:*) {
            super(targetObj);
        }
  
        // Override play() method class.
        override public function play():void {
            // All classes must call super.play().
            super.play();
            // Create a Tween object. The tween begins playing immediately.
            var tween:Tween = 
                createTween(this,0, angleTo, duration);  
        }

        // Override onTweenUpdate() method.
        override public function onTweenUpdate(val:Object):void {
        	trace(val);
            target.reFill(val);
        }
  
        // Override onTweenEnd() method.
        override public function onTweenEnd(val:Object):void {
            // All classes that implement onTweenEnd() 
            // must call    super.onTweenEnd().
            super.onTweenEnd(val);
        }

	}
}
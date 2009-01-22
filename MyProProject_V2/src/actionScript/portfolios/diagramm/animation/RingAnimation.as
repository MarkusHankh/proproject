package actionScript.portfolios.diagramm.animation
{
	import mx.effects.IEffectInstance;
	import mx.effects.TweenEffect;
	public class RingAnimation extends TweenEffect
	{

		 // Define parameters for the effect.
       public var angleTo:Number = 0;
       
       public function setAngle(angle:Number){
       		this.angleTo=angle;
       }
  
       // Define constructor with optional argument.
       public function RingAnimation(targetObj:* = null) {
           super(targetObj);
           instanceClass= RingAnimationInstance;            
       }

       // Override getAffectedProperties() method to return "rotation".
       override public function getAffectedProperties():Array {
           return ["rotation"];
       }
    
       // Override initInstance() method.
       override protected function initInstance(inst:IEffectInstance):void {
           super.initInstance(inst);
           RingAnimationInstance(inst).angleTo = angleTo;
       } 

	}
}
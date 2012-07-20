package {
	import flash.display.Sprite;
	import flash.events.Event;
	import org.cove.ape.*;

	public class BotCar extends Sprite {
		// Car Body Parts
		public var CarGroup:Group=new Group();

		private var frontWheel:WheelParticle=new WheelParticle(160,20,10,false,3,.3,.01,1);
		private var backWheel:WheelParticle=new WheelParticle(200,20,10,false,3,.3,.01,1);
		private var wheelTransmission:SpringConstraint=new SpringConstraint(frontWheel,
		backWheel,1,true,10);

		public function BotCar() {
			addEventListener(Event.ENTER_FRAME,runLikeHell);

			var frontTire:frontW=new frontW();
			var backTire:frontW=new frontW();
			frontWheel.setDisplay(frontTire);
			backWheel.setDisplay(backTire);

			CarGroup.addParticle(frontWheel);
			CarGroup.addParticle(backWheel);
			CarGroup.addConstraint(wheelTransmission);
			CarGroup.collideInternal=true;



		}
		
		
		// this will be the main function which will move car and will be called by Game AI
		public function runLikeHell(e:Event) {
			frontWheel.angularVelocity=.05;
			backWheel.angularVelocity=.05;
		}

	}
}
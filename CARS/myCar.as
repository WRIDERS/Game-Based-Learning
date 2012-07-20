package {
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import org.cove.ape.*;

	public class myCar extends Sprite {
		//var to detect LEFT RIGHT position
		public var leftArrow=false;
		public var rightArrow=false;
		public var spaceBar=false;

		public var spacebarPressedOnEdge=false;

		// Car Body Parts
		public var CarGroup:Group=new Group();
		public var frontWheel:WheelParticle=new WheelParticle(280,20,20,false,3,.3,.01,1);
		public var backWheel:WheelParticle=new WheelParticle(200,20,20,false,3,.3,.01,1);
		private var wheelTransmission:SpringConstraint=new SpringConstraint(frontWheel,
		backWheel,1,false,10);
		



		public function myCar() {
			//setting up Car Body Parts
			var frontTire:wheel=new wheel();
			var backTire:wheel=new wheel();
			var body:Body=new Body();
			frontWheel.setDisplay(frontTire);
			backWheel.setDisplay(backTire);
			wheelTransmission.setDisplay(body);

			CarGroup.addParticle(frontWheel);
			CarGroup.addParticle(backWheel);
			CarGroup.addConstraint(wheelTransmission);
			
			CarGroup.collideInternal=true;
		}
		public function keyDownHandler(e:KeyboardEvent) {
			if (Keyboard.LEFT==e.keyCode) {
				leftArrow=true;

			} else if (Keyboard.RIGHT==e.keyCode) {
				rightArrow=true;
			} else if (Keyboard.SPACE==e.keyCode) {
				spaceBar=true;
				if (!spacebarPressedOnEdge) {
					spacebarPressedOnEdge=true;
				}
			}
		}
		public function keyUpHandler(e:KeyboardEvent) {
			if (e.keyCode==Keyboard.LEFT  ) {
				frontWheel.angularVelocity=0;
				backWheel.angularVelocity=0;
				leftArrow=false;
			} else if (e.keyCode==Keyboard.RIGHT  ) {
				frontWheel.angularVelocity=0;
				backWheel.angularVelocity=0;
				rightArrow=false;
			} else if (e.keyCode==Keyboard.SPACE) {
				spacebarPressedOnEdge=false;
				spaceBar=false;
			}
		}
		public function moveCar() {
//			trace(frontWheel.velocity.x+" "+frontWheel.velocity.y);
			if (leftArrow) {
				frontWheel.angularVelocity=-.11;
				backWheel.angularVelocity=-.11;
			} else if (rightArrow) {
				frontWheel.angularVelocity=.11;
				backWheel.angularVelocity=.11;				
			}
			if (posedgeDetector(spaceBar)) {
				var carV=frontWheel.velocity;
				var perpendicularVelGain=5;
				var parallelVelGain=1;
				var addCarVx;
				var addCarVy;
				if (carV.x>0) {
					addCarVx=(-carV.y*perpendicularVelGain)/Math.sqrt(carV.x*carV.x+carV.y*carV.y);
					addCarVy=(-carV.x*perpendicularVelGain)/Math.sqrt(carV.x*carV.x+carV.y*carV.y);
				} else if (carV.x<0) {
					addCarVx=(carV.y*perpendicularVelGain)/Math.sqrt(carV.x*carV.x+carV.y*carV.y);
					addCarVy=(carV.x*perpendicularVelGain)/Math.sqrt(carV.x*carV.x+carV.y*carV.y);
				}
				frontWheel.velocity=new Vector(addCarVx+carV.x*parallelVelGain,addCarVy+carV.y*parallelVelGain);
				backWheel.velocity=new Vector(addCarVx+carV.x*parallelVelGain,addCarVy+carV.y*parallelVelGain);


			}
		}
		//function for edge detection 
		private var prevVal=false;
		private var currVal=false;
		public function posedgeDetector(current) {
			prevVal=currVal;
			currVal=current;
			if (currVal && (currVal!=prevVal)  ) {
				return true;
			}
			return false;

		}

	}
}
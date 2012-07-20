package {
	import org.cove.ape.*;
	import flash.display.*;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;


	public class gamePlay extends MovieClip {
	
		public var floor:RectangleParticle=new RectangleParticle(300,380,1800,20,0,true);
		public var slopeRight:RectangleParticle=new RectangleParticle(1000,360,800,100,-10*3.14/180,true);

		public var MainGroup:Group=new Group();

		public var ground=new  grnd();


		//var to detect LEFT RIGHT position
		private var leftArrow=false;
		private var rightArrow=false;
		private var spaceBar=false;

		// Car Body Parts
		public var CarGroup:Group=new Group();

		private var frontWheel:WheelParticle=new WheelParticle(200,20,10,false,3,.3,.01,1);
		private var backWheel:WheelParticle=new WheelParticle(240,20,10,false,3,.3,.01,1);
		private var wheelTransmission:SpringConstraint=new SpringConstraint(frontWheel,
		backWheel,1,true,10);



		public function gamePlay() {


			stage.addEventListener(Event.ENTER_FRAME,run);
			stage.addEventListener(KeyboardEvent.KEY_DOWN , keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP , keyUpHandler);

			stage.frameRate=60;

			APEngine.init(1/4);
			APEngine.container=this;
			APEngine.addMasslessForce(new Vector(0,2));
			APEngine.damping=.99;
			
			//setting up Main Game Container
			slopeRight.setStyle(0,0xCC3300,1,0xCC3300);			
			floor.setStyle(0,0xCC3300,1,0xCC3300);
			MainGroup.addParticle(floor);
			MainGroup.addParticle(slopeRight);
			MainGroup.collideInternal=true;

			//setting up Car Body Parts
			var frontTire:frontW=new frontW();
			var backTire:frontW=new frontW();
			frontWheel.setDisplay(frontTire);
			backWheel.setDisplay(backTire);			
			
			CarGroup.addParticle(frontWheel);
			CarGroup.addParticle(backWheel);
			CarGroup.addConstraint(wheelTransmission);
			CarGroup.collideInternal=true;
			
			APEngine.addGroup(MainGroup);
			APEngine.addGroup(CarGroup);


			//Making our car collide with ground
			CarGroup.addCollidable(MainGroup);

		}
		
		public function run(evt:Event) {
			APEngine.step();
			APEngine.paint();
			APEngine.container.x=-frontWheel.px+200;
			moveCar();
		}
		
		public function keyDownHandler(e:KeyboardEvent) {
			if (Keyboard.LEFT==e.keyCode) {
				leftArrow=true;
				
			} else if (Keyboard.RIGHT==e.keyCode) {
				rightArrow=true;
			} else if (Keyboard.SPACE==e.keyCode) {
				spaceBar=true;
			}
		}
		
		public function keyUpHandler(e:KeyboardEvent) {			
			frontWheel.angularVelocity=0;
			backWheel.angularVelocity=0;
			leftArrow=false;
			rightArrow=false;
			spaceBar=false;
		}
		
		public function moveCar(){
			if(leftArrow) {frontWheel.angularVelocity=-.1;}
			else if(rightArrow) {frontWheel.angularVelocity=.1;}
			if(spaceBar) 
			{
				frontWheel.velocity=new Vector(5*frontWheel.radius*frontWheel.angularVelocity,7);
				backWheel.velocity=new Vector(5*backWheel.radius*backWheel.angularVelocity,7);
			}
		}
		
	}
}
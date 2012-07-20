package {
	import org.cove.ape.*;
	import flash.display.*;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;


	public class main extends MovieClip {


		public var MYCAR:myCar;
		var GAMELEVEL:levelContainer;
		public function main() {

			MYCAR=new myCar();
			stage.addChild(MYCAR);

			stage.addEventListener(KeyboardEvent.KEY_DOWN , MYCAR.keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP , MYCAR.keyUpHandler);
			stage.addEventListener(Event.ENTER_FRAME,run);
			stage.frameRate=60;

			APEngine.init(1/4);
			APEngine.container=this;
			APEngine.addMasslessForce(new Vector(0,2));
			APEngine.damping=.99;



			GAMELEVEL=new levelContainer();
			stage.addChild(GAMELEVEL);


			var BOT:BotCar=new BotCar();
			stage.addChild(BOT);
			BOT.x=150;
			BOT.y=10;
			BOT.CarGroup.addCollidable(GAMELEVEL.MainGroup);


			APEngine.addGroup(MYCAR.CarGroup);
			APEngine.addGroup(BOT.CarGroup);
			APEngine.addGroup(GAMELEVEL.MainGroup);


			//Making our car collide with ground
			MYCAR.CarGroup.addCollidable(GAMELEVEL.MainGroup);
		}
		public function run(evt:Event) {
			APEngine.step();
			APEngine.paint();
			APEngine.container.x=-MYCAR.frontWheel.px+200; 
			this.x=-MYCAR.frontWheel.px+200;
			MYCAR.moveCar();
			checkLevelEnd();
			checkGameOver();
		}
		public function checkLevelEnd() {
			if (MYCAR.frontWheel.px >= GAMELEVEL.levelMaxWidth-250 && MYCAR.frontWheel.py<700) {
				//trace("Call addPlat"+MYCAR.frontWheel.px+"/"+GAMELEVEL.levelMaxWidth);
				GAMELEVEL.addPlatform(MYCAR.frontWheel.px,MYCAR.frontWheel.py);
			}
		}
		public function checkGameOver() {
			if ( MYCAR.frontWheel.py>700 || MYCAR.backWheel.py>700) {
				MovieClip(root).gotoAndStop(3);
			}
		}
	}
}
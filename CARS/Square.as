package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class Square extends Sprite {
		var lefty=false;

		public function init() {
			stage.addEventListener(KeyboardEvent.KEY_DOWN,moveR);
			stage.addEventListener(Event.ENTER_FRAME,run);
			
		}
		public function moveR(evt:KeyboardEvent) {
			if (evt.keyCode==Keyboard.LEFT) {
				lefty=true;
			} else {
				lefty=false;
			}
		}
		public function run(e:Event)
		{
			if(lefty)
			{
				this.x+=.01;
			}
		}
	}
}
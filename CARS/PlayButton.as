package {
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	public class PlayButton extends SimpleButton {
		public function PlayButton() {
			addEventListener(MouseEvent.CLICK,playButtonClick);
		}
		public function playButtonClick(evt:MouseEvent) {
			MovieClip(root).gotoAndStop(2);
		}
	}
}
package {
	import flash.display.MovieClip;
	import flash.text.TextField;
	public class endGameScreen extends MovieClip {
		public function endGameScreen() {
			var t=new TextField();
			t.Text="GAME OVER";
			stage.addChild(t);
		}


	}

}
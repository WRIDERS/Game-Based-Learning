package {
	import flash.display.Sprite;
	import org.cove.ape.*;


	public class levelContainer extends Sprite {

		public var levelMaxWidth=2700;
		public var platFormWidth=700;
		public var platFormHeight=30;		

		public var floor:RectangleParticle=new RectangleParticle(300,380,1800,20,0,true);
		public var slopeRight:RectangleParticle=new RectangleParticle(1000,360,800,100,-10*3.14/180,true);
		public var jumpRight :RectangleParticle=new RectangleParticle(1850,360,700,30,0,true);
		public var jumpAgain :RectangleParticle=new RectangleParticle(2400,300,300,30,0,true);

		public var MainGroup:Group=new Group();

		public var ground=new  grnd();

		public function levelContainer() {

			//setting up Main Game Container
			slopeRight.setStyle(0,0xCC3300,1,0xCC3300);
			floor.setStyle(0,0xCC3300,1,0xCC3300);
			jumpRight.setStyle(0,0xCC3300,1,0xCC3300);
			jumpAgain.setStyle(0,0xCC3300,1,0xCC3300);
			MainGroup.addParticle(floor);
			MainGroup.addParticle(slopeRight);
			MainGroup.addParticle(jumpRight);
			MainGroup.addParticle(jumpAgain);
			MainGroup.collideInternal=false;
		}

		public function addPlatform(CarX:Number,CarY:Number) {			
			var platformWidth=Math.random()*platFormWidth;
			
			var platform:RectangleParticle=new RectangleParticle(levelMaxWidth+20+platformWidth/2,(CarY-40)+Math.random()*(440-CarY) ,platformWidth, platFormHeight, 0,true );
			platform.setStyle(0,0xCC3300,1,0xCC3300);
			
			MainGroup.addParticle(platform);
			levelMaxWidth+=platformWidth+20;
		}
	}
}
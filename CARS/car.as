package car{
	import org.cove.ape.*;

	public class car extends Group {
		private var frontWheel:WheelParticle=new WheelParticle(200,20,10,false,3);
		private var backWheel:WheelParticle=new WheelParticle(240,20,10,false,3);
		private var wheelTransmission:SpringConstraint=new SpringConstraint(frontWheel,
		backWheel,.5,true,10);

		public function car() {
			this.addParticle(frontWheel);
			this.addParticle(backWheel);
			this.addConstraint(wheelTransmission);

		}

	}

}
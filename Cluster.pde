// The Cluster that spawns on top of te screen and bounces from left to right downwards

class Cluster
{
  Cluster() {
    this.steak = loadImage("Steak.png");
  }
  
  // The distance from both edges where clusters can spawn
  private float screenEdgeOffset = 200;
  
  // Movement variables
  private PVector speed = new PVector(random(-10, 10), random(4, 7));
  private PVector location = new PVector(random(screenEdgeOffset, width-screenEdgeOffset), -100);
  
  // Shape Sizes
  private float minShapeScale = 50;
  private float maxShapeScale = 200;
  
  // Set Random Scale of Shape at start
  private float shapeSize = random(minShapeScale, maxShapeScale);
  
  // Image for the steak in the cluster
  private PImage steak;
  
  // Executed every frame
  public void update()
  { 
      this.location.y += this.speed.y;
      this.location.x += this.speed.x;
      
      if (this.location.x > width || this.location.x < 0)
      {
        this.location.x += this.speed.x * -2;
        this.speed.x *= -1;
      }
      
      // Draw Steak on Screen
      image(steak, this.location.x - this.shapeSize * 0.5, this.location.y - this.shapeSize * 0.5, this.shapeSize, this.shapeSize);
   }
}

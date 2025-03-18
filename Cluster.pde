// The Cluster that spawns on top of te screen and bounces from left to right downwards

class Cluster {
  Cluster(int ClusterIndex) {
    this.steak = loadImage("Steak.png");
    this.yLocation = ClusterIndex *= -200;
  }
  
  //The distance from both edges where clusters can spawn
  private float screenEdgeOffset = 400;
  
  //Movement variables
  private float xSpeed = random(3, 10); //The Horizontal Speed of the shape
  private float ySpeed = random(4, 7); //The Vertical Speed of the shape
  private float xLocation = random(screenEdgeOffset, width-screenEdgeOffset); //The Horizontal Start Location
  private float yLocation = random(-2000, -200); //The Vertical Start Location
  
  //Shape Sizes
  private float minShapeScale = 10;
  private float maxShapeScale = 100;
  private float shapeScaleSpeed = 0.5;
  
  //Set Random Scale of Shape at start
  private float shapeSize = random(minShapeScale, maxShapeScale);
  
  //Image for the steak in the cluster
  private PImage steak;
  
  //Executed every frame
  public void update()
  { 
    //Calculate the X and Y position
    xLocation = calculateXposition(this.xLocation, this.xSpeed);
    yLocation = calculateYposition(this.yLocation, this.ySpeed);
    
    //Calculate the shape scale speed
    calculateScaling();
    
    //Check wall collision
    xSpeed = checkspeed(this.xLocation, this.xSpeed, this.shapeSize);
    
    //Draw Shapes to screen
    drawshapes(this.xLocation, this.yLocation);
  }
  
  //Calculate the new horizontal location based on the horizontal speed
  float calculateXposition(float xPos, float xSpeed)
  { 
    return xPos += xSpeed;
  }
  
  //Calculate the new Vertical location based on the verticle speed
  float calculateYposition(float yPos, float ySpeed)
  {
    return yPos += ySpeed;
  }
  
  //Scale the shapes between the min and max valuess
  private void calculateScaling()
  {
    if (this.shapeSize + this.shapeScaleSpeed >= this.maxShapeScale || this.shapeSize + this.shapeScaleSpeed < this.minShapeScale)
    {
       this.shapeScaleSpeed *= -1;
    } 
    this.shapeSize += this.shapeScaleSpeed;
  }
  
  //Check if the cluster is touching the bottom of the screen
  float checkbottomcollision(float yPos)
  {
    //Is touching the bottom of the screen
    if (yPos + this.shapeSize * 0.5 > height)
    {
       return this.xLocation;
    }
    return 0;
  }
  
  //Check if the horizontal position is outside the border of the screen
  float checkspeed(float xPos, float xSpeed, float shapeSize)
  {
    //If it's outside of the borders go the other way
    if (xPos + (shapeSize * 0.5 + shapeSize) + 2 > width || xPos - (shapeSize * 0.5 + shapeSize) - 2 < 0)
    {
       this.xLocation += xSpeed * -2;
       return xSpeed * -1;
    }
    return xSpeed;
  }
  
  //Draw the shapes on the screen based on the X and Y Origin point
  private void drawshapes(float xPos, float yPos)
  {
    //Draw shapes
    image(this.steak, xPos - this.shapeSize, yPos - this.shapeSize, this.shapeSize * 2, this.shapeSize * 2);
  }
}

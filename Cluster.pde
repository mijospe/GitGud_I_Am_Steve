// The Cluster that spawns on top of te screen and bounces from left to right downwards
// Getest door Aurora Polak - GDV

class Cluster {
  Cluster(int ClusterIndex) {
    Steak = loadImage("Steak.png");
    YLocation = ClusterIndex *= -200;
  }
  
  //The distance from both edges where clusters can spawn
  float ScreenEdgeOffset = 400;
  
  //Movement variables
  float XSpeed = random(3, 10); //The Horizontal Speed of the shape
  float YSpeed = random(4, 7); //The Vertical Speed of the shape
  float XLocation = random(ScreenEdgeOffset, width-ScreenEdgeOffset); //The Horizontal Start Location
  float YLocation = random(-2000, -200); //The Vertical Start Location
  
  //Shape Sizes
  float MinShapeScale = 10;
  float MaxShapeScale = 100;
  float ShapeScaleSpeed = 0.5;
  
  //Set Random Scale of Shape at start
  float ShapeSize = random(MinShapeScale, MaxShapeScale);
  
  //Image for the steak in the cluster
  PImage Steak;
  
  //Executed every frame
  void update()
  { 
    //Calculate the X and Y position
    XLocation = calculateXposition(XLocation, XSpeed);
    YLocation = calculateYposition(YLocation, YSpeed);
    
    //Calculate the shape scale speed
    calculateScaling();
    
    //Check wall collision
    XSpeed = checkspeed(XLocation, XSpeed, ShapeSize);
    
    //Draw Shapes to screen
    drawshapes(XLocation, YLocation);
  }
  
  //Calculate the new horizontal location based on the horizontal speed
  float calculateXposition(float XPos, float XSpeed)
  { 
    return XPos += XSpeed;
  }
  
  //Calculate the new Vertical location based on the verticle speed
  float calculateYposition(float YPos, float YSpeed)
  {
    return YPos += YSpeed;
  }
  
  //Scale the shapes between the min and max valuess
  void calculateScaling()
  {
    if (ShapeSize + ShapeScaleSpeed >= MaxShapeScale || ShapeSize + ShapeScaleSpeed < MinShapeScale)
    {
      ShapeScaleSpeed*=-1;
    } 
    ShapeSize += ShapeScaleSpeed;
  }
  
  //Check if the cluster is touching the bottom of the screen
  float checkbottomcollision(float YPos)
  {
    //Is touching the bottom of the screen
    if (YPos + ShapeSize * 0.5 > height)
    {
      
      //Reset cluster to the top of the screen
      //YLocation = random(-400, -100);
      //XLocation = random(400, width-400);
      //XSpeed+=2;
      //YSpeed+=0.2;
      return XLocation;
    }
    return 0;
  }
  
  //Check if the horizontal position is outside the border of the screen
  float checkspeed(float xpos, float xspeed, float shapesize)
  {
    //If it's outside of the borders go the other way
    if (xpos + (shapesize * 0.5 + shapesize) + 2 > width || xpos - (shapesize * 0.5 + shapesize) - 2 < 0)
    {
      XLocation += xspeed*-2;
      return xspeed * -1;
    }
    return xspeed;
  }
  
  //Draw the shapes on the screen based on the X and Y Origin point
  void drawshapes(float xpos, float ypos)
  {
    //Draw shapes
    image(Steak, xpos-ShapeSize, ypos-ShapeSize, ShapeSize*2, ShapeSize*2);
    //circle(xpos - ShapeSize * 0.5 - ShapeSize * 0.5, ypos, ShapeSize);
    //circle(xpos + ShapeSize * 0.5 + ShapeSize * 0.5, ypos, ShapeSize);
  }
}

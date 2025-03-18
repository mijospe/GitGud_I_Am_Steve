// The Player on the bottom of the screen that can be moved by the mouse
// Getest door Aurora Polak - GDV

class Player {
  Player()
  {
    //Load the player image
    PlayerImage = loadImage("I_Am_Steve.png");
  }
  
  //Player Image Size
  int PlayerImageWidth = 200;
  int PlayerImageHeight = 250;
  
  //Player Movement
  float XLocation = width*0.5; //The horizontal Player Location
  float YLocation = height; //The Vertical Player Location
  float Mass = 10; //Player Mass (The Higher it is the slower it moves)
  
  //Player Image
  PImage PlayerImage;
  
  //Update every frame
  void update()
  {
    //Calculate new position based on Mouse Location and Mass
    float Distance = mouseX - XLocation;
    float PlayerSpeed = Distance / Mass;
    XLocation = XLocation + PlayerSpeed;
    
    //Draw Player
    image(PlayerImage, XLocation - PlayerImageWidth * 0.5, YLocation - PlayerImageHeight, PlayerImageWidth, PlayerImageHeight);
  }
}

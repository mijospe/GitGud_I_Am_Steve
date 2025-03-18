// The Player on the bottom of the screen that can be moved by the mouse

class Player {
  Player()
  {
    //Load the player image
    playerImage = loadImage("I_Am_Steve.png");
  }
  
  //Player Image Size
  private int playerImageWidth = 200;
  private int playerImageHeight = 250;
  
  //Player Movement
  private float xLocation = width*0.5; //The horizontal Player Location
  private float yLocation = height; //The Vertical Player Location
  private float mass = 10; //Player Mass (The Higher it is the slower it moves)
  
  //Player Image
  private PImage playerImage;
  
  //Update every frame
  public void update()
  {
    //Calculate new position based on Mouse Location and Mass
    float distance = mouseX - this.xLocation;
    float playerSpeed = distance / this.mass;
    this.xLocation = this.xLocation + playerSpeed;
    
    //Draw Player
    image(this.playerImage, this.xLocation - this.playerImageWidth * 0.5, this.yLocation - this.playerImageHeight, this.playerImageWidth, this.playerImageHeight);
  }
}

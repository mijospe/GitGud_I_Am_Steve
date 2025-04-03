// The Player on the bottom of the screen that can be moved by the mouse

class Player
{
  Player()
  {
    playerImage = loadImage("I_Am_Steve.png"); // Load Player Image
    
    healthUI = new HealthUI(3);
  }
  
  // Player Image Size
  private int playerImageWidth = 200;
  private int playerImageHeight = 250;
  
  private float previousDamageMiliSecond;
  private float damageDuration = 200;
  
  // Player Movement
  private PVector location = new PVector(width*0.5, height);
  private float mass = 10; // Player Mass (The Higher it is the slower it moves)
  
  private PImage playerImage; // Player Image
  
  private HealthUI healthUI; // Health on top of the screen
  
  // Update every frame
  public void update()
  {
    // Color the player red for a certain amount of time
    if (millis() - previousDamageMiliSecond <= damageDuration)
    {
      println("RED");
      tint(255, 150, 150);
    }
    
    
    // Calculate new position based on Mouse Location and Mass
    float distance = mouseX - this.location.x;
    float playerSpeed = distance / this.mass;
    this.location.x = this.location.x + playerSpeed;
    
    // Draw Player and Health UI
    image(this.playerImage, this.location.x - this.playerImageWidth * 0.5, this.location.y - this.playerImageHeight, this.playerImageWidth, this.playerImageHeight);
    healthUI.update();
    
    tint(255, 255, 255);
  }
  
  // Damages the player, returns true if dead
  public boolean damage(int damageAmount)
  {
    previousDamageMiliSecond = millis();
    return healthUI.damage(damageAmount);
  }
  
  // Add health to the player
  public void addHealth(int healthAmount)
  {
    healthUI.addHealth(healthAmount);
  }
  
  // Reset all player data (Upon game reset)
  public void reset()
  {
    addHealth(5);
    mass = 10;
    playerImageWidth = 200;
  }
}

// Git Gud
// Made by Joey van der Hoef - GDV

import ddf.minim.*;

//The delay in between spawning a cluser (In Miliseconds)
private float delay = 2000;

//How much mass does the player need to gain after eating a cluster
private int massIncreaser = 1;

//Scoreboard text settings
public float textXOffset = 25;
public float textYOffset = 100;
public float textSize = 100;

//The Previous spawn time and delay for when to spawn the next Cluster
private int previousMiliSecond;

//Score for the steaks
private int score = 0;

//Sounds
private Minim soundFunctionality;
private AudioSample eat;
private AudioSample steve;
private AudioSample damage;
private AudioSample minecraftMusic;

//Background Image & Game Over Image
private PImage backgroundImage;
private PImage gameOverImage;

// Buttons
private Button restartButton;
private Button quitButton;

//Instance References to the Player and Clusters
private ArrayList<Cluster> clusters = new ArrayList<Cluster>();
private Player playerReference;

// Game over
private boolean gameOver;
private boolean gameOverTriggered;

//--------------------//
//    Run at Start    //
//--------------------//
void setup()
{
  // Change Window Size and Text Size
  size(1920, 1080);
  rectMode(CENTER);
  textSize(128);
  
  // Load Images
  backgroundImage = loadImage("Background.png");
  backgroundImage.resize(width, height);
  gameOverImage = loadImage("GameOver.png");
  gameOverImage.resize(width, height);
  
  // Set Sounds and play music
  soundFunctionality = new Minim(this);
  eat = soundFunctionality.loadSample("Eat.mp3");
  steve = soundFunctionality.loadSample("I_Am_Steve.mp3");
  damage = soundFunctionality.loadSample("Oof.mp3");
  minecraftMusic = soundFunctionality.loadSample("Minecraft.mp3");
  minecraftMusic.trigger();
  minecraftMusic.setGain(4000);
  
  // Spawn Player into the game and save it
  playerReference = new Player();
}

//-----------------------//
//    Run every frame    //
//-----------------------//
void draw()
{
  // Draw background
  image(backgroundImage, 0, 0);
  
  // If the player is dead, dont draw game assets
  if (checkGameOver()) { return; }
  
  // Update the player every frame and reset the color to default after (for the damage functionality)
  playerReference.update();
  
  // If time has passed since previous spawn, spawn a new one
  if (millis() - previousMiliSecond >= delay)
  {
    delay = constrain(delay * 0.995, 1, 2000);
    previousMiliSecond = millis();
    clusters.add(new Cluster());
  }
  
  // Update all the clusters
  updateClusters();
  
  // Show score on screen
  fill(255, 255, 255, 255);
  text(score, 25, 100);
  println(score);
}

//-------------------------//
//    Reset entire game    //
//-------------------------//
void reset()
{
  clusters.clear();
  steve.stop();
  minecraftMusic.stop();
  minecraftMusic.trigger();
  score = 0;
  delay = 2000;
  gameOver = false;
  gameOverTriggered = false;
  playerReference.reset();
}

//------------------------------------------------------//
//    Check the collision based on location and size    //
//------------------------------------------------------//
boolean checkCollision(PVector location1, PVector size1, PVector location2, PVector size2)
{
  return location1.x > location2.x - size2.x * 0.5 &&
         location1.x < location2.x + size2.x * 0.5 &&
         location1.y + size1.y > location2.y - size2.y * 0.5f &&
         location1.y < location2.y + size2.y * 0.5;
}

//-------------------------------//
//    Update all the clusters    //
//-------------------------------//
void updateClusters()
{
  // Go trough every single cluster in the list of clusters
  for(int i = 0; i < clusters.size() - 1; i++) 
  {
    Cluster currentCluster = clusters.get(i);
    currentCluster.update();
    
    // Collision detection
    if (checkCollision(currentCluster.location, new PVector(currentCluster.shapeSize, currentCluster.shapeSize), playerReference.location, new PVector(playerReference.playerImageWidth, playerReference.playerImageHeight)))
    {
        // Increase score and play eat sound
        score++;
        playerReference.mass += massIncreaser;
        playerReference.playerImageWidth += massIncreaser * 3;
        
        eat.setGain(-10);
        eat.trigger();
        
        // Remove Cluster
        clusters.remove(i);
        i--;
    }
    else if (currentCluster.location.y > height)
    {
      // If the health is <= 0, end the game, otherwise play damage sound
       if (playerReference.damage(1)) { gameOver = true; }
       damage.trigger();
       
       // Remove Cluster
       clusters.remove(i);
       i--;
    }
  }
}

//-------------------------------------//
//    Check if the game needs to end   //
//-------------------------------------//
boolean checkGameOver()
{
  // If the player is dead
  if (gameOver)
  {
    if (!gameOverTriggered)
    {
      gameOverTriggered = true;
      steve.trigger();
      restartButton = new Button(width * 0.5, height * 0.59, width * 0.465, height * 0.08);
      quitButton = new Button(width * 0.5, height * 0.69, width * 0.465, height * 0.08);
    }
    image(gameOverImage, 0, 0);
    if (restartButton.update()) reset();
    if (quitButton.update()) exit();
    return true;
  }
  return false;
}

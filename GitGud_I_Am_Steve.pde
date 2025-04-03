// Git Gud
// Made by Joey van der Hoef - GDV

import ddf.minim.*;

//The delay in between spawning a cluser (In Miliseconds)
private int delay = 2000;

//How much mass does the player need to gain after eating a cluster
private int massIncreaser = 5;

//Scoreboard text settings
public float textXOffset = 25;
public float textYOffset = 100;
public float textSize = 100;

//The amount of clusters that have been spawned
private int clusterCount;

//The Previous spawn time and delay for when to spawn the next Cluster
private int previousMiliSecond;

//Score for the steaks
private int score;

//Sounds
private Minim soundFunctionality;
private AudioSample eat;
private AudioSample steve;
private AudioSample minecraftMusic;

//Background Image & Game Over Image
private PImage backgroundImage;
private PImage gameOverImage;

//Instance References to the Player and Clusters
private ArrayList<Cluster> clusters = new ArrayList<Cluster>();
private Player playerReference;


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
  
  // Set Sounds
  soundFunctionality = new Minim(this);
  eat = soundFunctionality.loadSample("Eat.mp3");
  steve = soundFunctionality.loadSample("I_Am_Steve.mp3");
  minecraftMusic = soundFunctionality.loadSample("Minecraft.mp3");
  // Play Background Music
  minecraftMusic.trigger();
  
  // Spawn Player into the game and save it
  playerReference = new Player();
}

//-----------------------//
//    Run every frame    //
//-----------------------//
void draw()
{
  // Change the volume every frame
  minecraftMusic.setGain(4000);
  
  // Draw background
  image(backgroundImage, 0, 0);
  
  // Update the player every frame
  playerReference.update();
  
  // If time has passed since previous spawn, spawn a new one
  if (millis() - previousMiliSecond >= delay)
  {
    previousMiliSecond = millis();
    clusters.add(new Cluster(0));
    clusterCount++;
  }
  
  // Go trough every single cluster in the list of clusters
  for(int i = 0; i < clusters.size() - 1; i++) 
  {
    // Set the current looping Cluster
    Cluster currentCluster = clusters.get(i);
    // Update Cluster
    currentCluster.update();
    // Check Bottom Collision for Cluster
    float clusterXLocation = currentCluster.checkbottomcollision(currentCluster.yLocation);
    float playerX = playerReference.xLocation;
    // If the cluster is currently hitting the bottom of the screen
    log(clusterXLocation);
    if (clusterXLocation != 0)
    {
      if (clusterXLocation > playerX - playerReference.playerImageWidth*0.5 && clusterXLocation < playerX + playerReference.playerImageWidth * 0.5)
      {
         score++;
         playerReference.mass += massIncreaser;
         playerReference.playerImageWidth += massIncreaser;
         eat.setGain(-10);
         eat.trigger();
      }
      
      // Stop rendering this cluster
      clusters.remove(i);
      i--;
    }
  }
  
  text(score, 25, 100);
  
  println(clusters.size());
}
  
  // Game Over
  //else if(clusters.size() <= 1 && clusterCount > 0)
  //{
  //  clusterCount = 0;
  //  steve.trigger();
  //  image(gameOverImage, 0, 0);
  //}

// Practicum opdracht 7 (Game)
// Gemaakt door Joey van der Hoef - GDV
// Getest door Aurora Polak - GDV

import ddf.minim.*;

//The delay in between spawning a cluser (In Miliseconds)
int Delay = 2000;

//Max Cluster Count to Spawn in Level
int MaxClusterCount = 10;

//How much mass does the player need to gain after eating a cluster
int MassIncreaser = 5;

//Scoreboard text settings
float TextXOffset = 25;
float TextYOffset = 100;
float TextSize = 100;

//The amount of clusters that have been spawned
int ClusterCount;

//The Previous spawn time and delay for when to spawn the next Cluster
int PreviousMiliSecond;

//Score for the steaks
int Score;

//Sounds
Minim SoundFunctionality;
AudioSample Eat;
AudioSample Steve;
AudioSample MinecraftMusic;

//Background Image & Game Over Image
PImage BackgroundImage;
PImage GameOverImage;

//Instance References to the Player and Clusters
ArrayList<Cluster> Clusters = new ArrayList<Cluster>();
Player PlayerReference;


void setup()
{
  size(1920, 1080);
  rectMode(CENTER);
  textSize(128);
  
  //Load Images
  BackgroundImage = loadImage("Background.png");
  BackgroundImage.resize(width, height);
  GameOverImage = loadImage("GameOver.png");
  GameOverImage.resize(width, height);
  
  //Set Sounds
  SoundFunctionality = new Minim(this);
  Eat = SoundFunctionality.loadSample("Eat.mp3");
  Steve = SoundFunctionality.loadSample("I_Am_Steve.mp3");
  MinecraftMusic = SoundFunctionality.loadSample("Minecraft.mp3");
  
  //Play Background Music
  MinecraftMusic.trigger();
  
  //Spawn 3 clusters at the start of the game
  for(int i=0; i <= 3; i++){
     Clusters.add(new Cluster(i));
     ClusterCount++;
  }
  
  //Spawn Player into the game and set its reference
  PlayerReference = new Player();
}

//Run every frame
void draw()
{
  MinecraftMusic.setGain(10000);
  
  //If the game has not finished
  if (Clusters.size() > 1)
  {
    //Redraw background
    image(BackgroundImage, 0, 0);
    
    //Update the player every frame
    PlayerReference.update();
    
    //If time has passed since previous spawn, spawn a new one
    if (millis() - PreviousMiliSecond >= Delay && ClusterCount <= MaxClusterCount)
    {
      PreviousMiliSecond = millis();
      Clusters.add(new Cluster(0));
      ClusterCount++;
    }
    
    //Go trough every single cluster in the list of clusters
    for(int i = 0; i < Clusters.size() - 1; i++) 
    {
      Cluster CurrentCluster = Clusters.get(i);
      //Update Cluster
      CurrentCluster.update();
      //Check Bottom Collision for Cluster
      float ClusterXLocation = CurrentCluster.checkbottomcollision(CurrentCluster.YLocation);
      float PlayerX = PlayerReference.XLocation;
      //If the cluster is currently hitting the bottom of the screen
      if (ClusterXLocation != 0)
      {
        if (ClusterXLocation > PlayerX - PlayerReference.PlayerImageWidth*0.5 && ClusterXLocation < PlayerX + PlayerReference.PlayerImageWidth * 0.5)
        {
           Score++;
           PlayerReference.Mass += MassIncreaser;
           PlayerReference.PlayerImageWidth += MassIncreaser;
           Eat.setGain(-10);
           Eat.trigger();
        }
        
        //Stop rendering this cluster
        Clusters.remove(i);
        i--;
      }
    }
    
    
    text(Score, 25, 100);
    
    println(Clusters.size());
  }
  //Game Over
  else if(Clusters.size() <= 1 && ClusterCount > 0)
  {
    ClusterCount = 0;
    Steve.trigger();
    image(GameOverImage, 0, 0);
  }
}

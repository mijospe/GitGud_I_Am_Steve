// A heart that can be added as visual cue for the lives remaining

class Heart
{
  Heart()
  {
    heartImage = loadImage("Heart.png"); // Load Player Image
  }
  
  private PImage heartImage; // Player Image
  
  // Executed every frame
  public void update(int index)
  {
    image(heartImage, width - 80 * (index + 1), 0, 75, 75);
  }
}

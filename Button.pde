class Button
{
  Button(float inX, float inY, float inW, float inH) {
    // Use Default values if no values are given
    if (inX != 0) x = inX;
    if (inY != 0) y = inY;
    if (inW != 0) w = inW;
    if (inH != 0) h = inH;
  }
  
  private float x = 100;
  private float y = 50;
  private float w = 150;
  private float h = 80;
  
  public boolean update()
  {
   fill(0, 0, 0, 0);
   // If hovered
   if (mouseX > this.x - this.w * 0.5 && mouseX < this.x + this.w * 0.5 && mouseY > this.y - this.h * 0.5 && mouseY < this.y + this.h * 0.5)
   {
     fill(150, 150, 150, 50);
     // If pressed
     if (mousePressed)
     {
       fill(0, 0, 0, 50);
       rect(this.x, this.y, this.w, this.h);
       return true;
     }
   }
   rect(this.x, this.y, this.w, this.h);
   return false;
  } 
}

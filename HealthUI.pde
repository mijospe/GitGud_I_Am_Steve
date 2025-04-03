// The Health UI shown on top of everything on screen

class HealthUI
{
  HealthUI(int inHealth)
  {
    health = inHealth;
    
    for (int i = 0; i < health; i++)
    {
      hearts.add(new Heart());
    }
  }
  
  private ArrayList<Heart> hearts = new ArrayList<Heart>();
  
  private int health;
  
  // Executed every frame
  public void update()
  {
    // Update all hearts
    for (int i = 0; i < hearts.size(); i++)
    {
      hearts.get(i).update(i);
    }
  }
  
  // Damage the player (Remove health)
  public boolean damage(int damageAmount)
  {
    health -= damageAmount;
    
    // Remove health if it's still above 0 (to prevent nullptrs)
    if (health >= 0)
    {
      for (int i = 0; i < damageAmount; i++)
      {
        hearts.remove(hearts.size() - 1);
      }
    }

    return health <= 0;
  }
  
  // Add health to the player
  public void addHealth(int healthAmount)
  {
    health += healthAmount;
    
    // Add health
    for (int i = 0; i < healthAmount; i++)
    {
      hearts.add(new Heart());
    }
  }
}

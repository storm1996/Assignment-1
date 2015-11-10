ArrayList<Roster> wnbas = new ArrayList<Roster>();
void setup()
{
  size(500, 500);
  loadwnbas();
  drawwnbaBars();
}

void loadwnbas()
{
  String[] lines = loadStrings("wnba2014a.csv");    
  for(int i=0; i< lines.length; i++)
  {
     Roster wnba = new Roster(lines[i]);
     wnbas.add(wnba); 
  } 
    
}

void drawwnbaBars()
{
  float gap = (float) width / wnbas.size();
  float max = Float.MIN_VALUE;
  for (Roster wnba:wnbas)
  {
    if (wnba.total > max)
    {
      max = wnba.total;
    }
  }
  
  float scaleFactor = (float) height / max;  
  for (int i = 0 ; i < wnbas.size() ; i ++)
  {
    Roster wnba = wnbas.get(i);
    stroke(wnba.colour);
    fill(wnba.colour);
    float x = i * gap;
    rect(x, height, gap, - (wnba.total * scaleFactor));
  }
}

void draw()
{
}

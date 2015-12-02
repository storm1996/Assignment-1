import controlP5.*;

ControlP5 cp5;

int myGraph1 = 1;
int myGraph2 = 2;
int toggle = 0;

void setup()
{
 size(700, 700);
 loadData();
 calcMinMax();
 border = width * 0.1f;
 cp5 = new ControlP5(this);
 
   // create a new button with name 'buttonA'
  cp5.addButton("Points")
     .setValue(0)
     .setPosition(250, height -51)
     .setSize(70,50)
     ;
  
  // and add another 2 buttons
  cp5.addButton("Rebounds")
     .setValue(100)
     .setPosition(340, height -51)
     .setSize(100,50)
     ;
     
  PFont pfont = createFont("Arial",20,true); // use true/false for smooth/no-smooth
  ControlFont font = new ControlFont(pfont,241);
  
    cp5.getController("Points")
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(20)
     ;
     
     cp5.getController("Rebounds")
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(20)
     ;
}


ArrayList<Roster> wnbas = new ArrayList<Roster>();

float border;
float min, max;


void loadData()
{
  String[] lines = loadStrings("wnba2014a.csv");
  for(String line: lines)
  {
    Roster wnba = new Roster(line);
    wnbas.add(wnba);
  }
}


void calcMinMax()
{
  min = max = wnbas.get(0).points; 
  for (Roster wnba:wnbas)
  {
    if (wnba.points < min)
    {
      min = wnba.points;
    }
    if (wnba.points > max)
    {
      max = wnba.points;
    }    
  }
}


void drawLineGraph()
{
  stroke(255);
   textAlign(CENTER, CENTER);   
   float textY = (border * 0.5f); 
   text("Skylar Diggins Points Per Game", width * 0.5f, textY);
  
  stroke(255);  
 line(border, height - border, width - border, height - border);
 line(border, border , border, height - border);
  
  
  for (int i = 1 ; i < wnbas.size() ; i ++)
  {
    stroke(255, 20, 147);
    float x1 = map(i - 1, 0, wnbas.size() - 1, border, width - border);
    float y1 = map(wnbas.get(i - 1).points, min, max, height - border, border);
    float x2 = map(i, 0, wnbas.size() - 1, border, width - border);
    float y2 = map(wnbas.get(i).points, min, max, height - border, border);
    line(x1, y1, x2, y2);
    
    if (mouseX >= x1 && mouseX <= x2)
    {
     
      fill(255,69,0);
      stroke(0);
      strokeWeight(2);
      ellipseMode(CENTER);
      ellipse(x1, y1, 55, 55);
       
      //seams in basketball
      line(x1, y1-28, x1, y1+25);
      arc(x1-20, y1, 30, 42, -1.571, 1.571);
      arc(x1+20, y1, 30, 42, 1.785, 4.632);
      line(x1-25, y1, x1+25, y1);
      
      //ellipse(x1, y1, 25, 25);
      fill(255);
      textSize(15);
      text("Game: " + wnbas.get(i - 1).opponent, x1 + 10, y1 + 30);
      text("Points Scored: " + wnbas.get(i - 1).points, x1 + 10, y1 + 50);
    } 
    
  }  
}

void drawOtherGraph()
{
  
}
void draw()
{
  background(0);
  
  if ( toggle == 1)
  {
    drawLineGraph();
  }
  if ( toggle == 2)
  {
    drawOtherGraph();
  }
}

public void Points(int theValue) 
{
 toggle = 1; 
}

public void Rebounds(int theValue) 
{
 toggle = 2; 
}

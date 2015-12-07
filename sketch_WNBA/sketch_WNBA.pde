import controlP5.*;

ControlP5 cp5;

int myGraph1 = 1;
int myGraph2 = 2;
int myGraph3 = 3;
int toggle = 0;
float radius;
float min2;
float max2;
float temp;
float scale;

void setup()
{
 size(700, 700);
 loadData();
 calcMinMax();
 border = width * 0.1f;
 radius = width / 2; 
 assignColors();
 cp5 = new ControlP5(this);
 
   // create a new button with name 'buttonA'
  cp5.addButton("Points")
     .setValue(0)
     .setPosition(210, height -51)
     .setSize(70,50)
     ;
  
  // and add another 2 buttons
  cp5.addButton("Fouls")
     .setValue(100)
     .setPosition(300, height -51)
     .setSize(70,50)
     ;
     
     cp5.addButton("Rebounds")
     .setValue(100)
     .setPosition(390, height -51)
     .setSize(110,50)
     ;
     
  PFont pfont = createFont("Arial",20,true); // use true/false for smooth/no-smooth
  ControlFont font = new ControlFont(pfont,241);
  
    cp5.getController("Points")
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(20)
     ;
     
     cp5.getController("Fouls")
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
color[] colors = new color[34];
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
  
  
  for (int i = 1 ; i < wnbas.size(); i ++)
  {
    stroke(255, 20, 147);
    float x1 = map(i - 1, 0, wnbas.size() - 1, border, width - border);
    float y1 = map(wnbas.get(i - 1).points, min, max, height - border, border);
    float x2 = map(i, 0, wnbas.size() - 1, border, width - border);
    float y2 = map(wnbas.get(i).points, min, max, height - border, border);
    line(x1, y1, x2, y2);
    
    if (mouseX >= x1 && (mouseX <= x2 && mouseX <= width-(border+5)))
    {
     
      fill(255,69,0);
      stroke(0);
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
        if (mouseX >= width-(border+5) && mouseX <= width)
    {
       x1 = map(33, 0, wnbas.size()-1 , border, width - border);
     y1 = map(wnbas.get(33).points, min, max, height - border, border);
     
      fill(255,69,0);
      stroke(0);
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
      text("Game: " + wnbas.get(33).opponent, x1 + 10, y1 + 30);
      text("Points Scored: " + wnbas.get(33).points, x1 + 10, y1 + 50);
    } 
    
  }  
}

void assignColors()
{
  for(int i = 0 ; i < wnbas.size(); i++)
  {
    colors[i] = color(random(10, 255), 0, random(10, 255));
  }
}

void drawOtherGraph()
{
   stroke(255);
   fill(255);
   textAlign(CENTER, CENTER);   
   float textY = (border * 0.5f); 
   text("Skylar Diggins Fouls Per Game", width * 0.5f, textY);

  float sum = 0.0f;
  for (int i = 0 ; i < wnbas.size() ; i ++)
  {
    sum += wnbas.get(i).fouls;
  }
 
 // Calculate the angle to the mouse
  float toMouseX = mouseX - radius;
  float toMouseY = mouseY - radius;  
  float angle = atan2(toMouseY, toMouseX);  
  // We have to do this because 
  // atan2 returns negative angles if y > 0 
  // See https://processing.org/reference/atan2_.html
  if (angle < 0)
  {
    angle = map(angle, -PI, 0, PI, TWO_PI);
  }
  
  
  // The last angle
  float last = 0;
  // The cumulative sum of the dataset 
  float cumulative = 0;
  for(int i = 0 ; i < wnbas.size(); i ++)
  {
    stroke(0);
    cumulative += wnbas.get(i).fouls;
    // Calculate the surrent angle
    float current = map(cumulative, 0, sum, 0, TWO_PI);
    // Draw the pie segment
    
    
    float r = radius;
    // If the mouse angle is inside the pie segment
    // Mmmm pie. Im hungry
    if (angle > last && angle < current)
    {
      r = radius * 1.5f;
      fill(255);
      text("Game: " + wnbas.get(i ).opponent, width - 100, 30);
      text("Fouls: " + wnbas.get(i).fouls, width - 100, 50);
    }
    stroke(colors[i]);
    fill(colors[i]);
    // Draw the arc
    arc(
       radius
       ,radius
       ,r
       ,r
       , last
       , current
       );
    last = current;       
  }
  fill(255);
      textSize(15);

}

void drawBarChart()
{
  
     textAlign(CENTER, CENTER);   
   float textY = (border * 0.5f); 
   stroke(255);
   text("Skylar Diggins Rebounds for the Season", width * 0.5f, textY);
  
  stroke(255); 
  line(border, height - border, width - border, height - border);
  line(border, border , border, height - border);
  
  min2 = max2 = wnbas.get(0).totrb; 
  for (Roster wnba:wnbas)
  {
    if (wnba.totrb > max2)
    {
      max2 = wnba.totrb;
    }    
  float barWidth = (width -(border * 2))/wnbas.size();
  for (int i = 0; i < wnbas.size(); i ++)
  {
      
      float x = i * barWidth;
      float y = map(wnbas.get(i).totrb, 0, max2, border, height - (border* 2));
      stroke(colors[i]);
      fill(colors[i]);
      rect((float)x + border + 1, height - border - 1, (float)barWidth, -y);

    }
  }

   scale = max2/4;
  textAlign(RIGHT);
  
  for(int i=0; i<5; i++)
  {
    stroke(255);
    temp = map(i, 0, 4, height-border, border);
    line(border, temp, border-5, temp);
    text(floor(scale*i), border-3, temp-3);
  }
  
  scale = wnbas.size()/4.0;
  textAlign(CENTER);
  
  for(int i=0; i<5; i++)
  {
    stroke(255);
    temp = map(i, 0, 4, border, width-border);
    line(temp, height-border+5, temp, height-border);
    text(floor(scale*i), temp, (height+13) - border);
  }
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
    if ( toggle == 3)
  {
    drawBarChart();
  }
  
}

public void Points(int theValue) 
{
 toggle = 1; 
}

public void Fouls(int theValue) 
{
 toggle = 2; 
}
public void Rebounds(int theValue) 
{
 toggle = 3; 
}

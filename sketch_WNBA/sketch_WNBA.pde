import controlP5.*; // include the controlP5 library

ControlP5 cp5;
controlP5.Button D;
controlP5.Button D2;

int myGraph1 = 1; //used for switching between graphs 
int myGraph2 = 2;
int myGraph3 = 3;
int toggle = 0;
int data = 0;
float radius; //for pie chart 
float min2;
float max2;
float temp;
float scale;
boolean display = false;


void setup()
{
 size(700, 700);
 loadData(); //load stat sheet into processing 
 calcMinMax();
 border = width * 0.1f;
 radius = width / 2; 
 assignColors();
 cp5 = new ControlP5(this);
 
   // create a new button with name Points for the menu
  cp5.addButton("Points")
     .setValue(0)
     .setPosition(210, height -51)
     .setSize(70,50)
     ;
  
  // and add another Fouls button and Rebound button
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
     
     // these buttons only appear when the fouls graph is called 
    D = cp5.addButton("Data1")
     .setValue(0)
     .setPosition(width - (border*2), 100)
     .setSize(70,50)
     ;

     D2 = cp5.addButton("Data2")
     .setValue(0)
     .setPosition(width - (border*2), 150)
     .setSize(70,70)
     ;
     
  PFont pfont = createFont("Arial",20,true); // use true/false for smooth/no-smooth
  ControlFont font = new ControlFont(pfont,241); // nicer font
  
    cp5.getController("Points") //sets the parameters for the buttons 
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
     
     cp5.getController("Data1") //sets the parameters for the buttons 
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(20)
     ;
     
     cp5.getController("Data2") //sets the parameters for the buttons 
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(20)
     ;
}


ArrayList<Roster> wnbas = new ArrayList<Roster>(); //array list for reading in the data
color[] colors = new color[34];
float border;
float min, max;


void loadData()
{
  String[] lines = loadStrings("wnba2014a.csv");
  for(String line: lines) //convert .csv file to string 
  {
    Roster wnba = new Roster(line); //put into the class
    wnbas.add(wnba);
  }
}


void calcMinMax()
{
  min = max = wnbas.get(0).points; 
  for (Roster wnba:wnbas)
  {
    if (wnba.points < min) // min and max for line graph 
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
  display = false; // will stop data1 and data2 buttons from appearing
  stroke(255); //heading centered
   textAlign(CENTER, CENTER);   
   float textY = (border * 0.5f); 
   text("Skylar Diggins Points Per Game", width * 0.5f, textY);
  
  stroke(255);  // draw basic border no ticks on the side needed 
 line(border, height - border, width - border, height - border);
 line(border, border , border, height - border);
  
  
  for (int i = 1 ; i < wnbas.size(); i ++) // map the line grpah into the border space drawn 
  {
    stroke(255, 20, 147);
    float x1 = map(i - 1, 0, wnbas.size() - 1, border, width - border);
    float y1 = map(wnbas.get(i - 1).points, min, max, height - border, border);
    float x2 = map(i, 0, wnbas.size() - 1, border, width - border);
    float y2 = map(wnbas.get(i).points, min, max, height - border, border);
    line(x1, y1, x2, y2);
    
    if (mouseX >= x1 && (mouseX <= x2 && mouseX <= width-(border+5))) //if mouse is on a certain point that'snot the last point 
    {
     // draw circle for basketball
      fill(255,69,0);
      stroke(0);
      ellipseMode(CENTER);
      ellipse(x1, y1, 55, 55);
       
      //seams in basketball
      line(x1, y1-28, x1, y1+25);
      arc(x1-20, y1, 30, 42, -1.571, 1.571);
      arc(x1+20, y1, 30, 42, 1.785, 4.632);
      line(x1-25, y1, x1+25, y1);
      
      //display the game info too 
      fill(255);
      textSize(15);
      text("Game: " + wnbas.get(i - 1).opponent, x1 + 10, y1 + 30);
      text("Points Scored: " + wnbas.get(i - 1).points, x1 + 10, y1 + 50);
    } 
        if (mouseX >= width-(border+5) && mouseX <= width) // if mouse at last position 
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
      
      fill(255);
      textSize(15);
      text("Game: " + wnbas.get(33).opponent, x1 + 10, y1 + 30);
      text("Points Scored: " + wnbas.get(33).points, x1 + 10, y1 + 50);
    } 
    
  }  
}

void assignColors() // random colour selection
{
  for(int i = 0 ; i < wnbas.size(); i++)
  {
    colors[i] = color(random(10, 255), 0, random(10, 255));
  }
}

void drawOtherGraph() //piechart
{
   display = true; // buttons appear 
   stroke(255); //heading
   fill(255);
   textAlign(CENTER, CENTER);   
   float textY = (border * 0.5f); 
   text("Skylar Diggins Fouls Per Game", width * 0.5f, textY);

  float sum = 0.0f; // find total value of fouls 
  for (int i = 0 ; i < wnbas.size() ; i ++)
  {
    sum += wnbas.get(i).fouls;
  }
 
 // Calculate the angle to the mouse
  float toMouseX = mouseX - radius;
  float toMouseY = mouseY - radius;  
  float angle = atan2(toMouseY, toMouseX);  // atan2 is handy for finding angle from mouse
  
  
  // We have to do this because 
  // atan2 returns negative angles if y > 0 
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
    // Calculate the current angle
    float current = map(cumulative, 0, sum, 0, TWO_PI);
    
    
    // Draw the pie segment
    float r = radius;
    if (angle > last && angle < current) // mouse on certain segment
    {
      r = radius * 1.5f; //increase the size of the segment
     if( data == 1) // switches between different outputs for piechart
     {
      fill(255);
      text("Game Opponent: " + wnbas.get(i ).opponent, width - 100, 30);
      text("Fouls: " + wnbas.get(i).fouls, width - 100, 50);
     }
   else
     {
       fill(255);
      text("Fouls: " + wnbas.get(i).fouls, width - 100, 50);
        if ( wnbas.get(i).win == 1)
        {
          text("Win ", width - 100, 30);
        }
        else
        {
          text("Lose ", width - 100, 30);
        }
     }
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
  display = false;
  textAlign(CENTER, CENTER);   
  float textY = (border * 0.5f); 
  stroke(255);
  fill(255);
  text("Skylar Diggins Rebounds for the Season", width * 0.5f, textY);
  
  stroke(255); 
  line(border, height - border, width - border, height - border);
  line(border, border , border, height - border);
  
  max2 = wnbas.get(0).totrb; 
  for (Roster wnba:wnbas)
  {
    if (wnba.totrb > max2)
    {
      max2 = wnba.totrb;
    }  
    
  float barWidth = (width -(border * 2))/wnbas.size(); // how thick the bars are 
  for (int i = 0; i < wnbas.size(); i ++)
  {
      
      float x = i * barWidth; // mapping bars 
      float y = map(wnbas.get(i).totrb, 0, max2, 0, height-(border*2));
      stroke(colors[i]);
      fill(colors[i]);
      rect((float)x + border+1, height - border -1, (float)barWidth, -y);
    }
  }

  scale = max2/4; // drawing ticks on side 
  textAlign(RIGHT);
  
  for(int i=0; i<5; i++)
  {
    stroke(255);
  fill(255);
    temp = map(i, 0, 4, height-border, border);
    line(border, temp, border-5, temp);
    text(floor(scale*i), border-3, temp-3);
  }
  
  scale = wnbas.size()/4.0;
  textAlign(CENTER);
  
  for(int i=0; i<5; i++)
  {
    stroke(255);
  fill(255);
    temp = map(i, 0, 4, border, width-border);
    line(temp, height-border+5, temp, height-border);
    text(floor(scale*i), temp, (height+13) - border);
  }
}

void draw()
{
  background(0);
  hideButton(); // function for displaying buttons 
  
  if ( toggle == 1) // toggle between the menu settings 
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
 toggle = 1; // sets toggle value 
}

public void Fouls(int theValue) 
{
 toggle = 2; 
}
public void Rebounds(int theValue) 
{
 toggle = 3; 
}

public void Data1(int theValue) 
{
 data = 1; 
}

public void Data2(int theValue) 
{
 data = 2; 
}

void hideButton()
{
  if (display == false) {
    D.hide();
  }
  else {
    D.show();
  }
  if (display == false) {
    D2.hide();
  }
  else {
    D2.show();
  }
}

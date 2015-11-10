class Roster
{
  String Player; 
  float player_id;
  String team;
  float date;
  float home;
  String opponent;
  float win;
  float team_pts;
  float opp_pts;
  float minutes;
  float fgmade;
  float fgatt;
  float made3;
  float att3;
  float made1;
  float att1;
  float offrb;
  float defrb;
  float totrb;
  float assist;
  float steal;
  float block;
  float turnover;
  float fouls;
  float points;
  float efficiency;
  float total;
  color colour;
  
   
  Roster(String line)
  {
    String[] elements = line.split(",");
    Player = elements[0];
    player_id = Float.parseFloat(elements[1]);
    team = elements[2];
    date = Float.parseFloat(elements[3]);    
    home = Float.parseFloat(elements[4]);  
    opponent = elements[5];
    win = Float.parseFloat(elements[6]); 
    team_pts = Float.parseFloat(elements[7]); 
    opp_pts = Float.parseFloat(elements[8]);
    minutes = Float.parseFloat(elements[9]); 
    fgmade = Float.parseFloat(elements[10]);
    fgatt = Float.parseFloat(elements[11]);
    made3 = Float.parseFloat(elements[12]);
    att3 = Float.parseFloat(elements[13]);
    made1 = Float.parseFloat(elements[14]);
    att1 = Float.parseFloat(elements[15]);
    offrb = Float.parseFloat(elements[16]);
    defrb = Float.parseFloat(elements[17]);
    totrb = Float.parseFloat(elements[18]);
    assist = Float.parseFloat(elements[19]);
    steal = Float.parseFloat(elements[20]);
    block = Float.parseFloat(elements[21]);
    turnover = Float.parseFloat(elements[22]);
    fouls = Float.parseFloat(elements[23]);
    points = Float.parseFloat(elements[24]);
    efficiency = Float.parseFloat(elements[25]);
    total = fgmade + made3 + made1;
    colour = color(random(0, 255), random(0, 255), random(0, 255));
  } 
  
}

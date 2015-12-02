class Roster
{
  String Player; //a
  float player_id; //b
  String team; //c
  float date; //d
  float home; //e
  String opponent;  //f
  float win; //g
  float team_pts; //h
  float opp_pts; //i
  float minutes; //j
  float fgmade; //k
  float fgatt; //l
  float made3; //m
  float att3; //n
  float made1; //o
  float att1; //p
  float offrb; //q
  float defrb; //r
  float totrb; //s
  float assist; //t
  float steal; //u
  float block; //v
  float turnover; //w
  float fouls; //x
  float points; //y
  float efficiency; //z


  
   
  Roster(String lines)
  {
    String[] elements = lines.split(","); 
    home = Float.parseFloat(elements[0]);  
    opponent = elements[1];
    win = Float.parseFloat(elements[2]); 
    team_pts = Float.parseFloat(elements[3]); 
    opp_pts = Float.parseFloat(elements[4]);
    minutes = Float.parseFloat(elements[5]); 
    fgmade = Float.parseFloat(elements[6]);
    fgatt = Float.parseFloat(elements[7]);
    made3 = Float.parseFloat(elements[8]);
    att3 = Float.parseFloat(elements[9]);
    made1 = Float.parseFloat(elements[10]);
    att1 = Float.parseFloat(elements[11]);
    offrb = Float.parseFloat(elements[12]);
    defrb = Float.parseFloat(elements[13]);
    totrb = Float.parseFloat(elements[14]);
    assist = Float.parseFloat(elements[15]);
    steal = Float.parseFloat(elements[16]);
    block = Float.parseFloat(elements[17]);
    turnover = Float.parseFloat(elements[18]);
    fouls = Float.parseFloat(elements[19]);
    points = Float.parseFloat(elements[20]);
    efficiency = Float.parseFloat(elements[21]);
    
    } 
  
}

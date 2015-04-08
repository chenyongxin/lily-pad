/*********************************

This class creats a circle array of cylinders.
This is special for bundle case.

The input arguments are center coordinates X, Y; diameter of each cylinder D; Radius of circle array; division n; window.




**********************************/

class CircleArray extends Body{
  ArrayList<CircleBody> circleList = new ArrayList<CircleBody>();          //This is a container for all bodies
  
  float X, Y;                                                              //X, Y represent a temporal coordinate of a new body
  
  
  CircleArray(float x, float y, float d, float R, int n, float rad, Window window){
    super(x, y, window);
    for ( int i = 1; i <= n; i++ ){
      
      //Define each body's center coordinate.
      X = x+R*cos(TWO_PI/n*i+rad);
      Y = y+R*sin(TWO_PI/n*i+rad);
      
      circleList.add(new CircleBody(X, Y, d, window));
    }
  }
  
  void display(color C, Window window ){
    for ( CircleBody circle : circleList ){
        circle.display(C, window);
    }
    
  }
  
  float distance(float x, float y){
    float d = 0;
    float dmin = 1E5;
    for ( CircleBody circle : circleList ){
        d = circle.distance(x, y);
        dmin = min(d, dmin);
    }
    return dmin;
  }
  
  
  
  
   int distance( int px, int py){     // in pixels
    int d = 0;
    int dmin = (int)1e3;
    for ( CircleBody circle : circleList ){
        d = circle.distance(px, py);
        dmin = min(d, dmin);
    }
    return dmin;
    }
  
  Body closest (float x, float y){  
      float dmin = 1e5;
      Body body = circleList.get(0);
      //CircleBody b;
      for (CircleBody circle: circleList){
          if(circle.distance(x, y) < dmin){
            dmin = circle.distance(x, y);
            body = circle;
          }
      }
      return body;
  }
  
  
   PVector WallNormal(float x, float y){
     Body c = closest(x,y);
     return c.WallNormal(x,y); 
  }
  
    float velocity( int d, float dt, float x, float y ){
    Body c = closest(x,y);
    return c.velocity(d,dt,x,y);
    }
  
  
  
}






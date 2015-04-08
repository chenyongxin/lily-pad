/*********************************************************
                  Main Window! 

Click the "Run" button to Run the simulation.

Change the geometry, flow conditions, numercial parameters
 visualizations and measurments from this window. 

*********************************************************/
BDIM flow;
CircleArrangement body;
FloodPlot flood;

void setup(){
  int n=(int)pow(2,8)+2; // number of grid points
  size(800,800);         // display window size
  Window view = new Window(n,n);
  
  float R = n/5;      //Bundle radius
  int d = 5;          //division
  float x = n/2, y = n/2;
  float aoa = PI/2;   //aoa is Angle of Attack
   
//   body = new CircleArray(x, y, n/10, 1.5*R, d+3, aoa, view);
  body = new CircleArrangement(x, y, n/30, R*2, 133, aoa, view);
  
//  flow = new BDIM(n,n,1.5,body);           // solve for flow using BDIM
  flow = new BDIM(n,n,0,body,0.01,true);   // QUICK with adaptive dt
  flood = new FloodPlot(view);
  flood.range = new Scale(-.75,.75);
  flood.setLegend("vorticity");
}
void draw(){
  body.update();
  flow.update(body);
  flow.update2();
  flood.display(flow.u.vorticity());
  body.display();
}
void mousePressed(){body.mousePressed();}
void mouseReleased(){body.mouseReleased();}


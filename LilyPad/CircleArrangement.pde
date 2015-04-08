class CircleArrangement extends Body {
  ArrayList<CircleArray> circleArr = new ArrayList<CircleArray>();

  // constructor, ro is density, n is division for the very out layer
  // delete density ro, and use number of cylinders to control.
  
  CircleArrangement(float x, float y, float d, float R, int n, //float ro,
      float rad, Window window) {
    super(x, y, window);

    // define different layer
    // when define each layer depending on density ro, the inner circle
    // should be considered in case of conflict

    //float r; // r is interval of radial direction
//    r = ro * R;
    int N; // N is number of circles in radial direction without central
        // circle
//    N = (int)(1/ro);
//    define N
    if (n<6){
      N = 1;
    } else if (n<20){
      N = 2;
    } else if (n<40){
      N = 3;
    } else if (n<65){
      N = 4;
    } else if (n<96) {
      N = 5;
    } else{
      N = 6;
    }
      
    
    
//    int div = n; // div is division number of each layer

//    for (int i = 0; i < N; i++) {
//      if (TWO_PI * (R - r * i) / n > d) {
//       
//        circleArr.add(new CircleArray(x, y, d, R - i * r, div, rad, window));
//      } else {
//        div = div - 1;
//        while (TWO_PI * (R - r * i) / div < d) {
//          div = div - 1;
//        }
//        circleArr.add(new CircleArray(x, y, d, R - i * r, div, rad, window));
//      }
//
//    }


    //
//  new a arraylist to restore the number of maximum cylinders on each ring.
    int[] ring = new int[7];
    ring[1] = 6;
    ring[2] = 13;
    ring[3] = 20;
    ring[4] = 25;
    ring[5] = 31;
    
    if (N==1){
      circleArr.add(new CircleArray(x, y, d, R, n-1, rad, window));
      circleArr.add(new CircleArray(x, y, d, 0, 1, rad, window));
    } else{
    int temp;
    temp = n-1;
    for (int i=1; i<N; i++){ //loop in the different ring; i is current ring.
      circleArr.add(new CircleArray(x, y, d, R/N*i, ring[i], rad, window));
//      calculate the number on the outer ring.
      temp = temp - ring[i];
      }
      circleArr.add(new CircleArray(x, y, d, R, temp, rad, window));
      circleArr.add(new CircleArray(x, y, d, 0, 1, rad, window));
    }

//    if (1 / ro - N > 0) {
//      // new a circle in the center
//      CircleBody c = new CircleBody(x, y, d, window);
//    }
  }

  float distance(float x, float y) {
    float d = 0;
    float dmin = 1E5;
    for (CircleArray array : circleArr) {
      d = array.distance(x, y);
      dmin = min(d, dmin);
    }
    return dmin;
  }

  void display(color C, Window window ){
    for ( CircleArray circle : circleArr ){
        circle.display(C, window);
    }
    
  }
  int distance(int px, int py) { // in pixels
    int d = 0;
    int dmin = (int) 1e3;
    for (CircleArray array : circleArr) {
      d = array.distance(px, py);
      dmin = min(d, dmin);
    }
    return dmin;
  }

  Body closest(float x, float y) {
    float dmin = 1e5;
    CircleArray body = circleArr.get(0);
    // CircleBody b;
    for (CircleArray array : circleArr) {
      if (array.distance(x, y) < dmin) {
        dmin = array.distance(x, y);
        body = array;
      }
    }
    return body.closest(x, y);
  }

  PVector WallNormal(float x, float y) {
    Body c = closest(x, y);
    return c.WallNormal(x, y);
  }

  float velocity(int d, float dt, float x, float y) {
    Body c = closest(x, y);
    return c.velocity(d, dt, x, y);
  }

}

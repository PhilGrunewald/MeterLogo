// 19 Jul 15 - created by Phil Grunewald
// A short and simple simulation of a clock that mutates into a power switch symbol
// intended for use as an animated logo

float time=  -PI;  // 12 o'clock
int step = 0;

PShape hand,ring,start,stop;
int hand_y = 0;
int start_y = 0;

void setup()
{
  size( 510, 608, P2D);
  time = - PI;
  frameRate(20);
  smooth();
  start = loadShape("button_start.svg");
  stop = loadShape("button_stop.svg");
  ring = loadShape("ring.svg");
  hand = loadShape("hand.svg");
}

void drawClock() {
  // minute

  if (time < PI) {
 	 time+= PI/30;
	  start_y = 20;
	} else {
	  time = PI;
	  hand_y = 55;
	  start_y = 0;
	  ring = loadShape("ring_down.svg");
	  hand = loadShape("hand_down.svg");
	}
  if (step < 10) {
    start_y = step;
    time = -PI;
  } 
  if (step > 71) {
	  ring = loadShape("ring.svg");
	  hand = loadShape("hand.svg");
  }

  pushMatrix();
    translate(width/2,height/2);
    rotate(time);
    shape(hand, 0, hand_y);
  popMatrix();
}

void draw()
{
if (keyPressed == true) {
	time = -PI;
    step =0;
    hand_y = 0;
    start_y = 0;
	ring = loadShape("ring.svg");
	hand = loadShape("hand.svg");
  }
  step +=1;
  background(255);

  drawClock();
  shape(ring,0,0);
  shape(start,0,start_y);
  shape(stop,0,0);
}

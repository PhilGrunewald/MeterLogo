// 19 Jul 15 - created by Phil Grunewald
// A short and simple simulation of a clock that mutates into a power switch symbol
// intended for use as an animated logo
int tx,ty,tz = 0;
int phase = 0;  // cycles from 0 = button to 1 = hour to 2 = power button
int buttonHeight =140;

float hour_angle=0;  // 12 o'clock
float minute_angle=-PI;  // 12 o'clock
float    h_start = 20;
float    h_end   = 200;
float    h_width = 10;

PShape hand,crown;

void setTime(int hour, int minute) {
  //hour_angle = (TWO_PI/12) * hour + (TWO_PI/12/60) * minute - PI;
  //minute_angle = (TWO_PI/60) * minute - PI;
  hour_angle = (TWO_PI/12) * hour + (TWO_PI/12/60) * minute -PI/2;
  minute_angle = (TWO_PI/60) * minute -PI/2;
}

float getHour() {
  return (hour_angle +PI/2) / (TWO_PI/12) ;
}

void setup()
{
  size( 600, 600, P2D);
  frameRate(35);
  smooth();
  setTime(0,0);

  crown = createShape();
  crown.beginShape();
  crown.vertex(-10,  0);
  crown.vertex( 10,  0);
  crown.vertex( 10,  15);
  crown.vertex( 15,  15);
  crown.vertex( 15, 50);
  crown.vertex(-15, 50);
  crown.vertex(-15,  15);
  crown.vertex(-10,  15);
  crown.endShape(CLOSE);
  hand = createShape();
  hand.beginShape();
  noFill();
  hand.vertex(0,0);
  hand.bezierVertex( 20,  0,  100, 25,  100, 25);
  hand.bezierVertex(100, 25,  400,  0,  400,  0);
  hand.bezierVertex(400,  0,  100,-25,  100,-25);
  hand.bezierVertex(100,-25,   20,  0,    0,  0);
  hand.endShape(CLOSE);
}

void pushButton() 
{
  if (buttonHeight < 145) {
     buttonHeight += 1;
    }
  else {
     phase = 1;
    }
}
void advanceTime()
{
  if (getHour() < 0.99) {
     hour_angle+=TWO_PI/60/12;
     minute_angle+=TWO_PI/60;
  } else {
  phase = 2;
  }
}

void HourToPower() {
if (h_width < 25) {
    h_start += 5;
    h_end   += 0.2;
    h_width += 1;
  }
}

void keyPressed() {
  if (keyCode == UP) { tx += 1000;}
}

void drawTicks() {
  for (float i=0; i< TWO_PI; i+=TWO_PI/60) {
  pushMatrix();
    translate(width/2,height/2);
    rotate(i);
    strokeWeight(1);
    line(0,0.95*width/4,0,width/4);
  popMatrix();
  }
  for (float i=0; i< TWO_PI; i+=TWO_PI/12) {
  pushMatrix();
    translate(width/2,height/2);
    rotate(i);
    strokeWeight(3);
    line(0,0.85*width/4,0,width/4);
  popMatrix();
  }
}

void drawClock() {
  // Hour
  pushMatrix();
    translate(width/2,height/2);
    rotate(hour_angle);
    strokeWeight(15);
    //shape(hand, 0, 0, 100, 25);
    //line(0,15,0,0.5*h_end);
  popMatrix();
  // minute
  pushMatrix();
    translate(width/2,height/2);
    rotate(minute_angle);
    strokeWeight(h_width);
    shape(hand, 0, 0, 130, 25);
    // line(0,h_start,0,h_end);
  popMatrix();
}

void draw()
{
  background(180);
  stroke(0);
  noFill();
  if (phase == 0) {
    pushButton();
  } else 
  if (phase ==1) {
    advanceTime();
  } else
  if (phase == 2) {
    HourToPower();
  }
  shape(crown, width/2, buttonHeight, 50, -50);
  strokeWeight(h_width);
  arc(width/2,height/2,width/2,height/2,-HALF_PI+(PI/12),1.5*PI-(PI/12));
  drawClock();
  drawTicks();
}

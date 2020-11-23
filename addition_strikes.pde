int spacing;
int squareSize;
int initX;
int initY;
int sum;
int addend1;
int addend2;
int[] xStarters = new int[10];
int[] yStarters = new int[10];
int[] xEnders = new int[11];
int[] yEnders = new int[11];
int[] clicked = new int[0];
int correct;

PFont f;

void setup() {
  fullScreen();
  correct=0;
  spacing = width/40;
  squareSize=spacing*3;
  initX=spacing/2;
  initY=spacing/2;
  sum=int(random(100,999));
  addend1=int(random(0,sum));
  addend2=sum-addend1;
  f = createFont("Arial Bold",squareSize,true);
  for (int i=0;i<10;i++) {
    xStarters[i] = initX+squareSize/2+(spacing+squareSize)*(i);
    yStarters[i] = initY+4*squareSize/5+height/4;
  }
  for (int i=0;i<11;i++) {
    xEnders[i] = width*7*(i+1+i/3)/480+squareSize*(i+i/3)+squareSize/2;
    yEnders[i] = height/2+squareSize/3+height/8;
  }
  textFont(f);
  textAlign(CENTER);
    fill(0); 
}

void draw() {
  background(240);
  endRectangles();
  fill(0);
    for(int j = 0;j<=9; j++) {
      text(j,xStarters[j],yStarters[j]);
     }
  text("+", width*7*(4)/480+squareSize*(3)+squareSize/2,height/2+squareSize/3+height/8);
  text("=", width*7*(8)/480+squareSize*(7)+squareSize/2,height/2+squareSize/3+height/8);
  for(int i = 0; i<clicked.length; i++){
    for(int j = 0; j<xDestinations(clicked[i]).length;j++){
      
      fill(0);
      text(digits()[xDestinations(clicked[i])[j]],xEnders[xDestinations(clicked[i])[j]],yEnders[xDestinations(clicked[i])[j]]);
    }
    if(xDestinations(clicked[i]).length==0){
      fill(255,10,10);
    } else {
      fill(46,229,19);
    }
    text(clicked[i],xStarters[clicked[i]],yStarters[clicked[i]]);
    if(correct==9){
      drawReset();
    }
  }
}

void mousePressed(){
  if(correct==9&&mouseX>width/2-3*squareSize/2&&mouseX<width/2+3*squareSize/2&&mouseY>4*height/5&&mouseY<4*height/5+squareSize){
    clicked=new int[]{};
    setup();
  }
  int thisSquare = whichSquare();
  
  if(newClick(thisSquare,clicked)&&thisSquare>=0){
    clicked = append(clicked, thisSquare);    
  }
  correct = 0;
  for(int i = 0; i<clicked.length;i++){
    correct+=xDestinations(clicked[i]).length;
  }
}

void endRectangles(){
  fill(190);
  noStroke();
  for (int i = 0; i<=8;i++) {
    rect(width*7*(i+1+i/3)/480+squareSize*(i+i/3),height/2-squareSize/2+height/8,squareSize, squareSize);
  }
}

int[] digits(){
  int[] dig = new int[9];
  dig[0]=addend1/100;
  dig[1]=(addend1%100)/10;
  dig[2]=addend1%10;
  dig[3]=addend2/100;
  dig[4]=(addend2%100)/10;
  dig[5]=addend2%10;
  dig[6]=sum/100;
  dig[7]=(sum%100)/10;
  dig[8]=sum%10;
  return dig;
}

int whichSquare(){
  if (mouseY>=initY+height/4 && mouseY<=initY+squareSize+height/4) {
    int leftSide = (mouseX-initX)/(squareSize+spacing);
    int rightSide = (mouseX -initX+spacing)/(squareSize+spacing);
    if (leftSide==rightSide){
      return leftSide;
    } else { 
      return -1;
    }
  } else {
    return -1;
  }
}

int[] xDestinations(int which) {
  int[] destinations = {};
  int place = 0;
  for(int i=0;i<9;i++){
    if(digits()[i]==which){
      destinations = append(destinations, i);
      place++;
    }    
  }
  return destinations;
}

boolean newClick(int which,int[] array){
  boolean trueOrFalse = true;
  for(int i = 0; i<array.length; i++){
    if(array[i]==which){
      trueOrFalse = false;
    }
  }
  return trueOrFalse;
}

void drawReset(){
  fill(0);
  rect(width/2-3*squareSize/2,4*height/5,3*squareSize,squareSize);
  fill(190);
  text("Reset",width/2,4*height/5+5*squareSize/6);
}    

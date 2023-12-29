import java.util.*;
void setup(){
  size(800,800);
  noStroke();
  frameRate(1000);
  once();
}
boolean getColor(int x,int y){
  color c = color(get(x,y));
  var r = true;
  if(red(c)>128)
    r=false;
  fill(r?0:255,r?255:0,0);
  rect(x-1,y-1,3,3);
  return r;
}
int f=526;
void once(){
  PrintWriter output = createWriter("bad_appleds.txt"); 
  fill(255,0,0);
  f++;
  String frameString = Integer.toString(f);
    var len = 5-frameString.length();
    frameString = "0".repeat(len)+f;
        println(frameString);
    PImage frame = loadImage("frames/frame"+frameString+".jpg");
    image(frame,0,0);
    boolean[][] frameData = new boolean[100][100];
    int is=8,js=22;
    for(int i=0;i<60;i+=1){
      for(int j=0;j<16;j+=1)
      {
        var c = getColor(i*is,j*js);
        frameData[i][j]=c;
      }
    }
  for(int j=0;j<16;j+=4){
        String line="";
      for(int i=0;i<60;i+=2)
      {
        int symbol=0;
        symbol = setBit(symbol,frameData[i][j],0);
        symbol = setBit(symbol,frameData[i+1][j],1);
        symbol = setBit(symbol,frameData[i+2][j],2);
        
        symbol = setBit(symbol,frameData[i][j+1],3);
        symbol = setBit(symbol,frameData[i+1][j+1],4);
        symbol = setBit(symbol,frameData[i+2][j+1],5);
        
        symbol = setBit(symbol,frameData[i+3][j],6);
        symbol = setBit(symbol,frameData[i+3][j+1],7);
        int begin = 0x2800;
        line += (char)(((begin+(int)symbol)));
      }
      println(line);
      output.println(line);
    }
    output.flush();
    output.close();
//f=10000;   
}
short setBit(short value,boolean b,int bit){
    if(b) return value |= 1 << bit;
    else return value &= ~(1 << bit);
}

import java.io.PrintWriter;

void setup() {
  size(500, 500);
  noStroke();
  frameRate(1000);
  initialize();
}

boolean getColor(int x, int y) {
  color c = color(get(x, y));
  boolean r = red(c) <= 128;
  fill(r ? 0 : 255, r ? 255 : 0, 0);
  rect(x - 1, y - 1, 3, 3);
  return r;
}

int f = 0;
PrintWriter output = createWriter("bad_apple.txt");

void draw() {
  initialize();
}

void initialize() {
  fill(255, 0, 0);
  if (f == 500) {
    
    exit();
    return;
  }
  
  f++;
  String frameString = String.format("%05d", f);
  println(frameString);
  
  PImage frame = loadImage("frames/frame" + frameString + ".jpg");
  if (frame == null) return;
  
  image(frame, 0, 0);
  
  int is = 8, js = 22;
  
  boolean[][] frameData = new boolean[16][60]; // Fix the array dimensions

  for (int i = 0; i < 60; i += 1) {
    for (int j = 0; j < 16; j += 1) {
      var c = getColor(i * is, j * js);
      frameData[j][i] = c;
    }
  }

  for (int j = 0; j < 16; j += 4) {
    StringBuilder line = new StringBuilder();
    for (int i = 0; i < 60; i += 2) {
      int symbol = 0;
      symbol = setBit(symbol, frameData[j    ][i    ], 0);
      symbol = setBit(symbol, frameData[j + 1][i    ], 1);
      symbol = setBit(symbol, frameData[j + 2][i    ], 2);
      symbol = setBit(symbol, frameData[j + 3][i    ], 6);
      
      symbol = setBit(symbol, frameData[j    ][i + 1], 3);
      symbol = setBit(symbol, frameData[j + 1][i + 1], 4);
      symbol = setBit(symbol, frameData[j + 2][i + 1], 5);
      symbol = setBit(symbol, frameData[j + 3][i + 1], 7);
      
      int begin = 0x2800;
      line.append((char) (begin + symbol));
    }
    println(line);
    output.println(line);
  }
}

short setBit(int value, boolean setBit, int bitPosition) {
        if (setBit) {
            // Set the bit to 1
            value |= (1 << bitPosition);
        } else {
            // Clear the bit to 0
            value &= ~(1 << bitPosition);
        }
        return (short) value;
    }

int pixelSize, widthPixels, heightPixels, xCenter, yCenter, radius;
PShape[] bigPixels;

void setup(){
  size(800, 600);
  pixelSize = 25;
  if (width % pixelSize != 0 || height % pixelSize != 0) error();
  xCenter = width / 2;
  yCenter = height / 2;
  radius = 240;
  widthPixels = width / pixelSize;
  heightPixels = height / pixelSize;
  bigPixels = new PShape[widthPixels * heightPixels];
  createPixels();
  bresenham();
}

void paintPurePixels(int x, int y, int xOffset, int yOffset){
  bigPixels[(x+xOffset)*heightPixels + y + yOffset].setFill(128);
  bigPixels[(x+xOffset)*heightPixels - y - 1 + yOffset].setFill(128);
  bigPixels[(-x+xOffset-1)*heightPixels + y + yOffset].setFill(128);
  bigPixels[(-x+xOffset-1)*heightPixels - y - 1 + yOffset].setFill(128);
  bigPixels[(y+xOffset)*heightPixels + x + yOffset].setFill(128);
  bigPixels[(y+xOffset)*heightPixels - x - 1 + yOffset].setFill(128);
  bigPixels[(-y+xOffset-1)*heightPixels + x + yOffset].setFill(128);
  bigPixels[(-y+xOffset-1)*heightPixels - x - 1 + yOffset].setFill(128);
}

void bresenham(){
  double x = radius / (double) pixelSize;
  int xOffset = (xCenter + radius) / pixelSize,yOffset = yCenter / pixelSize, y = 0;  
  xOffset = xOffset - (int)x;
  while (x >= y){
    paintPurePixels((int) x, y, xOffset, yOffset);
    println(x, y);
    x = Math.sqrt(x*x - 2*y - 1);
    y += 1; 
  }
}

void error(){
  println("Pixel size must be divisible by both width and height.");
  System.exit(1);
}

void createPixels(){
  for (int i = 0; i < widthPixels; i++){
    for (int j = 0; j < heightPixels; j++){
      bigPixels[i*heightPixels + j] = createShape(RECT, i*pixelSize, j*pixelSize, pixelSize, pixelSize);  
    }
  }
}

void showPixels(){
  for (PShape pShape: bigPixels) {
    shape(pShape);
  }
}

/*void paintPixel(int x, int y){
  int pixelPosition = (int)(x / pixelSize) * heightPixels + (int)(y / pixelSize);
  bigPixels[pixelPosition].setFill(128);
}

void mouseClicked(){
  paintPixel(mouseX, mouseY);
}*/

void draw(){
  showPixels();
  noFill();
  circle(xCenter, yCenter, radius*2);
}

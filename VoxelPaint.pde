int sW = 64;
int sH = 64;
int sD = 64;
int scaleFactor=10;
PVector offsetOrig = new PVector(0, 0, -1 * 20 * scaleFactor);
PVector offset = offsetOrig;
PVector loc = new PVector(0, 0, 0);
float offsetDelta = 10;
float drawOdds = 0.001;
boolean triggered=false;

Voxel[][][] voxel = new Voxel[sW][sH][sD];

void setup() {
  size(sW*scaleFactor, sH*scaleFactor, OPENGL);
  initVolume();
  noCursor();
}

void draw() {
  controls();
  background(0);
  for (int i=0;i<voxel.length;i++) {
    for (int j=0;j<voxel[i].length;j++) {
      for (int k=0;k<voxel[i][j].length;k++) {
        voxel[i][j][k].selectMe=false;
        voxel[int(loc.x)][int(loc.y)][int(loc.z)].selectMe=true;
        voxel[i][j][k].update();
      }
    }
  }
}

void posCheck(){
    if(loc.z>sD-1) loc.z=sD-1;
    if(loc.z<0) loc.z=0;
    if(loc.x>sW-1) loc.x=sW-1;
    if(loc.x<0) loc.x=0;
    if(loc.y>sH-1) loc.y=sH-1;
    if(loc.y<0) loc.y=0;
}


void controls() {
  if (keyPressed) {
    if (key=='w'||key=='W') offset.z += offsetDelta;
    if (key=='s'||key=='S') offset.z -= offsetDelta;
    if (key=='a'||key=='A') offset.x += offsetDelta;
    if (key=='d'||key=='D') offset.x -= offsetDelta;
    if (key=='e'||key=='E') offset.y += offsetDelta;
    if (key=='q'||key=='Q') offset.y -= offsetDelta;
  }
  if(mouseX!=pmouseX||mouseY!=pmouseY){
  triggered=false;
  loc.x=int(mouseX/scaleFactor);
  loc.y=int(mouseY/scaleFactor);
  posCheck();
  }
  if(mousePressed&!triggered){
    loc.x=int(mouseX/scaleFactor);
    loc.y=int(mouseY/scaleFactor);
    posCheck();
    if(!voxel[int(loc.x)][int(loc.y)][int(loc.z)].drawMe){
      voxel[int(loc.x)][int(loc.y)][int(loc.z)].drawMe=true;
    }
    triggered=true;  
  }
}

void keyPressed(){
    if(key=='n'||key=='N') initVolume();
    if(key==' '){
      voxel[int(loc.x)][int(loc.y)][int(loc.z)].drawMe=!voxel[int(loc.x)][int(loc.y)][int(loc.z)].drawMe;
    }
    if (keyCode==34) {
      loc.z ++;
      if(loc.z>sD-1) loc.z=sD-1;
    }
    if (keyCode==33) {
      loc.z --;
      if(loc.z<0) loc.z=0;
    }
    if (keyCode==RIGHT) {
      loc.x ++;
      if(loc.x>sW-1) loc.x=sW-1;
    }
    if (keyCode==LEFT) {
      loc.x --;
      if(loc.x<0) loc.x=0;
    }
    if (keyCode==DOWN) {
      loc.y ++;
      if(loc.y>sH-1) loc.y=sH-1;
    }
    if (keyCode==UP) {
      loc.y --;
      if(loc.y<0) loc.y=0;
    }
}

void initVolume(){
    for (int i=0;i<voxel.length;i++) {
    for (int j=0;j<voxel[i].length;j++) {
      for (int k=0;k<voxel[i][j].length;k++) {
        voxel[i][j][k] = new Voxel(i, j, k, scaleFactor);
      }
    }
  }
}


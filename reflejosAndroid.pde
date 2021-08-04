float tam;
float tamB;
float posX;
float posY;
color colorVariable;
int framesPorSegundo;
int velocidad;
int cantidadDeCuadrantes;
int estado;
int nivel;
int maxNivel;
PFont thunderstrike;
void setup() {
  size(displayWidth, displayHeight);
  cantidadDeCuadrantes = 2;
  velocidad = 60;
  estado = 0;
  nivel = 0;
  framesPorSegundo = 60;
  background(0);
  textAlign(CENTER, BASELINE);
  background(255);
  frameRate(framesPorSegundo);
  thunderstrike = createFont("thunderstrike.ttf", 48);
  textFont(thunderstrike);
  tam = displayWidth/cantidadDeCuadrantes;
  tamB = displayWidth/4;
  colorVariable = color(255);
}
void draw() {
  textSize(20);
  if (estado == 0) {
    background(0, 0, 32);
    fill(colorVariable);
    text("Prueba tus reflejos y sube de nivel", displayWidth/2, displayHeight/6);
    noFill();
    stroke(colorVariable);
    rect(displayWidth/2-tamB/2, displayHeight/2-tamB/2, tamB, tamB);
    fill(colorVariable);
    text("Empezar", displayWidth/2, displayHeight/2);
    text("Nivel máximo alcanzado: "+maxNivel, displayWidth/2, displayHeight/10);
  } else if (estado == 1) {
    textSize(30);
    text("Estás en el nivel:"+nivel, displayWidth/2, displayHeight/5);
    text("Reset para salir", displayWidth/5, displayHeight/10);
    textSize(30);
    fill(0, 0, 32, 255);
    noStroke();
    rect(0, 0, displayWidth, displayHeight);
    fill(colorVariable);
    stroke(colorVariable);
    if (posY > displayHeight || posX > displayWidth || frameCount % velocidad == 0) {
      posX = tam*round((random(0, cantidadDeCuadrantes-1)));
      posY = tam*round((random(0, cantidadDeCuadrantes)));
    }
    rect(posX, posY, tam, tam);
  } else if (estado == 2) {
    background(255);
    fill(0);
    text("Pasaste al nivel:"+nivel, displayWidth/2, displayHeight/5);
    text("La velocidad aumenta...", displayWidth/2, displayHeight/4);
    if (nivel > 80) {
      text("velocidad inhumana", displayWidth/2, displayHeight/3.5);
    }
    noFill();
    stroke(0);    
    rect(displayWidth/2-tamB/2, displayHeight/2-tamB/2, tamB, tamB);
    fill(0);
    text("Seguir", displayWidth/2, displayHeight/2);
    noStroke();
  } else if (estado == 3) {
    background(255);
    fill(0);
    text("¡Completaste una decena de niveles!", displayWidth/2, displayHeight/4);
    noFill();
    stroke(0);
    rect(displayWidth/2-tamB/2, displayHeight/2-tamB/2, tamB, tamB);
    fill(0);
    text("Seguir!", displayWidth/2, displayHeight/2);
    noStroke();
  }
  pushStyle();
  fill(255);
  stroke(0);   
  circle(displayWidth, 0, displayWidth/5);
  fill(0);
  textSize(10);
  text("Reset", displayWidth-displayWidth/25, displayWidth/25);
  popStyle();
}
void mousePressed() {
  if (dist(mouseX, mouseY, width, 0) < displayWidth/4.9) {
    estado = 0;
    velocidad = 60;
    nivel = 1;
    cantidadDeCuadrantes = 2;
    tam = displayWidth/cantidadDeCuadrantes;
    colorVariable = color(255);
  }
  if (
    mouseX > displayWidth/2-tamB/2
    && mouseX < displayWidth/2-tamB/2 + tamB 
    && mouseY > displayHeight/2-tamB/2 
    && mouseY < displayHeight/2-tamB/2 + tamB
    && estado == 0) {
    estado = 1;
  }
  if (mouseX > displayWidth/2-tamB/2 
    && mouseX < displayWidth/2-tamB/2 + tamB 
    && mouseY > displayHeight/2-tamB/2 
    && mouseY < displayHeight/2-tamB/2 + tamB 
    && estado == 2) {
    estado = 1;
  }
  if (mouseX > displayWidth/2-tamB/2 
    && mouseX < displayWidth/2-tamB/2 + tamB 
    && mouseY > displayHeight/2-tamB/2
    && mouseY < displayHeight/2-tamB/2 + tamB 
    && estado == 3) {
    estado = 1;
  }
  if (mouseX > posX 
    && mouseX < posX + tam 
    && mouseY > posY 
    && mouseY < posY + tam 
    && estado == 1) {
    posX = tam*round((random(0, cantidadDeCuadrantes-1)));
    posY = tam*round((random(0, cantidadDeCuadrantes)));
    nivel++;
    if (nivel > maxNivel) {
      maxNivel = nivel;
    }
    if (velocidad >= 12) {
      velocidad = velocidad - 6;
    }
    estado = 2;
  }
  if (nivel % 10 == 0 
    && nivel != 0
    && velocidad == 6) {
    estado = 3;
    velocidad = 60;
    cantidadDeCuadrantes=cantidadDeCuadrantes*2;
    tam = displayWidth/cantidadDeCuadrantes;
  }
  if (nivel >= 90) {
    estado = 0;
    velocidad = 60;
    nivel = 1;
    cantidadDeCuadrantes = 2;
    tam = displayWidth/cantidadDeCuadrantes;
  }
}

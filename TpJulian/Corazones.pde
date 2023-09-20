class Corazon {
  FCircle circle;
  PImage corazon;
  float yPosition; // Variable para controlar la posición vertical
  
  Corazon(FWorld world, float x, float y, float radius) {
    corazon = loadImage("corazon.png");
    circle = new FCircle(radius);
    yPosition = y;
    circle.setPosition(x, y);
    circle.attachImage(corazon);
    world.add(circle);
  }

  // Método para actualizar la posición vertical de la imagen
  void update() {
    yPosition -= 1; // Ajusta la velocidad de movimiento aquí
    circle.setPosition(circle.getX(), yPosition);
    
    // Si la imagen se mueve completamente fuera de la pantalla, elimínala
    if (yPosition + corazon.height < 0) {
      mundo.remove(circle);
    }
  }
}

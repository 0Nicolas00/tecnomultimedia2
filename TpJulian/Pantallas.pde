class Pantallas {
  
  Pantallas() {
    textSize(30);
    textAlign(CENTER);
    background(0);
  }
  
  void dibujarInicio() {
    background(0);
    text("Alimenta a los monos", 450, 50);
    text("¡Usa algo amarillo!", 450, 570);
  }
  void dibujarVictoria() {
    background(0);
    text("Lo hiciste, los monos estan felices", 450, 170);
    text("Usa algo amarillo para volver al menu", 450, 570);
  }
  void dibujarDerrota() {
    background(0);
    text("No llegaste a tiempo", 450, 170);
    text("Usa algo amarillo para volver al menu", 450, 570);
  }
  
  
}

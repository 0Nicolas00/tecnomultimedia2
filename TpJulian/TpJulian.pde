import fisica.*;

FWorld mundo;
Canion c;
Pantallas p;
Corazon corazon;
monoFeliz monofeliz;
PImage Fondo, Enemigo;
int estado;
int tiempoInicio;
int duracionEsperada = 30000; //30 segundos


void setup() {
  size(1000, 700);
  Fondo = loadImage("Selva.jpg");
  Enemigo = loadImage("MonoMalo.png");
  tiempoInicio = millis();
  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges();
  c = new Canion( 100, 600);
  p = new Pantallas();
  
  
    for (int i = 0; i < 1; i++)
  {
    FBox Mono1 = new FBox ( 75, 150);
    Mono1.setName( "mono1" );
    Mono1.setPosition ( 350, 150);
    Mono1.setStatic(true);
    Mono1.attachImage(Enemigo);
    mundo.add( Mono1 );
  }
   for (int i = 0; i < 1; i++)
  {
    FBox Mono2 = new FBox ( 75, 150);
    Mono2.setName( "mono2" );
    Mono2.setPosition ( 500, 600);
    Mono2.setStatic(true);
    Mono2.attachImage(Enemigo);
    mundo.add( Mono2 );
  }
  for (int i = 0; i < 1; i++)
  {
    FBox Mono3 = new FBox ( 75, 150);
    Mono3.setName( "mono3" );
    Mono3.setPosition ( 600, 100);
    Mono3.setStatic(true);
    Mono3.attachImage(Enemigo);
    mundo.add( Mono3 );
  }
    for (int i = 0; i < 1; i++)
  {
    FBox Mono4 = new FBox ( 75, 150);
    Mono4.setName( "mono4" );
    Mono4.setPosition ( 600, 400);
    Mono4.setStatic(true);
    Mono4.attachImage(Enemigo);
    mundo.add( Mono4 );
  }
    for (int i = 0; i < 1; i++)
  {
    FBox Mono5 = new FBox ( 75, 150);
    Mono5.setName( "mono5" );
    Mono5.setPosition ( 800, 300);
    Mono5.setStatic(true);
    Mono5.attachImage(Enemigo);
    mundo.add( Mono5 );
  }
}

void draw() {
  if ( estado==0) {
    p.dibujarInicio();
    if (key==' ') {
      estado = 1;
    }
  }
  if ( estado==1) {
    image(Fondo, 0, 0);
    c.actualizarAngulo();
    mundo.step();
    mundo.draw();
    //m.dibujar();
    c.dibujar();
    int tiempoTranscurrido = millis() - tiempoInicio;
    int segundosTranscurridos = tiempoTranscurrido / 1000;
    text("Tiempo transcurrido: " + segundosTranscurridos, 800, 50);
    if (millis() - tiempoInicio >= duracionEsperada) {
      estado = 3;
    }
  }
  if ( estado==2) {
    p.dibujarVictoria();
  }
  if ( estado==3) {
    p.dibujarDerrota();
  }
}

  void contactStarted(FContact contacto) {
  FBody body1 = contacto.getBody1();
  FBody body2 = contacto.getBody2();

  if (body1.getName() != null && body2.getName() != null)
  {
    println("body1= " + body1.getName());
    println("body2= " + body2.getName());
    mundo.remove(body1);
    mundo.remove(body2);
    
     // Crea y agrega un Corazon en la posición de body2
    corazon = new Corazon(mundo, body1.getX()+5, body1.getY()-110, 0);
    monofeliz = new monoFeliz(mundo, body1.getX(), body1.getY(), 0);
    corazon.update();
  }
}

void keyPressed() {
  if ( key==' ') {
    c.disparar( mundo );
  }
}

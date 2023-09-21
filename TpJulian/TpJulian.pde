import fisica.*;
import java.util.ArrayList;
import processing.sound.*;

SoundFile fondoMusical;
SoundFile perdiste;
SoundFile ganar;
SoundFile lanzamiento;
SoundFile monoalimentado;

ArrayList<FBox> balas = new ArrayList<FBox>();

FWorld mundo;
Canion c;
Pantallas p;
Corazon corazon;
monoFeliz monofeliz;
PImage Fondo, Enemigo, Cartel;
PFont miFuente; // Declarar una variable para la fuente
int estado;
int tiempoInicio;
int duracionEsperada = 10000; //un minuto
int contadorMonoFeliz = 0; // Inicialmente, el contador está en 0


void setup() {
  size(1000, 700);
  Fondo = loadImage("Selva.jpg");
  Enemigo = loadImage("MonoMalo.png");
  Cartel = loadImage("cartel.png");
  tiempoInicio = millis();
  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges();
  c = new Canion( 100, 600);
  p = new Pantallas();
  // Cargar la fuente desde el archivo en la carpeta del sketch
  miFuente = createFont("HoltwoodOneSC-Regular.ttf", 64);
  // Establecer la fuente para el texto
  textFont(miFuente);
  fondoMusical = new SoundFile(this, "jugando.wav"); // Reemplaza "nombre_del_archivo_de_audio.mp3" con el nombre de tu archivo de audio
  perdiste = new SoundFile(this, "perdiste.wav");
  ganar = new SoundFile(this, "ganar.wav");
  lanzamiento = new SoundFile(this, "lanzamiento.wav");
  monoalimentado = new SoundFile(this, "monofeliz.wav");
  monoalimentado.amp(0.3);
  fondoMusical.loop();
  // Establece el volumen inicial (un valor entre 0.0 y 1.0)
  fondoMusical.amp(0.3); // Esto establece el volumen al 50%


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
  if (estado==0) {
    p.dibujarInicio();
    if (key==' ') {
      estado = 1;
    }
  }
  if (estado==1) {
    image(Fondo, 0, 0);
    c.actualizarAngulo();
    mundo.step();
    mundo.draw();
    //m.dibujar();
    c.dibujar();
    int tiempoTranscurrido = millis() - tiempoInicio;
    int segundosTranscurridos = tiempoTranscurrido / 1000;
    image(Cartel, 720, 25, 257, 145);
    fill(241, 243, 71);
    text(segundosTranscurridos, 850, 120);
    if (millis() - tiempoInicio >= duracionEsperada) {
      fondoMusical.stop();
      estado = 3;
      perdiste.play();
      noLoop();
    }
    for (int i = balas.size() - 1; i >= 0; i--) {
      FBox bala = balas.get(i);
      if (millis() - c.tiempoDisparoBala >= 1400) {
        // Elimina la bala de la lista y del mundo
        mundo.remove(bala);
        balas.remove(i);
      }
    }
  }
  if (estado==2) {
    p.dibujarVictoria();
    fondoMusical.stop();
    ganar.play();
    noLoop();
  }
  if (estado==3) {
    p.dibujarDerrota();
  }
}

void contactStarted(FContact contacto) {
  FBody body1 = contacto.getBody1();
  FBody body2 = contacto.getBody2();

  // Detectar colisión con las paredes del mundo físico
  if (body1.getName() == null || body2.getName() == null) {
    if (body1.getName() == null) {
      // body1 colisionó con la pared, elimina body2
      mundo.remove(body2);
    } else {
      // body2 colisionó con la pared, elimina body1
      mundo.remove(body1);
    }
  } else {
    println("body1= " + body1.getName());
    println("body2= " + body2.getName());
    mundo.remove(body1);
    mundo.remove(body2);
    println(contadorMonoFeliz++); // Aumenta el contador cada vez que colisiona 
    monoalimentado.play();

    // Crea y agrega un Corazon en la posición de body2
    corazon = new Corazon(mundo, body1.getX()+5, body1.getY()-110, 0);
    monofeliz = new monoFeliz(mundo, body1.getX(), body1.getY(), 0);
  }

  // Si el contador llega a 5, cambia al estado de pantalla número 2 (victoria)
  if (contadorMonoFeliz >= 10) {
    estado = 2;
  }
}

void keyPressed() {
  println(key); // Imprime la tecla presionada en la consola
  if ( key==' ') {
    c.disparar( mundo );
    lanzamiento.play();
  }
  if (estado == 2 && (key == 'e' || key == 'E')) {
    resetJuego();
  }
  if (estado == 3 && (key == 'e' || key == 'E')) {
    resetJuego();
  }
}

void resetJuego() {
  // Reinicia el tiempo de inicio
  tiempoInicio = millis();
  // Reinicia el contador del mono feliz
  contadorMonoFeliz = 0;
  // Reinicia otros valores o elementos del juego según sea necesario
  // ...
  
  // Reinicia el estado del juego al estado inicial (por ejemplo, estado 0)
  estado = 0;
  
  // Reanuda la reproducción de la música de fondo
  fondoMusical.loop();
  
  // Reanuda el bucle de dibujo
  loop();
}

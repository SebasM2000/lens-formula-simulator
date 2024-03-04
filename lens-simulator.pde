int r=10, s=0, r1=7, fdc, fic, f1=350, f2=650;
float n=420, y1=290, y2=310;
float x1=490, x2=510;
float m=250, z=8;
float rf=14;//COORDENADAS MOVIMIENTO FLECHA
float c1, c2;//COORDENADAS RAYOCENTRAL_3
float yt, yt2, distanciaIL, distanciaImL, k, bt;//VARIABLES DE CALCULO DE ALTURA
float acum, bt2, k2;

//PANTALLA DE BIENVENIDA
void fondo(){
 PImage Lele;
 Lele=loadImage("Lele1.jpeg");
 image(Lele,0,0,1000,600);
}

void setup(){
 background(0);
 size(1000,600);
 fill(255,0,0);//Color de las letras
 textSize(40);
 fondo();
 PFont Mifuente;
 Mifuente=loadFont("Vivaldii-58.vlw");
 textFont(Mifuente);
 text("¡Bienvenido a Lele, haz click para comenzar!",80,80);
}

void draw(){
PFont Mifuente2;
 Mifuente2=loadFont("Arial-BoldMT-48.vlw");
 textFont(Mifuente2);
  int a=0;
  //CUERPO DEL PROYECTO
  if(mousePressed)
    a=1;
  if(a==1){
    Fondo2();
    Plano();
    Botones();
    EsteticaDistancia();
    Objeto();
    LenteConvergente();
    LenteDivergente();
    if(s>0)
    RayoCentral();
    RayoParalelo();
    ImagenEspejo();
  }
}

//PLANO COORDENADO
void Plano(){
    textSize(8);
    fill(0);
    stroke(0);
    drawSubXY();
    stroke(0);
    line(0,300,1000,300);//EJE X
    line(500,0,500,600);//EJE Y
    line(1000,300,990,310);//flecha del...
    line(1000,300,990,290);//...eje X
    line(490,10,500,0); //flecha del...
    line(510,10,500,0); //...eje Y
    stroke(0);
    drawX();
    drawY();
}

void Fondo2(){
background(0,240,200);
    textSize(20);
    fill(250,10,250);
    stroke(0,0,225);
    text("X",975,295);
    text("Y",515,20);
}

//Mini-lineas
void drawSubXY(){
    int i,a=0,b=0;
    
    for(i=0;i<=100;i++){
        stroke(0,200,190);
        line(0,b,1000,b);
        line(b,0,b,1000);
        b+=10;
    }
    
    for(i=0;i<=10;i++)
    {
        stroke(251,0,0);
        line(0,a,1000,a);
        line(a,0,a,1000);
        a+=100;
    }
}

//EJE X
void drawX(){
  float x,xp;
  String val;
  textAlign(RIGHT);
  for(x=0;x<1000;x+=50){
    line(x,y1,x,y2);
    xp=PX(x)-50;
    val=String.format("%4.2f",xp);
    text(val,x,y2);
  }
}

//EJE Y
void drawY(){
  float y,yp;
  String val2;
  textAlign(LEFT);
  for(y=0;y<600;y+=50){
    yp=(PX(y)*-1)+30;
    line(x1,y,x2,y);
    val2=String.format("%4.2f",yp);
    text(val2,x2,y);
  }
}
 
//INICIO FUNCIONES ESENCIALES
float PX(float x){
  return map(x,0,1000,0,100);
}

float PY(float y){
  return map(y,0,600,0,60);
}
//FIN FUNCIONES ESENCIALES

//BOTONES
void Botones(){
    ellipseMode(RADIUS);
    fill(244,0,0);
    stroke(0,0,0);
    ellipse(960,420,r,r);
    ellipse(960,450,r,r);
    textSize(17);
    fill(0,0,0);
    text("Lente convergente",790,426);
    text("Lente divergente",790,456);
}

//ImagenEcuacion-
void imageen(){
 PImage ecuac;
 ecuac=loadImage("imagen.jpeg");
 image(ecuac,20,20);
}

//ImagenEcuacion+
void imagen(){
 PImage ecua;
 ecua=loadImage("imagen2.jpeg");
 image(ecua,20,20);
}

//LENTE CONVERGENTE
void LenteConvergente(){
    
    float d_1=dist(mouseX,mouseY,960,420);
    if((mousePressed)&&(d_1<r))
      s=1;
    if(s==1){
      stroke(0);
      strokeWeight(2);
      fill(0,255,0,60);
      ellipse(500,300,35,200);     
      strokeWeight(1);
      imageen();
      FocosLC();
      
    }
}

//DISTANCIA OBJETO-LENTE
float foco(float a){
  return map(a,500,1000,0,50);
}

//ALTURA DEL OBJETO
float alturaO(float a){
  return map(a,300,100,0,20);//ACA CREO QUE SUMERCÉ TIENE UNA VARIACIÓN DIFERENTE POR LO DE LA RESOLUCIÓN
}

//FOCOS LENTE CONVERGENTE
void FocosLC(){
    float dfd=dist(mouseX,mouseY,f2,300);
    float dfi=dist(mouseX,mouseY,f1,300);
    float f=foco(f2);
    distanciaIL=(f*z)/(z-f);
    float mm=alturaO(m);
    yt=((distanciaIL*mm)/z)*(-1);//altura imagen
   
    fill(225,0,0);
    textSize(10);
    text(distanciaIL,926,60);//Distancia Img-Lente
    if(distanciaIL<0)
        text("IMAGEN VIRTUAL",880,120);
    else
        text("IMAGEN REAL", 880,120);
    text(yt,926,80);//Tamaño Imagen        

    ellipseMode(RADIUS);
    fill(255,0,0);
    stroke(255);
    ellipse(f2,300,r1,r1);
    ellipse(f1,300,r1,r1);
    if(((mouseX>=300)&&(mouseX<=400))||((mouseX>=600)&&(mouseX<=700))){
      if((mousePressed)&&(dfd<r1)){
       f2=mouseX;
       f1=1000-mouseX;
      }
   
      if((mousePressed)&&(dfi<r1)){
       f1=mouseX;
       f2=1000-mouseX;
      }
   }
}

float GrafAlturaLC(float t){
  if(t<0)
    t=(10*t)-300;
  else
    t=(-10*t)+300;
  if(t<0)
    t*=-1;
  return t;
}

float CalcDistILC(float w){
    w=(10*w)+500;
    if(w<0)
      w*=-1;
    return w;
}

//LENTE DIVERGENTE
void LenteDivergente(){ 
    float d_2=dist(mouseX,mouseY,960,450);
    
    if((mousePressed)&&(d_2<r))
      s=2;
    if(s==2){
      fill(255,0,0,100);
      noStroke();
      rect(450,100,100,400);
      strokeWeight(1);
      fill(0,240,200);
      stroke(0);
      translate(300,300);
      rotate(PI+HALF_PI);
      arc(0,150,200,40,0,PI,OPEN);//LADO IZQUIERDO
      rotate(HALF_PI);
      translate(-300,-300);
      arc(550,300,40,200,HALF_PI,PI+HALF_PI,OPEN);//LADO DERECHO
      line(450,100,550,100);//PARTE SUPERIOR
      line(450,500,550,500);//PARTE INFERIOR
      imagen();
      FocosLD();
    }   
}

//FOCOS LENTE DIVERGENTE
void FocosLD(){
  float dfd=dist(mouseX,mouseY,f2,300);
  float dfi=dist(mouseX,mouseY,f1,300);
  float ff=foco(f2);
  distanciaImL=(-ff*z)/(ff+z);
  float mm=alturaO(m);
  yt2=((distanciaImL/z)*mm)*(-1);
  fill(225,0,0);
  textSize(10); 
 
  text(distanciaImL,926,60);//Distancia Img-Lente
  text(yt2,926,80);//Tamaño Imagen
  

  ellipseMode(RADIUS);
  fill(255,0,0);
  stroke(255);
  ellipse(f2,300,r1,r1);
  ellipse(f1,300,r1,r1);
   
   if(((mouseX>=300)&&(mouseX<=400))||((mouseX>=600)&&(mouseX<=700))){
   if((mousePressed)&&(dfd<r1)){  
     f2=mouseX;                     
     f1=1000-mouseX;              
   }                              

   if((mousePressed)&&(dfi<r1)){  
     f1=mouseX;                   
     f2=1000-mouseX;              
   }
  }
}

//DISTANCIA OBJETO-LENTE
float distancia(float a){
  return map(a,0,1000,0,100);
}

//ESTETICA DISTANCIA
void EsteticaDistancia(){
    fill(220,220,220);
    stroke(0,0,250);
    rect(800,0,171,100);
    textSize(10);
    fill(0);
    text("Distancia objeto-lente:",810,20);
    text("Tamaño del objeto:",810,40);
    text("Distancia imagen-lente:",810,60);
    text("Tamaño de la imagen:",810,80);


}

//OBJETO DEL USUARIO
void Objeto(){
    float x,d,y;
    x=dist(mouseX,300,500,300);
    y=dist(mouseX,mouseY,n,m);
    d=distancia(x);
    noFill();
    noStroke();
    ellipseMode(RADIUS);
    ellipse(n,m,rf,rf);
    stroke(44,44,207);
    strokeWeight(2);
    fill(225,0,0);
    line(n,m,n,300);
    textSize(10);
    text(z,926,20);
    float mm=alturaO(m);
    if(mm<0)
    {float t=mm*(-1); text(t,926,40);} else {text(mm,926,40);}  //Tamaño objeto
    
    if((mouseY>=120)&&(mouseY<=480)){
    
    if(y<=rf){
      
    if(mouseY<300){
      line(n,m,n-10,m+10);
      line(n,m,n+10,m+10);
    }
    else{
      line(n,m,n-10,m-10);
      line(n,m,n+10,m-10);
    }
    
    if(mouseX<=420){             
      n=mouseX;
      m=mouseY;
      z=d;
    }
  }
    }
    strokeWeight(1);
}

//IMAGEN FORMADA
void ImagenEspejo(){
  stroke(50);
  if(s==1){
    if(k>300){
    line(bt-10,k-10,bt,k);
    line(bt+10,k-10,bt,k);
  }
  else{
    line(bt-10,k+10,bt,k);
    line(bt+10,k+10,bt,k);
  }
    line(bt,k,bt,300);
  }
  if(s==2){
    if(k2>300){
    line(bt2-10,k2-10,bt2,k2);
    line(bt2+10,k2-10,bt2,k2);
  }
  else{
    line(bt2-10,k2+10,bt2,k2);
    line(bt2+10,k2+10,bt2,k2);
  }
    line(bt2,k2,bt2,300);
  }
  
  strokeWeight(1);
}

//INICIO RAYO CENTRAL
void RayoCentral(){
    stroke(255,255,0);
    RayoCentral_1();
    RayoCentral_2();
    RayoCentral_3();
    RayoCentral_4();
}

void RayoCentral_1(){
    strokeWeight(2);
    //line(2*(n-1000),2*(m-600),n,m);
}

void RayoCentral_2(){
    line(n,m,500,300);
}

void RayoCentral_3(){
  if(s==1)
    line(bt,k,500,300);
  if(s==2)
    line(bt2,k2,500,300);
}

void RayoCentral_4(){
    strokeWeight(1);
}
//FINAL RAYO CENTRAL

//INICIO RAYO PARALELO
void RayoParalelo(){
    stroke(255,0,255);
    strokeWeight(2);
    
    if(s>0)
      line(n,m,0,m);
    if(s==1)
      HazLenteConv();
    if(s==2)
      HazLenteDiv();
}

void HazLenteConv(){
    float q1=m-300, q2=(49*pow(q1,2))/1600, xres=1225-q2;
    
    line(n,m,500-sqrt(xres),m);
    bt=CalcDistILC(distanciaIL);
    k=GrafAlturaLC(yt);
    line(bt,k,f2,300);
    if((m>150)||(m<450)){
      if(m<282){
        acum=m+18;
        line(f2,300,500+sqrt(xres),acum);
        line(500-sqrt(xres),m,500+sqrt(xres),acum);
      }
      if(m>318){
        acum=m-18;
        line(f2,300,500+sqrt(xres),acum);
        line(500-sqrt(xres),m,500+sqrt(xres),acum);
      }
   }
}

void HazLenteDiv(){
    float arg_1=m-300, arg_2=pow(arg_1,2)/25, arg=1600-arg_2;
    line(n,m,450+sqrt(arg),m);
    bt2=CalcDistILC(distanciaImL);
    k2=GrafAlturaLC(yt2);
    line(bt2,k2,f2,300);
    if((m>230)||(m<370)){
      if(m<282){
        acum=m+18;
        line(f2,300,550-sqrt(arg),acum);
        line(450+sqrt(arg),m,550-sqrt(arg),acum);
      }
      if(m>318){
        acum=m-18;
        line(f2,300,550-sqrt(arg),acum);
        line(450+sqrt(arg),m,550-sqrt(arg),acum);
      }
   }
}

//FINAL RAYO PARALELO

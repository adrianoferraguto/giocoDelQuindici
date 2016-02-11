gioco g = new gioco();
int f = 0;

void setup(){
  size(400,500);
  frameRate(30);
  g.setStatoGioco(false);
  String data[] = loadStrings("highscores.txt");
  g.setBestMosse(int(data[0]));
  g.setBestTempo(int(data[1]));
}

void draw(){
  if (keyPressed && (key=='g' || key=='G')) g.iniziaPartita();
  background(200);
  g.disegnaGriglia();
  if(mousePressed) g.click(mouseX, mouseY);
  textAlign(LEFT,TOP);
  textSize(24);
  text("MOSSE",10,10);
  text(g.getMosse(),10,10+24);
  if(g.getStatoGioco()){
    if(f<frameRate) f++;
    else{
      g.scorriTempo();
      f = 0;
    };
  }
  text("TEMPO",10+100,10);
  text(g.getTempo(),10+100,10+24);
  textSize(15);
  if (g.getBestMosse()<9999)
    text("HS " + g.getBestMosse(),10,10+24*2);
  if (g.getBestTempo()<9999)
    text("HS " + g.getBestTempo(),10+100,10+24*2);
  textSize(24);
  if(!g.getStatoGioco()){
    rect(0,100,500,600);
    fill(255);
    text("Premi 'g' per iniziare una partita",10,200);
    text("(o il pulsante 'Nuova partita')",10,230);
    if (g.getVittoria())
      text("Complimenti! Hai vinto!",10,110);
  }
  textSize(18);
  fill(255);
  rect(220,10,160,30);
  String t;
  if (!g.getStatoGioco()) t = "Nuova partita";
  else t = "Ricomincia";
  fill(0);
  text(t,220,10);
  
  if(!g.conImmagine){
    fill(255);
    rect(220,50,160,30);
    fill(0);
    text("Carica immagine",220,50);
    textSize(24);
  }
}

void mouseReleased(){
  if (mouseX>220 && mouseX<380 && mouseY>50 && mouseY<80) if(!g.conImmagine) g.caricaImmagine();
  if (mouseX>220 && mouseX<380 && mouseY>10 && mouseY<40) g.iniziaPartita();
}

public void imgSelezionata(File file){
  if (file == null) {
    g.immagine = null;
    g.conImmagine = false;
  } else {
    g.immagine = loadImage(file.getAbsolutePath());
    g.conImmagine = true;
  }
}
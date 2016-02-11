class gioco{
  private
    int[] griglia;
    int mosse;
    int tempo;
    boolean inGioco = false;
    boolean vittoria = false;
    int bestTempo, bestMosse;
  public
    gioco(){
    }
    int[] generaGrigliaRandom(){
      int[] griglia = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,};
      for(int i=0;i<16;i++){
        while(griglia[i]==-1){
          boolean ok = false;
          int r = 0;
          while(!ok){
            ok = true;
            r = floor(random(0,16));
            for(int j=i;j>=0;j--)
              if(r==griglia[j]) ok= false;
          }
          griglia[i] = r;
        }
      }
      //Valida griglia
      int r = -1;
      int n = 0;
      for(int i=0;i<16;i++){
        if(griglia[i]==0){
          if(i>=0&&i<=3||i>=8&&i<=11) r=1;
          else r=0;
        }
        for(int j=i;j<16;j++){
          if(griglia[j]<griglia[i]) n++;
        }
      }
      if((r+n)%2!=0) griglia = generaGrigliaRandom();
      /*for(int i=0; i<15; i++){
        griglia[i] = i+1;
      }*/
      return griglia;
    }
    void disegnaGriglia(){
      if(inGioco==false) return;
      int[] griglia = this.griglia;
      fill(255);
      stroke(255);
      rect(0,100,400,500);
      textAlign(CENTER, CENTER);
      textSize(48);
      for(int i=0; i<16; i++){
        fill(255);
        stroke(0);
        rect(i%4*100, i/4*100+100, i%4*100+100, i/4*100+100+100);
        fill(0);
        if (griglia[i] != 0) 
          text(griglia[i], i%4*100+100/2, i/4*100+100+100/2);
      }
    }
    void click(int x, int y){
      if(inGioco == false) return;
      // Interpreto la posizione del mouse per conoscere la casella cliccata
      int casella = (floor(x/100)+(floor(y/100)*4))-4;
      if(casella>=0) muovi(casella);
    }
    void muovi(int c){
      boolean scambiabileDx = true,
              scambiabileSx = true,
              scambiabileSu = true,
              scambiabileGiu = true;
      if(c==3 || c==7 || c==11 || c==15) scambiabileDx = false;
      if(c==0 || c==4 || c==8 || c==12) scambiabileSx = false;
      if(c==0 || c==1 || c==2 || c==3) scambiabileSu = false;
      if(c==12 || c==13 || c==14 || c==15) scambiabileGiu = false;
      if(scambiabileDx && griglia[c+1]==0) scambia(c, c+1);
      if(scambiabileSx && griglia[c-1]==0) scambia(c, c-1);
      if(scambiabileSu && griglia[c-4]==0) scambia(c, c-4);
      if(scambiabileGiu && griglia[c+4]==0) scambia(c, c+4);
      if(soluzioneVincente()) vittoria();
    }
    boolean soluzioneVincente(){
      int[] soluzione = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0};
      for(int i=0;i<16;i++){
        if(soluzione[i]!=griglia[i]) return false;
      }
      return true;
    }
    void vittoria(){
      this.inGioco = false;
      vittoria = true;
      String m = str(bestMosse),
             t = str(bestTempo);
      if(this.mosse<this.bestMosse){
        m = str(this.mosse);
        this.bestMosse = this.mosse;
      }
      if(this.tempo<this.bestTempo){
        t = str(this.tempo);
        this.bestTempo = this.tempo;
      }
      String[] data = {m,t};
      saveStrings("highscores.txt", data);
    }
    void setBestMosse(int value){
      this.bestMosse = value;
    }
    void setBestTempo(int value){
      this.bestTempo = value;
    }
    int getBestMosse(){
      return this.bestMosse;
    }
    int getBestTempo(){
      return this.bestTempo;
    }
    boolean getVittoria(){
      return vittoria;
    }
    void iniziaPartita(){
      griglia = generaGrigliaRandom();
      this.setStatoGioco(true);
      this.mosse = 0;
      this.tempo = 0;
    }
    boolean getStatoGioco(){
      return inGioco;
    }
    void setStatoGioco(boolean value){
      this.inGioco = value;
    }
    void scambia(int x, int y){
      int temp = griglia[x];
      griglia[x] = griglia[y];
      griglia[y] = temp;
      mosse++;
    }
    int getMosse(){
      return mosse;
    }
    int getTempo(){
      return tempo;
    }
    void scorriTempo(){
      tempo++;
    }
}
import javax.swing.JOptionPane;

/*

  program generates random string disguised in different colours
  and locations to fool neural algorithms, program when clicked
  then asks you for the string to test if you are a human.

*/

final int MIN_LENGTH = 6;
final int MAX_LENGTH = 10;
final String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
final int TEXT_SIZE = 35;

String randomString;
boolean programEnd = false;

public void setup() {
  // setup canvas, setup the string and draw it
  size(500,500);
  textSize(TEXT_SIZE);
  randomString = generateRandomString();
  drawRandomString();
}

public void draw() {
}

// generates the random string to be used
public String generateRandomString() {
  int sLength = (int)random(MIN_LENGTH,MAX_LENGTH+1);
  String s = "";
  for(int i=0;i<sLength;i++) {
    int rn = (int)random(1,ALPHABET.length());
    s += ALPHABET.substring(rn-1,rn);
  }
  return s;
}

// draws random string 
public void drawRandomString() {
  final int WAVE_MOD_W = (int)random(10,20);
  final int WAVE_MOD_H = (int)random(10,100);
  
  fill(0);
  int X_OFFSET = 1;
  for (int j = 0; j<4;j++) {
    int c=0;
    float textX, textY;
    
    // draw all the characters of the string
    for (float i = 0.0; i<width/WAVE_MOD_W;i+=0.1) {
      int dif = width/(randomString.length()+1)*(c+1);
      if (floor(i*WAVE_MOD_W) >= dif && c < randomString.length()) {
        String letter = randomString.substring(c,++c);
        fill(random(255),random(255),random(255));
        final int Y_OFFSET = 5;
        int randomizer = (random(2) >= 1) ? (int)random(Y_OFFSET) : (int)random(Y_OFFSET)*-1;
        textX = i*WAVE_MOD_W - textWidth(letter)/2 + X_OFFSET*j;
        textY = height/2-cos(i)*WAVE_MOD_H + textDescent() + randomizer;
        text(letter,textX,textY);
      }
    }
  }
  
  // draw the line through characters
  float oldX = 0, oldY = 0;
  for (float k = 0.0;k<width/5;k+=0.1) {
    float newX = k*WAVE_MOD_W;
    float newY = height/2 - cos(k)*WAVE_MOD_H;
    circle(newX,newY,1);
    if(oldX != 0) line(oldX,oldY,newX,newY);
    oldX = newX;
    oldY = newY;
  }
}

// if mouseclicked check if program endded, if not then ask for answer
public void mouseClicked() {
  if (!programEnd) {
    var answer = JOptionPane.showInputDialog("What is the string?");
    displayEndMsg(checkAnswer(answer));
  }
}

// checks the answer
public boolean checkAnswer(String answer) {
  programEnd = true;
  return (answer.equals(randomString));
}

// displays the end msg and ends program
public void displayEndMsg(boolean correct) {
  String endMsg = "";
  if (correct) {
    endMsg = "Access Granted.";
  } else {
    endMsg = "Access Denied.";
  }
  background(190);
  fill(0,0,255);
  text(endMsg, width/2 - textWidth(endMsg)/2,height/2);
}

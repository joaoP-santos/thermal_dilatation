import java.math.BigDecimal;
float initialSize, temperatureVariation, coeficient, sizeVariation, cm, thickness, h50, liX, deltaLX, initialStart, initialEnd;
color red = color(254, 74, 73);
color copper = color(184, 115, 51);
color lightCopper = color(207, 141, 79);
color yellow = color(233, 223, 0);
color blue = color(61, 82, 213);
color white = color(243, 243, 244, 200);
PFont cmusr;
String degree = "\u00B0";
String coeficientCaption = degree + "C-1";
String frmtCoeficientCaption = degree + "C\u207B\u00B9";
String lI = "Li";
String frmtLI = "Li\u1D62";
String deltaL = "DL";
ArrayList<Button> buttons = new ArrayList<Button>();
float unlocked, unlockMultiplier;
int mouseXSnap;
float sizeVariationSnap, initialSizeSnap, temperatureVariationSnap, coeficientSnap;
int index = -1;
PImage view, hide;

//<a href="https://www.flaticon.com/free-icons/eye" title="eye icons">Eye icons created by Kiranshastry - Flaticon</a>
//<a href="https://www.flaticon.com/free-icons/password" title="password icons">Password icons created by th studio - Flaticon</a>

void setup() {
  orientation(LANDSCAPE);
  fullScreen();
  cm = 45 * width / 1366;
  thickness = cm - 30 * width / 1366;
  initialSize = cm;
  initialStart = width / 5;
  initialEnd = initialStart + initialSize;
  coeficient = 1.000;
  cmusr = createFont("CMU Serif Roman.ttf", 36);
  temperatureVariation = 1;
  sizeVariation = initialSize * temperatureVariation * coeficient;
  deltaLX = initialEnd + sizeVariation;
  view = loadImage("view.png");
  hide = loadImage("hide.png");

  for (int i = 0; i < 8; i++) {
    Button b = new Button(i);
    buttons.add(b);
    b.lockAll();
  }
}

void draw() {
  background(yellow);
  textAlign(CENTER); 
  textFont(cmusr);
  h50 = height / 2;
  initialEnd = initialStart + initialSize;

  deltaLX = initialEnd + sizeVariation;
  liX = initialStart;


  for (Button b : buttons) {
    switch(b.index) {
    case 0:
      if (b.unlocked == false) {
        break;
      }
      initialSize = unlocked;
      initialSize = sizeVariation / (temperatureVariationSnap * coeficientSnap);
      break;
    case 1:
      if (b.unlocked == false) {
        break;
      }
      temperatureVariation = unlocked;
      temperatureVariation = sizeVariation / (coeficient * initialSize);
      break;
    case 2:
      if (b.unlocked == false) {
        break;
      }
      coeficient = unlocked;
      coeficient = sizeVariation / (temperatureVariation * initialSize);
      //coeficient = sizeVariation / (temperatureVariation * initialSize);
    }
  }
  //sizeVariation = initialSize * temperatureVariation * coeficient;
  //temperatureVariation = sizeVariation / (coeficient * initialSize);


  //Initial state
  stroke(copper); 
  strokeWeight(thickness);
  line(initialStart, h50, initialEnd, h50);
  //Captions
  fill(copper);

  textAlign(CENTER, BOTTOM);
  text(lI, liX, h50 - thickness);

  textAlign(CENTER, TOP);
  text(buttons.get(5).unlocked == false 
    ? BigDecimal.valueOf(initialSize / cm)
    .setScale(3, BigDecimal.ROUND_HALF_UP)
    .floatValue() + "cm"
    : "?", liX, h50 + thickness);


  //Size Variation
  stroke(lightCopper);
  line(initialEnd, h50, initialEnd + sizeVariation, h50);
  //Captions
  fill(lightCopper);

  textAlign(CENTER, BOTTOM);
  text(deltaL, deltaLX, h50 - thickness);

  textAlign(CENTER, TOP);
  text(buttons.get(4).unlocked == false
    ? BigDecimal.valueOf(sizeVariation / cm)
    .setScale(3, BigDecimal.ROUND_HALF_UP)
    .floatValue() + "cm"
    : "?", deltaLX, h50 + thickness);

  //Total size
  stroke(white); 
  strokeWeight(thickness / 2);
  line(initialStart, height / 3, initialEnd + sizeVariation, height / 3);
  line(initialStart, height / 3, initialStart, height / 2.7);
  line(initialEnd + sizeVariation, height / 3, initialEnd + sizeVariation, height / 2.7);
  //Caption
  fill(white);
  textAlign(CENTER, BOTTOM);
  text(buttons.get(3).unlocked == false
    ?"L = " + BigDecimal.valueOf((initialSize + sizeVariation) / cm)
    .setScale(3, BigDecimal.ROUND_HALF_UP)
    .floatValue() + "cm"
    : "L = ?", initialStart + (initialSize + sizeVariation) / 2, height / 3 - thickness);

  //Temperature variation
  fill(red);
  text(buttons.get(6).unlocked == false
    ?"DT = "  + BigDecimal.valueOf(temperatureVariation)
    .setScale(2, BigDecimal.ROUND_HALF_UP)
    .floatValue() + degree + "C"
    : "DT = ?", width/2, 4*height / 5);
  //Coeficient
  fill(blue);
  //if (buttons.get(4).unlocked == false) {
  text(buttons.get(7).unlocked == false
    ? "\u03B1 = " + BigDecimal.valueOf(coeficient)
    .setScale(3, BigDecimal.ROUND_HALF_UP)
    .floatValue() + degree + "C-1"
    : "\u03B1 = ?", width * 0.15, height * 0.2);

  //Buttons
  for (Button b : buttons) {
    b.show();
  }
}

void mouseDragged() {
  /*if (mouseX > mouseX) {
   if (mouseX - mouseX > 10) {}
   else{
   unlocked -= unlockMultiplier;
   }
   } else {
   unlocked += unlockMultiplier;
   }
   //unlocked += (mouseX - mouseX) * unlockMultiplier;
   mouseX = mouseX;
   */
  for (Button b : buttons) {
    if (b.unlocked == true) {
      index = b.index;
    }
  }

  switch (index) {
  case 0:
    unlockMultiplier = 0.55; 
    break;
  case 1: 
    unlockMultiplier = 1.0; 
    break;
  case 2:
    unlockMultiplier = 0.15; 
    break;
  }
  sizeVariationSnap = sizeVariation + (mouseX - mouseXSnap) * unlockMultiplier;
  if (index == 0 && sizeVariationSnap / (temperatureVariationSnap * coeficientSnap) / cm < 1) {
    sizeVariation = temperatureVariationSnap * coeficientSnap * cm;
    return;
  }

  if (initialEnd + sizeVariationSnap > width - 2*cm) {
    sizeVariation = width - initialEnd - 2*cm;
    return;
  }

  sizeVariation += (mouseX - mouseXSnap) * unlockMultiplier;
  mouseXSnap = mouseX;
}
void mousePressed() {
  mouseXSnap = mouseX;
  for (Button b : buttons) {
    b.checkClick();
  }
}

void mouseReleased() {
  mouseXSnap = mouseX;
}

/*Integer getSelectedVariable(int index) {
 for (Button b : buttons) {
 if (b.unlocked == true) {
 index = b.index;
 return(index);
 }
 }
 }
 */

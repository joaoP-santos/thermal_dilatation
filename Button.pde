class Button {
  float bX;
  float bY;
  float side;
  color bColor;
  String caption;
  boolean unlocked;
  int index;
  String type;

  Button(int i) {
    index = i;
    switch(index) {
    case 0:
      bColor = copper;
      caption = "Li";
      temperatureVariationSnap = temperatureVariation;
      coeficientSnap = coeficient;
      type = "lock";
      break;
    case 1:
      bColor = red;
      caption = "DT";
      initialSizeSnap = initialSize;
      coeficientSnap = coeficient;
      type = "lock";
      break;
    case 2:
      bColor = blue;
      caption = "\u03B1";
      initialSizeSnap = initialSize;
      temperatureVariationSnap = temperatureVariation;
      type = "lock";
      break;
    case 3: 
      bColor = white;
      caption = "L";
      type = "showUnshow";
      break;
    case 4:
      bColor = lightCopper;
      caption = "DL";
      type = "showUnshow";
      break;
    case 5:
      bColor = copper;
      caption = "Li";
      type = "showUnshow";
      break;
    case 6:
      bColor = red;
      caption = "DT";
      type = "showUnshow";
      break;
    case 7:
      bColor = blue;
      caption = "\u03B1";
      type = "showUnshow";
    }
    switch (type) {
    case "lock":
      bX = (index + 3) * width / 8;
      bY = 0.9 * height;
      side = width * 0.1;
      break;
    case "showUnshow":
      bX = (index + 1) * width / 12;
      bY = 0.15 * height;
      side = width * 0.07;
      break;
    }
  }

  void show() {
    imageMode(CENTER);
    if (type == "lock") {
      rectMode(CENTER); 
      textAlign(CENTER, CENTER);
      if (unlocked == true) {
        fill(white);
      } else {
        fill(bColor);
      }
      rect(bX, bY, side, side, 10);
      if (unlocked == true) {
        fill(red);
      } else {
        fill(yellow);
      }
      text(caption, bX, bY - 10);
    } else if (type == "showUnshow") {
      rectMode(CENTER); 
      textAlign(CENTER, CENTER);
      if (unlocked == true) {
        image(hide, bX, bY - side * 0.8, side * 0.5, side * 0.5);
        fill(white);
      } else {
        image(view, bX, bY - side * 0.8, side * 0.5, side * 0.5);
        fill(bColor);
      }
      rect(bX, bY, side, side, 10);
      if (unlocked == true) {
        fill(red);
      } else {
        fill(yellow);
      }
      text(caption, bX, bY - 10);
    }
  }

  void checkClick() {
    if (bX - side/2 < mouseX && mouseX < bX + side/2 && bY - side/2 < mouseY && mouseY < bY + side) {

      if (type == "lock") {
        lockAll();
      };
      if (unlocked == false) {
        unlocked = true;
      } else if (unlocked == true) {
        unlocked = false;
      }
      switch(index) {
      case 0:
        temperatureVariationSnap = temperatureVariation;
        coeficientSnap = coeficient;
        break;
      case 1:
        initialSizeSnap = initialSize;
        coeficientSnap = coeficient;
        break;
      case 2:
        initialSizeSnap = initialSize;
        temperatureVariationSnap = temperatureVariation;
        break;
      }
    }
  }

  void lockAll() {
    for (Button b : buttons) { 
      if (b.type == "lock") {
        b.unlocked = false;
      }
    }
  }
}

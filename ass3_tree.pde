// This artwork is a representation of a fractal art. 
// It depicts a tree which each small part is a perfect,
// exact reproduction of its previous, bigger part.
// It is a very elegant and organic-looking object 
// which is triggered and can be changed by the user input.

/** INSTRUCTIONS 
 *
 * Click on the canvas to start generating a fractal tree.
 * Each click generates a new part of the tree.
 *
 * UP and DOWN arrow keys modify the length of the tree parts.
 * LEFT and RIGHT arrow keys modify the angle of the tree branches.
 * MOUSE WHEEL movements also modify the angle of the tree branches.
 *
 * To save the artwork as a screenshot, press s or S.
 * To see your saved artwork, go back to Processing 
 * and go to Sketch -> Show Sketch Folder (CTRL+K)
 *
 * IMPORTANT:
 * Remember, this artwork is a fractal. 
 * The longer you click to produce new parts of the tree,
 * the more work your computer's processor needs to do to generate 
 * a whole new tree with all those new parts. 
 * So, be gentle to your processor :) 
 * 
 * Have fun!
*/ 

boolean drawTree;
int maxTreeSteps;
float branchAngle;
float treeLength;
color background;

void setup() {
  size(1280, 720);
  background = #444444;
  drawTree = false;
  maxTreeSteps = 1;  
  branchAngle = 45; 
  treeLength = 200;
}

void draw() {  
  noFill();
  background(background);   
  if (drawTree) {
    translate(width / 2, height); 
    tree(treeLength, treeLength * 0.1, 1); 
  }
}

void mouseClicked() {
  drawTree = true;
  maxTreeSteps++;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();  
  changeBranchAngle(e);
}

void keyPressed() {
  if (key == CODED) {
      switch (keyCode) {
        case LEFT: 
          changeBranchAngle(-1);
          break;
        case RIGHT: 
          changeBranchAngle(1);
          break;
        case UP: 
          changeTreeLength(1);
          break;   
        case DOWN: 
          changeTreeLength(-1);
          break;        
      }      
  }
}

void keyReleased() {
  if (key == 's' || key == 'S') {
    saveFrame("screenshot.png");  
  }
}

void changeBranchAngle(float n) {
  branchAngle += n;
}

void changeTreeLength(float n) {
  if (treeLength + n >= 50)
    treeLength += n;
}

void tree(float treeLength, float strokeWeight, int currentTreeStep) {
  if (currentTreeStep < maxTreeSteps) {
    stroke(#c9c9c9);
    strokeCap(PROJECT);
    strokeWeight(strokeWeight);
    line(0, 0, 0, -treeLength);  
    translate(0, -treeLength);
    
    strokeWeight *= 0.6;
    treeLength *= 0.7;
    
    if (treeLength > 2) {
      pushMatrix();
      rotate(radians(branchAngle));
      tree(treeLength, strokeWeight, currentTreeStep + 1);
      popMatrix();
      
      pushMatrix();
      rotate(-radians(branchAngle));
      tree(treeLength, strokeWeight, currentTreeStep + 1);
      popMatrix();
    } 
  }
}

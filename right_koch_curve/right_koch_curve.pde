BinaryGraphFractal l;

void setup(){
    size(1920,1080);
}
class BinaryGraphFractal {
    PVector start;       // A PVector for the start
    PVector end;         // A PVector for the end
    ArrayList<BinaryGraphLine> lines;   // A list to keep track of all the lines
    int maxDepth;

    BinaryGraphFractal(int md) {
        int length = 1500;
        int offset = length/2;
        start = new PVector(width/2-offset,height/2);
        end = new PVector(width/2+offset,height/2);
        lines = new ArrayList<BinaryGraphLine>();
        maxDepth = md;
        generateFractal(0);
    }

    ArrayList<BinaryGraphLine> generateBinaryGraph(BinaryGraphLine line){
        ArrayList<BinaryGraphLine> newlines = new ArrayList<BinaryGraphLine>();
        PVector frp = line.firstRightPoint();
        PVector stp = line.secondTopPoint(frp);
        PVector trp = line.thirdRightPoint(stp);
        PVector mfdp = line.midFourthDownPoint(trp);
        PVector fdp = line.fourthDownPoint(trp);
        PVector vrp = line.fifthRightPoint(fdp);
        PVector sixtp = line.sixthTopPoint(vrp);

        BinaryGraphLine line1 = new BinaryGraphLine(line.p1,frp);
        BinaryGraphLine line2 = new BinaryGraphLine(stp,frp);
        BinaryGraphLine line3 = new BinaryGraphLine(stp,trp);
        BinaryGraphLine line4 = new BinaryGraphLine(trp,mfdp);
        BinaryGraphLine line5 = new BinaryGraphLine(mfdp,fdp);
        BinaryGraphLine line6 = new BinaryGraphLine(fdp,vrp);
        BinaryGraphLine line7 = new BinaryGraphLine(sixtp,vrp);
        BinaryGraphLine line8 = new BinaryGraphLine(sixtp,line.p2);

        newlines.add(line1);
        newlines.add(line2);
        newlines.add(line3);
        newlines.add(line4);
        newlines.add(line5);
        newlines.add(line6);
        newlines.add(line7);
        newlines.add(line8);
        return newlines;
    }

    void renderLines(){
        for(BinaryGraphLine line : lines) {
            line.display();
        }
    }

    void generateFractal(int depth){
        if (depth==maxDepth){ 
            renderLines();
            return;
            }
        if (lines.size() == 0){
            BinaryGraphLine line = new BinaryGraphLine(start,end);
            lines.add(line);
        }
        ArrayList now = new ArrayList<BinaryGraphLine>();    // Create empty list
        for(BinaryGraphLine line : lines) {
            ArrayList<BinaryGraphLine> newlines = generateBinaryGraph(line);
            now.addAll(newlines);
            //println("generated");
        }
        lines = now;
        generateFractal(depth+1);
  }
}
class BinaryGraphLine {
    PVector p1;
    PVector p2;

    BinaryGraphLine(PVector start, PVector end) {
    p1 = start.copy();
    p2 = end.copy();
  } 
  void display(){
    stroke(255);
    line(p1.x,p1.y,p2.x,p2.y);
  }
  PVector firstRightPoint() {
      PVector v = PVector.sub(p2,p1);
      v.div(4);
      v.add(p1);
      return v;
  }

  PVector secondTopPoint(PVector frp){
    float newAngle = - PI/2;
    PVector v = PVector.sub(p2,p1);
    v.div(4);
    v.rotate(newAngle);
    v.add(frp);
    return v;
  }

  PVector thirdRightPoint(PVector stp){
    PVector v = PVector.sub(p2,p1);
    v.div(4);
    v.add(stp);
    return v;
  }

  PVector midFourthDownPoint(PVector trp){
    float newAngle = PI/2;
    PVector v = PVector.sub(p2,p1);
    // one edge of half-hex is equal to half length
    v.div(4);
    v.rotate(newAngle);
    v.add(trp);
    return v;
  }

  PVector fourthDownPoint(PVector trp){
    float newAngle = PI/2;
    PVector v = PVector.sub(p2,p1);
    v.div(2);
    v.rotate(newAngle);
    v.add(trp);
    return v;
  }
  PVector fifthRightPoint(PVector fdp){
    PVector v = PVector.sub(p2,p1);
    v.div(4);
    v.add(fdp);
    return v;
  }
  PVector sixthTopPoint(PVector vrp){
    PVector v = PVector.sub(p2,p1);
    float newAngle = -PI/2;
    v.div(4);
    v.rotate(newAngle);
    v.add(vrp);
    return v;
  }
}

// MAIN
void draw() {
    //println("Hello? 1");
    background(0,0,0);
    l = new BinaryGraphFractal(1);

}
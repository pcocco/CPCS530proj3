// *********************************************************
// **** CPCS530 - Paulette Cocco - Project3 Processing
// *********************************************************
PImage mapImage;
PFont plotFont;
Table locationTable;
Table dataTableHS;  // No High School Diploma
Table dataTableDP;  // Major Depression
Table dataTableUN;  // Unemployed
boolean toggleFunction = true;
int rowCount;
int c;
int toggleCount = 3;
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;
String title2;

// *********************************************************
// **** Begin Setup of Visualizations
void setup() {
    size(640,400);
    surface.setTitle("U.S Census Data from Vulnerable Populations and Environmental Health Dataset");
    mapImage = loadImage("map.png");
    plotFont = createFont("TimesNewRoman",16);
    textFont(plotFont);
    
    // Make a data table from a file that contains coord of each state
    locationTable = new Table("locations.tsv");
    rowCount = locationTable.getRowCount();
 
    // Read data tables
    dataTableHS = new Table("NoHSDiploma.tsv");
    dataTableDP = new Table("MajorDepression.tsv");
    dataTableUN = new Table("Unemployed.tsv"); 
} // ...end setup

// find the minimum and maxium values of any table passed
void getMinMax(Table table) {
    dataMax = MIN_FLOAT;
    dataMin = MAX_FLOAT;
    for ( int row = 0; row < table.getRowCount(); row++ ) {      
       float point1 = table.getFloat(row,1);
        if ( point1  >  dataMax) {
            dataMax = point1;
            continue;
        }       
        if (point1 < dataMin) {
            dataMin = point1; 
        } 
    }
}  // ...end getMinMax

// count each time the space bar is pressed
void keyPressed() {      
   if (key == ' ') {  
        toggleCount ++;
   }
}  // ... end keyPressed

// *********************************************************
// **** Begin Visualizations
void draw () {
    // Load background of U.S.
    background(0xFF);
    image(mapImage,0,0);
 
    // Drawing attributes of the ellipses
    smooth();
    fill(192,0,0);
    noStroke();
    textSize(16);

    
    c = toggleCount % 3;  // modulo gives the remainder; divide by three to determine which map to display
    
  if (c == 0) { // draw No HS Diploma table
       // Loop thru rows of locations and draw points of new table
       getMinMax(dataTableHS);
       for (int row= 0; row < rowCount; row++) {
         String abbrev = dataTableHS.getRowName(row);
         float x = locationTable.getFloat(abbrev,1);   //col 1
         float y = locationTable.getFloat(abbrev,2);   //col 2
         text("No HS Diploma",250,25);
         drawDataHS(x,y,abbrev);  // Use green to blue colors
   }
 } else if (c == 1) { //draw Major Dression table
       // Loop thru rows of locations and draw points of new table
       getMinMax(dataTableDP);
       for (int row= 0; row < rowCount; row++) {
         String abbrev = dataTableDP.getRowName(row);
         float x = locationTable.getFloat(abbrev,1);   //col 1
         float y = locationTable.getFloat(abbrev,2);   //col 2
         text("Major Depression",250,25);
         drawDataDP(x,y,abbrev); 
   }
 } else { //draw Unemployed table
       // Loop thru rows of locations and draw points of new table
       getMinMax(dataTableUN);
       for (int row= 0; row < rowCount; row++) {
         String abbrev = dataTableUN.getRowName(row);
         float x = locationTable.getFloat(abbrev,1);   //col 1
         float y = locationTable.getFloat(abbrev,2);   //col 2
         text("Unemployed",250,25);
         drawDataUN(x,y,abbrev); 
   }
 }
}  // ... end draw


// **** Map the size of the ellipse to the data values ****
// No High School Diploma
void drawDataHS(float x, float y, String abbrev) {
    float value = dataTableHS.getFloat(abbrev, 1);
     float diameter = 0;
    if (value >=0) {
      diameter = map(value,0,dataMax,3,30);
      fill(#333366); //blue
  } else {
      diameter = map(value,0,dataMin,3,30);
      fill(#EC5166); //red
  }
    float percent = norm(value,dataMin,dataMax);
    color between = lerpColor(#294F32, #61E2F0, percent); // green to blue
    fill(between);
    ellipse(x,y,diameter,diameter);
}

// Major Depression
void drawDataDP(float x, float y, String abbrev) {
    float value = dataTableDP.getFloat(abbrev, 1);
    float diameter = 0;
    if (value >=0) {
      diameter = map(value,0,dataMax,3,30);
      fill(#333366); //blue
  } else {
      diameter = map(value,0,dataMin,3,30);
      fill(#EC5166); //red
  }
    float percent = norm(value,dataMin,dataMax);
    color between = lerpColor(#000000, #C0C0C0, percent); // black to grey
    fill(between);
    ellipse(x,y,diameter,diameter);
}

// Unemployeed
void drawDataUN(float x, float y, String abbrev) {
    float value = dataTableUN.getFloat(abbrev, 1);
    float diameter = 0;
    if (value >=0) {
      diameter = map(value,0,dataMax,3,30);
      fill(#333366); //blue
  } else {
      diameter = map(value,0,dataMin,3,30);
      fill(#EC5166); //red
  }
    float percent = norm(value,dataMin,dataMax);
    color between = lerpColor(#FBF003, #FB0303, percent); // red to yellow
    fill(between);
    ellipse(x,y,diameter,diameter);
}
// **** end of program ****
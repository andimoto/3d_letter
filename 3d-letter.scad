/* by andimoto */
use <fonts/HussarBd.otf>
use <fonts/HussarBdObl.otf>
use <fonts/Millimetre-Bold.otf>

$fn=50;

/* printlayer=0.45; //mm */
letterHight=60;
thickness=13;
font="DejaVu Sans Mono:style=Bold";
fontHussarBolt="Hussar:style=Fett";
fontMillimetre="Millimetre:style=Bold";

echo("Font hight=",letterHight);
echo("Thickness=",thickness);

module 3d_letter(letter, hight, thickness) {
    linear_extrude(thickness) text(letter,size=hight,font=fontMillimetre,$fn = 100);
}

module ledPlate(){
    cube([10.5,5,10+1]);
}


AlphCnt=73;
Alphabet=["A","B","C","D","E","F","G","H","I","J","K","L","M","N",
          "O","P","Q","R","S","T","U","V","W","X","Y","Z","Ä","Ö","Ü",
          "a","b","c","d","e","f","g","h","i","j","k","l","m","n",
          "o","p","q","r","s","t","u","v","w","x","y","z","ä","ö","ü",
          "1","2","3","4","5","6","7","8","9","0","d","!","$","&","?"];

module alphabet(){
for(i = [0:AlphCnt-1]){
  translate([(i%13)*letterHight,(i-(i%13))*13*letterHight/100,0])
    3d_letter(Alphabet[i],letterHight,thickness);
};
}

/* translate([0,0,0])
rotate([90,0,180])
difference() {
  3d_letter("A",letterHight,thickness);
  translate([5.2,1,-1]) ledPlate();
  translate([34.3,1,-1]) ledPlate();
} */

/* difference() {
  3d_letter("H",letterHight,thickness);
  translate([5.2,1,-1]) ledPlate();
  translate([34.3,1,-1]) ledPlate();
} */

/* difference() {
  3d_letter("N",letterHight,thickness);
  translate([5.2,1,-1]) ledPlate();
  translate([34.3,1,-1]) ledPlate();
} */

/* alphabet(); */
/* cube([30,58.35,1]); */


socketLenX = 60;
socketLenY = 30;
socketLenZ = 30;
socketWallThickness = 2;

cableHoleRad=3;
tolerance=0.1;
extra=0.1;

screwDia=3;
screwHeadDia=6;

connectorRad = 5;
conPlateMulti=1.4;

lidFixRad = 0.5;
lidFixMove = 0.2;

cableHole1Xmov = 15;
cableHole1Ymov = 5;
cableHole2Xmov = 44.5;
cableHole2Ymov = 5;
topCableHoleR = 3/2;

module connectorNegPlate()
{
  hull()
  {
    cylinder(r=connectorRad,h=socketWallThickness);
    translate([-connectorRad,-connectorRad*2,0]) cube([connectorRad*2,connectorRad*2,socketWallThickness]);
  }
}


module connector()
{
  difference()
  {
    union()
    {
      translate([0,0,socketWallThickness*2]) scale([conPlateMulti,conPlateMulti,1]) connectorNegPlate();
      connectorNegPlate();
      translate([0,0,socketWallThickness])connectorNegPlate();
      translate([0,0,-socketWallThickness]) scale([conPlateMulti,conPlateMulti,1]) connectorNegPlate();
    }

    translate([0,0,-socketWallThickness]) cylinder(r=cableHoleRad,h=socketWallThickness*4);
    translate([-cableHoleRad/2,0,-socketWallThickness]) cube([cableHoleRad,cableHoleRad*2*conPlateMulti,socketWallThickness*4]);

    translate([-conPlateMulti*connectorRad,-connectorRad*2*conPlateMulti,-socketWallThickness])
      cube([conPlateMulti*connectorRad*2,connectorRad,socketWallThickness*4]);

  }
}

/* connector(); */
/* connectorNegPlate(); */

module socket(cableHoleL=false, cableHoleR=false, topCableHole=false)
{
  difference() {
    cube([socketLenX,socketLenY-socketWallThickness,socketLenZ]);
    translate([socketWallThickness,-extra,socketWallThickness])
    cube([socketLenX-socketWallThickness*2,
      socketLenY-socketWallThickness*2+extra,
      socketLenZ-socketWallThickness*2]);

    if(cableHoleL == true)
    {
      translate([0,socketLenY/3,socketLenZ/2]) rotate([0,90,0])
      connectorNegPlate();
    }

    if(cableHoleR == true)
    {
      translate([socketLenX-socketWallThickness,socketLenY/3,socketLenZ/2]) rotate([0,90,0])
      connectorNegPlate();
    }

    /* lid fixer */
    translate([socketWallThickness,socketWallThickness/2,socketWallThickness+tolerance+lidFixMove])
      rotate([0,90,0]) cylinder(r=lidFixRad, h=socketLenX-socketWallThickness*2);

    translate([socketWallThickness,socketWallThickness/2,socketLenZ-socketWallThickness-tolerance-lidFixMove])
      rotate([0,90,0]) cylinder(r=lidFixRad, h=socketLenX-socketWallThickness*2);


    /* case champfer */
    translate([0,socketLenY-socketWallThickness-sqrt(2),-socketWallThickness+2]) rotate([-45,0,0]) cube([socketLenX,2,2]);
    translate([0,socketLenY-socketWallThickness-sqrt(2),socketLenZ-socketWallThickness+2]) rotate([-45,0,0]) cube([socketLenX,2,2]);

    if(topCableHole==true)
    {
      /* top cable coles */
      #translate([cableHole1Xmov,cableHole1Ymov,socketLenZ-socketWallThickness]) cylinder(r=topCableHoleR, h=socketWallThickness);
      #translate([cableHole2Xmov,cableHole2Ymov,socketLenZ-socketWallThickness]) cylinder(r=topCableHoleR, h=socketWallThickness);
    }
  }

}


module lid()
{
  union()
  {
    cube([socketLenX,socketWallThickness,socketLenZ]);

    translate([socketWallThickness+tolerance,socketWallThickness,socketWallThickness+tolerance])
    cube([socketLenX-socketWallThickness*2-tolerance*2,
      socketWallThickness,
      socketLenZ-socketWallThickness*2-tolerance*2]);

    translate([socketWallThickness+tolerance,socketWallThickness*1.5,socketWallThickness+tolerance+lidFixMove])
      rotate([0,90,0]) cylinder(r=lidFixRad, h=socketLenX-socketWallThickness*2-tolerance*2);

    translate([socketWallThickness+tolerance,socketWallThickness*1.5,socketLenZ-socketWallThickness-tolerance-lidFixMove])
      rotate([0,90,0]) cylinder(r=lidFixRad, h=socketLenX-socketWallThickness*2-tolerance*2);
  }
}


lid();
/* socket(cableHoleL=true,cableHoleR=true); */

/* translate([(socketLenX-42.5)/2,0,socketLenZ])
translate([45.83333333333333,(socketLenY-thickness)/2,0])
rotate([90,0,180])
difference() {
  3d_letter("A",letterHight,thickness);
  translate([5.2,1,-1]) ledPlate();
  translate([34.3,1,-1]) ledPlate();
} */

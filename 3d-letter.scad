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

cableHoleRad=5;
tolerance=0.2;
extra=0.1;

screwDia=3;
screwHeadDia=6;

module socket(cableHoleL=false, cableHoleR=false)
{
  difference() {
    cube([socketLenX,socketLenY-socketWallThickness,socketLenZ]);
    translate([socketWallThickness,-extra,socketWallThickness])
    cube([socketLenX-socketWallThickness*2,
      socketLenY-socketWallThickness*2+extra,
      socketLenZ-socketWallThickness*2]);

    if(cableHoleL == true)
    {
      translate([-extra,socketLenY/3,socketLenZ/2]) rotate([-90,0,-90])
      cylinder(r=cableHoleRad,h=socketWallThickness+extra*2);
    }

    if(cableHoleR == true)
    {
      translate([socketLenX-socketWallThickness-extra,socketLenY/3,socketLenZ/2]) rotate([-90,0,-90])
      cylinder(r=cableHoleRad,h=socketWallThickness+extra*2);
    }
  }

  /* screw hole lower left corner */
  difference() {
    translate([socketWallThickness,socketWallThickness,socketWallThickness])
      cube([screwDia+2,socketLenY-socketWallThickness*3,screwDia+2]);
    translate([socketWallThickness+(screwDia+2)/2,socketWallThickness,socketWallThickness+(screwDia+2)/2])
      rotate([90,0,180]) cylinder(r=(screwDia-tolerance)/2, h=10, center=false);
  }

  /* screw hole upper right corner */
  difference() {
    translate([socketLenX-socketWallThickness-(screwDia+2),
        socketWallThickness,
        socketLenZ-socketWallThickness-(screwDia+2)])
      cube([screwDia+2,socketLenY-socketWallThickness*3,screwDia+2]);
    translate([socketLenX-socketWallThickness-(screwDia+2)/2,
        socketWallThickness,
        socketLenZ-socketWallThickness-(screwDia+2)/2])
      rotate([90,0,180]) cylinder(r=(screwDia-tolerance)/2, h=10, center=false);
  }


}


module lid()
{
  difference() {

    union()
    {
      cube([socketLenX,socketWallThickness,socketLenZ]);

      translate([socketWallThickness+tolerance,socketWallThickness,socketWallThickness+tolerance])
      cube([socketLenX-socketWallThickness*2-tolerance*2,
        socketWallThickness,
        socketLenZ-socketWallThickness*2-tolerance*2]);
    }

  /* screw hole lower left corner */
  translate([socketWallThickness+(screwDia+2)/2,
      0,
      socketWallThickness+(screwDia+2)/2])
    rotate([90,0,180]) cylinder(r=screwDia/2, h=socketWallThickness*2, center=false);

    /* screw hole upper right corner */
  translate([socketLenX-socketWallThickness-(screwDia+2)/2,
      0,
      socketLenZ-socketWallThickness-(screwDia+2)/2])
    rotate([90,0,180]) cylinder(r=screwDia/2, h=socketWallThickness*2, center=false);
  translate([socketLenX-socketWallThickness-(screwDia+2)/2,
      0,
      socketLenZ-socketWallThickness-(screwDia+2)/2])
    rotate([90,0,180]) cylinder(r=screwHeadDia/2, h=socketWallThickness, center=false);
  }
}


lid();

translate([0,socketWallThickness+5,0]) socket(cableHoleL=true,cableHoleR=true);

cutoutPoly = [
[0,0],
[0,3],
[8,3],
[5,0]
];

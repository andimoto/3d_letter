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

/* translate([5,thickness,socketLenZ-lowSocketHeight])
rotate([90,0,0])
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
lowSocketHeight = 7;
lowSocketDepht = thickness + 5;
socketWallThickness = 2;





module socket()
{
  difference() {
    cube([socketLenX,socketLenY,socketLenZ]);
    translate([0,0,socketLenZ-lowSocketHeight]) cube([socketLenX,lowSocketDepht,lowSocketHeight]);
    /* #translate([0,lowSocketDepht,socketLenZ-lowSocketHeight]) rotate([20,0,0]) cube([socketLenX,lowSocketDepht,lowSocketHeight]); */

    translate([socketWallThickness,socketWallThickness,socketWallThickness])
    cube([socketLenX-socketWallThickness*2,
      socketLenY-socketWallThickness,
      socketLenZ-lowSocketHeight-socketWallThickness*2]);


  }

}
socket();

cutoutPoly = [
[0,0],
[0,3],
[8,3],
[5,0]
];

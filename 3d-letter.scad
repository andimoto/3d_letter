/* by andimoto */
letterHight=80;
thickness=15;
font="DejaVu Sans Mono:style=Bold";


module 3d_letter(letter, hight, thickness) {
    linear_extrude(thickness) text(letter,size=hight,font=font,$fn = 50);
}

translate([0*letterHight,0,0]) 3d_letter("A",letterHight,thickness);
translate([1*letterHight,0,0]) 3d_letter("N",letterHight,thickness);
translate([2*letterHight,0,0]) 3d_letter("D",letterHight,thickness);
translate([3*letterHight,0,0]) 3d_letter("I",letterHight,thickness);

EXT_WIDTH=0.6;
PLAY=0.2;

WIDTH_1=13;
WIDTH_2=27;

DEPTH_0=2*EXT_WIDTH;
DEPTH_1=7.9;
DEPTH_2=14.3;
DEPTH_3=17.5;

HEIGHT_1=2.7;
HEIGHT_2=16.3+PLAY;

HOLE_R=1.6;
HOLE_D=20.5;
HOLE_Z=4.5;

R_OUTSIDE=7.85+PLAY;
R_INSIDE=R_OUTSIDE-2*EXT_WIDTH;

R_SCREW=1.85+PLAY;

module base() {
    intersection() {
    minkowski() {
        cube([WIDTH_2-1,2*HEIGHT_1-1,2*DEPTH_1-1], center=true);
        sphere(r=0.5);
    }
    //translate([-50,0,0])
    //cube([100,100,100]);
    }
}

module hole() {
    translate([0,50,HOLE_Z])
    rotate([90,0,0])
    cylinder(100,r=HOLE_R,$fn=20);
}

module outer() {
    translate([0,HEIGHT_2-R_OUTSIDE,0])
    cylinder(DEPTH_3,r=R_OUTSIDE);
}

module inner() {
    translate([0,HEIGHT_2-R_OUTSIDE,-0.01])
    cylinder(DEPTH_2,r=R_INSIDE);
}

module screw() {
    translate([0,HEIGHT_2-R_OUTSIDE,-50])
    cylinder(100,r=R_SCREW, $fn=20);
}

module front() {
    intersection() {
        hull() {
            base();
            outer();
        }
        translate([-50,-50,0])
            cube([100,100,DEPTH_0]);
    }
}

module block() {
    translate([-WIDTH_1/2,0,0])
    cube([WIDTH_1,2*HEIGHT_1,DEPTH_1]);
}

module disc_hole() {
    translate([0,HEIGHT_2-R_OUTSIDE,DEPTH_3-0.5])
    minkowski() {
        cylinder(1,r=R_INSIDE-1,$fn=20);
        sphere(r=1);
    }
}

module close_hole() {
    translate([0,HEIGHT_2-R_OUTSIDE,DEPTH_2])
    cylinder(0.2,r=R_INSIDE);
}

module support() {
    translate([0,HEIGHT_2-R_OUTSIDE,0])
    difference() {
        cylinder(DEPTH_2,r=R_SCREW+EXT_WIDTH, $fn=20);
        cylinder(DEPTH_2,r=R_SCREW, $fn=20);
    }
}

//close_hole();
//support();

difference() {
    union() {
        //front();
        //outer();
        base();
        //block();
    }

}

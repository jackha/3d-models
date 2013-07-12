//PRIMARY INPUTS
gdmin = 20;     //minimum reversal gap distance (mm)
gdmax = 50;	//maximum reversal gap distance (mm)	
bdmin = 10;	//minimum bridging distance (mm)
bdmax = 60;	//maximum bridging distance (mm)
increment = 10;    //number of steps
height = 50;     //total height of object (mm)

//SECONDARY INPUTS
towerwidth = 3;     //width of vertical tower (mm)
borderwidth = 6;     //width of border on base plane (mm)
borderthickness = 0.5;     //thickness of border on base plane (mm)
bridgethickness = 2;     //thickness of bridges (mm)

//Script
xstepsize = (gdmax-gdmin)/increment; 
ystepsize = (bdmax-bdmin)/(increment);
zstepsize = height/increment;

union(){

difference(){
translate([-towerwidth,0,0]) cube([gdmin+xstepsize*(increment+1),ystepsize*(increment+2),borderthickness]);

translate([-towerwidth+borderwidth,borderwidth,0]) cube([gdmin+xstepsize*(increment+1)-2*borderwidth,ystepsize*(increment+2)-2*borderwidth,borderthickness]);
}

for(i=[0:increment-1]){
translate([-towerwidth,0+ystepsize*i,0])cube([towerwidth,ystepsize,zstepsize+zstepsize*i]);  //tower

translate([gdmin+xstepsize*i,0+ystepsize*i,0]) cube([(xstepsize+gdmax-gdmin)-xstepsize*i,ystepsize, zstepsize+zstepsize*i]);  //stairs

translate([gdmin+xstepsize*i,(ystepsize*increment)+ystepsize,0]) cube([(xstepsize+gdmax-gdmin)-xstepsize*i,ystepsize,zstepsize+zstepsize*i]);   //back tower

translate([gdmin+xstepsize*i,0+ystepsize*i,zstepsize+zstepsize*i-bridgethickness]) cube([xstepsize,ystepsize*(increment+1)-ystepsize*i,bridgethickness]);   //bridge
}

for(j=[increment:increment+1]){
translate([-towerwidth,ystepsize*j,0])cube([towerwidth,ystepsize,zstepsize+zstepsize*(increment-1)]);  //tower addon

translate([gdmin+xstepsize*increment,ystepsize*j,0]) cube([(xstepsize+gdmax-gdmin)-xstepsize*increment,ystepsize, zstepsize+zstepsize*(increment-1)]);   //top stair
}

}

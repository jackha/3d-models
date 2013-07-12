// koch 3d recursive

// Size of edge
D=40;
// Max edge length -> level of detail depending on build size
MAXSIDE = 1;
// Max fractal depth (number of iterations)
n=4;

// rotate([45, 45, 0])
translate([-D/6, -D/6, -D/6])
koch_3D(side=D,maxside=MAXSIDE,level=n);


module koch_3D(side=1,maxside=1,level=1) {
   l=side/3;
   if ((level == 0) || (l < maxside)) {
      cube([side,side,side],center="true");
   } else {
      for (i=[-1:1], j=[-1:1], k=[-1:1])
        if ((i==0 || j==0 || k==0) && !(i==0 && j==0 && k==0)) {
           translate([i*l,j*l,k*l]) 
              koch_3D(side=l,maxside=maxside,level=level-1);
        }
   }
}
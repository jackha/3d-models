
/* Remaking of ExtruderNMisc-HuxleyTipClamp.stl
 *  TechZone Huxley hot end clamp part.
 * Totally libre, do whatever you want with that stuff
 *  as long you keep that header here and gimme credit.
 * -- 
 *     DeuxVis - device@ymail.com 
 *
 * Modified by Ketil Froyn for J-Head groove mount - 2012-10-21
 * Several positions were modified to align elements more closely to the 
 * original part from TechZone, by measuring and aligning in Blender.
*/

// added arbitrary rotation to improve display on thingiverse
rotate( [0, 0, 180] ) union() {
 difference() {
  // Base shape
  //cube( size = [73, 22, 10], center = false );
  // 3mm wider bridge to give it more strength when squeezing in a hotend
  translate( [0, -3, 0] ) cube( size = [73, 25, 10], center = false );

  // Thermal barrier hole
//  translate( [36.5, 11, 0] ) { cylinder( h = 10.2, r=8.5, $fs=.5 ); }
  translate( [36, 11, 0] ) { cylinder( h = 10.2, r=8.5, $fs=.5 ); }

  // Cut out side section of thermal barrier hole for groove mount
//   translate ([28, 11, -0.5]) cube (size = [17, 11, 11], center = false );
   translate ([27.5, 11, -0.5]) cube (size = [17, 11, 11], center = false );

  // 2 x M3 screws holes (bowden clamp and xcarriage assembly)
  translate( [5.75, 11, 0] ) cylinder( h = 10.1, r=1.7, $fs=.5 );
//  translate( [66.025, 11, 0] ) cylinder( h = 10.1, r=1.7, $fs=.5 );
  translate( [66.05, 11, 0] ) cylinder( h = 10.1, r=1.7, $fs=.5 );

  // translation found by comparing with original in openscad
  translate( [14.1, 22.5, 0] ) rotate( [90, 0, 0] ) cylinder(h = 23, r=5.5);

 }
 difference() {
  // base shape for groove mount inner edge
//  translate ([27.5, 0, 0]) cube( size = [18, 22, 4.64], center = false );
  translate ([27, 0, 0]) cube( size = [18, 22, 4.64], center = false );

  // hole for inner diameter of groove mount
//  translate( [36.5, 11, 0] ) cylinder( h = 10.2, r=6, $fs =.5);
  translate( [36, 11, 0] ) cylinder( h = 10.2, r=6, $fs =.5);

  // cut out side section of inner edge
//  translate( [30.5, 11, -0.5] ) cube ( size = [12, 11, 11], center = false );
  translate( [30, 11, -0.5] ) cube ( size = [12, 11, 11], center = false );
 }
}

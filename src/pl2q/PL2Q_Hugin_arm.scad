

light_blue = [0.30, 0.45, 0.90, 0.85];
light_green = [0.30, 0.95, 0.40, 0.85];
//arm_o_dia = 17.5;
arm_o_dia = 17.5;
arm_i_dia = 13.1;
arm_h     = 140.25;
spacing   = 5;
notch_l = 21.7;
connecting_notch_l = 17;
smudge = 0.1;


//different arm geometries
// cylinder 
//arm_o_face = 30;   //use 30 for cylinder, 6 for hexagon
//arm_o_rot  = 0;  //use 19 for 7 sides (septagon), use 15 for 6
//lay_flat_on_bed = -0.5;  //might be needed for different sided arms

// septagon 
arm_o_face = 11;   //use 30 for cylinder, 6 for hexagon
arm_o_rot  = 29.0;  //use 19 for 7 sides (septagon), use 15 for 6
lay_flat_on_bed = -0.85;  //might be needed for different sided arms

// octagon 
//arm_o_face = 8;   //use 30 for cylinder, 6 for hexagon
//arm_o_rot  = 22.5;  //use 19 for 7 sides (septagon), use 15 for 6
//lay_flat_on_bed = -0.90;  //might be needed for different sided arms

// heptagon
//arm_o_face = 7;   //use 30 for cylinder, 6 for hexagon
//arm_o_rot  = 19;  //use 19 for 7 sides (septagon), use 15 for 6
//lay_flat_on_bed = -0.9;  //might be needed for different sided arms

// hexagon
//arm_o_face = 6;   //use 30 for cylinder, 6 for hexagon
//arm_o_rot  = 15;  //use 19 for 7 sides (septagon), use 15 for 6
//lay_flat_on_bed = -1.25;  //might be needed for different sided arms

//arm A
//  translate and rotate for show
//  translate( [ 16.25, 0, arm_h - notch_l + 4])
//  rotate([ 0, 180, -90])
//  translate(-[ -(arm_o_dia/2) - (spacing/2), 0, 0] )


/*
color( light_green )
translate([ -(arm_o_dia/2) - (spacing/2), 0, 0] )
arm_with_tab(arm_o_dia, arm_i_dia, arm_h/2, 0);
*/


//arm B

/*
color( light_blue )
translate([ (arm_o_dia/2) + (spacing/2) + 5, 0, 0] )
arm_with_notches(arm_o_dia, arm_i_dia, arm_h/2, notch_l, connecting_notch_l, 1);
*/

//arm A+B in one
color( light_blue )

rotate([ 0, 0, -45] )
translate([ 0, arm_h/2, 0] )
difference() {
	translate([ 0, 0, (arm_o_dia/2 ) + lay_flat_on_bed] )
	rotate([ 90, 0, 0 ])
	rotate([ 0, 0, -135 ])
	arm_with_notches(arm_o_dia, arm_i_dia, arm_h, notch_l, notch_l, 1);

	translate([ 0, -arm_h/2, -arm_o_dia/4 ])
	cube( [arm_h/4, arm_h, arm_o_dia/2], true);
}


module arm_bare(od, id, h, faces=0) {
	difference() {
	rotate([ 0, 0, arm_o_rot])
	if (faces == 0) {
		cylinder(r=od/2, h=h, $fn=arm_o_face);
	} else {
		cylinder(r=od/2, h=h, $fn=faces);
	}
	translate ([ 0, 0, -1])
	cylinder(r=id/2, h=h+2, $fn=40);
	}
}

module arm_base_ring(od, id, h) {
	difference() {
	cylinder(r=od/2, h=h, $fn=30);
	translate ([ 0, 0, -1])
	rotate([ 0, 0, arm_o_rot])
	cylinder(r=id/2, h=h+2, $fn=arm_o_face);
	}
}


module arm_with_notches(od, id, h, notch1, notch2, ring=0) {


	difference() {
		union() {
		if (ring) {
			arm_base_ring( 25.5, od -0.2, 4.25);
		}
		arm_bare(od, id + smudge, h);
		}

		bottom_notch( notch2 , h-notch2);

		bottom_notch( notch1 + 4);

	}

}

module arm_with_tab(od, id, h, ring=0) {

	trans_l = 4;

	difference() {
		color([ .20, .30, .80, .70])
		union() {
		if (ring) {
			arm_base_ring( 25.5, od -0.2, 4.25);
		}

		arm_bare(od, id, h );

		translate( [0, 0, h ] )
		arm_bare(id - smudge , id-3, connecting_notch_l, 40);

		translate( [0, 0, h  - trans_l ] )
		difference() {
		cylinder(r1=(od-0.4)/2, r2=od/2, h=trans_l, $fn=20);
		translate( [0, 0, -0.1] )
		cylinder(r1=(od-0.4)/2, r2=(id-3)/2, h=trans_l+0.2, $fn=20);
		}
		}

		bottom_notch( notch_l + 4);
	}

		bottom_tab( connecting_notch_l , (h));
}

module bottom_tab(l, offset=0) {

	rotate([ 0, 0, 45])
	intersection() {
	translate([ 5.5, -2.75,  offset])
		cube( [ 3.3, 5.5, l  + 0.1] );
	translate([ 0, 0,  offset])
		cylinder( r=arm_o_dia/2, h=l, $fn=40);
	}
}

module bottom_notch(l, offset=0) {

	rotate([ 0, 0, 45])
	translate([ 5.5, -2.75,  offset])
	cube( [ 9, 5.5, l  + 0.1] );
}


//show_orig();

module show_orig() {
	color([ 0.85, 0.40, 0.45, 0.25])
	import(file="PL2Q_Hugin_arm_no_base_raft.stl");
}


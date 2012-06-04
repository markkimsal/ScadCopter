

light_blue = [0.30, 0.45, 0.90, 0.85];
light_green = [0.30, 0.95, 0.40, 0.85];
arm_o_dia = 17.5;
arm_i_dia = 13.5;
arm_h     = 140.25;
spacing   = 5;
notch_l = 21.7;
smudge = 0.1;

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
arm_with_notches(arm_o_dia, arm_i_dia, arm_h/2, 1);
*/

//arm A+B in one
color( light_blue )

rotate([ 0, 0, 45] )
translate([ 0, arm_h/2, 0] )
difference() {
translate([ 0, 0, arm_o_dia/2] )
rotate([ 90, 0, 0 ])
rotate([ 0, 0, -135 ])
arm_with_notches(arm_o_dia, arm_i_dia, arm_h, 1);

translate([ 0, 0, -arm_o_dia/4])
cube( [arm_h, arm_h, arm_o_dia/2], true);
}


module arm_bare(od, id, h) {
	difference() {
	cylinder(r=od/2, h=h, $fn=40);
	translate ([ 0, 0, -1])
	cylinder(r=id/2, h=h+2, $fn=40);
	}
}

module arm_with_notches(od, id, h, ring=0) {


	difference() {
		union() {
		if (ring) {
			arm_bare( 25.5, od -0.2, 4.25);
		}
		arm_bare(od, id + smudge, h);
		}

		bottom_notch( notch_l , h-notch_l);

		bottom_notch( notch_l + 4);

	}

}

module arm_with_tab(od, id, h, ring=0) {

	trans_l = 4;

	difference() {
		color([ .20, .30, .80, .70])
		union() {
		if (ring) {
			arm_bare( 25.5, od -0.2, 4.25);
		}

		arm_bare(od, id, h - notch_l);

		translate( [0, 0, h - notch_l] )
		arm_bare(id - smudge , id-3, notch_l);

		translate( [0, 0, h - notch_l - trans_l ] )
		difference() {
		cylinder(r1=(od-0.4)/2, r2=od/2, h=trans_l, $fn=20);
		translate( [0, 0, -0.1] )
		cylinder(r1=(od-0.4)/2, r2=(id-3)/2, h=trans_l+0.2, $fn=20);
		}
		}

		bottom_notch( notch_l + 4);
	}

		bottom_tab( notch_l , (h)-notch_l);
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


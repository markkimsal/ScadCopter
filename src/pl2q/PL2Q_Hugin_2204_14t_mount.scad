
2204_14t_dia = 27.75;
hk_810_10a_l = 37.0;
hk_810_10a_w = 19.0;

motor_cup_dia = 2204_14t_dia + .10;
motor_cup_th  = 2.0;
esc_w = hk_810_10a_w;
esc_l = hk_810_10a_l + 3 + 2;

tab_width = 6 + 0.3;



color([ .50, .63, .93 , 0.90])
//translate( [ 37.45, 0, 5.0])
translate( [ (esc_l/2) + (motor_cup_dia/2), 0, 5.0])
2204_cup();


color([ .50, .63, .93 , 0.90])
translate( [ -(esc_l/2), 0, 8.75])
esc_arm();

color([ .50, .63, .93 , 0.90])
translate( [ -(esc_l/2) - 20, 0, 8.8])
connector();


//old modifications to original
//tab_holes();
//color([ 0.55, 0.40, 0.45, 0.60])
//tab_holders();
//wider_hole();

//show_orig();

//add pad to prevent curling
color([ .50, .63, .93 , 0.60])
translate( [-46, 0, 0.20])
cylinder(r=12, h=0.25, center=true) ;



module connector() {

	difference() {
		rotate([ 0, 90, 0])
		cylinder(r=6.5, h=20);

		translate( [-1, 0, 0])
		rotate([ 0, 90, 0])
		cylinder(r=5.05, h=20 + 2);

	}

	block_h =3;
	intersection() {
		translate([ 7 + ( 10 - (7/2)) ,  0 ,  (-6.5) - block_h/4 ] )
		//translate([ 7.5 + 7  ,  0 ,  (-6.5) - block_h/4 ] )
		cube( [14, 5, block_h], center=true);

		rotate([ 0, 90, 0])
		cylinder(r=8.75, h=esc_l, $fn=64);
	}

}

module esc_arm() {
	
	difference() {
		rotate([ 0, 90, 0])
		cylinder(r=8.75, h=esc_l, $fn=64);

		translate( [-1, 0, 0])
		rotate([ 0, 90, 0])
		cylinder(r=5.5, h=esc_l + 2);

		translate([ (esc_l/2)-0.5, 0, (4.5/2) + 3.0])
		cube([ esc_l - 5, esc_w , 9 + 4], center=true);
	}

}

module 2204_cup() {

	m_cup_r = motor_cup_dia/2;
	m_cup_th = motor_cup_th;
	difference() {
		union() {
		cylinder(r=m_cup_r + m_cup_th, h=15, $fn=24);

		translate([ 0, 0, 15])
		cylinder(r1=m_cup_r + m_cup_th, r2=m_cup_r + 1.0, h=2, $fn=24);

		translate([ 0, 0, -5])
		cylinder(r2=m_cup_r + m_cup_th, r1=m_cup_r , h=5, $fn=24);
		}

		translate([ 0, 0, -1.75] )
		cylinder(r=m_cup_r, h=24, $fn=24);

		//cable door
		translate( [-m_cup_r - m_cup_th, 0, 3.75])
		rotate([ 0, 90, 0])
		cylinder(r=5.5, h=5);


		tab_holes();

		//cable allowance
//		translate([ - m_cup_r + 0.5, 0, 10])
//		cylinder( r=2, h=10);
	}

	tab_holders();
}

module show_orig() {

//	translate([ 0, 1.3, 0])
	color([ 0.85, 0.40, 0.45, 0.35])
	import(file="PL2Q_Hugin_motormount.stl");
}



//widen hole
module wider_hole() {
	translate( [ -40, 0, 8.5])
	rotate([ 0, 90, 0])
	color([ .90, .33, .33 , .60])
	cylinder(r=4.5, h=30);

	translate( [ 17, 0, 9.0])
	rotate([ 0, 90, 0])
	color([ .90, .33, .33 , .60])
	cylinder(r=5.5, h=10);

	translate( [ 37.45, 0, 9.0])
	rotate([ 0, 0, -6])
	color([ .80, .23, .73 , .50])
	cylinder(r=15.275, h=15, $fn=24);


}

//subtract holes
module tab_holes() {

	center_of_mount = [0, 0, 15.0];

	translate( center_of_mount)
	rotate([ 0, 0, 45])
	//color([ 0.45, 0.10, 0.90, 0.30])
	cube([50, tab_width, 6], true);

	translate( center_of_mount)
	rotate([ 0, 0, -45])
	//color([ 0.45, 0.10, 0.90, 0.30])
	cube([50, tab_width, 6], true);

}


module tab_holders() {
	center_of_mount = [0, 0, 09.0];


	translate( center_of_mount )
	rotate(135, [0,0,1])
	translate( [(2204_14t_dia/2 - motor_cup_th -0.5)  + 5.5, 0, 0])
	motor_tab();

	translate( center_of_mount )
	rotate(-135, [0,0,1])
	translate( [(2204_14t_dia/2 - motor_cup_th -0.5)  + 5.5, 0, 0])
	motor_tab();



	translate( center_of_mount )
	rotate(45, [0,0,1])
	translate( - center_of_mount )
	translate( center_of_mount )
	translate( [(2204_14t_dia/2 - motor_cup_th -0.5)  + 5.5, 0, 0])
	motor_tab();

	translate( center_of_mount )
	rotate(-45, [0,0,1])
	translate( - center_of_mount )
	translate( center_of_mount )
	translate( [(2204_14t_dia/2 - motor_cup_th -0.5)  + 5.5, 0, 0])
	motor_tab();
}


module motor_tab() {
	difference() {

		cube([6 - motor_cup_th, tab_width, 6], true);

		translate( [6.5, -6, -8.3])
		rotate([ 0, 90, 90])
		cylinder(r=10, h=10);

/*
		translate( [-13.0, -6, -7])
		rotate([ 0, 90, 90])
		cylinder(r=11, h=10);
*/

/*
		translate( [0, 0, -5])
		cube([6, 6, 6], true);
*/

	}
}

/*
	Author: Michal Majercik <majermi6@fit.cvut.cz>
	Parametric box model
*/

module box_prototype ( x=30, y=30, rad=15, h=8, r=15 ){
	x_pos=(x-2*rad)/2; // x coordinate of center of corner cylinder
	y_pos=(y-2*rad)/2; // y coordinate

	if( r<=0 ){
		cube ( size=[x, y, h], center=true ); // in case of rad <=0, the corner is rectangular
	} else {
		hull(){ // draw 4 cylinders and hull them
			translate( [x_pos, y_pos, 0] )
			cylinder( h=h, r=r, center=true );

			translate( [-x_pos, y_pos, 0] )
			cylinder( h=h, r=r, center=true );

			translate( [x_pos, -y_pos, 0] )
			cylinder( h=h, r=r, center=true );

			translate( [-x_pos, -y_pos, 0] )
			cylinder( h=h, r=r, center=true );
		}
	}
}

module box_bottom( x=30, y=30, z1=5, rad=15, 
				 		 wall_thick=2, lock_z=2, reserve=0 ){
	difference(){
		box_prototype( x, y, rad, z1, rad+wall_thick ); // outer shell of the box
		translate( [0, 0, wall_thick/2] ) // move the cut part up
			box_prototype( x, y, rad, z1-wall_thick, rad ); // cut the inner shell
		translate( [0, 0, (z1-lock_z)/2] ) // move the tooth
			box_prototype( x, y, rad, lock_z, rad+wall_thick/2+reserve/2 ); // cut it
	}
}


module box_top( x=30, y=30, z2=5, rad=15, 
				 	 wall_thick=2, lock_z=2, reserve=0 ){
	difference(){
		box_prototype( x, y, rad, z2, rad+wall_thick ); // outer shell of the box
		translate( [0, 0, -wall_thick/2] ) // keep the top
			box_prototype( x, y, rad, z2-wall_thick, rad ); // cut the inside shell
	}
	translate( [0, 0, -((z2+lock_z)/2)] ) // the tooth
		difference(){
			box_prototype( x, y, rad, lock_z, rad+wall_thick/2-reserve/2 );
			box_prototype( x, y, rad, lock_z, rad );
		}
}


module box ( x=30, y=30, z1=10, z2=5, rad=15, 
				 wall_thick=2, lock_z=2, reserve=1.5, 
				 to_print=true, print_space=5 ){
	// input corrections
	max_rad= x/2>y/2 ? y/2 : x/2;
	rad= rad>max_rad ? max_rad : (rad>0 ? rad : 0); // max radius
	z1= z1>=(wall_thick+lock_z) ? z1 : wall_thick+lock_z; // set z1 to correct size in case z1<=wall_thick+lock_z
	z2= z2>=wall_thick ? z2 : wall_thick; // set z2 ...
	reserve= reserve>=0 ? reserve : 0; // in case reserve<0
	lock_z= lock_z>=0 ? lock_z : 0;  // ...
	
	if( x>0 && y>0 && wall_thick>0 ){ // render the parts
		if( to_print == false){ // on the top of each other
			translate( [0, 0, z1/2] )
				box_bottom( x, y, z1, rad, wall_thick, lock_z, reserve );
			translate( [0, 0, z1+z2/2+reserve] )
				box_top( x, y, z2, rad, wall_thick, lock_z, reserve );
		}
		else{ // next to each other
			translate( [x/2+wall_thick+print_space/2, 0, z1/2] )
				box_bottom( x, y, z1, rad, wall_thick, lock_z, reserve );
			rotate( [180,0,0] )
				translate( [-(x/2+wall_thick+print_space/2), 0, -(z2/2)] )
					box_top( x, y, z2, rad, wall_thick, lock_z, reserve );
		}
	}
}

box( 
x=30, 
y=30, 
z1=10, 
z2=5, 
rad=15, 
wall_thick=2, 
lock_z=2, 
reserve=1.5, 
to_print=true, 
print_space=5 
);

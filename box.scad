/*
	Autor: Michal Majercik <majermi6@fit.cvut.cz>
	Parametricky model krabicky
*/

module box_prototype ( x=30, y=30, rad=15, h=8, r=15 ){
	x_pos=(x-2*rad)/2; // x-ova suradnica centra valca tvoriaceho roh krabicky
	y_pos=(y-2*rad)/2; // y-ova suradnica ...

	if( r<=0 ){
		cube ( size=[x, y, h], center=true ); // v pripade rad <=0 je roh pravouhly
	} else {
		hull(){ // vykresli 4 krajne valce a potom to "ohulli"
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
		box_prototype( x, y, rad, z1, rad+wall_thick ); // vytvori "vonkajsi obal" krabicky
		translate( [0, 0, wall_thick/2] ) // posunutie vyrezu vyssie
			box_prototype( x, y, rad, z1-wall_thick, rad ); // vyreze vnutro
		translate( [0, 0, (z1-lock_z)/2] ) // posunutie zubu na okraj
			box_prototype( x, y, rad, lock_z, rad+wall_thick/2+reserve/2 ); // vyreze zub
	}
}


module box_top( x=30, y=30, z2=5, rad=15, 
				 	 wall_thick=2, lock_z=2, reserve=0 ){
	difference(){
		box_prototype( x, y, rad, z2, rad+wall_thick ); // vytvori "vonkajsi obal" krabicky
		translate( [0, 0, -wall_thick/2] ) // necha dno
			box_prototype( x, y, rad, z2-wall_thick, rad ); // "vyreze" vnutro
	}
	translate( [0, 0, -((z2+lock_z)/2)] ) // vytvori zub
		difference(){
			box_prototype( x, y, rad, lock_z, rad+wall_thick/2-reserve/2 );
			box_prototype( x, y, rad, lock_z, rad );
		}
}


module box ( x=30, y=30, z1=10, z2=5, rad=15, 
				 wall_thick=2, lock_z=2, reserve=1.5, 
				 to_print=true, print_space=5 ){
	// spravne nastavenie premennych
	max_rad= x/2>y/2 ? y/2 : x/2;
	rad= rad>max_rad ? max_rad : (rad>0 ? rad : 0); // vypocet max radiusu
	z1= z1>=(wall_thick+lock_z) ? z1 : wall_thick+lock_z; // nastavenie z1 na odpovedajucu velkost v pripade ze z1<=wall_thick+lock_z
	z2= z2>=wall_thick ? z2 : wall_thick; // nastavenie z2 ...
	reserve= reserve>=0 ? reserve : 0; // pripad ze reserve<0
	lock_z= lock_z>=0 ? lock_z : 0;  // ...
	
	if( x>0 && y>0 && wall_thick>0 ){ // pripad kedy sa krabicky vykresluju
		if( to_print == false){ // nad sebou
			translate( [0, 0, z1/2] )
				box_bottom( x, y, z1, rad, wall_thick, lock_z, reserve );
			translate( [0, 0, z1+z2/2+reserve] )
				box_top( x, y, z2, rad, wall_thick, lock_z, reserve );
		}
		else{ // vedla seba
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
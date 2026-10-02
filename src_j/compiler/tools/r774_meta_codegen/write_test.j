extern fn jj_raw_write(fd:i64,p:*i8,n:i64)->i64;
fn j_main(argc:i64,argv:*i64)->i64{var nl:[1]i64;nl[0]=10;if jj_raw_write(1,"HELLO",5)!=5{return 2;}if jj_raw_write(1,nl as *i8,1)!=1{return 3;}return 0;}

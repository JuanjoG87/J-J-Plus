// Shared bounded ELF32 extraction helpers for target executable seeds.
fn jj_e32_rd16(p:*i8)->i64{if p==0{return 0;}return (p[0]&255)|((p[1]&255)<<8);}
fn jj_e32_rd32(p:*i8)->i64{if p==0{return 0;}return (p[0]&255)|((p[1]&255)<<8)|((p[2]&255)<<16)|((p[3]&255)<<24);}
fn jj_e32_copy(dst:*i8,capacity:i64,at:i64,src:*i8,count:i64)->i64{
 if dst==0{return 0;}if src==0{return 0;}if at<0{return 0;}if count<=0{return 0;}if at>capacity-count{return 0;}
 var i:i64=0;while i<count{dst[at+i]=(src[i]&255) as i8;i=i+1;}return at+count;
}
fn jj_e32_object_text(object:*i8,size:i64,machine:i64,view:*i64)->i64{
 if object==0{return 0;}if view==0{return 0;}if size<252{return 0;}
 if object[0]!=0x7f{return 0;}if object[1]!=69{return 0;}if object[2]!=76{return 0;}if object[3]!=70{return 0;}if object[4]!=1{return 0;}if object[5]!=1{return 0;}
 if jj_e32_rd16(object+16)!=1{return 0;}if jj_e32_rd16(object+18)!=machine{return 0;}var shoff:i64=jj_e32_rd32(object+32);
 if jj_e32_rd16(object+46)!=40{return 0;}if jj_e32_rd16(object+48)!=5{return 0;}if jj_e32_rd16(object+50)!=4{return 0;}if shoff<=0{return 0;}if shoff>size-200{return 0;}
 var text:*i8=object+shoff+40;if jj_e32_rd32(text+4)!=1{return 0;}if jj_e32_rd32(text+8)!=6{return 0;}var offset:i64=jj_e32_rd32(text+16);var count:i64=jj_e32_rd32(text+20);
 if offset<52{return 0;}if count<=0{return 0;}if offset>size-count{return 0;}if machine==40{if (count&3)!=0{return 0;}}else{if machine!=3{return 0;}}
 view[0]=offset;view[1]=count;view[2]=offset^count^size^(machine<<32)^0x454c463332544558;view[3]=0;return 1;
}

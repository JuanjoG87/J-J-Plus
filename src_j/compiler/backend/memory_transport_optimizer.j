extern fn jj_rc_mto_get(p0:*i64,p1:i64)->i64;
extern fn jj_rc_affine_get(p0:*i64,p1:i64)->i64;
extern fn jj_reo_nop(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_reo_nop_match(p0:*i8,p1:i64,p2:i64)->i64;

fn jj_mto_s32(v:i64)->i64{var lo:i64=v&0xffffffff;if lo>=0x80000000{return lo-0x100000000;}return lo;}
fn jj_mto_rd32(p:*i8)->i64{return (p[0]&255)|((p[1]&255)<<8)|((p[2]&255)<<16)|((p[3]&255)<<24);}
fn jj_mto_wr32(p:*i8,v:i64)->i64{var i:i64=0;while i<4{p[i]=v>>>(i*8);i=i+1;}return 1;}
fn jj_mto_slot_from_disp(v:i64)->i64{var d:i64=jj_mto_s32(v);if d>=0{return 0-1;}if (0-d)%8!=0{return 0-1;}var slot:i64=(0-d)/8-1;if slot<0{return 0-1;}if slot>32767{return 0-1;}return slot;}
fn jj_mto_marker(p:*i8,at:i64,value:i64)->i64{p[at]=0x0f;p[at+1]=0x1f;p[at+2]=0x44;p[at+3]=0;p[at+4]=value;return 1;}
fn jj_mto_same_local(a:i64,b:i64)->i64{if a<0{return 0;}if b<0{return 0;}if a>32767{return 0;}if b>32767{return 0;}if a!=b{return 0;}return 1;}
fn jj_mto_store_shape(code:*i8,at:i64)->i64{if code[at]!=0x58{return 0-1;}if code[at+1]!=0x48{return 0-1;}if (code[at+2]&255)!=0x89{return 0-1;}if (code[at+3]&255)!=0x85{return 0-1;}return jj_mto_slot_from_disp(jj_mto_rd32(code+at+4));}
fn jj_mto_load_shape(code:*i8,at:i64)->i64{if (code[at]&255)!=0xff{return 0-1;}if (code[at+1]&255)!=0xb5{return 0-1;}return jj_mto_slot_from_disp(jj_mto_rd32(code+at+2));}
fn jj_mto_moved_load_shape(code:*i8,at:i64)->i64{if code[at]!=0x48{return 0-1;}if (code[at+1]&255)!=0x8b{return 0-1;}if (code[at+2]&255)!=0x85{return 0-1;}return jj_mto_slot_from_disp(jj_mto_rd32(code+at+3));}
fn jj_mto_moved_store_shape(code:*i8,at:i64)->i64{if code[at]!=0x48{return 0-1;}if (code[at+1]&255)!=0x89{return 0-1;}if (code[at+2]&255)!=0x85{return 0-1;}return jj_mto_slot_from_disp(jj_mto_rd32(code+at+3));}

// 1 store->load forwarding, 2 repeated load, 3 dead overwritten store,
// 4 load->same-store roundtrip elimination.
fn jj_mto_try_pair(code:*i8,end:i64,previous_at:i64,current_at:i64,classes:i64,targets:i64)->i64{
 if code==0{return 0-1;}var previous_op:i64=classes&255;var op:i64=(classes>>>8)&255;if previous_at<0{return 0;}if current_at<=previous_at{return 0;}if end<=current_at{return 0;}if targets!=0{return 0;}
 if previous_op==3{if op==2{if current_at!=previous_at+8{return 0;}if end-current_at<6{return 0;}var a:i64=jj_mto_store_shape(code,previous_at);var b:i64=jj_mto_load_shape(code,current_at);if a<0{return 0;}if b<0{return 0;}if jj_mto_same_local(a,b)==0{return 0;}if a>15{return 0;}var da:i64=(0-((a+1)*8))&255;code[previous_at]=0x58;code[previous_at+1]=0x48;code[previous_at+2]=0x89;code[previous_at+3]=0x45;code[previous_at+4]=da;code[previous_at+5]=0x50;if jj_mto_marker(code,previous_at+6,0x60)==0{return 0-1;}if jj_reo_nop(code,previous_at+11,previous_at+14)==0{return 0-1;}return 1;}}
 if previous_op==2{if op==2{if current_at!=previous_at+6{return 0;}if end-current_at<6{return 0;}var a2:i64=jj_mto_load_shape(code,previous_at);var b2:i64=jj_mto_load_shape(code,current_at);if a2<0{return 0;}if b2<0{return 0;}if jj_mto_same_local(a2,b2)==0{return 0;}if a2>15{return 0;}var db:i64=(0-((a2+1)*8))&255;code[previous_at]=0x48;code[previous_at+1]=0x8b;code[previous_at+2]=0x45;code[previous_at+3]=db;code[previous_at+4]=0x50;code[previous_at+5]=0x50;if jj_mto_marker(code,previous_at+6,0x61)==0{return 0-1;}if jj_reo_nop(code,previous_at+11,previous_at+12)==0{return 0-1;}return 2;}}
 if previous_op==3{if op==3{if current_at!=previous_at+8{return 0;}if end-current_at<8{return 0;}var a3:i64=jj_mto_store_shape(code,previous_at);var b3:i64=jj_mto_store_shape(code,current_at);if a3<0{return 0;}if b3<0{return 0;}if jj_mto_same_local(a3,b3)==0{return 0;}if a3>15{return 0;}var dc:i64=(0-((a3+1)*8))&255;code[previous_at]=0x58;code[previous_at+1]=0x58;code[previous_at+2]=0x48;code[previous_at+3]=0x89;code[previous_at+4]=0x45;code[previous_at+5]=dc;if jj_mto_marker(code,previous_at+6,0x62)==0{return 0-1;}if jj_reo_nop(code,previous_at+11,previous_at+16)==0{return 0-1;}return 3;}}
 if previous_op==2{if op==3{if current_at!=previous_at+6{return 0;}if end-current_at<8{return 0;}var a4:i64=jj_mto_moved_load_shape(code,previous_at);var b4:i64=jj_mto_moved_store_shape(code,previous_at+7);if a4<0{return 0;}if b4<0{return 0;}if jj_mto_same_local(a4,b4)==0{return 0;}code[previous_at]=0x90;if jj_mto_marker(code,previous_at+1,0x63)==0{return 0-1;}if jj_reo_nop(code,previous_at+6,previous_at+14)==0{return 0-1;}return 4;}}
 return 0;
}

// Four-record bounded history for exact local induction. Records are
// opcode, bytecode pc, machine offset and target census.
fn jj_mto_bc_rd16(p:*i8)->i64{return (p[0]&255)|((p[1]&255)<<8);}
fn jj_mto_bc_rd64(p:*i8)->i64{var v:i64=0;var i:i64=0;while i<8{v=v|((p[i]&255)<<(i*8));i=i+1;}return v;}
fn jj_mto_increment_old_shape(code:*i8,begin:i64,end:i64,slot:i64,step:i64)->i64{
 if code==0{return 0;}if begin<0{return 0;}if end-begin!=31{return 0;}if slot<0{return 0;}if slot>15{return 0;}if step<1{return 0;}if step>127{return 0;}var d:i64=0-((slot+1)*8);var lo:i64=d&0xffffffff;
 if code[begin]!=0x48{return 0;}if (code[begin+1]&255)!=0x8b{return 0;}if (code[begin+2]&255)!=0x85{return 0;}if jj_mto_rd32(code+begin+3)!=lo{return 0;}
 if code[begin+7]!=0x48{return 0;}if (code[begin+8]&255)!=0x81{return 0;}if (code[begin+9]&255)!=0xc0{return 0;}if jj_mto_rd32(code+begin+10)!=step{return 0;}if code[begin+14]!=0x50{return 0;}
 if code[begin+23]!=0x58{return 0;}if code[begin+24]!=0x48{return 0;}if (code[begin+25]&255)!=0x89{return 0;}if (code[begin+26]&255)!=0x85{return 0;}if jj_mto_rd32(code+begin+27)!=lo{return 0;}return 1;
}
fn jj_mto_try_increment(code:*i8,end:i64,program:*i8,h:*i64)->i64{
 if code==0{return 0-1;}if program==0{return 0-1;}if h==0{return 0-1;}if jj_rc_mto_get(h,0)!=2{return 0;}if jj_rc_mto_get(h,4)!=1{return 0;}if jj_rc_mto_get(h,8)!=9{return 0;}if jj_rc_mto_get(h,12)!=3{return 0;}if (jj_rc_mto_get(h,3)|jj_rc_mto_get(h,7)|jj_rc_mto_get(h,11)|jj_rc_mto_get(h,15))!=0{return 0;}var begin:i64=jj_rc_mto_get(h,2);var finish:i64=jj_rc_mto_get(h,14)+8;if begin<0{return 0;}if finish>end{return 0;}if finish-begin!=31{return 0;}
 var load_pc:i64=jj_rc_mto_get(h,1);var const_pc:i64=jj_rc_mto_get(h,5);var store_pc:i64=jj_rc_mto_get(h,13);if load_pc<0{return 0;}if const_pc<0{return 0;}if store_pc<0{return 0;}if program[load_pc]!=2{return 0;}if program[const_pc]!=1{return 0;}if program[store_pc]!=3{return 0;}var step:i64=jj_mto_bc_rd64(program+const_pc+1);if step<1{return 0;}if step>127{return 0;}var load_slot:i64=jj_mto_bc_rd16(program+load_pc+1);var store_slot:i64=jj_mto_bc_rd16(program+store_pc+1);if jj_mto_same_local(load_slot,store_slot)==0{return 0;}if load_slot>15{return 0;}if jj_mto_increment_old_shape(code,begin,finish,load_slot,step)==0{return 0;}
 var disp:i64=(0-((load_slot+1)*8))&255;code[begin]=0x48;code[begin+1]=0x83;code[begin+2]=0x45;code[begin+3]=disp;code[begin+4]=step;if jj_mto_marker(code,begin+5,0x64)==0{return 0-1;}if jj_reo_nop(code,begin+10,finish)==0{return 0-1;}return 5;
}

// Six-operation exact indexed u64 load:
// local base, local index, constant 8, multiply, add, load64.
// The rewrite keeps stack semantics and authenticates the SIB geometry.
fn jj_mto_try_indexed_load64(code:*i8,end:i64,program:*i8,h:*i64)->i64{
 if code==0{return 0-1;}if program==0{return 0-1;}if h==0{return 0-1;}
 if jj_rc_affine_get(h,20)!=2{return 0;}if jj_rc_affine_get(h,24)!=2{return 0;}if jj_rc_affine_get(h,28)!=1{return 0;}if jj_rc_affine_get(h,32)!=11{return 0;}if jj_rc_affine_get(h,36)!=9{return 0;}if jj_rc_affine_get(h,40)!=6{return 0;}var i:i64=0;while i<6{var at:i64=20+i*4;if jj_rc_affine_get(h,at+3)!=0{return 0;}i=i+1;}
 var begin:i64=jj_rc_affine_get(h,22);var index_at:i64=jj_rc_affine_get(h,26);var constant_at:i64=jj_rc_affine_get(h,30);var multiply_at:i64=jj_rc_affine_get(h,34);var add_at:i64=jj_rc_affine_get(h,38);var load_at:i64=jj_rc_affine_get(h,42);
 if begin<0{return 0;}if index_at!=begin+6{return 0;}if constant_at!=index_at+6{return 0;}if multiply_at!=constant_at+11{return 0;}if add_at!=multiply_at+7{return 0;}if load_at!=add_at+6{return 0;}if end!=load_at+6{return 0;}
 var constant_pc:i64=jj_rc_affine_get(h,29);if constant_pc<0{return 0;}if program[constant_pc]!=1{return 0;}if jj_mto_bc_rd64(program+constant_pc+1)!=8{return 0;}
 if (code[begin]&255)!=0xff{return 0;}if (code[begin+1]&255)!=0xb5{return 0;}var base_slot:i64=jj_mto_slot_from_disp(jj_mto_rd32(code+begin+2));if base_slot<0{return 0;}
 if code[index_at]!=0x48{return 0;}if (code[index_at+1]&255)!=0x8b{return 0;}if (code[index_at+2]&255)!=0x85{return 0;}var index_slot:i64=jj_mto_slot_from_disp(jj_mto_rd32(code+index_at+3));if index_slot<0{return 0;}if base_slot==index_slot{return 0;}
 if code[index_at+7]!=0x48{return 0;}if (code[index_at+8]&255)!=0xc1{return 0;}if (code[index_at+9]&255)!=0xe0{return 0;}if code[index_at+10]!=3{return 0;}if code[index_at+11]!=0x50{return 0;}if jj_reo_nop_match(code,index_at+12,add_at)==0{return 0;}
 if code[add_at]!=0x59{return 0;}if code[add_at+1]!=0x58{return 0;}if code[add_at+2]!=0x48{return 0;}if code[add_at+3]!=0x01{return 0;}if (code[add_at+4]&255)!=0xc8{return 0;}if jj_reo_nop_match(code,add_at+5,load_at+1)==0{return 0;}
 if code[load_at+1]!=0x48{return 0;}if (code[load_at+2]&255)!=0x8b{return 0;}if code[load_at+3]!=0{return 0;}if code[load_at+4]!=0x50{return 0;}if code[load_at+5]!=0x90{return 0;}
 var bd:i64=jj_mto_rd32(code+begin+2);var id:i64=jj_mto_rd32(code+index_at+3);
 code[begin]=0x48;code[begin+1]=0x8b;code[begin+2]=0x85;jj_mto_wr32(code+begin+3,bd);
 code[begin+7]=0x48;code[begin+8]=0x8b;code[begin+9]=0x8d;jj_mto_wr32(code+begin+10,id);
 code[begin+14]=0x48;code[begin+15]=0x8b;code[begin+16]=0x04;code[begin+17]=0xc8;code[begin+18]=0x50;
 if jj_mto_marker(code,begin+19,0x65)==0{return 0-1;}if jj_reo_nop(code,begin+24,end)==0{return 0-1;}return 6;
}


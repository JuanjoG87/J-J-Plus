// jj_file: src_j/compiler/backend/reaction_block_address_store.j
// block plan extends the bounded address-store reaction local-array store with block-local RangeFacts.
extern fn jj_rc_history_get(p0:*i64,p1:i64)->i64;
extern fn jj_vm_rd16(p0:*i8)->i64;
extern fn jj_vm_rd32(p0:*i8)->i64;
extern fn jj_vm_rd64(p0:*i8)->i64;
extern fn jj_reo_wr32(p0:*i8,p1:i64)->i64;
extern fn jj_reo_nop(p0:*i8,p1:i64,p2:i64)->i64;

fn jj_rbas_proof_tail(code:*i8,end:i64,range_max:i64,bound:i64,marker:i64)->i64{
  if code==0{return 0;}if end<21{return 0;}var at:i64=end-21;code[at]=0x0f;code[at+1]=0x1f;code[at+2]=0x84;code[at+3]=0;if jj_reo_wr32(code+at+4,range_max)==0{return 0;}at=at+8;code[at]=0x0f;code[at+1]=0x1f;code[at+2]=0x84;code[at+3]=0;if jj_reo_wr32(code+at+4,bound)==0{return 0;}code[end-5]=0x0f;code[end-4]=0x1f;code[end-3]=0x44;code[end-2]=0;code[end-1]=marker;return 1;
}

fn jj_rbas_emit(code:*i8,begin:i64,end:i64,d:*i64)->i64{
  if code==0{return 0;}if d==0{return 0;}var array_slot:i64=d[0];var bound:i64=d[1];var index_slot:i64=d[2];var value_slot:i64=d[3];var fail_at:i64=d[4];var entry_target:i64=d[5];var range_max:i64=d[6];if begin<0{return 0;}if end-begin!=72{return 0;}if array_slot<0{return 0;}if index_slot<0{return 0;}if value_slot<0{return 0;}if bound<=0{return 0;}if bound>0x7fffffff{return 0;}if array_slot>32767{return 0;}if index_slot>32767{return 0;}if value_slot>32767{return 0;}if array_slot+bound>32768{return 0;}if fail_at<=end{return 0;}if entry_target<0{return 0;}if entry_target>1{return 0;}
  var at:i64=begin;code[at]=0x48;code[at+1]=0x8b;code[at+2]=0x85;if jj_reo_wr32(code+at+3,0-((index_slot+1)*8))==0{return 0;}at=at+7;
  if range_max>=0{
    if range_max>=bound{return 0;}code[at]=0x48;code[at+1]=0x8b;code[at+2]=0x8d;if jj_reo_wr32(code+at+3,0-((value_slot+1)*8))==0{return 0;}at=at+7;code[at]=0x48;code[at+1]=0x89;code[at+2]=0x8c;code[at+3]=0xc5;if jj_reo_wr32(code+at+4,0-((array_slot+bound)*8))==0{return 0;}at=at+8;if end-at<23{return 0;}var skip:i64=end-(at+2);if skip<0{return 0;}if skip>127{return 0;}code[at]=0xeb;code[at+1]=skip;at=at+2;if jj_reo_nop(code,at,end-21)==0{return 0;}var marker:i64=0x47;if entry_target!=0{marker=0x48;}return jj_rbas_proof_tail(code,end,range_max,bound,marker);
  }
  code[at]=0x48;code[at+1]=0x85;code[at+2]=0xc0;at=at+3;code[at]=0x0f;code[at+1]=0x88;if jj_reo_wr32(code+at+2,fail_at-(at+6))==0{return 0;}at=at+6;code[at]=0x48;code[at+1]=0x3d;if jj_reo_wr32(code+at+2,bound)==0{return 0;}at=at+6;code[at]=0x0f;code[at+1]=0x83;if jj_reo_wr32(code+at+2,fail_at-(at+6))==0{return 0;}at=at+6;code[at]=0x48;code[at+1]=0x8b;code[at+2]=0x8d;if jj_reo_wr32(code+at+3,0-((value_slot+1)*8))==0{return 0;}at=at+7;code[at]=0x48;code[at+1]=0x89;code[at+2]=0x8c;code[at+3]=0xc5;if jj_reo_wr32(code+at+4,0-((array_slot+bound)*8))==0{return 0;}at=at+8;if end-at<5{return 0;}if jj_reo_nop(code,at,end-5)==0{return 0;}code[end-5]=0x0f;code[end-4]=0x1f;code[end-3]=0x44;code[end-2]=0;if entry_target==0{code[end-1]=0x42;}else{code[end-1]=0x44;}return 1;
}

fn jj_rbas_try_history(code:*i8,end:i64,program:*i8,h:*i64,receipts:*i64,fail_at:i64)->i64{
  if code==0{return 0-1;}if program==0{return 0-1;}if h==0{return 0-1;}if receipts==0{return 0-1;}var range_max:i64=receipts[3];if jj_rc_history_get(h,49)!=4{return 0;}if jj_rc_history_get(h,56)!=2{return 0;}if jj_rc_history_get(h,63)!=45{return 0;}if jj_rc_history_get(h,70)!=1{return 0;}if jj_rc_history_get(h,77)!=11{return 0;}if jj_rc_history_get(h,84)!=9{return 0;}if jj_rc_history_get(h,91)!=2{return 0;}if jj_rc_history_get(h,98)!=8{return 0;}
  var entry_target:i64=jj_rc_history_get(h,52);if entry_target<0{return 0-1;}if entry_target>1{return 0-1;}var i:i64=8;while i<15{if jj_rc_history_get(h,i*7+3)!=0{return 0;}i=i+1;}var array_pc:i64=jj_rc_history_get(h,50);var index_pc:i64=jj_rc_history_get(h,57);var bound_pc:i64=jj_rc_history_get(h,64);var scale_pc:i64=jj_rc_history_get(h,71);var value_pc:i64=jj_rc_history_get(h,92);if array_pc<0{return 0-1;}if index_pc<0{return 0-1;}if bound_pc<0{return 0-1;}if scale_pc<0{return 0-1;}if value_pc<0{return 0-1;}
  var array_slot:i64=jj_vm_rd16(program+array_pc+1);var array_count:i64=jj_vm_rd16(program+array_pc+3);var index_slot:i64=jj_vm_rd16(program+index_pc+1);var bound:i64=jj_vm_rd32(program+bound_pc+1);var scale:i64=jj_vm_rd64(program+scale_pc+1);var value_slot:i64=jj_vm_rd16(program+value_pc+1);if array_count!=bound{return 0;}if scale!=8{return 0;}if end-jj_rc_history_get(h,51)!=72{return 0;}if range_max>=bound{range_max=0-1;}
  var d:[7]i64;d[0]=array_slot;d[1]=bound;d[2]=index_slot;d[3]=value_slot;d[4]=fail_at;d[5]=entry_target;d[6]=range_max;if jj_rbas_emit(code,jj_rc_history_get(h,51),end,d as *i64)==0{return 0;}receipts[3]=(array_slot&65535)|((bound&65535)<<16);
  var fgr:*i64=receipts[0] as *i64;var reo:*i64=receipts[1] as *i64;var reom:*i64=receipts[2] as *i64;if fgr==0{return 0-1;}if reo==0{return 0-1;}if reom==0{return 0-1;}fgr[0]=jj_rc_history_get(h,53);reo[0]=jj_rc_history_get(h,54);var packed:i64=jj_rc_history_get(h,55);var count:i64=(packed>>>16)&65535;var fp:i64=(packed>>>32)&65535;var ndr:i64=(packed>>>48)&65535;if count>=65535{return 0-1;}if ndr>65533{return 0-1;}var token:i64=0;if range_max>=0{token=(0x47+array_slot*3+index_slot*5+bound*7+value_slot*11+entry_target*13+range_max*17)&65535;}else{token=(0x42+array_slot*3+index_slot*5+bound*7+value_slot*11+entry_target*13)&65535;}reom[0]=(packed&65535)|((count+1)<<16)|(((fp*257+token)&65535)<<32)|((ndr+2)<<48);return 1;
}

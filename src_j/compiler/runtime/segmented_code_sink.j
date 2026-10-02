// Logical segmented append sink for temporary native code. The backing
// capability may be contiguous, but all writes are resolved through sealed
// segment descriptors and stable offsets. Metadata is address-bound.
fn jj_codeseg_seal(state:*i64)->i64{
  var seal:i64=(state as i64)^0x4a4a434f44455331;var i:i64=0;while i<40{if i!=6{seal=seal^state[i];}i=i+1;}return seal;
}
fn jj_codeseg_valid(state:*i64)->i64{
  if state==0{return 0;}if state[0]!=0x4a4a434f44455331{return 0;}if state[1]==0{return 0;}if state[2]<=0{return 0;}if state[3]<4096{return 0;}if state[3]>65536{return 0;}if state[4]<=0{return 0;}if state[4]>16{return 0;}if state[5]<0{return 0;}if state[5]>state[2]{return 0;}if state[7]!=0{return 0;}
  var expected:i64=0;var i:i64=0;while i<state[4]{var off:i64=state[8+i*2];var len:i64=state[9+i*2];if off!=expected{return 0;}if len<=0{return 0;}if off>state[2]-len{return 0;}expected=off+len;i=i+1;}if expected!=state[2]{return 0;}if state[6]!=jj_codeseg_seal(state){return 0;}return 1;
}
fn jj_codeseg_init(state:*i64,base:*i8,capacity:i64,quantum:i64)->i64{
  if state==0{return 0;}if base==0{return 0;}if capacity<=0{return 0;}if quantum<4096{return 0;}if quantum>65536{return 0;}
  var count:i64=(capacity+quantum-1)/quantum;if count<=0{return 0;}if count>16{return 0;}var z:i64=0;while z<40{state[z]=0;z=z+1;}
  state[0]=0x4a4a434f44455331;state[1]=base as i64;state[2]=capacity;state[3]=quantum;state[4]=count;state[5]=0;state[7]=0;
  var i:i64=0;var off:i64=0;while i<count{var len:i64=quantum;if len>capacity-off{len=capacity-off;}state[8+i*2]=off;state[9+i*2]=len;off=off+len;i=i+1;}state[6]=jj_codeseg_seal(state);return jj_codeseg_valid(state);
}
fn jj_codeseg_touch(state:*i64,end:i64)->i64{if jj_codeseg_valid(state)==0{return 0;}if end<0{return 0;}if end>state[2]{return 0;}if end>state[5]{state[5]=end;state[6]=jj_codeseg_seal(state);}return 1;}
fn jj_codeseg_emit8(state:*i64,cursor:*i64,value:i64)->i64{
  if jj_codeseg_valid(state)==0{return 0;}if cursor==0{return 0;}var position:i64=cursor[0];if position<0{return 0;}if position>=state[2]{return 0;}var quantum:i64=state[3];var index:i64=position/quantum;if index<0{return 0;}if index>=state[4]{return 0;}var off:i64=state[8+index*2];var len:i64=state[9+index*2];var local:i64=position-off;if local<0{return 0;}if local>=len{return 0;}var base:*i8=state[1] as *i8;base[off+local]=value;cursor[0]=position+1;return jj_codeseg_touch(state,position+1);
}
fn jj_codeseg_emit(state:*i64,cursor:*i64,value:i64,width:i64)->i64{
  if width!=1{if width!=4{if width!=8{return 0;}}}var i:i64=0;while i<width{if jj_codeseg_emit8(state,cursor,value>>>(i*8))==0{return 0;}i=i+1;}return 1;
}
fn jj_codeseg_commit(state:*i64,total:i64)->i64{if jj_codeseg_valid(state)==0{return 0;}if total<=0{return 0;}if total>state[2]{return 0;}if state[5]!=total{return 0;}return total;}

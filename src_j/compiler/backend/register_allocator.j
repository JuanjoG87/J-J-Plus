// Deterministic linear-scan register allocation for sealed linear CIR.
// Plan layout: header[0..7], then one four-word record per virtual value:
// last_use, location_kind(1=register,2=spill), location_index, reserved.
extern fn jj_cir_validate(p0:*i64,p1:i64)->i64;

fn jj_ra_zero(plan:*i64,slots:i64)->i64{
  if plan==0{return 0;}if slots!=64{return 0;}var i:i64=0;while i<slots{plan[i]=0;i=i+1;}return 1;
}

fn jj_ra_seal(plan:*i64,slots:i64)->i64{
  if plan==0{return 0;}if slots!=64{return 0;}var count:i64=plan[1];if count<=0{return 0;}if count>14{return 0;}
  var used:i64=8+count*4;var h:i64=0x4a4a52415345414c;var i:i64=0;
  while i<used{if i!=6{h=((h<<7)|(h>>>57))^plan[i]^(i*0x9e37);}i=i+1;}return h;
}

fn jj_ra_fail(plan:*i64)->i64{jj_ra_zero(plan,64);return 0;}

fn jj_ra_nonoverlap(a:*i64,a_slots:i64,b:*i64,b_slots:i64)->i64{
  if a==0{return 0;}if b==0{return 0;}if a_slots<=0{return 0;}if b_slots<=0{return 0;}
  var aa:i64=a as i64;var ba:i64=b as i64;var an:i64=a_slots*8;var bn:i64=b_slots*8;
  if aa<=0{return 0;}if ba<=0{return 0;}if an<=0{return 0;}if bn<=0{return 0;}
  if aa<ba{if ba-aa<an{return 0;}}else{if aa-ba<bn{return 0;}}return 1;
}

fn jj_ra_build(cir:*i64,cir_slots:i64,registers:i64,plan:*i64,plan_slots:i64)->i64{
  if cir==0{return 0;}if plan==0{return 0;}if cir_slots!=64{return 0;}if plan_slots!=64{return 0;}
  if jj_ra_nonoverlap(cir,cir_slots,plan,plan_slots)==0{return 0;}
  if registers<=0{return 0;}if registers>8{return 0;}if jj_ra_zero(plan,64)==0{return 0;}
  if jj_cir_validate(cir,64)==0{return 0;}if cir[1]!=1{return 0;}var count:i64=cir[2];if cir[6]!=count{return 0;}if count<=0{return 0;}if count>14{return 0;}
  plan[0]=0x4a4a5241504c414e;plan[1]=count;plan[2]=registers;plan[5]=cir[6];plan[7]=cir[7];
  var value:i64=1;while value<=count{plan[8+(value-1)*4]=value;value=value+1;}
  var node:i64=1;while node<=count{var base:i64=8+(node-1)*4;var op:i64=cir[base];
    if op!=1{if op!=2{var a:i64=cir[base+2];var b:i64=cir[base+3];if a<=0{return jj_ra_fail(plan);}if b<=0{return jj_ra_fail(plan);}
      plan[8+(a-1)*4]=node;plan[8+(b-1)*4]=node;}}
    node=node+1;}
  if plan[5]<=0{return jj_ra_fail(plan);}if plan[5]>count{return jj_ra_fail(plan);}plan[8+(plan[5]-1)*4]=count+1;
  var spills:i64=0;value=1;
  while value<=count{
    var free:i64=0-1;var r:i64=0;
    while r<registers{var busy:i64=0;var previous:i64=1;while previous<value{var pb:i64=8+(previous-1)*4;
        if plan[pb+1]==1{if plan[pb+2]==r{if plan[pb]>value{busy=1;}}}previous=previous+1;}
      if busy==0{free=r;r=registers;}else{r=r+1;}}
    var current:i64=8+(value-1)*4;
    if free>=0{plan[current+1]=1;plan[current+2]=free;}
    else{
      var victim:i64=0;var victim_end:i64=0-1;var previous2:i64=1;
      while previous2<value{var vb:i64=8+(previous2-1)*4;if plan[vb+1]==1{if plan[vb]>=value{
            if plan[vb]>victim_end{victim=previous2;victim_end=plan[vb];}
            else{if plan[vb]==victim_end{if previous2>victim{victim=previous2;}}}}}previous2=previous2+1;}
      if victim==0{return jj_ra_fail(plan);}var victim_base:i64=8+(victim-1)*4;
      if victim_end>plan[current]{var inherited:i64=plan[victim_base+2];plan[victim_base+1]=2;plan[victim_base+2]=spills;spills=spills+1;
        plan[current+1]=1;plan[current+2]=inherited;}
      else{plan[current+1]=2;plan[current+2]=spills;spills=spills+1;}
    }
    value=value+1;
  }
  plan[3]=spills;plan[4]=((spills*8+15)/16)*16;plan[6]=jj_ra_seal(plan,64);if plan[6]==0{return jj_ra_fail(plan);}return 1;
}

fn jj_ra_validate(plan:*i64,slots:i64)->i64{
  if plan==0{return 0;}if slots!=64{return 0;}if plan[0]!=0x4a4a5241504c414e{return 0;}var count:i64=plan[1];var registers:i64=plan[2];
  if count<=0{return 0;}if count>14{return 0;}if registers<=0{return 0;}if registers>8{return 0;}if plan[3]<0{return 0;}
  if plan[4]!=((plan[3]*8+15)/16)*16{return 0;}if plan[5]<=0{return 0;}if plan[5]>count{return 0;}if plan[6]==0{return 0;}if plan[7]==0{return 0;}
  if plan[6]!=jj_ra_seal(plan,64){return 0;}var value:i64=1;var spill_seen:[14]i64;var si:i64=0;while si<14{spill_seen[si]=0;si=si+1;}
  while value<=count{var base:i64=8+(value-1)*4;var last:i64=plan[base];var kind:i64=plan[base+1];var index:i64=plan[base+2];
    if last<value{return 0;}if last>count+1{return 0;}if plan[base+3]!=0{return 0;}
    if kind==1{if index<0{return 0;}if index>=registers{return 0;}}
    else{if kind==2{if index<0{return 0;}if index>=plan[3]{return 0;}if index>=14{return 0;}if spill_seen[index]!=0{return 0;}spill_seen[index]=1;}else{return 0;}}
    value=value+1;}
  var a:i64=1;while a<=count{var ab:i64=8+(a-1)*4;if plan[ab+1]==1{var b:i64=a+1;while b<=count{var bb:i64=8+(b-1)*4;
        if plan[bb+1]==1{if plan[ab+2]==plan[bb+2]{if b<plan[ab]{return 0;}}}b=b+1;}}a=a+1;}
  var i:i64=8+count*4;while i<64{if plan[i]!=0{return 0;}i=i+1;}return 1;
}


fn jj_ra_validate_for_cir(plan:*i64,plan_slots:i64,cir:*i64,cir_slots:i64)->i64{
  if jj_ra_validate(plan,plan_slots)==0{return 0;}if jj_cir_validate(cir,cir_slots)==0{return 0;}if cir[1]!=1{return 0;}
  if plan[1]!=cir[2]{return 0;}if plan[5]!=cir[6]{return 0;}if plan[7]!=cir[7]{return 0;}
  var expected:[64]i64;if jj_ra_build(cir,cir_slots,plan[2],expected as *i64,64)==0{return 0;}var i:i64=0;while i<64{if plan[i]!=expected[i]{return 0;}i=i+1;}return 1;
}






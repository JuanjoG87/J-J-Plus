fn guarded(value:i64)->i64{
  require value!=0 else return 7;
  return 9;
}
fn j_main(argc:i64,argv:*i64)->i64{
  if guarded(0)!=7{return 1;}
  if guarded(1)!=9{return 2;}
  return 0;
}

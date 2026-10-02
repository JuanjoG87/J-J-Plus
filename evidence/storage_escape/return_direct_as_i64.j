fn bad(data:*i64)->i64
capability data;
reads none;
writes none;
{
  return data as i64;
}
fn j_main(argc:i64,argv:*i64)->i64{return 0;}

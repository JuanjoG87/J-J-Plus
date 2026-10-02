fn p14probe(data:*i64)->i64
capability data;
reads data;
writes none;
{
  var next:*i64 = data;
  var first:i64 = next[0];
  var second:i64 = data[0];
  return first+second;
}

fn j_main(argc:i64,argv:*i64)->i64 {
  p14probe(argv);
  return 0;
}

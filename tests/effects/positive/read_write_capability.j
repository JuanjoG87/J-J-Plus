fn increment_first(data:*i64)->i64
capability data;
reads data;
writes data;
{
  var value:i64 = data[0];
  data[0] = value + 1;
  return value;
}

fn j_main(argc:i64, argv:*i64)->i64 {
  return 0;
}

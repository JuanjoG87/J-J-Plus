fn first(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return data[0];
}

fn j_main(argc:i64, argv:*i64)->i64 {
  first(argv);
  return 0;
}

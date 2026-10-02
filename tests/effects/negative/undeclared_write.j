fn bad(data:*i64)->i64
capability data;
reads none;
writes none;
{
  data[0] = 1;
  return 0;
}

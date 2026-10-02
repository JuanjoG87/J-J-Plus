fn bad(data:*i64)->*i64
capability data;
reads none;
writes none;
{
  var shifted:*i64 = data + 8;
  return shifted;
}

fn probe(data:*i64)->i64 {
  var shifted:*i64 = data + 1;
  return shifted[0];
}

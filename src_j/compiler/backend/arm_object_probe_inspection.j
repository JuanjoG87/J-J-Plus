// on-demand inspection companion; excluded from resident selfhost closures.

fn jj_arm32_binary_word(op:i64)->i64{
  if op==9{return 0xe0800001;}if op==10{return 0xe0400001;}if op==11{return 0xe0000190;}
  if op==16{return 0xe0000001;}if op==17{return 0xe1800001;}if op==18{return 0xe0200001;}
  return 0;
}

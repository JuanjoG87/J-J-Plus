// R757 compact localized failure diagnostics. Failed objects are scratch: no allocation,
// no local arrays and no mutation of successful output.
extern fn jj_raw_object_buffer()->i64;
extern fn jj_raw_source_buffer()->i64;
extern fn jj_raw_write(p0:i64,p1:*i8,p2:i64)->i64;

fn jj_diag_seal(report:*i64)->i64{return (report as i64)^report[0]^report[1]^report[2]^report[3]^report[4]^report[5]^report[6]^0x4a4a444941475332;}
fn jj_diag_valid(report:*i64)->i64{if report==0{return 0;}if report[0]!=0x4a4a444941473032{return 0;}if report[7]!=jj_diag_seal(report){return 0;}return 1;}
fn jj_diag_put_text(out:*i8,at:i64,text:*i8)->i64{if out==0{return 0-1;}if text==0{return 0-1;}if at<0{return 0-1;}var i:i64=0;while text[i]!=0{if at>=510{return 0-1;}out[at]=text[i];at=at+1;i=i+1;}return at;}
fn jj_diag_put_u64(out:*i8,at:i64,value:i64)->i64{if out==0{return 0-1;}if at<0{return 0-1;}if value<0{if at>=510{return 0-1;}out[at]=45;at=at+1;value=0-value;}var start:i64=at;if value==0{if at>=510{return 0-1;}out[at]=48;return at+1;}while value>0{if at>=510{return 0-1;}out[at]=48+(value%10);at=at+1;value=value/10;}var left:i64=start;var right:i64=at-1;while left<right{var c:i64=out[left];out[left]=out[right];out[right]=c;left=left+1;right=right-1;}return at;}
fn jj_diag_reason(reason:i64)->*i8{
  if reason==6001{return "frontend-rejected" as *i8;}
  if reason==6002{return "backend-rejected" as *i8;}
  if reason==6101{return "parser-token-stream" as *i8;}
  if reason==6102{return "parser-unexpected-close" as *i8;}
  if reason==6103{return "parser-unclosed-delimiter" as *i8;}
  if reason==6104{return "parser-depth-limit" as *i8;}
  if reason==6105{return "parser-declaration-missing" as *i8;}
  if reason==6106{return "parser-authority-failure" as *i8;}
  if reason==6107{return "parser-structure-empty" as *i8;}
  if reason==6201{return "scanner-illegal-character" as *i8;}
  if reason==6202{return "scanner-unterminated-token" as *i8;}
  if reason==6203{return "scanner-non-ascii-control" as *i8;}
  if reason==6204{return "scanner-invalid-number" as *i8;}
  if reason==6205{return "scanner-zero-byte" as *i8;}
  if reason==6206{return "scanner-tokenization-failure" as *i8;}
  if reason==6401{return "require-missing-else" as *i8;}
  if reason==6402{return "require-missing-return" as *i8;}
  if reason==6403{return "require-invalid-condition" as *i8;}
  if reason==6404{return "require-condition-authority" as *i8;}
  if reason==6405{return "require-invalid-failure-expression" as *i8;}
  if reason==6406{return "require-failure-type-mismatch" as *i8;}
  if reason==6407{return "require-missing-semicolon" as *i8;}
  if reason==6501{return "effect-contract-incomplete" as *i8;}
  if reason==6502{return "effect-contract-order" as *i8;}
  if reason==6503{return "effect-target-not-pointer-parameter" as *i8;}
  if reason==6504{return "effect-target-duplicate" as *i8;}
  if reason==6505{return "effect-outside-capability" as *i8;}
  if reason==6506{return "undeclared-read-effect" as *i8;}
  if reason==6507{return "undeclared-write-effect" as *i8;}
  if reason==6508{return "unsupported-capability-escape" as *i8;}
  if reason==6509{return "effect-call-unverified" as *i8;}
  if reason==6510{return "effect-alias-unverified" as *i8;}
  if reason==6511{return "effect-pointer-transform-unverified" as *i8;}
  if reason==6512{return "effect-return-escape-unverified" as *i8;}
  if reason==6513{return "effect-storage-escape-unverified" as *i8;}
  if reason==6514{return "authority-source-transferred" as *i8;}
  if reason==6601{return "arm32-direct-load-index-range" as *i8;}
  if reason==6301{return "manifest-version-line" as *i8;}
  if reason==6302{return "manifest-prefix-line" as *i8;}
  if reason==6303{return "manifest-line-short" as *i8;}
  if reason==6304{return "manifest-digest-syntax" as *i8;}
  if reason==6305{return "manifest-separator" as *i8;}
  if reason==6306{return "manifest-path" as *i8;}
  if reason==6307{return "manifest-duplicate-path" as *i8;}
  if reason==6308{return "manifest-source-read" as *i8;}
  if reason==6309{return "manifest-source-hash-mismatch" as *i8;}
  if reason==6310{return "manifest-entry-limit" as *i8;}
  if reason==6311{return "manifest-stream" as *i8;}
  if reason==6312{return "manifest-empty" as *i8;}
  if reason==71101{return "phase-begin" as *i8;}
  if reason==71102{return "phase-read" as *i8;}
  if reason==71103{return "phase-parse" as *i8;}
  if reason==71104{return "phase-write" as *i8;}
  if reason==71105{return "sandbox-install" as *i8;}
  if reason==75601{return "layout-measure-failed" as *i8;}
  if reason==75602{return "layout-receipt-mismatch" as *i8;}
  if reason==75603{return "layout-size-mismatch" as *i8;}
  if reason==75604{return "layout-offset-mismatch" as *i8;}
  if reason==75610{return "direct-prepare-failed" as *i8;}
  if reason==75611{return "direct-receipt-mismatch" as *i8;}
  if reason==75612{return "direct-size-mismatch" as *i8;}
  if reason>=75620{if reason<=75669{return "direct-op-emission" as *i8;}}
  if reason==75801{return "edge-transport-prepare" as *i8;}
  if reason==75802{return "edge-transport-compact-map" as *i8;}
  if reason==75803{return "edge-transport-exit-store" as *i8;}
  if reason==75804{return "edge-transport-clobber" as *i8;}
  if reason==75805{return "edge-transport-entry-load" as *i8;}
  if reason==75806{return "edge-transport-receipt" as *i8;}
  if reason==75901{return "join-transport-prepare" as *i8;}
  if reason==75902{return "join-transport-pattern" as *i8;}
  if reason==75903{return "join-same-location" as *i8;}
  if reason==75904{return "join-edge-copy" as *i8;}
  if reason==75905{return "join-transport-clobber" as *i8;}
  if reason==75906{return "join-transport-receipt" as *i8;}
  if reason==76021{return "cfg-location-action-order" as *i8;}
  if reason==76022{return "cfg-location-machine-offset" as *i8;}
  if reason==76023{return "cfg-location-emission" as *i8;}
  if reason==76024{return "cfg-location-emission-receipt" as *i8;}
  if reason==76030{return "cfg-location-relayout" as *i8;}
  if reason==76031{return "cfg-location-regions" as *i8;}
  if reason==76032{return "cfg-location-compact" as *i8;}
  if reason==76033{return "cfg-location-index" as *i8;}
  if reason==76034{return "cfg-location-branch-patch" as *i8;}
  if reason==76035{return "cfg-location-relocation" as *i8;}
  if reason==76040{return "cfg-location-input" as *i8;}
  if reason==76041{return "cfg-location-block-scan" as *i8;}
  if reason==76042{return "cfg-location-predecessors" as *i8;}
  if reason==76043{return "cfg-location-join-live-in" as *i8;}
  if reason==76044{return "cfg-location-pred0-live-out" as *i8;}
  if reason==76045{return "cfg-location-pred1-live-out" as *i8;}
  if reason==76046{return "cfg-location-admission" as *i8;}
  if reason==76047{return "cfg-location-mode1-offset" as *i8;}
  if reason==76048{return "cfg-location-mode1-action" as *i8;}
  if reason==76049{return "cfg-location-mode2-action" as *i8;}
  if reason==76050{return "cfg-location-seal" as *i8;}
  if reason==76121{return "cfg-copy-action-order" as *i8;}
  if reason==76122{return "cfg-copy-machine-offset" as *i8;}
  if reason==76123{return "cfg-copy-emission" as *i8;}
  if reason==76140{return "cfg-copy-input" as *i8;}
  if reason==76141{return "cfg-copy-candidate" as *i8;}
  if reason==76142{return "cfg-copy-location" as *i8;}
  if reason==76143{return "cfg-copy-program-hash" as *i8;}
  if reason==76144{return "cfg-copy-layout-offset" as *i8;}
  if reason==76145{return "cfg-copy-order" as *i8;}
  if reason==76146{return "cfg-copy-seal" as *i8;}
  if reason==76150{return "cfg-relayout-bytecode" as *i8;}
  if reason==76151{return "cfg-relayout-op-size" as *i8;}
  if reason==76152{return "cfg-relayout-map" as *i8;}
  if reason==76153{return "cfg-relayout-jump-opcode" as *i8;}
  if reason==76154{return "cfg-relayout-jump-target" as *i8;}
  if reason==76155{return "cfg-relayout-branch-target" as *i8;}
  if reason==76156{return "cfg-relayout-stream-end" as *i8;}
  if reason==76157{return "cfg-relayout-size" as *i8;}
  if reason==76158{return "cfg-relayout-compact-patch" as *i8;}
  if reason==76124{return "cfg-copy-emission-receipt" as *i8;}
  if reason==76159{return "cfg-copy-relayout" as *i8;}
  if reason>=73000{if reason<=73049{return "legacy-op-emission" as *i8;}}
  if reason==76001{return "publish-input-invalid" as *i8;}
  if reason==76002{return "relocation-scan-failed" as *i8;}
  if reason==76003{return "workspace-budget-rejected" as *i8;}
  if reason==76004{return "abi-receipt-rejected" as *i8;}
  if reason==76005{return "function-emission-failed" as *i8;}
  if reason==76006{return "ast-map-rejected" as *i8;}
  if reason==76007{return "object-finalize-rejected" as *i8;}
  return "unspecified" as *i8;
}
fn jj_diag_manifest_reason(reason:i64)->i64{if reason>=6301{if reason<=6312{return 1;}}return 0;}
fn jj_diag_frontend_reason(reason:i64)->i64{if reason==6001{return 1;}if reason>=6101{if reason<=6107{return 1;}}if reason>=6201{if reason<=6206{return 1;}}if reason>=6301{if reason<=6312{return 1;}}if reason>=6401{if reason<=6407{return 1;}}if reason>=6501{if reason<=6514{return 1;}}return 0;}
fn jj_diag_expected(reason:i64)->*i8{
  if reason==6401{return "else-return" as *i8;}
  if reason==6402{return "return" as *i8;}
  if reason==6403{return "condition-expression" as *i8;}
  if reason==6404{return "non-narrow-condition-authority" as *i8;}
  if reason==6405{return "failure-expression" as *i8;}
  if reason==6406{return "failure-value-compatible-with-function-return" as *i8;}
  if reason==6407{return "semicolon" as *i8;}
  if reason==6501{return "capability-reads-writes-contract" as *i8;}
  if reason==6502{return "capability-then-reads-then-writes" as *i8;}
  if reason==6503{return "pointer-parameter-or-none" as *i8;}
  if reason==6504{return "unique-effect-target" as *i8;}
  if reason==6505{return "effect-target-declared-as-capability" as *i8;}
  if reason==6506{return "reads-declaration-covering-observed-read" as *i8;}
  if reason==6507{return "writes-declaration-covering-observed-write" as *i8;}
  if reason==6508{return "direct-indexed-capability-access" as *i8;}
  if reason==6509{return "contracted-callee-for-direct-capability-argument" as *i8;}
  if reason==6510{return "acyclic-single-assignment-local-pointer-alias-chain-to-capability-root" as *i8;}
  if reason==6511{return "constant-byte-offset-0-through-248-aligned-to-8-from-capability-provenance" as *i8;}
  if reason==6512{return "non-escaping-capability-use-or-future-explicit-transfer-contract" as *i8;}
  if reason==6513{return "non-publishing-capability-storage-or-future-explicit-transfer-contract" as *i8;}
  if reason==6514{return "active-authority-root-at-capability-use" as *i8;}
  if reason==6601{return "constant-index-0-through-31" as *i8;}
  return "" as *i8;
}
fn jj_diag_append_span(out:*i8,at:i64,source_offset:i64,token_length:i64,source_length:i64)->i64{if source_offset<0{source_offset=0;}if source_offset>source_length{source_offset=source_length;}var line:i64=1;var column:i64=1;var source_text:*i8=jj_raw_source_buffer() as *i8;var si:i64=0;if source_text!=0{while si<source_offset{if source_text[si]==10{line=line+1;column=1;}else{column=column+1;}si=si+1;}}at=jj_diag_put_text(out,at," source_offset=");if at<0{return 0-1;}at=jj_diag_put_u64(out,at,source_offset);if at<0{return 0-1;}at=jj_diag_put_text(out,at," line=");if at<0{return 0-1;}at=jj_diag_put_u64(out,at,line);if at<0{return 0-1;}at=jj_diag_put_text(out,at," column=");if at<0{return 0-1;}at=jj_diag_put_u64(out,at,column);if at<0{return 0-1;}at=jj_diag_put_text(out,at," token_length=");if at<0{return 0-1;}return jj_diag_put_u64(out,at,token_length);}
fn jj_diag_origin(kind:i64)->*i8{if kind==1{return "exact" as *i8;}if kind==2{return "nearest-prior" as *i8;}if kind==3{return "function" as *i8;}return "unknown" as *i8;}
fn jj_diag_write_line(path:*i8,rc:i64,report:*i64)->i64{
  var out:*i8=jj_raw_object_buffer() as *i8;if out==0{return 0;}var code:i64=0;var reason:i64=0;var function_id:i64=0;var bytecode:i64=0;var machine:i64=0;var origin_kind:i64=0;var origin_pc:i64=0;var transform_pass:i64=0;var transform_mode:i64=0;var original_value:i64=0;var replacement_value:i64=0;var copy_ordinal:i64=0;var copy_count:i64=0;var source_node:i64=0;var source_length:i64=0;var packed_span:i64=0xffffffff;if jj_diag_valid(report)!=0{code=report[1];reason=report[2];function_id=report[3]&65535;origin_kind=(report[3]>>>16)&255;transform_pass=(report[3]>>>24)&4095;transform_mode=(report[3]>>>36)&15;source_node=(report[3]>>>40)&0xffffff;bytecode=report[4]&0xffffff;original_value=(report[4]>>>24)&255;replacement_value=(report[4]>>>32)&255;copy_ordinal=(report[4]>>>40)&255;copy_count=(report[4]>>>48)&255;machine=report[5]&0xffffff;origin_pc=(report[5]>>>24)&0xffffff;source_length=(report[6]>>>32)&0xffffffff;packed_span=report[6]&0xffffffff;}
  var at:i64=0;at=jj_diag_put_text(out,at,"OMEGA_FAIL rc=");if at<0{return 0;}at=jj_diag_put_u64(out,at,rc);if at<0{return 0;}at=jj_diag_put_text(out,at," code=");if at<0{return 0;}at=jj_diag_put_u64(out,at,code);if at<0{return 0;}at=jj_diag_put_text(out,at," reason=");if at<0{return 0;}at=jj_diag_put_text(out,at,jj_diag_reason(reason));if at<0{return 0;}at=jj_diag_put_text(out,at," reason_id=");if at<0{return 0;}at=jj_diag_put_u64(out,at,reason);if at<0{return 0;}var expected:*i8=jj_diag_expected(reason);if expected[0]!=0{at=jj_diag_put_text(out,at," expected=");if at<0{return 0;}at=jj_diag_put_text(out,at,expected);if at<0{return 0;} }if jj_diag_manifest_reason(reason)!=0{at=jj_diag_put_text(out,at," source_offset=");if at<0{return 0;}at=jj_diag_put_u64(out,at,report[6]&0xffffffff);if at<0{return 0;}at=jj_diag_put_text(out,at," line=");if at<0{return 0;}at=jj_diag_put_u64(out,at,function_id);if at<0{return 0;}at=jj_diag_put_text(out,at," column=");if at<0{return 0;}at=jj_diag_put_u64(out,at,bytecode);if at<0{return 0;}at=jj_diag_put_text(out,at," token_length=");if at<0{return 0;}at=jj_diag_put_u64(out,at,machine);if at<0{return 0;}}else{if jj_diag_frontend_reason(reason)!=0{at=jj_diag_append_span(out,at,bytecode,machine,source_length);if at<0{return 0;}}else{at=jj_diag_put_text(out,at," function=");if at<0{return 0;}at=jj_diag_put_u64(out,at,function_id);if at<0{return 0;}at=jj_diag_put_text(out,at," bytecode=");if at<0{return 0;}at=jj_diag_put_u64(out,at,bytecode);if at<0{return 0;}at=jj_diag_put_text(out,at," machine=");if at<0{return 0;}at=jj_diag_put_u64(out,at,machine);if at<0{return 0;}if origin_kind!=0{at=jj_diag_put_text(out,at," origin=");if at<0{return 0;}at=jj_diag_put_text(out,at,jj_diag_origin(origin_kind));if at<0{return 0;}at=jj_diag_put_text(out,at," origin_bytecode=");if at<0{return 0;}at=jj_diag_put_u64(out,at,origin_pc);if at<0{return 0;}}if transform_pass!=0{at=jj_diag_put_text(out,at," transform_pass=");if at<0{return 0;}at=jj_diag_put_u64(out,at,transform_pass);if at<0{return 0;}at=jj_diag_put_text(out,at," transform_mode=");if at<0{return 0;}at=jj_diag_put_u64(out,at,transform_mode);if at<0{return 0;}at=jj_diag_put_text(out,at," source_node=");if at<0{return 0;}at=jj_diag_put_u64(out,at,source_node);if at<0{return 0;}at=jj_diag_put_text(out,at," replacement_machine=");if at<0{return 0;}at=jj_diag_put_u64(out,at,machine);if at<0{return 0;}at=jj_diag_put_text(out,at," original_value=");if at<0{return 0;}at=jj_diag_put_u64(out,at,original_value);if at<0{return 0;}at=jj_diag_put_text(out,at," replacement_value=");if at<0{return 0;}at=jj_diag_put_u64(out,at,replacement_value);if at<0{return 0;}at=jj_diag_put_text(out,at," copy_ordinal=");if at<0{return 0;}at=jj_diag_put_u64(out,at,copy_ordinal);if at<0{return 0;}at=jj_diag_put_text(out,at," copy_count=");if at<0{return 0;}at=jj_diag_put_u64(out,at,copy_count);if at<0{return 0;}}if packed_span!=0xffffffff{var source_offset:i64=packed_span&0xfffff;var token_length:i64=(packed_span>>>20)&4095;at=jj_diag_append_span(out,at,source_offset,token_length,source_length);if at<0{return 0;}}}}at=jj_diag_put_text(out,at," source=");if at<0{return 0;}
  if path==0{at=jj_diag_put_text(out,at,"<unknown>");if at<0{return 0;}}else{var i:i64=0;while path[i]!=0{if i>=180{break;}if at>=510{return 0;}out[at]=path[i];at=at+1;i=i+1;}}
  if at>=511{return 0;}out[at]=10;at=at+1;return jj_raw_write(2,out,at);
}
fn jj_compile_failure_pending()->i64{var out:*i8=jj_raw_object_buffer() as *i8;if out==0{return 0;}return jj_diag_valid((out+2097152-64) as *i64);}
fn jj_compile_failure_emit(path:*i8,rc:i64,object:*i8)->i64{if object==0{return 0;}var report:*i64=(object+2097152-64) as *i64;if jj_diag_valid(report)!=0{return jj_diag_write_line(path,rc,report);}return jj_diag_write_line(path,rc,0 as *i64);}
fn jj_runtime_failure_emit(path:*i8,rc:i64,detail:i64)->i64{var out:*i8=jj_raw_object_buffer() as *i8;if out==0{return 0;}var report:*i64=(out+2097152-64) as *i64;report[0]=0x4a4a444941473032;report[1]=detail&65535;report[2]=detail>>>16;report[3]=0;report[4]=0;report[5]=0;report[6]=0;report[7]=jj_diag_seal(report);return jj_diag_write_line(path,rc,report);}

const $reinterpret_view = new DataView(new ArrayBuffer(8));
function $i64_reinterpret_f64(a) {
  $reinterpret_view.setBigUint64(0, BigInt.asUintN(64, a), false);
  return $reinterpret_view.getFloat64(0, false);
}
function _M0TPC28internal7strconv9FloatInfo(param0, param1, param2) {
  this.mantissa_bits = param0;
  this.exponent_bits = param1;
  this.bias = param2;
}
function _M0TPB9ArrayViewGUiRP211localreview3tcl11InterpreterEE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
class $PanicError extends Error {}
function $panic() {
  throw new $PanicError();
}
function $oob() {
  throw new Error("Index out of bounds");
}
function _M0TPB13StringBuilder(param0) {
  this.val = param0;
}
function _M0TPC16string10StringView(param0, param1, param2) {
  this.str = param0;
  this.start = param1;
  this.end = param2;
}
function $compare_int(a, b) {
  return (a >= b) - (a <= b);
}
const _M0FPB12random__seed = () => {
  if (globalThis.crypto?.getRandomValues) {
    const array = new Uint32Array(1);
    globalThis.crypto.getRandomValues(array);
    return array[0] | 0; // Convert to signed 32
  } else {
    return Math.floor(Math.random() * 0x100000000) | 0; // Fallback to Math.random
  }
};
const _M0FPB19int__to__string__js = (x, radix) => {
  return x.toString(radix);
};
const _M0FPB21int64__to__string__js = (num, radix) => BigInt.asIntN(64, num).toString(radix);
const _M0FPB22uint64__to__string__js = (num, radix) => num.toString(radix);
function _M0TPB4IterGUsRPB4JsonEE(param0, param1) {
  this.f = param0;
  this.size_hint = param1;
}
function _M0TPB4IterGcE(param0, param1) {
  this.f = param0;
  this.size_hint = param1;
}
function $makebytes(a, b) {
  const arr = new Uint8Array(a);
  if (b !== 0) {
    arr.fill(b);
  }
  return arr;
}
function _M0TPB8MutLocalGiE(param0) {
  this.val = param0;
}
function $make_array_len_and_init(a, b) {
  const arr = new Array(a);
  arr.fill(b);
  return arr;
}
const _M0MPB7JSArray4push = (arr, val) => { arr.push(val); };
function _M0TPB4IterGsE(param0, param1) {
  this.f = param0;
  this.size_hint = param1;
}
function _M0TPB4IterGRPC16string10StringViewE(param0, param1) {
  this.f = param0;
  this.size_hint = param1;
}
function _M0TPB8MutLocalGORPC16string10StringViewE(param0) {
  this.val = param0;
}
function _M0TPB9ArrayViewGUssEE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
function _M0TPB9ArrayViewGcE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
function _M0TPB3MapGsRP211localreview3tcl7CommandE(param0, param1, param2, param3, param4, param5, param6) {
  this.entries = param0;
  this.size = param1;
  this.capacity = param2;
  this.capacity_mask = param3;
  this.grow_at = param4;
  this.head = param5;
  this.tail = param6;
}
function _M0TPB3MapGsRPB5ArrayGsEE(param0, param1, param2, param3, param4, param5, param6) {
  this.entries = param0;
  this.size = param1;
  this.capacity = param2;
  this.capacity_mask = param3;
  this.grow_at = param4;
  this.head = param5;
  this.tail = param6;
}
function _M0TPB3MapGsbE(param0, param1, param2, param3, param4, param5, param6) {
  this.entries = param0;
  this.size = param1;
  this.capacity = param2;
  this.capacity_mask = param3;
  this.grow_at = param4;
  this.head = param5;
  this.tail = param6;
}
function _M0TPB3MapGiRP211localreview3tcl11InterpreterE(param0, param1, param2, param3, param4, param5, param6) {
  this.entries = param0;
  this.size = param1;
  this.capacity = param2;
  this.capacity_mask = param3;
  this.grow_at = param4;
  this.head = param5;
  this.tail = param6;
}
function _M0TPB3MapGsiE(param0, param1, param2, param3, param4, param5, param6) {
  this.entries = param0;
  this.size = param1;
  this.capacity = param2;
  this.capacity_mask = param3;
  this.grow_at = param4;
  this.head = param5;
  this.tail = param6;
}
function _M0TPB5EntryGiRP211localreview3tcl11InterpreterE(param0, param1, param2, param3, param4, param5) {
  this.prev = param0;
  this.next = param1;
  this.psl = param2;
  this.hash = param3;
  this.key = param4;
  this.value = param5;
}
function _M0TPB5EntryGsRP211localreview3tcl7CommandE(param0, param1, param2, param3, param4, param5) {
  this.prev = param0;
  this.next = param1;
  this.psl = param2;
  this.hash = param3;
  this.key = param4;
  this.value = param5;
}
function _M0TPB5EntryGsRP211localreview3tcl4CellE(param0, param1, param2, param3, param4, param5) {
  this.prev = param0;
  this.next = param1;
  this.psl = param2;
  this.hash = param3;
  this.key = param4;
  this.value = param5;
}
function _M0TPB5EntryGsRP211localreview3tcl7BindingE(param0, param1, param2, param3, param4, param5) {
  this.prev = param0;
  this.next = param1;
  this.psl = param2;
  this.hash = param3;
  this.key = param4;
  this.value = param5;
}
function _M0TPB5EntryGsRPB5ArrayGsEE(param0, param1, param2, param3, param4, param5) {
  this.prev = param0;
  this.next = param1;
  this.psl = param2;
  this.hash = param3;
  this.key = param4;
  this.value = param5;
}
function _M0TPB5EntryGssE(param0, param1, param2, param3, param4, param5) {
  this.prev = param0;
  this.next = param1;
  this.psl = param2;
  this.hash = param3;
  this.key = param4;
  this.value = param5;
}
function _M0TPB5EntryGsbE(param0, param1, param2, param3, param4, param5) {
  this.prev = param0;
  this.next = param1;
  this.psl = param2;
  this.hash = param3;
  this.key = param4;
  this.value = param5;
}
function _M0TPB5EntryGsRPB4JsonE(param0, param1, param2, param3, param4, param5) {
  this.prev = param0;
  this.next = param1;
  this.psl = param2;
  this.hash = param3;
  this.key = param4;
  this.value = param5;
}
function _M0TPB5EntryGsRP211localreview3tcl13ScriptProgramE(param0, param1, param2, param3, param4, param5) {
  this.prev = param0;
  this.next = param1;
  this.psl = param2;
  this.hash = param3;
  this.key = param4;
  this.value = param5;
}
function _M0TPB5EntryGsRP211localreview3tcl4ExprE(param0, param1, param2, param3, param4, param5) {
  this.prev = param0;
  this.next = param1;
  this.psl = param2;
  this.hash = param3;
  this.key = param4;
  this.value = param5;
}
function _M0TPB5EntryGsRPC15debug4ReprE(param0, param1, param2, param3, param4, param5) {
  this.prev = param0;
  this.next = param1;
  this.psl = param2;
  this.hash = param3;
  this.key = param4;
  this.value = param5;
}
function _M0TPB5EntryGsiE(param0, param1, param2, param3, param4, param5) {
  this.prev = param0;
  this.next = param1;
  this.psl = param2;
  this.hash = param3;
  this.key = param4;
  this.value = param5;
}
function _M0DTPC16option6OptionGRPB5ArrayGsEE4None() {}
_M0DTPC16option6OptionGRPB5ArrayGsEE4None.prototype.$tag = 0;
const _M0DTPC16option6OptionGRPB5ArrayGsEE4None__ = new _M0DTPC16option6OptionGRPB5ArrayGsEE4None();
function _M0DTPC16option6OptionGRPB5ArrayGsEE4Some(param0) {
  this._0 = param0;
}
_M0DTPC16option6OptionGRPB5ArrayGsEE4Some.prototype.$tag = 1;
function _M0TPB8MutLocalGORPB5EntryGsRPB4JsonEE(param0) {
  this.val = param0;
}
function _M0TPB8MutLocalGORPB5EntryGsbEE(param0) {
  this.val = param0;
}
function _M0TPB8MutLocalGORPB5EntryGsRP211localreview3tcl4CellEE(param0) {
  this.val = param0;
}
function _M0TPB8MutLocalGORPB5EntryGsRPB5ArrayGsEEE(param0) {
  this.val = param0;
}
function _M0TPB8MutLocalGORPB5EntryGsRP211localreview3tcl7CommandEE(param0) {
  this.val = param0;
}
function _M0DTPB4Json4Null() {}
_M0DTPB4Json4Null.prototype.$tag = 0;
function _M0DTPB4Json4True() {}
_M0DTPB4Json4True.prototype.$tag = 1;
const _M0DTPB4Json4True__ = new _M0DTPB4Json4True();
function _M0DTPB4Json5False() {}
_M0DTPB4Json5False.prototype.$tag = 2;
const _M0DTPB4Json5False__ = new _M0DTPB4Json5False();
function _M0DTPB4Json6Number(param0, param1) {
  this._0 = param0;
  this._1 = param1;
}
_M0DTPB4Json6Number.prototype.$tag = 3;
function _M0DTPB4Json6String(param0) {
  this._0 = param0;
}
_M0DTPB4Json6String.prototype.$tag = 4;
function _M0DTPB4Json5Array(param0) {
  this._0 = param0;
}
_M0DTPB4Json5Array.prototype.$tag = 5;
function _M0DTPB4Json6Object(param0) {
  this._0 = param0;
}
_M0DTPB4Json6Object.prototype.$tag = 6;
function _M0DTPC16result6ResultGRPB5ArrayGsERP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPB5ArrayGsERP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRPB5ArrayGsERP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPB5ArrayGsERP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl6NumberERP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl6NumberERP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl6NumberERP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl6NumberERP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
const _M0MPB7JSArray4copy = (arr) => arr.slice(0);
function _M0TPB9ArrayViewGsE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
const _M0MPB7JSArray11set__length = (arr, len) => { arr.length = len; };
const _M0MPB7JSArray12append__view = (dst, src, src_offset, len) => {
   for (let i = 0; i < len; i++) {
     dst.push(src[src_offset + i]);
   }
 };
const _M0MPB7JSArray3pop = (arr) => arr.pop();
const _M0MPB7JSArray6splice = (arr, idx, cnt) => arr.splice(idx, cnt);
function _M0TPB12MutArrayViewGsE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
function _M0TPB9ArrayViewGRPC16string10StringViewE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
function _M0DTPC15debug4Repr7UnitLit() {}
_M0DTPC15debug4Repr7UnitLit.prototype.$tag = 0;
function _M0DTPC15debug4Repr7Integer(param0) {
  this._0 = param0;
}
_M0DTPC15debug4Repr7Integer.prototype.$tag = 1;
function _M0DTPC15debug4Repr9DoubleLit(param0) {
  this._0 = param0;
}
_M0DTPC15debug4Repr9DoubleLit.prototype.$tag = 2;
function _M0DTPC15debug4Repr8FloatLit(param0) {
  this._0 = param0;
}
_M0DTPC15debug4Repr8FloatLit.prototype.$tag = 3;
function _M0DTPC15debug4Repr7BoolLit(param0) {
  this._0 = param0;
}
_M0DTPC15debug4Repr7BoolLit.prototype.$tag = 4;
function _M0DTPC15debug4Repr7CharLit(param0) {
  this._0 = param0;
}
_M0DTPC15debug4Repr7CharLit.prototype.$tag = 5;
function _M0DTPC15debug4Repr9StringLit(param0) {
  this._0 = param0;
}
_M0DTPC15debug4Repr9StringLit.prototype.$tag = 6;
function _M0DTPC15debug4Repr5Tuple(param0) {
  this._0 = param0;
}
_M0DTPC15debug4Repr5Tuple.prototype.$tag = 7;
function _M0DTPC15debug4Repr5Array(param0) {
  this._0 = param0;
}
_M0DTPC15debug4Repr5Array.prototype.$tag = 8;
function _M0DTPC15debug4Repr6Record(param0) {
  this._0 = param0;
}
_M0DTPC15debug4Repr6Record.prototype.$tag = 9;
function _M0DTPC15debug4Repr4Enum(param0, param1) {
  this._0 = param0;
  this._1 = param1;
}
_M0DTPC15debug4Repr4Enum.prototype.$tag = 10;
function _M0DTPC15debug4Repr3Map(param0) {
  this._0 = param0;
}
_M0DTPC15debug4Repr3Map.prototype.$tag = 11;
function _M0DTPC15debug4Repr11RecordField(param0, param1) {
  this._0 = param0;
  this._1 = param1;
}
_M0DTPC15debug4Repr11RecordField.prototype.$tag = 12;
function _M0DTPC15debug4Repr14EnumLabeledArg(param0, param1) {
  this._0 = param0;
  this._1 = param1;
}
_M0DTPC15debug4Repr14EnumLabeledArg.prototype.$tag = 13;
function _M0DTPC15debug4Repr6Opaque(param0, param1) {
  this._0 = param0;
  this._1 = param1;
}
_M0DTPC15debug4Repr6Opaque.prototype.$tag = 14;
function _M0DTPC15debug4Repr7Literal(param0) {
  this._0 = param0;
}
_M0DTPC15debug4Repr7Literal.prototype.$tag = 15;
function _M0DTPC15debug4Repr8MapEntry(param0, param1) {
  this._0 = param0;
  this._1 = param1;
}
_M0DTPC15debug4Repr8MapEntry.prototype.$tag = 16;
function _M0DTPC15debug4Repr7Omitted() {}
_M0DTPC15debug4Repr7Omitted.prototype.$tag = 17;
const _M0DTPC15debug4Repr7Omitted__ = new _M0DTPC15debug4Repr7Omitted();
function _M0TPC15debug13ContentParens(param0, param1) {
  this.size = param0;
  this.lines = param1;
}
function _M0TPC15debug7Content(param0, param1, param2) {
  this.size = param0;
  this.lines = param1;
  this.needs_parens = param2;
}
function _M0TPC13ref3RefGRPB5ArrayGUssEEE(param0) {
  this.val = param0;
}
function _M0TPC13ref3RefGsE(param0) {
  this.val = param0;
}
function _M0TPC13ref3RefGiE(param0) {
  this.val = param0;
}
function _M0DTPC16result6ResultGuRPB7FailureE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGuRPB7FailureE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGuRPB7FailureE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGuRPB7FailureE2Ok.prototype.$tag = 1;
function _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(param0) {
  this._0 = param0;
}
_M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure.prototype.$tag = 5;
function _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid(param0) {
  this._0 = param0;
}
_M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid.prototype.$tag = 4;
function _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eReturn(param0) {
  this._0 = param0;
}
_M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eReturn.prototype.$tag = 3;
function _M0DTPC15error5Error36localreview_2ftcl_2eTclError_2eBreak() {}
_M0DTPC15error5Error36localreview_2ftcl_2eTclError_2eBreak.prototype.$tag = 2;
const _M0DTPC15error5Error36localreview_2ftcl_2eTclError_2eBreak__ = new _M0DTPC15error5Error36localreview_2ftcl_2eTclError_2eBreak();
function _M0DTPC15error5Error39localreview_2ftcl_2eTclError_2eContinue() {}
_M0DTPC15error5Error39localreview_2ftcl_2eTclError_2eContinue.prototype.$tag = 1;
const _M0DTPC15error5Error39localreview_2ftcl_2eTclError_2eContinue__ = new _M0DTPC15error5Error39localreview_2ftcl_2eTclError_2eContinue();
function _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(param0) {
  this._0 = param0;
}
_M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal.prototype.$tag = 0;
function _M0DTPC16result6ResultGdRPB7FailureE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGdRPB7FailureE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGdRPB7FailureE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGdRPB7FailureE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGORPC28internal7strconv6NumberRPB7FailureE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGORPC28internal7strconv6NumberRPB7FailureE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGORPC28internal7strconv6NumberRPB7FailureE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGORPC28internal7strconv6NumberRPB7FailureE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGRPC16string10StringViewRPB7FailureE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPC16string10StringViewRPB7FailureE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRPC16string10StringViewRPB7FailureE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPC16string10StringViewRPB7FailureE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGORPC28internal7strconv6NumberRPC15error5ErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGORPC28internal7strconv6NumberRPC15error5ErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGORPC28internal7strconv6NumberRPC15error5ErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGORPC28internal7strconv6NumberRPC15error5ErrorE2Ok.prototype.$tag = 1;
function _M0TPC28internal7strconv6Number(param0, param1, param2, param3) {
  this.exponent = param0;
  this.mantissa = param1;
  this.negative = param2;
  this.many_digits = param3;
}
function _M0DTPC16result6ResultGdRPC15error5ErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGdRPC15error5ErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGdRPC15error5ErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGdRPC15error5ErrorE2Ok.prototype.$tag = 1;
function $i64_clz(a) {
  a = BigInt.asUintN(64, a);
  if (a === 0n) return 64;
  const hi = Number(a >> 32n);
  if (hi !== 0) {
    return Math.clz32(hi);
  }
  return 32 + Math.clz32(Number(a & 0xffffffffn));
}
function _M0TPC28internal7strconv12EiselProduct(param0, param1) {
  this.lo = param0;
  this.hi = param1;
}
function _M0TPC28internal7strconv7Decimal(param0, param1, param2, param3, param4, param5) {
  this.digits = param0;
  this.digits_num = param1;
  this.decimal_point = param2;
  this.negative = param3;
  this.truncated = param4;
  this.overflowed = param5;
}
function _M0DTPC16result6ResultGRPC28internal7strconv7DecimalRPC15error5ErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPC28internal7strconv7DecimalRPC15error5ErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRPC28internal7strconv7DecimalRPC15error5ErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPC28internal7strconv7DecimalRPC15error5ErrorE2Ok.prototype.$tag = 1;
function $f64_convert_i64_u(a) {
  return Number(a);
}
function _M0DTPC16option6OptionGdE4None() {}
_M0DTPC16option6OptionGdE4None.prototype.$tag = 0;
const _M0DTPC16option6OptionGdE4None__ = new _M0DTPC16option6OptionGdE4None();
function _M0DTPC16option6OptionGdE4Some(param0) {
  this._0 = param0;
}
_M0DTPC16option6OptionGdE4Some.prototype.$tag = 1;
function _M0DTPC14json10WriteFrame5Array(param0, param1) {
  this._0 = param0;
  this._1 = param1;
}
_M0DTPC14json10WriteFrame5Array.prototype.$tag = 0;
function _M0DTPC14json10WriteFrame6Object(param0, param1) {
  this._0 = param0;
  this._1 = param1;
}
_M0DTPC14json10WriteFrame6Object.prototype.$tag = 1;
function _M0DTPC16result6ResultGRPC16bigint6BigIntRPB7FailureE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPC16bigint6BigIntRPB7FailureE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRPC16bigint6BigIntRPB7FailureE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPC16bigint6BigIntRPB7FailureE2Ok.prototype.$tag = 1;
function $i32_ctz(a) {
  a >>>= 0;
  if (a === 0) return 32;
  a &= -a;
  return 31 - Math.clz32(a);
}
const _M0MPC16bigint6BigInt9from__int = (x) => BigInt(x);
function _M0DTPC16result6ResultGRPC16bigint6BigIntRPC15error5ErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPC16bigint6BigIntRPC15error5ErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRPC16bigint6BigIntRPC15error5ErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPC16bigint6BigIntRPC15error5ErrorE2Ok.prototype.$tag = 1;
const _M0MPC16bigint6BigInt17js__parse__string = (str, start, end, base, some, none) => {
  try {
    if (base === 10) {
      const input = start === 0 && end === str.length ? str : str.slice(start, end);
      return some(BigInt(input));
    }
    const negative = str.charCodeAt(start) === 45;
    const digits = str.slice(negative ? start + 1 : start, end);
    const prefix = base === 2 ? "0b" : base === 8 ? "0o" : "0x";
    const value = BigInt(prefix + digits);
    return some(negative ? -value : value);
  } catch (_) {
    return none;
  }
};
function _M0DTPC16option6OptionGRPC16bigint6BigIntE4None() {}
_M0DTPC16option6OptionGRPC16bigint6BigIntE4None.prototype.$tag = 0;
const _M0DTPC16option6OptionGRPC16bigint6BigIntE4None__ = new _M0DTPC16option6OptionGRPC16bigint6BigIntE4None();
function _M0DTPC16option6OptionGRPC16bigint6BigIntE4Some(param0) {
  this._0 = param0;
}
_M0DTPC16option6OptionGRPC16bigint6BigIntE4Some.prototype.$tag = 1;
const _M0MPC16bigint6BigInt21js__to__string__radix = (x, radix) => x.toString(radix);
const _M0MPC16bigint6BigInt11compare__js = (x, y) => x < y ? -1 : x > y ? 1 : 0;
const _M0MPC16bigint6BigInt9equal__js = (x, y) => x === y;
const _M0MPC16bigint6BigInt12op__neg__ffi = (x) => -x;
const _M0MPC16bigint6BigInt12op__add__ffi = (x, y) => x + y;
const _M0MPC16bigint6BigInt12op__sub__ffi = (x, y) => x - y;
const _M0MPC16bigint6BigInt12op__mul__ffi = (x, y) => x * y;
const _M0MPC16bigint6BigInt12op__div__ffi = (x, y) => x / y;
const _M0MPC16bigint6BigInt12op__mod__ffi = (x, y) => x % y;
const _M0MPC16bigint6BigInt11modpow__ffi = (x, y, z) => {
  if (z === 1n) return 0n;
  let result = 1n;
  x = ((x % z) + z) % z;
  while (y > 0n) {
    if (y & 1n) {
       result = (result * x) % z;
    }
    y >>= 1n;
    x = (x * x) % z;
  }
  return result;
};
const _M0MPC16bigint6BigInt8pow__ffi = (x, y) => x ** y;
const _M0MPC16bigint6BigInt7js__shl = (x, y) => x << BigInt(y);
const _M0MPC16bigint6BigInt7js__shr = (x, y) => x >> BigInt(y);
const _M0MPC16bigint6BigInt8js__land = (x, y) => x & y;
const _M0MPC16bigint6BigInt7js__lor = (x, y) => x | y;
const _M0MPC16bigint6BigInt8js__lxor = (x, y) => x ^ y;
const _M0MPC16bigint6BigInt7to__int = (x) => Number(BigInt.asIntN(32, x));
const _M0MPC16bigint6BigInt11bit__length = (n) => {
  if (n >= 0) {
    return n === 0n ? 0 : n.toString(2).length;
  } else {
    const absN = -n;
    const absMinus1 = absN - 1n;
    return absMinus1 === 0n ? 0 : absMinus1.toString(2).length;
  }
};
function _M0TPB9ArrayViewGUsRPC15debug4ReprEE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
function _M0DTPC16result6ResultGORP211localreview3tcl7BindingRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGORP211localreview3tcl7BindingRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGORP211localreview3tcl7BindingRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGORP211localreview3tcl7BindingRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0TP211localreview3tcl7Binding(param0, param1, param2) {
  this.cell = param0;
  this.index = param1;
  this.linked = param2;
}
function _M0TP211localreview3tcl4Cell(param0, param1) {
  this.value = param0;
  this.declared = param1;
}
function _M0TPB8MutLocalGsE(param0) {
  this.val = param0;
}
function _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0TP211localreview3tcl10Completion(param0, param1, param2, param3, param4) {
  this.code = param0;
  this.level = param1;
  this.value = param2;
  this.options = param3;
  this.skip_trace = param4;
}
function _M0TPB8MutLocalGbE(param0) {
  this.val = param0;
}
function _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0DTP211localreview3tcl13VariableValue6Scalar(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl13VariableValue6Scalar.prototype.$tag = 0;
function _M0DTP211localreview3tcl13VariableValue8Sequence(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl13VariableValue8Sequence.prototype.$tag = 1;
function _M0DTP211localreview3tcl13VariableValue7Mapping(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl13VariableValue7Mapping.prototype.$tag = 2;
function _M0DTP211localreview3tcl13VariableValue8Elements(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl13VariableValue8Elements.prototype.$tag = 3;
function _M0TP211localreview3tcl11Interpreter(param0, param1, param2, param3, param4) {
  this.state = param0;
  this.frame = param1;
  this.output = param2;
  this.output_size = param3;
  this.budget = param4;
}
function _M0DTPC16result6ResultGRPC16bigint6BigIntRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPC16bigint6BigIntRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRPC16bigint6BigIntRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPC16bigint6BigIntRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0TPB8MutLocalGRP211localreview3tcl5FrameE(param0) {
  this.val = param0;
}
function _M0DTPC16result6ResultGRP211localreview3tcl5FrameRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl5FrameRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP211localreview3tcl5FrameRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl5FrameRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0DTP211localreview3tcl9GlobToken4Many() {}
_M0DTP211localreview3tcl9GlobToken4Many.prototype.$tag = 0;
const _M0DTP211localreview3tcl9GlobToken4Many__ = new _M0DTP211localreview3tcl9GlobToken4Many();
function _M0DTP211localreview3tcl9GlobToken3One() {}
_M0DTP211localreview3tcl9GlobToken3One.prototype.$tag = 1;
const _M0DTP211localreview3tcl9GlobToken3One__ = new _M0DTP211localreview3tcl9GlobToken3One();
function _M0DTP211localreview3tcl9GlobToken9Character(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl9GlobToken9Character.prototype.$tag = 2;
function _M0DTP211localreview3tcl9GlobToken5Range(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl9GlobToken5Range.prototype.$tag = 3;
function _M0TPB8MutLocalGRPB5ArrayGbEE(param0) {
  this.val = param0;
}
function _M0TPB8MutLocalGmE(param0) {
  this.val = param0;
}
function _M0TPB8MutLocalGRP211localreview3tcl7CommandE(param0) {
  this.val = param0;
}
function _M0DTP211localreview3tcl6Number5Small(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl6Number5Small.prototype.$tag = 0;
function _M0DTP211localreview3tcl6Number5Whole(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl6Number5Whole.prototype.$tag = 1;
function _M0DTP211localreview3tcl6Number4Real(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl6Number4Real.prototype.$tag = 2;
function _M0TP211localreview3tcl8Ensemble(param0, param1, param2, param3, param4, param5, param6) {
  this.namespace_name = param0;
  this.mapping = param1;
  this.parameters = param2;
  this.prefixes = param3;
  this.subcommands = param4;
  this.unknown = param5;
  this.option_text = param6;
}
function _M0TP211localreview3tcl7Command(param0, param1) {
  this.name = param0;
  this.body = param1;
}
function _M0DTP211localreview3tcl11CommandBody6Native(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl11CommandBody6Native.prototype.$tag = 0;
function _M0DTP211localreview3tcl11CommandBody6Script(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl11CommandBody6Script.prototype.$tag = 1;
function _M0DTP211localreview3tcl11CommandBody8Imported(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl11CommandBody8Imported.prototype.$tag = 2;
function _M0DTP211localreview3tcl11CommandBody15EnsembleCommand(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl11CommandBody15EnsembleCommand.prototype.$tag = 3;
function _M0DTPC16result6ResultGRP211localreview3tcl10CompletionRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl10CompletionRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP211localreview3tcl10CompletionRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl10CompletionRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0TP211localreview3tcl13ScriptProgram(param0, param1, param2) {
  this.parser = param0;
  this.commands = param1;
  this.failure = param2;
}
function _M0TP211localreview3tcl12ScriptParser(param0, param1, param2, param3, param4, param5) {
  this.chars = param0;
  this.pos = param1;
  this.line_pos = param2;
  this.line = param3;
  this.command_start = param4;
  this.command_line = param5;
}
function _M0DTPC16option6OptionGRPB5ArrayGUssEEE4None() {}
_M0DTPC16option6OptionGRPB5ArrayGUssEEE4None.prototype.$tag = 0;
const _M0DTPC16option6OptionGRPB5ArrayGUssEEE4None__ = new _M0DTPC16option6OptionGRPB5ArrayGUssEEE4None();
function _M0DTPC16option6OptionGRPB5ArrayGUssEEE4Some(param0) {
  this._0 = param0;
}
_M0DTPC16option6OptionGRPB5ArrayGUssEEE4Some.prototype.$tag = 1;
function $f64_reinterpret_i64(a) {
  $reinterpret_view.setFloat64(0, a, false);
  return BigInt.asUintN(64, $reinterpret_view.getBigUint64(0, false));
}
function _M0TP211localreview3tcl13ParsedCommand(param0, param1, param2) {
  this.words = param0;
  this.source = param1;
  this.line = param2;
}
function _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl4PartERP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl4PartERP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl4PartERP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl4PartERP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0TPB8MutLocalGRPB13StringBuilderE(param0) {
  this.val = param0;
}
function _M0DTP211localreview3tcl4Part4Text(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl4Part4Text.prototype.$tag = 0;
function _M0DTP211localreview3tcl4Part8Variable(param0, param1) {
  this._0 = param0;
  this._1 = param1;
}
_M0DTP211localreview3tcl4Part8Variable.prototype.$tag = 1;
function _M0DTP211localreview3tcl4Part7Command(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl4Part7Command.prototype.$tag = 2;
function _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl13ParsedCommandERP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl13ParsedCommandERP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl13ParsedCommandERP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl13ParsedCommandERP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0TPB8MutLocalGRPB5ArrayGRP211localreview3tcl4WordEE(param0) {
  this.val = param0;
}
function _M0DTPC16result6ResultGRP211localreview3tcl4WordRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl4WordRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP211localreview3tcl4WordRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl4WordRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0TP211localreview3tcl4Word(param0, param1) {
  this.parts = param0;
  this.expand = param1;
}
function _M0DTPC16result6ResultGRP211localreview3tcl4PartRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl4PartRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP211localreview3tcl4PartRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl4PartRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0DTPC16option6OptionGRPB5ArrayGRP211localreview3tcl4PartEE4None() {}
_M0DTPC16option6OptionGRPB5ArrayGRP211localreview3tcl4PartEE4None.prototype.$tag = 0;
const _M0DTPC16option6OptionGRPB5ArrayGRP211localreview3tcl4PartEE4None__ = new _M0DTPC16option6OptionGRPB5ArrayGRP211localreview3tcl4PartEE4None();
function _M0DTPC16option6OptionGRPB5ArrayGRP211localreview3tcl4PartEE4Some(param0) {
  this._0 = param0;
}
_M0DTPC16option6OptionGRPB5ArrayGRP211localreview3tcl4PartEE4Some.prototype.$tag = 1;
function _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0TPB8MutLocalGRP211localreview3tcl4ExprE(param0) {
  this.val = param0;
}
function _M0DTP211localreview3tcl4Expr5Value(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl4Expr5Value.prototype.$tag = 0;
function _M0DTP211localreview3tcl4Expr10Substitute(param0) {
  this._0 = param0;
}
_M0DTP211localreview3tcl4Expr10Substitute.prototype.$tag = 1;
function _M0DTP211localreview3tcl4Expr5Unary(param0, param1) {
  this._0 = param0;
  this._1 = param1;
}
_M0DTP211localreview3tcl4Expr5Unary.prototype.$tag = 2;
function _M0DTP211localreview3tcl4Expr6Binary(param0, param1, param2) {
  this._0 = param0;
  this._1 = param1;
  this._2 = param2;
}
_M0DTP211localreview3tcl4Expr6Binary.prototype.$tag = 3;
function _M0DTP211localreview3tcl4Expr11Conditional(param0, param1, param2) {
  this._0 = param0;
  this._1 = param1;
  this._2 = param2;
}
_M0DTP211localreview3tcl4Expr11Conditional.prototype.$tag = 4;
function _M0DTP211localreview3tcl4Expr8Function(param0, param1) {
  this._0 = param0;
  this._1 = param1;
}
_M0DTP211localreview3tcl4Expr8Function.prototype.$tag = 5;
function _M0TPB8MutLocalGUsiEE(param0) {
  this.val = param0;
}
function _M0DTPC16result6ResultGRPB5ArrayGUssEERP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPB5ArrayGUssEERP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRPB5ArrayGUssEERP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPB5ArrayGUssEERP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0TPB9ArrayViewGUsiEE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
function _M0TP211localreview3tcl10DictObject(param0, param1, param2, param3, param4, param5) {
  this.keys = param0;
  this.values = param1;
  this.index = param2;
  this.encoded = param3;
  this.units = param4;
  this.representation = param5;
}
function _M0DTPC16result6ResultGRP211localreview3tcl10DictObjectRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl10DictObjectRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP211localreview3tcl10DictObjectRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl10DictObjectRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl7CommandERP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl7CommandERP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl7CommandERP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl7CommandERP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0TPB8MutLocalGOsE(param0) {
  this.val = param0;
}
function _M0DTPC16result6ResultGORPB5ArrayGsERP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGORPB5ArrayGsERP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGORPB5ArrayGsERP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGORPB5ArrayGsERP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0TP211localreview3tcl10ListObject(param0, param1, param2, param3) {
  this.values = param0;
  this.encoded = param1;
  this.units = param2;
  this.representation = param3;
}
function _M0DTPC16result6ResultGRP211localreview3tcl10ListObjectRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl10ListObjectRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP211localreview3tcl10ListObjectRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl10ListObjectRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0TP211localreview3tcl9Procedure(param0, param1, param2) {
  this.parameters = param0;
  this.body = param1;
  this.namespace_name = param2;
}
function _M0TPB8MutLocalGOiE(param0) {
  this.val = param0;
}
function _M0DTPC16result6ResultGUssERP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGUssERP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGUssERP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGUssERP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0TP211localreview3tcl5Frame(param0, param1, param2, param3) {
  this.vars = param0;
  this.namespace_name = param1;
  this.procedure = param2;
  this.parent = param3;
}
function _M0TPB9ArrayViewGUsRP211localreview3tcl7BindingEE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
function _M0TPB8MutLocalGORPB13StringBuilderE(param0) {
  this.val = param0;
}
function _M0DTPC16result6ResultGRP211localreview3tcl6NumberRP211localreview3tcl8TclErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl6NumberRP211localreview3tcl8TclErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP211localreview3tcl6NumberRP211localreview3tcl8TclErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP211localreview3tcl6NumberRP211localreview3tcl8TclErrorE2Ok.prototype.$tag = 1;
function _M0TP211localreview3tcl7Handler(param0, param1, param2, param3) {
  this.code = param0;
  this.pattern = param1;
  this.variables = param2;
  this.script = param3;
}
function _M0TPB8MutLocalGRP211localreview3tcl10CompletionE(param0) {
  this.val = param0;
}
function _M0TPB8MutLocalGORPB5ArrayGsEE(param0) {
  this.val = param0;
}
function _M0TP211localreview3tcl10ParseCache(param0, param1, param2, param3, param4, param5) {
  this.scripts = param0;
  this.expressions = param1;
  this.script_units = param2;
  this.expression_units = param3;
  this.script_hits = param4;
  this.expression_hits = param5;
}
function _M0TPB9ArrayViewGUsRP211localreview3tcl13ScriptProgramEE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
function _M0TPB9ArrayViewGUsRP211localreview3tcl4ExprEE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
function _M0TPB9ArrayViewGUsRP211localreview3tcl7CommandEE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
function _M0TPB9ArrayViewGUsRP211localreview3tcl4CellEE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
function _M0TPB9ArrayViewGUsRPB5ArrayGsEEE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
function _M0TPB9ArrayViewGUsbEE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
function _M0TP211localreview3tcl5State(param0, param1, param2, param3, param4, param5, param6, param7, param8, param9) {
  this.globals = param0;
  this.aliases = param1;
  this.commands = param2;
  this.exports = param3;
  this.namespace_paths = param4;
  this.unknown_handlers = param5;
  this.namespaces = param6;
  this.return_options = param7;
  this.error_stack = param8;
  this.cache = param9;
}
function _M0TPB9ArrayViewGUsRPB4JsonEE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
const _M0FP092moonbitlang_2fcore_2fbuiltin_2fStringBuilder_24as_24_40moonbitlang_2fcore_2fbuiltin_2eLogger = { method_0: _M0IPB13StringBuilderPB6Logger13write__string, method_1: _M0IP016_24default__implPB6Logger16write__substringGRPB13StringBuilderE, method_2: _M0IPB13StringBuilderPB6Logger11write__view, method_3: _M0IPB13StringBuilderPB6Logger11write__char, method_4: _M0IP016_24default__implPB6Logger28write__string__interpolationGRPB13StringBuilderE, method_5: _M0IP016_24default__implPB6Logger5writeGRPB13StringBuilderE };
const _M0MPC16string6String9trim__endN7_2abindS6844 = "\t\n\r ";
const _M0MPC16string6String4trimN7_2abindS6861 = "\t\n\r ";
const _M0FPB18double__max__value = $i64_reinterpret_f64(9218868437227405311n);
const _M0FPB18double__min__value = $i64_reinterpret_f64(18442240474082181119n);
const _M0MPB4Iter4nextN6constrS9855GUsRPB4JsonEE = 0;
const _M0MPB4Iter4nextN6constrS9856GUsRPB4JsonEE = 0;
const _M0MPB4Iter4nextN6constrS9855GcE = 0;
const _M0MPB4Iter4nextN6constrS9856GcE = 0;
const _M0MPB4Iter3newN6constrS9863GUsRPB4JsonEE = 0;
const _M0MPB4Iter3newN6constrS9863GcE = 0;
const _M0FPC16double14not__a__number = $i64_reinterpret_f64(9221120237041090561n);
const _M0FPC16double8infinity = $i64_reinterpret_f64(9218868437227405312n);
const _M0FPC16double13neg__infinity = $i64_reinterpret_f64(18442240474082181120n);
const _M0FPC15debug14compact__linesN7_2abindS1134 = "";
const _M0FPC15debug14compact__linesN7_2abindS1147 = " ";
const _M0FPC15debug14compact__linesN7_2abindS1141 = ",";
const _M0FPC15debug14compact__linesN7_2abindS1139 = " ";
const _M0FPC15debug14compact__linesN7_2abindS1138 = " ";
const _M0FPC15debug14compact__linesN7_2abindS1136 = "";
const _M0FPC15debug14compact__linesN7_2abindS1148 = "(";
const _M0FPC15debug14compact__linesN7_2abindS1152 = "";
const _M0FPC15debug14compact__linesN7_2abindS1161 = " ";
const _M0FPC15debug14compact__linesN7_2abindS1155 = ",";
const _M0FPC15debug14compact__linesN7_2abindS1166 = " ";
const _M0FPC15debug19bracket__seq__linesN7_2abindS1175 = "";
const _M0FPC15debug14print__contentN7_2abindS1244 = "\n";
const _M0FPC28internal7strconv15range__err__str = "value out of range";
const _M0FPC28internal7strconv16syntax__err__str = "invalid syntax";
const _M0FPC28internal7strconv17min__19digit__int = 1000000000000000000n;
const _M0FPC28internal7strconv17parse__scientificN8exp__numS354 = 0n;
const _M0FPC28internal7strconv27eisel__lemire__pow10__table = [18054884314459144840n, 1671618768450675795n, 11284302696536965525n, 1044761730281672372n, 14105378370671206906n, 5917638181279478369n, 17631722963339008632n, 16620419763454123769n, 11019826852086880395n, 10387762352158827356n, 13774783565108600494n, 8373016921771146291n, 17218479456385750618n, 1242899115359157055n, 10761549660241094136n, 5388497965526861063n, 13451937075301367670n, 6735622456908576329n, 16814921344126709587n, 17642900107990496220n, 10509325840079193492n, 8720969558280366185n, 13136657300098991865n, 10901211947850457732n, 16420821625123739831n, 18238200953240460069n, 10263013515702337394n, 18316404623416369399n, 12828766894627921743n, 13672133742415685941n, 16035958618284902179n, 12478481159592219522n, 10022474136428063862n, 5493207715531443249n, 12528092670535079827n, 16089881681269079869n, 15660115838168849784n, 15500666083158961933n, 9787572398855531115n, 9687916301974351208n, 12234465498569413894n, 7498209359040551106n, 15293081873211767368n, 149389661945913074n, 9558176170757354605n, 93368538716195671n, 11947720213446693256n, 4728396691822632493n, 14934650266808366570n, 5910495864778290617n, 9334156416755229106n, 8305745933913819539n, 11667695520944036383n, 1158810380537498616n, 14584619401180045478n, 15283571030954036982n, 18230774251475056848n, 9881091751837770420n, 11394233907171910530n, 6175682344898606512n, 14242792383964888162n, 16942974967978033949n, 17803490479956110203n, 11955346673117766628n, 11127181549972568877n, 5166248661484910190n, 13908976937465711096n, 11069496845283525642n, 17386221171832138870n, 13836871056604407053n, 10866388232395086794n, 4036358391950366504n, 13582985290493858492n, 14268820026792733938n, 16978731613117323115n, 17836025033490917422n, 10611707258198326947n, 8841672636718129437n, 13264634072747908684n, 6440404777470273892n, 16580792590934885855n, 8050505971837842365n, 10362995369334303659n, 11949095260039733334n, 12953744211667879574n, 10324683056622278764n, 16192180264584849468n, 3682481783923072647n, 10120112665365530917n, 11524923151806696212n, 12650140831706913647n, 571095884476206553n, 15812676039633642058n, 14548927910877421904n, 9882922524771026286n, 13704765962725776594n, 12353653155963782858n, 7907585416552444934n, 15442066444954728573n, 661109733835780360n, 9651291528096705358n, 2719036592861056677n, 12064114410120881697n, 12622167777931096654n, 15080143012651102122n, 1942651667131707105n, 9425089382906938826n, 5825843310384704845n, 11781361728633673532n, 16505676174835656864n, 14726702160792091916n, 2185351144835019464n, 18408377700990114895n, 2731688931043774330n, 11505236063118821809n, 8624834609543440812n, 14381545078898527261n, 15392729280356688919n, 17976931348623159077n, 5405853545163697437n, 11235582092889474423n, 5684501474941004850n, 14044477616111843029n, 2493940825248868159n, 17555597020139803786n, 7729112049988473103n, 10972248137587377366n, 9442381049670183593n, 13715310171984221708n, 2579604275232953683n, 17144137714980277135n, 3224505344041192104n, 10715086071862673209n, 8932844867666826921n, 13393857589828341511n, 15777742103010921555n, 16742321987285426889n, 15110491610336264040n, 10463951242053391806n, 2526528228819083169n, 13079939052566739757n, 12381532322878629770n, 16349923815708424697n, 1641857348316123500n, 10218702384817765435n, 12555375888766046947n, 12773377981022206794n, 11082533842530170780n, 15966722476277758493n, 4629795266307937667n, 9979201547673599058n, 5199465050656154994n, 12474001934591998822n, 15722703350174969551n, 15592502418239998528n, 10430007150863936130n, 9745314011399999080n, 6518754469289960081n, 12181642514249998850n, 8148443086612450102n, 15227053142812498563n, 962181821410786819n, 9516908214257811601n, 16742264702877599426n, 11896135267822264502n, 7092772823314835570n, 14870169084777830627n, 18089338065998320271n, 9293855677986144142n, 8999993282035256217n, 11617319597482680178n, 2026619565689294464n, 14521649496853350222n, 11756646493966393888n, 18152061871066687778n, 5472436080603216552n, 11345038669416679861n, 8031958568804398249n, 14181298336770849826n, 14651634229432885715n, 17726622920963562283n, 9091170749936331336n, 11079139325602226427n, 3376138709496513133n, 13848924157002783033n, 18055231442152805128n, 17311155196253478792n, 8733981247408842698n, 10819471997658424245n, 5458738279630526686n, 13524339997073030306n, 11435108867965546262n, 16905424996341287883n, 5070514048102157020n, 10565890622713304927n, 863228270850154185n, 13207363278391631158n, 14914093393844856443n, 16509204097989538948n, 9419244705451294746n, 10318252561243461842n, 15110399977761835024n, 12897815701554327303n, 9664627935347517973n, 16122269626942909129n, 7469098900757009562n, 10076418516839318205n, 16197401859041600736n, 12595523146049147757n, 6411694268519837208n, 15744403932561434696n, 12626303854077184414n, 9840252457850896685n, 7891439908798240259n, 12300315572313620856n, 14475985904425188227n, 15375394465392026070n, 18094982380531485284n, 9609621540870016294n, 6697677969404790399n, 12012026926087520367n, 17595469498610763806n, 15015033657609400459n, 17382650854836066854n, 9384396036005875287n, 8558313775058847832n, 11730495045007344109n, 6086206200396171886n, 14663118806259180136n, 12219443768922602761n, 18328898507823975170n, 15274304711153253452n, 11455561567389984481n, 14158126462898171311n, 14319451959237480602n, 3862600023340550427n, 17899314949046850752n, 14051622066030463842n, 11187071843154281720n, 8782263791269039901n, 13983839803942852150n, 10977829739086299876n, 17479799754928565188n, 4498915137003099037n, 10924874846830353242n, 12035193997481712706n, 13656093558537941553n, 5820620459997365075n, 17070116948172426941n, 11887461593424094248n, 10668823092607766838n, 9735506505103752857n, 13336028865759708548n, 2946011094524915263n, 16670036082199635685n, 3682513868156144079n, 10418772551374772303n, 4607414176811284001n, 13023465689218465379n, 1147581702586717097n, 16279332111523081723n, 15269535183515560084n, 10174582569701926077n, 7237616480483531100n, 12718228212127407596n, 13658706619031801779n, 15897785265159259495n, 17073383273789752224n, 9936115790724537184n, 17588393573759676996n, 12420144738405671481n, 3538747893490044629n, 15525180923007089351n, 9035120885289943691n, 9703238076879430844n, 12564479580947296663n, 12129047596099288555n, 15705599476184120828n, 15161309495124110694n, 15020313326802763131n, 9475818434452569184n, 4776009810824339053n, 11844773043065711480n, 5970012263530423816n, 14805966303832139350n, 7462515329413029771n, 9253728939895087094n, 52386062455755702n, 11567161174868858867n, 9288854614924470436n, 14458951468586073584n, 6999382250228200141n, 18073689335732591980n, 8749227812785250177n, 11296055834832869987n, 14691639419845557168n, 14120069793541087484n, 13752863256379558556n, 17650087241926359355n, 17191079070474448196n, 11031304526203974597n, 8438581409832836170n, 13789130657754968246n, 15159912780718433117n, 17236413322193710308n, 9726518939043265588n, 10772758326371068942n, 15302446373756816800n, 13465947907963836178n, 9904685930341245193n, 16832434884954795223n, 3157485376071780683n, 10520271803096747014n, 8890957387685944783n, 13150339753870933768n, 1890324697752655170n, 16437924692338667210n, 2362905872190818963n, 10273702932711667006n, 6088502188546649756n, 12842128665889583757n, 16833999772538088003n, 16052660832361979697n, 7207441660390446292n, 10032913020226237310n, 16033866083812498692n, 12541141275282796638n, 10818960567910847557n, 15676426594103495798n, 4300328673033783639n, 9797766621314684873n, 16522763475928278486n, 12247208276643356092n, 6818396289628184396n, 15309010345804195115n, 8522995362035230495n, 9568131466127621947n, 3021029092058325107n, 11960164332659527433n, 17611344420355070096n, 14950205415824409292n, 8179122470161673908n, 9343878384890255807n, 14335323580705822000n, 11679847981112819759n, 13307468457454889596n, 14599809976391024699n, 12022649553391224092n, 18249762470488780874n, 10416625923311642211n, 11406101544055488046n, 11122077220497164286n, 14257626930069360058n, 4679224488766679549n, 17822033662586700072n, 15072402647813125244n, 11138771039116687545n, 9420251654883203278n, 13923463798895859431n, 16387000587031392001n, 17404329748619824289n, 15872064715361852097n, 10877706092887390181n, 3002511419460075705n, 13597132616109237726n, 8364825292752482535n, 16996415770136547158n, 1232659579085827361n, 10622759856335341973n, 14605470292210805812n, 13278449820419177467n, 4421779809981343554n, 16598062275523971834n, 915538744049291538n, 10373788922202482396n, 5183897733458195115n, 12967236152753102995n, 6479872166822743894n, 16209045190941378744n, 3488154190101041964n, 10130653244338361715n, 2180096368813151227n, 12663316555422952143n, 16560178516298602746n, 15829145694278690179n, 16088537126945865529n, 9893216058924181362n, 7749492695127472003n, 12366520073655226703n, 463493832054564196n, 15458150092069033378n, 14414425345350368957n, 9661343807543145861n, 13620701859271368502n, 12076679759428932327n, 3190819268807046916n, 15095849699286165408n, 17823582141290972357n, 9434906062053853380n, 11139738838306857723n, 11793632577567316725n, 13924673547883572154n, 14742040721959145907n, 3570783879572301480n, 18427550902448932383n, 18298537904747540562n, 11517219314030582739n, 18354115218108294707n, 14396524142538228424n, 18330958004207980480n, 17995655178172785531n, 4466953431550423984n, 11247284486357990957n, 486002885505321038n, 14059105607947488696n, 5219189625309039202n, 17573882009934360870n, 6523987031636299002n, 10983676256208975543n, 17912549950054850588n, 13729595320261219429n, 17779001419141175331n, 17161994150326524287n, 8388693718644305452n, 10726246343954077679n, 12160462601793772764n, 13407807929942597099n, 10588892233814828051n, 16759759912428246374n, 8624429273841147159n, 10474849945267653984n, 778582277723329070n, 13093562431584567480n, 973227847154161338n, 16366953039480709350n, 1216534808942701673n, 10229345649675443343n, 14595392310871352257n, 12786682062094304179n, 13632554370161802418n, 15983352577617880224n, 12429006944274865118n, 9989595361011175140n, 7768129340171790699n, 12486994201263968925n, 9710161675214738374n, 15608742751579961156n, 16749388112445810871n, 9755464219737475723n, 1244995533423855986n, 12194330274671844653n, 15391302472061983695n, 15242912843339805817n, 5404070034795315907n, 9526820527087378635n, 14906758817815542202n, 11908525658859223294n, 14021762503842039848n, 14885657073574029118n, 8303831092947774002n, 9303535670983768199n, 578208414664970847n, 11629419588729710248n, 14557818573613377271n, 14536774485912137810n, 18197273217016721589n, 18170968107390172263n, 13523219484416126178n, 11356855067118857664n, 15369541205401160717n, 14196068833898572081n, 765182433041899281n, 17745086042373215101n, 5568164059729762005n, 11090678776483259438n, 5785945546544795205n, 13863348470604074297n, 16455803970035769814n, 17329185588255092872n, 6734696907262548556n, 10830740992659433045n, 4209185567039092847n, 13538426240824291306n, 9873167977226253963n, 16923032801030364133n, 3118087934678041646n, 10576895500643977583n, 4254647968387469981n, 13221119375804971979n, 706623942056949572n, 16526399219756214973n, 14718337982853350677n, 10328999512347634358n, 11504804248497038125n, 12911249390434542948n, 5157633273766521849n, 16139061738043178685n, 6447041592208152311n, 10086913586276986678n, 6335244004343789146n, 12608641982846233347n, 17142427042284512241n, 15760802478557791684n, 16816347784428252397n, 9850501549098619803n, 1286845328412881940n, 12313126936373274753n, 15443614715798266137n, 15391408670466593442n, 5469460339465668959n, 9619630419041620901n, 8030098730593431003n, 12024538023802026126n, 14649309431669176658n, 15030672529752532658n, 9088264752731695015n, 9394170331095332911n, 10291851488884697288n, 11742712913869166139n, 8253128342678483706n, 14678391142336457674n, 5704724409920716729n, 18347988927920572092n, 16354277549255671720n, 11467493079950357558n, 998051431430019017n, 14334366349937946947n, 10470936326142299579n, 17917957937422433684n, 8476984389250486570n, 11198723710889021052n, 14521487280136329914n, 13998404638611276315n, 18151859100170412392n, 17498005798264095394n, 18078137856785627587n, 10936253623915059621n, 15910522178918405146n, 13670317029893824527n, 6053094668365842720n, 17087896287367280659n, 2954682317029915496n, 10679935179604550411n, 17987577512639554849n, 13349918974505688014n, 17872785872372055657n, 16687398718132110018n, 13117610303610293764n, 10429624198832568761n, 12810192458183821506n, 13037030248540710952n, 2177682517447613171n, 16296287810675888690n, 2722103146809516464n, 10185179881672430431n, 6313000485183335694n, 12731474852090538039n, 3279564588051781713n, 15914343565113172548n, 17934513790346890853n, 9946464728195732843n, 1985699082112030975n, 12433080910244666053n, 16317181907922202431n, 15541351137805832567n, 6561419329620589327n, 9713344461128645354n, 11018416108653950185n, 12141680576410806693n, 4549648098962661924n, 15177100720513508366n, 10298746142130715309n, 9485687950320942729n, 1825030320404309164n, 11857109937901178411n, 6892973918932774359n, 14821387422376473014n, 4004531380238580045n, 9263367138985295633n, 16337890167931276240n, 11579208923731619542n, 6587304654631931588n, 14474011154664524427n, 17457502855144690293n, 18092513943330655534n, 17210192550503474962n, 11307821214581659709n, 6144684325637283947n, 14134776518227074636n, 12292541425473992838n, 17668470647783843295n, 15365676781842491048n, 11042794154864902059n, 16521077016292638761n, 13803492693581127574n, 16039660251938410547n, 17254365866976409468n, 10826203278068237376n, 10783978666860255917n, 15989749085647424168n, 13479973333575319897n, 6152128301777116498n, 16849966666969149871n, 12301846395648783526n, 10531229166855718669n, 14606183024921571560n, 13164036458569648337n, 4422670725869800738n, 16455045573212060421n, 10140024425764638826n, 10284403483257537763n, 8643358275316593218n, 12855504354071922204n, 6192511825718353619n, 16069380442589902755n, 7740639782147942024n, 10043362776618689222n, 2532056854628769813n, 12554203470773361527n, 12388443105140738074n, 15692754338466701909n, 10873867862998534689n, 9807971461541688693n, 9102010423587778132n, 12259964326927110866n, 15989199047912110569n, 15324955408658888583n, 10763126773035362404n, 9578097130411805364n, 13644483260788183358n, 11972621413014756705n, 17055604075985229198n, 14965776766268445882n, 7484447039699372786n, 9353610478917778676n, 9289465418239495895n, 11692013098647223345n, 11611831772799369869n, 14615016373309029182n, 679731660717048624n, 18268770466636286477n, 10073036612751086588n, 11417981541647679048n, 8601490892183123069n, 14272476927059598810n, 10751863615228903837n, 17840596158824498513n, 4216457482181353988n, 11150372599265311570n, 14164500972431816002n, 13937965749081639463n, 8482254178684994195n, 17422457186352049329n, 5991131704928854840n, 10889035741470030830n, 15273672361649004035n, 13611294676837538538n, 9868718415206479236n, 17014118346046923173n, 3112525982153323237n, 10633823966279326983n, 4251171748059520975n, 13292279957849158729n, 702278666647013314n, 16615349947311448411n, 5489534351736154547n, 10384593717069655257n, 1125115960621402640n, 12980742146337069071n, 6018080969204141204n, 16225927682921336339n, 2910915193077788601n, 10141204801825835211n, 17960223060169475539n, 12676506002282294014n, 17838592806784456520n, 15845632502852867518n, 13074868971625794843n, 9903520314283042199n, 3560107088838733872n, 12379400392853802748n, 18285191916330581053n, 15474250491067253436n, 4409745821703674700n, 9671406556917033397n, 11979463175419572495n, 12089258196146291747n, 1139270913992301907n, 15111572745182864683n, 15259146697772541096n, 9444732965739290427n, 7231123676894144233n, 11805916207174113034n, 4427218577690292387n, 14757395258967641292n, 14757395258967641292n, 9223372036854775808n, 0n, 11529215046068469760n, 0n, 14411518807585587200n, 0n, 18014398509481984000n, 0n, 11258999068426240000n, 0n, 14073748835532800000n, 0n, 17592186044416000000n, 0n, 10995116277760000000n, 0n, 13743895347200000000n, 0n, 17179869184000000000n, 0n, 10737418240000000000n, 0n, 13421772800000000000n, 0n, 16777216000000000000n, 0n, 10485760000000000000n, 0n, 13107200000000000000n, 0n, 16384000000000000000n, 0n, 10240000000000000000n, 0n, 12800000000000000000n, 0n, 16000000000000000000n, 0n, 10000000000000000000n, 0n, 12500000000000000000n, 0n, 15625000000000000000n, 0n, 9765625000000000000n, 0n, 12207031250000000000n, 0n, 15258789062500000000n, 0n, 9536743164062500000n, 0n, 11920928955078125000n, 0n, 14901161193847656250n, 0n, 9313225746154785156n, 4611686018427387904n, 11641532182693481445n, 5764607523034234880n, 14551915228366851806n, 11817445422220181504n, 18189894035458564758n, 5548434740920451072n, 11368683772161602973n, 17302829768357445632n, 14210854715202003717n, 7793479155164643328n, 17763568394002504646n, 14353534962383192064n, 11102230246251565404n, 4359273333062107136n, 13877787807814456755n, 5449091666327633920n, 17347234759768070944n, 2199678564482154496n, 10842021724855044340n, 1374799102801346560n, 13552527156068805425n, 1718498878501683200n, 16940658945086006781n, 6759809616554491904n, 10587911840678754238n, 6530724019560251392n, 13234889800848442797n, 17386777061305090048n, 16543612251060553497n, 7898413271349198848n, 10339757656912845935n, 16465723340661719040n, 12924697071141057419n, 15970468157399760896n, 16155871338926321774n, 15351399178322313216n, 10097419586828951109n, 4982938468024057856n, 12621774483536188886n, 10840359103457460224n, 15777218104420236108n, 4327076842467049472n, 9860761315262647567n, 11927795063396681728n, 12325951644078309459n, 10298057810818464256n, 15407439555097886824n, 8260886245095692416n, 9629649721936179265n, 5163053903184807760n, 12037062152420224081n, 11065503397408397604n, 15046327690525280101n, 18443565265187884909n, 9403954806578300063n, 13833071299956122020n, 11754943508222875079n, 12679653106517764621n, 14693679385278593849n, 11237880364719817872n, 18367099231598242312n, 212292400617608628n, 11479437019748901445n, 132682750386005392n, 14349296274686126806n, 4777539456409894645n, 17936620343357658507n, 15195296357367144114n, 11210387714598536567n, 7191217214140771119n, 14012984643248170709n, 4377335499248575995n, 17516230804060213386n, 10083355392488107898n, 10947644252537633366n, 10913783138732455340n, 13684555315672041708n, 4418856886560793367n, 17105694144590052135n, 5523571108200991709n, 10691058840368782584n, 10369760970266701674n, 13363823550460978230n, 12962201212833377092n, 16704779438076222788n, 6979379479186945558n, 10440487148797639242n, 13585484211346616781n, 13050608935997049053n, 7758483227328495169n, 16313261169996311316n, 14309790052588006865n, 10195788231247694572n, 18166990819722280098n, 12744735289059618216n, 4261994450943298507n, 15930919111324522770n, 5327493063679123134n, 9956824444577826731n, 7941369183226839863n, 12446030555722283414n, 5315025460606161924n, 15557538194652854267n, 15867153862612478214n, 9723461371658033917n, 7611128154919104931n, 12154326714572542396n, 14125596212076269068n, 15192908393215677995n, 17656995265095336336n, 9495567745759798747n, 8729779031470891258n, 11869459682199748434n, 6300537770911226168n, 14836824602749685542n, 17099044250493808518n, 9273015376718553464n, 6075216638131242420n, 11591269220898191830n, 7594020797664053025n, 14489086526122739788n, 269153960225290473n, 18111358157653424735n, 336442450281613091n, 11319598848533390459n, 7127805559067090038n, 14149498560666738074n, 4298070930406474644n, 17686873200833422592n, 14595960699862869113n, 11054295750520889120n, 9122475437414293195n, 13817869688151111400n, 11403094296767866494n, 17272337110188889250n, 14253867870959833118n, 10795210693868055781n, 13520353437777283602n, 13494013367335069727n, 3065383741939440791n, 16867516709168837158n, 17666787732706464701n, 10542197943230523224n, 6430056314514152534n, 13177747429038154030n, 8037570393142690668n, 16472184286297692538n, 823590954573587527n, 10295115178936057836n, 5126430365035880108n, 12868893973670072295n, 6408037956294850135n, 16086117467087590369n, 3398361426941174765n, 10053823416929743980n, 13653190937906703988n, 12567279271162179975n, 17066488672383379985n, 15709099088952724969n, 16721424822051837077n, 9818186930595453106n, 3533361486141316317n, 12272733663244316382n, 13640073894531421205n, 15340917079055395478n, 7826720331309500698n, 9588073174409622174n, 280014188641050032n, 11985091468012027717n, 9573389772656088348n, 14981364335015034646n, 16578423234247498339n, 9363352709384396654n, 5749828502977298558n, 11704190886730495817n, 16410657665576399005n, 14630238608413119772n, 6678264026688335045n, 18287798260516399715n, 8347830033360418806n, 11429873912822749822n, 2911550761636567802n, 14287342391028437277n, 12862810488900485560n, 17859177988785546597n, 2243455055843443238n, 11161986242990966623n, 3708002419115845976n, 13952482803738708279n, 23317005467419566n, 17440603504673385348n, 13864204312116438170n, 10900377190420865842n, 17888499731927549664n, 13625471488026082303n, 13137252628054661272n, 17031839360032602879n, 11809879766640938686n, 10644899600020376799n, 14298703881791668535n, 13306124500025470999n, 13261693833812197764n, 16632655625031838749n, 11965431273837859301n, 10395409765644899218n, 9784237555362356015n, 12994262207056124023n, 3006924907348169211n, 16242827758820155028n, 17593714189467375226n, 10151767349262596893n, 1772699331562333708n, 12689709186578246116n, 6827560182880305039n, 15862136483222807645n, 8534450228600381299n, 9913835302014254778n, 7639874402088932264n, 12392294127517818473n, 326470965756389522n, 15490367659397273091n, 5019774725622874806n, 9681479787123295682n, 831516194300602802n, 12101849733904119602n, 10262767279730529310n, 15127312167380149503n, 3605087062808385830n, 9454570104612593439n, 9170708441896323000n, 11818212630765741799n, 6851699533943015846n, 14772765788457177249n, 3952938399001381903n, 9232978617785735780n, 13999801545444333449n, 11541223272232169725n, 17499751931805416812n, 14426529090290212157n, 8039631859474607303n, 18033161362862765196n, 14661225842770647033n, 11270725851789228247n, 18386638188586430203n, 14088407314736535309n, 18371611717305649850n, 17610509143420669137n, 9129456591349898601n, 11006568214637918210n, 17235125415662156385n, 13758210268297397763n, 12320534732722919674n, 17197762835371747204n, 10788982397476261688n, 10748601772107342002n, 15966486035277439363n, 13435752215134177503n, 10734735507242023396n, 16794690268917721879n, 8806733365625141341n, 10496681418073576174n, 12421737381156795194n, 13120851772591970218n, 6303799689591218185n, 16401064715739962772n, 17103121648843798539n, 10250665447337476733n, 1466078993672598279n, 12813331809171845916n, 6444284760518135752n, 16016664761464807395n, 8055355950647669691n, 10010415475915504622n, 2728754459941099604n, 12513019344894380777n, 12634315111781150314n, 15641274181117975972n, 1957835834444274180n, 9775796363198734982n, 10447019433382447170n, 12219745453998418728n, 3835402254873283155n, 15274681817498023410n, 4794252818591603944n, 9546676135936264631n, 7608094030047140369n, 11933345169920330789n, 4898431519131537557n, 14916681462400413486n, 10734725417341809851n, 9322925914000258429n, 2097517367411243253n, 11653657392500323036n, 7233582727691441970n, 14567071740625403795n, 9041978409614302462n, 18208839675781754744n, 6690786993590490174n, 11380524797363596715n, 4181741870994056359n, 14225655996704495894n, 615491320315182544n, 17782069995880619867n, 9992736187248753989n, 11113793747425387417n, 3939617107816777291n, 13892242184281734271n, 9536207403198359517n, 17365302730352167839n, 7308573235570561493n, 10853314206470104899n, 11485387299872682789n, 13566642758087631124n, 9745048106413465582n, 16958303447609538905n, 12181310133016831978n, 10598939654755961816n, 695789805494438130n, 13248674568444952270n, 869737256868047663n, 16560843210556190337n, 10310543607939835386n, 10350527006597618960n, 17973304801030866876n, 12938158758247023701n, 4019886927579031980n, 16172698447808779626n, 9636544677901177879n, 10107936529880487266n, 10634526442115624078n, 12634920662350609083n, 4069786015789754290n, 15793650827938261354n, 475546501309804958n, 9871031767461413346n, 4908902581746016003n, 12338789709326766682n, 15359500264037295811n, 15423487136658458353n, 9976003293191843956n, 9639679460411536470n, 17764217104313372233n, 12049599325514420588n, 12981899343536939483n, 15061999156893025735n, 16227374179421174354n, 9413749473058141084n, 17059637889779315827n, 11767186841322676356n, 2877803288514593168n, 14708983551653345445n, 3597254110643241460n, 18386229439566681806n, 9108253656731439729n, 11491393399729176129n, 1080972517029761926n, 14364241749661470161n, 5962901664714590312n, 17955302187076837701n, 12065313099320625794n, 11222063866923023563n, 9846663696289085073n, 14027579833653779454n, 7696643601933968437n, 17534474792067224318n, 397432465562684739n, 10959046745042015198n, 14083453346258841674n, 13698808431302518998n, 8380944645968776284n, 17123510539128148748n, 1252808770606194547n, 10702194086955092967n, 10006377518483647400n, 13377742608693866209n, 7896285879677171346n, 16722178260867332761n, 14482043368023852087n, 10451361413042082976n, 2133748077373825698n, 13064201766302603720n, 2667185096717282123n, 16330252207878254650n, 3333981370896602653n, 10206407629923909156n, 6695424375237764562n, 12758009537404886445n, 8369280469047205703n, 15947511921756108056n, 15073286604736395033n, 9967194951097567535n, 9420804127960246895n, 12458993688871959419n, 7164319141522920715n, 15573742111089949274n, 4343712908476262990n, 9733588819431218296n, 7326506586225052273n, 12166986024289022870n, 9158133232781315341n, 15208732530361278588n, 2224294504121868368n, 9505457831475799117n, 10613556101930943538n, 11881822289344748896n, 17878631145841067327n, 14852277861680936121n, 3901544858591782542n, 9282673663550585075n, 13967680582688333849n, 11603342079438231344n, 12847914709933029407n, 14504177599297789180n, 16059893387416286759n, 18130221999122236476n, 1628122660560806833n, 11331388749451397797n, 10240948699705280078n, 14164235936814247246n, 17412871893058988002n, 17705294921017809058n, 12542717829468959195n, 11065809325636130661n, 12450884661845487401n, 13832261657045163327n, 1728547772024695539n, 17290327071306454158n, 15995742770313033136n, 10806454419566533849n, 5385653213018257806n, 13508068024458167311n, 11343752534700210161n, 16885085030572709139n, 9568004649947874797n, 10553178144107943212n, 3674159897003727796n, 13191472680134929015n, 4592699871254659745n, 16489340850168661269n, 1129188820640936778n, 10305838031355413293n, 3011586022114279438n, 12882297539194266616n, 8376168546070237202n, 16102871923992833270n, 10470210682587796502n, 10064294952495520794n, 1932195658189984910n, 12580368690619400992n, 11638616609592256945n, 15725460863274251240n, 14548270761990321182n, 9828413039546407025n, 9092669226243950738n, 12285516299433008781n, 15977522551232326327n, 15356895374291260977n, 6136845133758244197n, 9598059608932038110n, 15364743254667372383n, 11997574511165047638n, 9982557031479439671n, 14996968138956309548n, 3254824252494523781n, 9373105086847693467n, 11257637194663853171n, 11716381358559616834n, 9460360474902428559n, 14645476698199521043n, 2602078556773259891n, 18306845872749401303n, 17087656251248738576n, 11441778670468375814n, 17597314184671543466n, 14302223338085469768n, 12773270693984653525n, 17877779172606837210n, 15966588367480816906n, 11173611982879273256n, 14590803748102898470n, 13967014978599091570n, 18238504685128623088n, 17458768723248864463n, 13574758819556003052n, 10911730452030540289n, 15401753289863583763n, 13639663065038175362n, 5417133557047315992n, 17049578831297719202n, 15994788983163920798n, 10655986769561074501n, 14608429132904838403n, 13319983461951343127n, 4425478360848884291n, 16649979327439178909n, 920161932633717460n, 10406237079649486818n, 2880944217109767365n, 13007796349561858522n, 12824552308241985014n, 16259745436952323153n, 6807318348447705459n, 10162340898095201970n, 15783789013848285672n, 12702926122619002463n, 10506364230455581282n, 15878657653273753079n, 8521269269642088699n, 9924161033296095674n, 12243322321167387293n, 12405201291620119593n, 6080780864604458308n, 15506501614525149491n, 12212662099182960789n, 9691563509078218432n, 5327070802775656541n, 12114454386347773040n, 6658838503469570676n, 15143067982934716300n, 8323548129336963345n, 9464417489334197687n, 14425589617690377899n, 11830521861667747109n, 13420301003685584469n, 14788152327084683887n, 2940318199324816875n, 9242595204427927429n, 8755227902219092403n, 11553244005534909286n, 15555720896201253407n, 14441555006918636608n, 10221279083396790951n, 18051943758648295760n, 12776598854245988689n, 11282464849155184850n, 7985374283903742931n, 14103081061443981063n, 758345818024902856n, 17628851326804976328n, 14782990327813292282n, 11018032079253110205n, 9239368954883307676n, 13772540099066387756n, 16160897212031522499n, 17215675123832984696n, 1754377441329851508n, 10759796952395615435n, 1096485900831157192n, 13449746190494519293n, 15205665431321110202n, 16812182738118149117n, 5172023733869224041n, 10507614211323843198n, 5538357842881958977n, 13134517764154803997n, 16146319340457224530n, 16418147205193504997n, 6347841120289366950n, 10261342003245940623n, 6273243709394548296n, 12826677504057425779n, 3229868618315797466n, 16033346880071782223n, 17872393828176910545n, 10020841800044863889n, 18087775170251650946n, 12526052250056079862n, 8774660907532399971n, 15657565312570099828n, 1744954097560724156n, 9785978320356312392n, 10313968347830228405n, 12232472900445390490n, 12892460434787785506n, 15290591125556738113n, 6892203506629956075n, 9556619453472961320n, 15836842237712192307n, 11945774316841201651n, 1349308723430688768n, 14932217896051502063n, 15521693959570524672n, 9332636185032188789n, 16618587752372659776n, 11665795231290235987n, 6938176635183661008n, 14582244039112794984n, 4061034775552188356n, 18227805048890993730n, 5076293469440235445n, 11392378155556871081n, 7784369436827535057n, 14240472694446088851n, 14342147814461806725n, 17800590868057611064n, 13315998749649870503n, 11125369292536006915n, 8322499218531169064n, 13906711615670008644n, 5791438004736573426n, 17383389519587510805n, 7239297505920716783n, 10864618449742194253n, 6830403950414141941n, 13580773062177742816n, 13149690956445065330n, 16975966327722178520n, 16437113695556331663n, 10609978954826361575n, 10273196059722707289n, 13262473693532951969n, 8229809056225996208n, 16578092116916189961n, 14898947338709883164n, 10361307573072618726n, 2394313059052595121n, 12951634466340773407n, 12216263360670519709n, 16189543082925966759n, 10658643182410761733n, 10118464426828729224n, 13579181016647807939n, 12648080533535911530n, 16973976270809759924n, 15810100666919889413n, 11994098301657424097n, 9881312916824930883n, 9802154447749584012n, 12351641146031163604n, 7641007041259592112n, 15439551432538954505n, 9551258801574490140n, 9649719645336846565n, 17498751797052526097n, 12062149556671058207n, 8038381691033493909n, 15077686945838822759n, 5436291095364479483n];
const _M0FPC28internal7strconv12double__info = new _M0TPC28internal7strconv9FloatInfo(52, 11, -1023);
const _M0FPC28internal7strconv25min__exponent__fast__path = 18446744073709551594n;
const _M0FPC28internal7strconv25max__exponent__fast__path = 22n;
const _M0FPC28internal7strconv36max__exponent__disguised__fast__path = 37n;
const _M0FPC28internal7strconv25max__mantissa__fast__path = 9007199254740992n;
const _M0FPC28internal7strconv6powtab = [1, 3, 6, 9, 13, 16, 19, 23, 26, 29, 33, 36, 39, 43, 46, 49, 53, 56, 59];
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1023 = { _0: 0, _1: "" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1024 = { _0: 1, _1: "5" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1025 = { _0: 1, _1: "25" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1026 = { _0: 1, _1: "125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1027 = { _0: 2, _1: "625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1028 = { _0: 2, _1: "3125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1029 = { _0: 2, _1: "15625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1030 = { _0: 3, _1: "78125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1031 = { _0: 3, _1: "390625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1032 = { _0: 3, _1: "1953125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1033 = { _0: 4, _1: "9765625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1034 = { _0: 4, _1: "48828125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1035 = { _0: 4, _1: "244140625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1036 = { _0: 4, _1: "1220703125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1037 = { _0: 5, _1: "6103515625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1038 = { _0: 5, _1: "30517578125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1039 = { _0: 5, _1: "152587890625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1040 = { _0: 6, _1: "762939453125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1041 = { _0: 6, _1: "3814697265625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1042 = { _0: 6, _1: "19073486328125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1043 = { _0: 7, _1: "95367431640625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1044 = { _0: 7, _1: "476837158203125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1045 = { _0: 7, _1: "2384185791015625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1046 = { _0: 7, _1: "11920928955078125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1047 = { _0: 8, _1: "59604644775390625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1048 = { _0: 8, _1: "298023223876953125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1049 = { _0: 8, _1: "1490116119384765625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1050 = { _0: 9, _1: "7450580596923828125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1051 = { _0: 9, _1: "37252902984619140625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1052 = { _0: 9, _1: "186264514923095703125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1053 = { _0: 10, _1: "931322574615478515625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1054 = { _0: 10, _1: "4656612873077392578125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1055 = { _0: 10, _1: "23283064365386962890625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1056 = { _0: 10, _1: "116415321826934814453125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1057 = { _0: 11, _1: "582076609134674072265625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1058 = { _0: 11, _1: "2910383045673370361328125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1059 = { _0: 11, _1: "14551915228366851806640625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1060 = { _0: 12, _1: "72759576141834259033203125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1061 = { _0: 12, _1: "363797880709171295166015625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1062 = { _0: 12, _1: "1818989403545856475830078125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1063 = { _0: 13, _1: "9094947017729282379150390625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1064 = { _0: 13, _1: "45474735088646411895751953125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1065 = { _0: 13, _1: "227373675443232059478759765625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1066 = { _0: 13, _1: "1136868377216160297393798828125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1067 = { _0: 14, _1: "5684341886080801486968994140625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1068 = { _0: 14, _1: "28421709430404007434844970703125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1069 = { _0: 14, _1: "142108547152020037174224853515625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1070 = { _0: 15, _1: "710542735760100185871124267578125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1071 = { _0: 15, _1: "3552713678800500929355621337890625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1072 = { _0: 15, _1: "17763568394002504646778106689453125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1073 = { _0: 16, _1: "88817841970012523233890533447265625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1074 = { _0: 16, _1: "444089209850062616169452667236328125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1075 = { _0: 16, _1: "2220446049250313080847263336181640625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1076 = { _0: 16, _1: "11102230246251565404236316680908203125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1077 = { _0: 17, _1: "55511151231257827021181583404541015625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1078 = { _0: 17, _1: "277555756156289135105907917022705078125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1079 = { _0: 17, _1: "1387778780781445675529539585113525390625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1080 = { _0: 18, _1: "6938893903907228377647697925567626953125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1081 = { _0: 18, _1: "34694469519536141888238489627838134765625" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1082 = { _0: 18, _1: "173472347597680709441192448139190673828125" };
const _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1083 = { _0: 19, _1: "867361737988403547205962240695953369140625" };
const _M0FPC28internal7strconv19left__shift__cheats = [_M0FPC28internal7strconv19left__shift__cheatsN5tupleS1023, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1024, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1025, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1026, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1027, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1028, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1029, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1030, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1031, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1032, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1033, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1034, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1035, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1036, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1037, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1038, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1039, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1040, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1041, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1042, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1043, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1044, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1045, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1046, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1047, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1048, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1049, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1050, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1051, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1052, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1053, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1054, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1055, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1056, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1057, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1058, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1059, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1060, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1061, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1062, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1063, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1064, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1065, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1066, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1067, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1068, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1069, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1070, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1071, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1072, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1073, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1074, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1075, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1076, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1077, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1078, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1079, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1080, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1081, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1082, _M0FPC28internal7strconv19left__shift__cheatsN5tupleS1083];
const _M0FPC28internal7strconv10int__pow10 = [1n, 10n, 100n, 1000n, 10000n, 100000n, 1000000n, 10000000n, 100000000n, 1000000000n, 10000000000n, 100000000000n, 1000000000000n, 10000000000000n, 100000000000000n, 1000000000000000n];
const _M0FPC28internal7strconv5table = [1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000, 10000000000, 100000000000, 1e+012, 1e+013, 1e+014, 1e+015, 1e+016, 1e+017, 1e+018, 1e+019, 1e+020, 1e+021, 1e+022, 0, 0, 0, 0, 0, 0, 0, 0, 0];
const _M0FPC28internal7strconv12checked__mulN6constrS1164 = 0n;
const _M0FPC16bigint16syntax__err__str = "invalid syntax";
const _M0FPC16bigint14base__err__str = "invalid base";
const _M0FPB4seed = _M0FPB12random__seed();
const _M0MPC16string10StringView4findN6constrS9865 = 0;
const _M0FPC28internal7strconv17check__underscoreN25_2atransition__table__222S230 = [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 5, 5, 5, 5, 5, 0, 1, 2, 5];
const _M0FPC28internal7strconv15parse__inf__nanN25_2atransition__table__304S312 = [14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 3, 4, 14, 14, 14, 14, 14, 14, 14, 7, 14, 14, 14, 14, 5, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 6, 14, 14, 14, 0, 14, 14, 14, 14, 14, 14, 14, 14, 14, 8, 14, 14, 14, 14, 14, 1, 14, 14, 9, 14, 14, 14, 14, 14, 14, 14, 14, 10, 14, 14, 14, 14, 14, 14, 11, 14, 14, 14, 14, 14, 14, 14, 14, 14, 12, 14, 14, 14, 14, 14, 14, 14, 14, 13, 14, 1, 14, 14, 14, 14, 14, 14, 14];
const _M0FPC15debug6renderN6constrS1705 = 16;
const _bind = [];
const _M0FP411localreview3tcl3cmd3web8sessions = _M0MPB3Map3MapGiRP211localreview3tcl11InterpreterE(new _M0TPB9ArrayViewGUiRP211localreview3tcl11InterpreterEE(_bind, 0, 0), undefined);
const _M0FP411localreview3tcl3cmd3web13next__session = _M0MPC13ref3Ref3RefGiE(0);
function _M0FPC15abort5abortGsE(msg) {
  return $panic();
}
function _M0FPC15abort5abortGuE(msg) {
  $panic();
}
function _M0FPC15abort5abortGRPC16bigint6BigIntE(msg) {
  return $panic();
}
function _M0FPC15abort5abortGOiE(msg) {
  return $panic();
}
function _M0FPB4rotl(x, r) {
  return x << r | (x >>> (32 - r | 0) | 0);
}
function _M0FPB13consume4__acc(acc, input) {
  return Math.imul(_M0FPB4rotl((acc >>> 0) + ((Math.imul(input, -1028477379) | 0) >>> 0) | 0, 17), 668265263) | 0;
}
function _M0MPC15array10FixedArray12unsafe__blitGRPB17UnsafeMaybeUninitGsEE(dst, dst_offset, src, src_offset, len) {
  if (dst === src && dst_offset < src_offset) {
    let _tmp = 0;
    while (true) {
      const i = _tmp;
      if (i < len) {
        const _tmp$2 = dst_offset + i | 0;
        const _tmp$3 = src_offset + i | 0;
        if (_tmp$2 >>> 0 < dst.length) {
          dst[_tmp$2] = _tmp$3 >>> 0 < src.length ? src[_tmp$3] : $oob();
        } else {
          $oob();
        }
        _tmp = i + 1 | 0;
        continue;
      } else {
        return;
      }
    }
  } else {
    let _tmp = len - 1 | 0;
    while (true) {
      const i = _tmp;
      if (i >= 0) {
        const _tmp$2 = dst_offset + i | 0;
        const _tmp$3 = src_offset + i | 0;
        if (_tmp$2 >>> 0 < dst.length) {
          dst[_tmp$2] = _tmp$3 >>> 0 < src.length ? src[_tmp$3] : $oob();
        } else {
          $oob();
        }
        _tmp = i - 1 | 0;
        continue;
      } else {
        return;
      }
    }
  }
}
function _M0MPC15array10FixedArray12unsafe__blitGRPB17UnsafeMaybeUninitGcEE(dst, dst_offset, src, src_offset, len) {
  if (dst === src && dst_offset < src_offset) {
    let _tmp = 0;
    while (true) {
      const i = _tmp;
      if (i < len) {
        const _tmp$2 = dst_offset + i | 0;
        const _tmp$3 = src_offset + i | 0;
        if (_tmp$2 >>> 0 < dst.length) {
          dst[_tmp$2] = _tmp$3 >>> 0 < src.length ? src[_tmp$3] : $oob();
        } else {
          $oob();
        }
        _tmp = i + 1 | 0;
        continue;
      } else {
        return;
      }
    }
  } else {
    let _tmp = len - 1 | 0;
    while (true) {
      const i = _tmp;
      if (i >= 0) {
        const _tmp$2 = dst_offset + i | 0;
        const _tmp$3 = src_offset + i | 0;
        if (_tmp$2 >>> 0 < dst.length) {
          dst[_tmp$2] = _tmp$3 >>> 0 < src.length ? src[_tmp$3] : $oob();
        } else {
          $oob();
        }
        _tmp = i - 1 | 0;
        continue;
      } else {
        return;
      }
    }
  }
}
function _M0MPB18UninitializedArray12unsafe__blitGsE(dst, dst_offset, src, src_offset, len) {
  _M0MPC15array10FixedArray12unsafe__blitGRPB17UnsafeMaybeUninitGsEE(dst, dst_offset, src, src_offset, len);
}
function _M0MPB18UninitializedArray12unsafe__blitGcE(dst, dst_offset, src, src_offset, len) {
  _M0MPC15array10FixedArray12unsafe__blitGRPB17UnsafeMaybeUninitGcEE(dst, dst_offset, src, src_offset, len);
}
function _M0MPB13StringBuilder13write__objectGdE(self, obj) {
  _M0IP016_24default__implPB4Show6outputGdE(obj, { self: self, method_table: _M0FP092moonbitlang_2fcore_2fbuiltin_2fStringBuilder_24as_24_40moonbitlang_2fcore_2fbuiltin_2eLogger });
}
function _M0MPB13StringBuilder13write__objectGRPC16string10StringViewE(self, obj) {
  _M0IPC16string10StringViewPB4Show6output(obj, { self: self, method_table: _M0FP092moonbitlang_2fcore_2fbuiltin_2fStringBuilder_24as_24_40moonbitlang_2fcore_2fbuiltin_2eLogger });
}
function _M0MPB13StringBuilder13write__objectGsE(self, obj) {
  _M0IP016_24default__implPB4Show6outputGsE(obj, { self: self, method_table: _M0FP092moonbitlang_2fcore_2fbuiltin_2fStringBuilder_24as_24_40moonbitlang_2fcore_2fbuiltin_2eLogger });
}
function _M0MPB13StringBuilder13write__objectGiE(self, obj) {
  _M0IP016_24default__implPB4Show6outputGiE(obj, { self: self, method_table: _M0FP092moonbitlang_2fcore_2fbuiltin_2fStringBuilder_24as_24_40moonbitlang_2fcore_2fbuiltin_2eLogger });
}
function _M0MPC13int3Int16unsafe__to__char(self) {
  return self;
}
function _M0MPC14byte4Byte8to__char(self) {
  return self;
}
function _M0MPB13StringBuilder21StringBuilder_2einner(size_hint) {
  return new _M0TPB13StringBuilder("");
}
function _M0MPB13StringBuilder10to__string(self) {
  return self.val;
}
function _M0IPB13StringBuilderPB6Logger11write__char(self, ch) {
  self.val = `${self.val}${String.fromCodePoint(ch)}`;
}
function _M0IPB13StringBuilderPB6Logger13write__string(self, str) {
  self.val = `${self.val}${str}`;
}
function _M0MPC16uint166UInt1622is__leading__surrogate(self) {
  return self >= 55296 && self <= 56319;
}
function _M0MPC16uint166UInt1623is__trailing__surrogate(self) {
  return self >= 56320 && self <= 57343;
}
function _M0FPB32code__point__of__surrogate__pair(leading, trailing) {
  return (((Math.imul(leading - 55296 | 0, 1024) | 0) + trailing | 0) - 56320 | 0) + 65536 | 0;
}
function _M0MPC16uint166UInt1616unsafe__to__char(self) {
  return self;
}
function _M0MPC16string6String16unsafe__char__at(self, index) {
  const c1 = self.charCodeAt(index);
  if (_M0MPC16uint166UInt1622is__leading__surrogate(c1)) {
    const c2 = self.charCodeAt(index + 1 | 0);
    return _M0FPB32code__point__of__surrogate__pair(c1, c2);
  } else {
    return _M0MPC16uint166UInt1616unsafe__to__char(c1);
  }
}
function _M0IPC14byte4BytePB3Add3add(self, that) {
  return (self + that | 0) & 255;
}
function _M0IPC14byte4BytePB3Div3div(self, that) {
  if (that === 0) {
    $panic();
  }
  return (self / that | 0) & 255;
}
function _M0IPC14byte4BytePB3Mod3mod(self, that) {
  if (that === 0) {
    $panic();
  }
  return (self % that | 0) & 255;
}
function _M0IPC14byte4BytePB3Sub3sub(self, that) {
  return (self - that | 0) & 255;
}
function _M0MPC14byte4Byte7to__hexN14to__hex__digitS3978(i) {
  return i < 10 ? _M0MPC14byte4Byte8to__char(_M0IPC14byte4BytePB3Add3add(i, 48)) : _M0MPC14byte4Byte8to__char(_M0IPC14byte4BytePB3Sub3sub(_M0IPC14byte4BytePB3Add3add(i, 97), 10));
}
function _M0MPC14byte4Byte7to__hex(b) {
  const _self = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  _M0IPB13StringBuilderPB6Logger11write__char(_self, _M0MPC14byte4Byte7to__hexN14to__hex__digitS3978(_M0IPC14byte4BytePB3Div3div(b, 16)));
  _M0IPB13StringBuilderPB6Logger11write__char(_self, _M0MPC14byte4Byte7to__hexN14to__hex__digitS3978(_M0IPC14byte4BytePB3Mod3mod(b, 16)));
  return _M0MPB13StringBuilder10to__string(_self);
}
function _M0MPC16string10StringView6length(self) {
  return self.end - self.start | 0;
}
function _M0MPC16string10StringView11sub_2einner(self, start, end) {
  const str_len = self.str.length;
  let abs_end;
  if (end === undefined) {
    abs_end = self.end;
  } else {
    const _Some = end;
    const _end = _Some;
    abs_end = self.start + _end | 0;
  }
  const abs_start = self.start + start | 0;
  if (abs_start >= self.start && (abs_start <= abs_end && abs_end <= self.end)) {
    if (abs_start < str_len) {
      if (!_M0MPC16uint166UInt1623is__trailing__surrogate(self.str.charCodeAt(abs_start))) {
      } else {
        $panic();
      }
    }
    if (abs_end < str_len) {
      if (!_M0MPC16uint166UInt1623is__trailing__surrogate(self.str.charCodeAt(abs_end))) {
      } else {
        $panic();
      }
    }
    return new _M0TPC16string10StringView(self.str, abs_start, abs_end);
  } else {
    return $panic();
  }
}
function _M0MPC16string10StringView18escape__to_2einnerN14flush__segmentS3963(_env, seg, i) {
  const logger = _env._1;
  const self = _env._0;
  if (i > seg) {
    logger.method_table.method_2(logger.self, _M0MPC16string10StringView11sub_2einner(self, seg, i));
    return;
  } else {
    return;
  }
}
function _M0MPC16string10StringView18escape__to_2einner(self, logger, quote) {
  if (quote) {
    logger.method_table.method_3(logger.self, 34);
  }
  const len = self.end - self.start | 0;
  const _env = { _0: self, _1: logger };
  let _tmp = 0;
  let _tmp$2 = 0;
  _L: while (true) {
    const i = _tmp;
    const seg = _tmp$2;
    if (i >= len) {
      _M0MPC16string10StringView18escape__to_2einnerN14flush__segmentS3963(_env, seg, i);
      break;
    }
    const code = self.str.charCodeAt(self.start + i | 0);
    let c;
    _L$2: {
      switch (code) {
        case 34: {
          c = code;
          break _L$2;
        }
        case 92: {
          c = code;
          break _L$2;
        }
        case 10: {
          _M0MPC16string10StringView18escape__to_2einnerN14flush__segmentS3963(_env, seg, i);
          logger.method_table.method_0(logger.self, "\\n");
          _tmp = i + 1 | 0;
          _tmp$2 = i + 1 | 0;
          continue _L;
        }
        case 13: {
          _M0MPC16string10StringView18escape__to_2einnerN14flush__segmentS3963(_env, seg, i);
          logger.method_table.method_0(logger.self, "\\r");
          _tmp = i + 1 | 0;
          _tmp$2 = i + 1 | 0;
          continue _L;
        }
        case 8: {
          _M0MPC16string10StringView18escape__to_2einnerN14flush__segmentS3963(_env, seg, i);
          logger.method_table.method_0(logger.self, "\\b");
          _tmp = i + 1 | 0;
          _tmp$2 = i + 1 | 0;
          continue _L;
        }
        case 9: {
          _M0MPC16string10StringView18escape__to_2einnerN14flush__segmentS3963(_env, seg, i);
          logger.method_table.method_0(logger.self, "\\t");
          _tmp = i + 1 | 0;
          _tmp$2 = i + 1 | 0;
          continue _L;
        }
        default: {
          if (code < 32) {
            _M0MPC16string10StringView18escape__to_2einnerN14flush__segmentS3963(_env, seg, i);
            logger.method_table.method_0(logger.self, "\\u{");
            logger.method_table.method_0(logger.self, _M0MPC14byte4Byte7to__hex(code & 255));
            logger.method_table.method_3(logger.self, 125);
            _tmp = i + 1 | 0;
            _tmp$2 = i + 1 | 0;
            continue _L;
          } else {
            _tmp = i + 1 | 0;
            continue _L;
          }
        }
      }
    }
    _M0MPC16string10StringView18escape__to_2einnerN14flush__segmentS3963(_env, seg, i);
    logger.method_table.method_3(logger.self, 92);
    logger.method_table.method_3(logger.self, _M0MPC16uint166UInt1616unsafe__to__char(c));
    _tmp = i + 1 | 0;
    _tmp$2 = i + 1 | 0;
    continue;
  }
  if (quote) {
    logger.method_table.method_3(logger.self, 34);
    return;
  } else {
    return;
  }
}
function _M0MPC16string6String14escape_2einner(self, quote) {
  const buf = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  _M0MPC16string10StringView18escape__to_2einner(new _M0TPC16string10StringView(self, 0, self.length), { self: buf, method_table: _M0FP092moonbitlang_2fcore_2fbuiltin_2fStringBuilder_24as_24_40moonbitlang_2fcore_2fbuiltin_2eLogger }, quote);
  return _M0MPB13StringBuilder10to__string(buf);
}
function _M0MPC15array13ReadOnlyArray11unsafe__getGiE(self, index) {
  return self[index];
}
function _M0MPC16string10StringView12view_2einner(self, start_offset, end_offset) {
  let end_offset$2;
  if (end_offset === undefined) {
    end_offset$2 = self.end - self.start | 0;
  } else {
    const _Some = end_offset;
    end_offset$2 = _Some;
  }
  return start_offset >= 0 && (start_offset <= end_offset$2 && end_offset$2 <= (self.end - self.start | 0)) ? new _M0TPC16string10StringView(self.str, self.start + start_offset | 0, self.start + end_offset$2 | 0) : _M0FPC15abort5abortGsE("Invalid index for View");
}
function _M0MPC16uint646UInt648to__byte(self) {
  return (Number(BigInt.asIntN(32, self)) | 0) & 255;
}
function _M0IPC16uint166UInt16PB2Eq5equal(self, that) {
  return self === that;
}
function _M0IPC16uint166UInt16PB2Eq10not__equal(self, that) {
  return self !== that;
}
function _M0IPC16uint166UInt16PB7Compare7compare(self, that) {
  return $compare_int(self, that);
}
function _M0MPC16uint166UInt168to__uint(self) {
  return self;
}
function _M0MPC13int3Int10to__uint64(self) {
  return BigInt.asUintN(64, BigInt(self));
}
function _M0IP016_24default__implPB2Eq10not__equalGbE(x, y) {
  return !(x === y);
}
function _M0IP016_24default__implPB2Eq10not__equalGsE(x, y) {
  return !(x === y);
}
function _M0IP016_24default__implPB2Eq10not__equalGOsE(x, y) {
  return !_M0IPC16option6OptionPB2Eq5equalGsE(x, y);
}
function _M0IP016_24default__implPB2Eq10not__equalGRPC16string10StringViewE(x, y) {
  return !_M0IPC16string10StringViewPB2Eq5equal(x, y);
}
function _M0IP016_24default__implPB2Eq10not__equalGRPC16bigint6BigIntE(x, y) {
  return !_M0IPC16bigint6BigIntPB2Eq5equal(x, y);
}
function _M0IP016_24default__implPB7Compare6op__ltGRPC16bigint6BigIntE(x, y) {
  return _M0IPC16bigint6BigIntPB7Compare7compare(x, y) < 0;
}
function _M0IP016_24default__implPB7Compare6op__ltGsE(x, y) {
  return _M0IPC16string6StringPB7Compare7compare(x, y) < 0;
}
function _M0IP016_24default__implPB7Compare6op__gtGRPC16bigint6BigIntE(x, y) {
  return _M0IPC16bigint6BigIntPB7Compare7compare(x, y) > 0;
}
function _M0IP016_24default__implPB7Compare6op__gtGsE(x, y) {
  return _M0IPC16string6StringPB7Compare7compare(x, y) > 0;
}
function _M0IP016_24default__implPB7Compare6op__leGRPC16bigint6BigIntE(x, y) {
  return _M0IPC16bigint6BigIntPB7Compare7compare(x, y) <= 0;
}
function _M0IP016_24default__implPB7Compare6op__geGRPC16bigint6BigIntE(x, y) {
  return _M0IPC16bigint6BigIntPB7Compare7compare(x, y) >= 0;
}
function _M0IP016_24default__implPB7Compare6op__geGsE(x, y) {
  return _M0IPC16string6StringPB7Compare7compare(x, y) >= 0;
}
function _M0FPB14avalanche__acc(acc) {
  let acc$2 = acc;
  acc$2 = acc$2 ^ (acc$2 >>> 15 | 0);
  acc$2 = Math.imul(acc$2, -2048144777) | 0;
  acc$2 = acc$2 ^ (acc$2 >>> 13 | 0);
  acc$2 = Math.imul(acc$2, -1028477379) | 0;
  acc$2 = acc$2 ^ (acc$2 >>> 16 | 0);
  return acc$2;
}
function _M0FPB13finalize__acc(acc) {
  return _M0FPB14avalanche__acc(acc);
}
function _M0IP016_24default__implPB6Logger28write__string__interpolationGRPB13StringBuilderE(self, show) {
  show.method_table.method_0(show.self, { self: self, method_table: _M0FP092moonbitlang_2fcore_2fbuiltin_2fStringBuilder_24as_24_40moonbitlang_2fcore_2fbuiltin_2eLogger });
}
function _M0IP016_24default__implPB6Logger5writeGRPB13StringBuilderE(self, show) {
  show.method_table.method_0(show.self, { self: self, method_table: _M0FP092moonbitlang_2fcore_2fbuiltin_2fStringBuilder_24as_24_40moonbitlang_2fcore_2fbuiltin_2eLogger });
}
function _M0MPC16string6String11sub_2einner(self, start, end) {
  const len = self.length;
  let end$2;
  if (end === undefined) {
    end$2 = len;
  } else {
    const _Some = end;
    const _end = _Some;
    end$2 = _end;
  }
  if (start >= 0 && (start <= end$2 && end$2 <= len)) {
    if (start < len) {
      if (!_M0MPC16uint166UInt1623is__trailing__surrogate(self.charCodeAt(start))) {
      } else {
        $panic();
      }
    }
    if (end$2 < len) {
      if (!_M0MPC16uint166UInt1623is__trailing__surrogate(self.charCodeAt(end$2))) {
      } else {
        $panic();
      }
    }
    return new _M0TPC16string10StringView(self, start, end$2);
  } else {
    return $panic();
  }
}
function _M0IP016_24default__implPB6Logger16write__substringGRPB13StringBuilderE(self, value, start, len) {
  _M0IPB13StringBuilderPB6Logger11write__view(self, _M0MPC16string6String11sub_2einner(value, start, start + len | 0));
}
function _M0MPC16string10StringView4data(self) {
  return self.str;
}
function _M0MPC16string10StringView13start__offset(self) {
  return self.start;
}
function _M0IP016_24default__implPB4Show6outputGdE(self, logger) {
  logger.method_table.method_0(logger.self, _M0IPC16double6DoublePB4Show10to__string(self));
}
function _M0IP016_24default__implPB4Show6outputGsE(self, logger) {
  logger.method_table.method_0(logger.self, _M0IPC16string6StringPB4Show10to__string(self));
}
function _M0IP016_24default__implPB4Show6outputGiE(self, logger) {
  logger.method_table.method_0(logger.self, _M0IPC13int3IntPB4Show10to__string(self));
}
function _M0IP016_24default__implPB4Show10to__stringGRPC15debug4ReprE(self) {
  const logger = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  _M0IPC15debug4ReprPB4Show6output(self, { self: logger, method_table: _M0FP092moonbitlang_2fcore_2fbuiltin_2fStringBuilder_24as_24_40moonbitlang_2fcore_2fbuiltin_2eLogger });
  return _M0MPB13StringBuilder10to__string(logger);
}
function _M0MPB4Iter4nextGUsRPB4JsonEE(self) {
  const _func = self.f;
  const result = _func();
  const _bind$2 = self.size_hint;
  if (result === undefined) {
    self.size_hint = _M0MPB4Iter4nextN6constrS9856GUsRPB4JsonEE;
  } else {
    if (_bind$2 === undefined) {
    } else {
      const _Some = _bind$2;
      const _n = _Some;
      self.size_hint = _n > 0 ? _n - 1 | 0 : _M0MPB4Iter4nextN6constrS9855GUsRPB4JsonEE;
    }
  }
  return result;
}
function _M0MPB4Iter4nextGcE(self) {
  const _func = self.f;
  const result = _func();
  const _bind$2 = self.size_hint;
  if (result === -1) {
    self.size_hint = _M0MPB4Iter4nextN6constrS9856GcE;
  } else {
    if (_bind$2 === undefined) {
    } else {
      const _Some = _bind$2;
      const _n = _Some;
      self.size_hint = _n > 0 ? _n - 1 | 0 : _M0MPB4Iter4nextN6constrS9855GcE;
    }
  }
  return result;
}
function _M0MPC13int3Int18to__string_2einner(self, radix) {
  return _M0FPB19int__to__string__js(self, radix);
}
function _M0MPC15int645Int6418to__string_2einner(self, radix) {
  return _M0FPB21int64__to__string__js(self, radix);
}
function _M0MPC16uint646UInt6418to__string_2einner(self, radix) {
  return _M0FPB22uint64__to__string__js(self, radix);
}
function _M0MPB4Iter3newGUsRPB4JsonEE(f, size_hint) {
  let size_hint$2;
  if (size_hint === undefined) {
    size_hint$2 = undefined;
  } else {
    const _Some = size_hint;
    const _n = _Some;
    size_hint$2 = _n > 0 ? _n : _M0MPB4Iter3newN6constrS9863GUsRPB4JsonEE;
  }
  return new _M0TPB4IterGUsRPB4JsonEE(f, size_hint$2);
}
function _M0MPB4Iter3newGcE(f, size_hint) {
  let size_hint$2;
  if (size_hint === undefined) {
    size_hint$2 = undefined;
  } else {
    const _Some = size_hint;
    const _n = _Some;
    size_hint$2 = _n > 0 ? _n : _M0MPB4Iter3newN6constrS9863GcE;
  }
  return new _M0TPB4IterGcE(f, size_hint$2);
}
function _M0MPC16string10StringView9to__owned(self) {
  return self.str.substring(self.start, self.end);
}
function _M0IPC16string10StringViewPB4Show6output(self, logger) {
  logger.method_table.method_2(logger.self, self);
}
function _M0MPC16string10StringView4iter(self) {
  const start = self.start;
  const end = self.end;
  const index = new _M0TPB8MutLocalGiE(start);
  return _M0MPB4Iter3newGcE(() => {
    if (index.val < end) {
      const c1 = self.str.charCodeAt(index.val);
      if (_M0MPC16uint166UInt1622is__leading__surrogate(c1) && (index.val + 1 | 0) < self.end) {
        const c2 = self.str.charCodeAt(index.val + 1 | 0);
        if (_M0MPC16uint166UInt1623is__trailing__surrogate(c2)) {
          index.val = index.val + 2 | 0;
          return _M0FPB32code__point__of__surrogate__pair(c1, c2);
        }
      }
      index.val = index.val + 1 | 0;
      return _M0MPC16uint166UInt1616unsafe__to__char(c1);
    } else {
      return -1;
    }
  }, undefined);
}
function _M0MPC16string10StringView9rev__iter(self) {
  const start = self.start;
  const end = self.end;
  const index = new _M0TPB8MutLocalGiE(end);
  return _M0MPB4Iter3newGcE(() => {
    if (index.val > start) {
      index.val = index.val - 1 | 0;
      const c1 = self.str.charCodeAt(index.val);
      if (_M0MPC16uint166UInt1623is__trailing__surrogate(c1) && (index.val - 1 | 0) >= 0) {
        const c2 = self.str.charCodeAt(index.val - 1 | 0);
        if (_M0MPC16uint166UInt1622is__leading__surrogate(c2)) {
          index.val = index.val - 1 | 0;
          return _M0FPB32code__point__of__surrogate__pair(c2, c1);
        }
      }
      return _M0MPC16uint166UInt1616unsafe__to__char(c1);
    } else {
      return -1;
    }
  }, undefined);
}
function _M0MPC16string10StringView3all(self, f) {
  const _bind$2 = self.str;
  const _bind$3 = self.start;
  const _bind$4 = self.end;
  let _tmp = _bind$3;
  while (true) {
    const _string_index = _tmp;
    if (_string_index < _bind$4) {
      let _decoded_next_string_index;
      let _decoded_char;
      _L: {
        const _bind$5 = _bind$2.charCodeAt(_string_index);
        if (_bind$5 >= 55296 && _bind$5 <= 56319 && (_string_index + 1 | 0) < _bind$4) {
          const _bind$6 = _bind$2.charCodeAt(_string_index + 1 | 0);
          if (_bind$6 >= 56320 && _bind$6 <= 57343) {
            _decoded_next_string_index = _string_index + 2 | 0;
            _decoded_char = _M0MPC13int3Int16unsafe__to__char((((Math.imul(_bind$5 - 55296 | 0, 1024) | 0) + _bind$6 | 0) - 56320 | 0) + 65536 | 0);
            break _L;
          } else {
            _decoded_next_string_index = _string_index + 1 | 0;
            _decoded_char = _M0MPC13int3Int16unsafe__to__char(_bind$5);
            break _L;
          }
        } else {
          _decoded_next_string_index = _string_index + 1 | 0;
          _decoded_char = _M0MPC13int3Int16unsafe__to__char(_bind$5);
          break _L;
        }
      }
      if (!f(_decoded_char)) {
        return false;
      }
      _tmp = _decoded_next_string_index;
      continue;
    } else {
      break;
    }
  }
  return true;
}
function _M0MPC16string6String20unsafe__range__equal(self, self_off, other, other_off, len) {
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < len) {
      if (_M0IPC16uint166UInt16PB2Eq5equal(self.charCodeAt(self_off + i | 0), other.charCodeAt(other_off + i | 0))) {
      } else {
        return false;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return true;
}
function _M0IPC16string10StringViewPB2Eq5equal(self, other) {
  const len = self.end - self.start | 0;
  if (len === (other.end - other.start | 0)) {
    if (self.str === other.str && self.start === other.start) {
      return true;
    }
    return _M0MPC16string6String20unsafe__range__equal(self.str, self.start, other.str, other.start, len);
  } else {
    return false;
  }
}
function _M0MPC16string6String12view_2einner(self, start_offset, end_offset) {
  let end_offset$2;
  if (end_offset === undefined) {
    end_offset$2 = self.length;
  } else {
    const _Some = end_offset;
    end_offset$2 = _Some;
  }
  return start_offset >= 0 && (start_offset <= end_offset$2 && end_offset$2 <= self.length) ? new _M0TPC16string10StringView(self, start_offset, end_offset$2) : _M0FPC15abort5abortGsE("Invalid index for View");
}
function _M0MPC16string6String11from__array(chars) {
  const buf = _M0MPB13StringBuilder21StringBuilder_2einner(Math.imul(chars.end - chars.start | 0, 4) | 0);
  const _bind$2 = chars.end - chars.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const c = chars.buf[chars.start + _ | 0];
      _M0IPB13StringBuilderPB6Logger11write__char(buf, c);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0MPB13StringBuilder10to__string(buf);
}
function _M0MPC16string6String24char__length__ge_2einner(self, len, start_offset, end_offset) {
  let end_offset$2;
  if (end_offset === undefined) {
    end_offset$2 = self.length;
  } else {
    const _Some = end_offset;
    end_offset$2 = _Some;
  }
  let _tmp = start_offset;
  let _tmp$2 = 0;
  while (true) {
    const index = _tmp;
    const count = _tmp$2;
    if (index < end_offset$2 && count < len) {
      const c1 = self.charCodeAt(index);
      if (_M0MPC16uint166UInt1622is__leading__surrogate(c1) && (index + 1 | 0) < end_offset$2) {
        const c2 = self.charCodeAt(index + 1 | 0);
        if (_M0MPC16uint166UInt1623is__trailing__surrogate(c2)) {
          _tmp = index + 2 | 0;
          _tmp$2 = count + 1 | 0;
          continue;
        } else {
          _M0FPC15abort5abortGuE("invalid surrogate pair");
        }
      }
      _tmp = index + 1 | 0;
      _tmp$2 = count + 1 | 0;
      continue;
    } else {
      return count >= len;
    }
  }
}
function _M0MPC16string6String31offset__of__nth__char__backward(self, n, start_offset, end_offset) {
  let _tmp = end_offset;
  let _tmp$2 = 0;
  while (true) {
    const utf16_offset = _tmp;
    const char_count = _tmp$2;
    if ((utf16_offset - 1 | 0) >= start_offset && char_count < n) {
      const c = self.charCodeAt(utf16_offset - 1 | 0);
      if (_M0MPC16uint166UInt1623is__trailing__surrogate(c)) {
        _tmp = utf16_offset - 2 | 0;
        _tmp$2 = char_count + 1 | 0;
        continue;
      } else {
        _tmp = utf16_offset - 1 | 0;
        _tmp$2 = char_count + 1 | 0;
        continue;
      }
    } else {
      return char_count < n || utf16_offset < start_offset ? undefined : utf16_offset;
    }
  }
}
function _M0MPC16string6String30offset__of__nth__char__forward(self, n, start_offset, end_offset) {
  if (start_offset >= 0 && start_offset <= end_offset) {
    let _tmp = start_offset;
    let _tmp$2 = 0;
    while (true) {
      const utf16_offset = _tmp;
      const char_count = _tmp$2;
      if (utf16_offset < end_offset && char_count < n) {
        const c = self.charCodeAt(utf16_offset);
        if (_M0MPC16uint166UInt1622is__leading__surrogate(c)) {
          _tmp = utf16_offset + 2 | 0;
          _tmp$2 = char_count + 1 | 0;
          continue;
        } else {
          _tmp = utf16_offset + 1 | 0;
          _tmp$2 = char_count + 1 | 0;
          continue;
        }
      } else {
        return char_count < n || utf16_offset >= end_offset ? undefined : utf16_offset;
      }
    }
  } else {
    return _M0FPC15abort5abortGOiE("Invalid start index");
  }
}
function _M0MPC16string6String29offset__of__nth__char_2einner(self, i, start_offset, end_offset) {
  let end_offset$2;
  if (end_offset === undefined) {
    end_offset$2 = self.length;
  } else {
    const _Some = end_offset;
    end_offset$2 = _Some;
  }
  return i >= 0 ? _M0MPC16string6String30offset__of__nth__char__forward(self, i, start_offset, end_offset$2) : _M0MPC16string6String31offset__of__nth__char__backward(self, -i | 0, start_offset, end_offset$2);
}
function _M0IPB13StringBuilderPB6Logger11write__view(self, str) {
  self.val = `${self.val}${_M0MPC16string10StringView9to__owned(str)}`;
}
function _M0FPB19kmp__failure__table(pattern) {
  const m = pattern.end - pattern.start | 0;
  const table = $make_array_len_and_init(m, 0);
  let k = 0;
  let _tmp = 1;
  while (true) {
    const i = _tmp;
    if (i < m) {
      const c = pattern.str.charCodeAt(pattern.start + i | 0);
      while (true) {
        if (k > 0 && _M0IPC16uint166UInt16PB2Eq10not__equal(c, pattern.str.charCodeAt(pattern.start + k | 0))) {
          const _tmp$2 = k - 1 | 0;
          k = _tmp$2 >>> 0 < table.length ? table[_tmp$2] : $oob();
          continue;
        } else {
          break;
        }
      }
      if (_M0IPC16uint166UInt16PB2Eq5equal(c, pattern.str.charCodeAt(pattern.start + k | 0))) {
        k = k + 1 | 0;
      }
      if (i >>> 0 < table.length) {
        table[i] = k;
      } else {
        $oob();
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return table;
}
function _M0FPB24find__pattern__kmp__from(target, pattern, start) {
  const n = target.end - target.start | 0;
  const m = pattern.end - pattern.start | 0;
  const table = _M0FPB19kmp__failure__table(pattern);
  let k = 0;
  let _tmp = start;
  while (true) {
    const i = _tmp;
    if (i < n) {
      const c = target.str.charCodeAt(target.start + i | 0);
      while (true) {
        if (k > 0 && _M0IPC16uint166UInt16PB2Eq10not__equal(c, pattern.str.charCodeAt(pattern.start + k | 0))) {
          const _tmp$2 = k - 1 | 0;
          k = _tmp$2 >>> 0 < table.length ? table[_tmp$2] : $oob();
          continue;
        } else {
          break;
        }
      }
      if (_M0IPC16uint166UInt16PB2Eq5equal(c, pattern.str.charCodeAt(pattern.start + k | 0))) {
        k = k + 1 | 0;
      }
      if (k === m) {
        return (i - m | 0) + 1 | 0;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return undefined;
}
function _M0FPB36find__two__anchor__candidate__scalar(data, start, candidate_end, first, last_offset, last) {
  let _tmp = start;
  while (true) {
    const pos = _tmp;
    if (pos < candidate_end) {
      if (_M0IPC16uint166UInt16PB2Eq5equal(data.charCodeAt(pos), first) && _M0IPC16uint166UInt16PB2Eq5equal(data.charCodeAt(pos + last_offset | 0), last)) {
        return pos;
      }
      _tmp = pos + 1 | 0;
      continue;
    } else {
      return -1;
    }
  }
}
function _M0FPB42find__two__anchor__candidate__from__string(data, start, candidate_end, first, last_offset, last) {
  return _M0FPB36find__two__anchor__candidate__scalar(data, start, candidate_end, first, last_offset, last);
}
function _M0FPB21string__ranges__equal(left, left_start, right, right_start, length) {
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < length) {
      if (_M0IPC16uint166UInt16PB2Eq10not__equal(left.charCodeAt(left_start + i | 0), right.charCodeAt(right_start + i | 0))) {
        return false;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return true;
}
function _M0FPB29two__anchor__should__fallback(failures, scanned) {
  if (failures > 64) {
    return true;
  } else {
    if (8 === 0) {
      $panic();
    }
    return failures > (4 + (scanned / 8 | 0) | 0);
  }
}
function _M0FPB22find__by__two__anchors(target, pattern) {
  const target_len = target.end - target.start | 0;
  const pattern_len = pattern.end - pattern.start | 0;
  const target_start = _M0MPC16string10StringView13start__offset(target);
  const pattern_start = _M0MPC16string10StringView13start__offset(pattern);
  const last_offset = pattern_len - 1 | 0;
  const candidate_end = ((target_start + target_len | 0) - pattern_len | 0) + 1 | 0;
  const first = pattern.str.charCodeAt(pattern.start);
  const last = pattern.str.charCodeAt(pattern.start + last_offset | 0);
  const middle_len = last_offset - 1 | 0;
  let _tmp = target_start;
  let _tmp$2 = 0;
  while (true) {
    const pos = _tmp;
    const failures = _tmp$2;
    if (pos < candidate_end) {
      const found = _M0FPB42find__two__anchor__candidate__from__string(_M0MPC16string10StringView4data(target), pos, candidate_end, first, last_offset, last);
      if (found < 0) {
        return undefined;
      }
      if (_M0FPB21string__ranges__equal(_M0MPC16string10StringView4data(target), found + 1 | 0, _M0MPC16string10StringView4data(pattern), pattern_start + 1 | 0, middle_len)) {
        return found - target_start | 0;
      }
      const failures$2 = failures + 1 | 0;
      const scanned = found - target_start | 0;
      if (_M0FPB29two__anchor__should__fallback(failures$2, scanned)) {
        return _M0FPB24find__pattern__kmp__from(target, pattern, scanned + 1 | 0);
      }
      _tmp = found + 1 | 0;
      _tmp$2 = failures$2;
      continue;
    } else {
      return undefined;
    }
  }
}
function _M0FPB24find__code__unit__scalar(data, start, end, code) {
  let _tmp = start;
  while (true) {
    const pos = _tmp;
    if (pos < end) {
      if (_M0IPC16uint166UInt16PB2Eq5equal(data.charCodeAt(pos), code)) {
        return pos;
      }
      _tmp = pos + 1 | 0;
      continue;
    } else {
      return -1;
    }
  }
}
function _M0FPB30find__code__unit__from__string(data, start, end, code) {
  return _M0FPB24find__code__unit__scalar(data, start, end, code);
}
function _M0FPB28find__code__unit__from__view(target, start, end, code) {
  const target_start = _M0MPC16string10StringView13start__offset(target);
  const found = _M0FPB30find__code__unit__from__string(_M0MPC16string10StringView4data(target), target_start + start | 0, target_start + end | 0, code);
  return found < 0 ? -1 : found - target_start | 0;
}
function _M0MPC16string10StringView4find(self, str) {
  const pattern_len = str.end - str.start | 0;
  switch (pattern_len) {
    case 0: {
      return _M0MPC16string10StringView4findN6constrS9865;
    }
    case 1: {
      const found = _M0FPB28find__code__unit__from__view(self, 0, self.end - self.start | 0, str.str.charCodeAt(str.start));
      return found < 0 ? undefined : found;
    }
    default: {
      return pattern_len > (self.end - self.start | 0) ? undefined : _M0FPB22find__by__two__anchors(self, str);
    }
  }
}
function _M0MPC16string6String4find(self, str) {
  return _M0MPC16string10StringView4find(new _M0TPC16string10StringView(self, 0, self.length), str);
}
function _M0IPC16string6StringPB4Show10to__string(self) {
  return self;
}
function _M0MPC16string6String6repeat(self, n) {
  if (n < 0) {
    return _M0FPC15abort5abortGsE("negative repeat count");
  } else {
    if (n === 0) {
      return "";
    } else {
      if (n === 1) {
        return self;
      } else {
        const len = self.length;
        const total = Math.imul(len, n) | 0;
        let _tmp;
        if (len === 0) {
          _tmp = true;
        } else {
          if (n === 0) {
            $panic();
          }
          _tmp = (total / n | 0) === len;
        }
        if (_tmp) {
          const buf = _M0MPB13StringBuilder21StringBuilder_2einner(total);
          const str = _M0IPC16string6StringPB4Show10to__string(self);
          let _tmp$2 = 0;
          while (true) {
            const _ = _tmp$2;
            if (_ < n) {
              _M0IPB13StringBuilderPB6Logger13write__string(buf, str);
              _tmp$2 = _ + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          return _M0MPB13StringBuilder10to__string(buf);
        } else {
          return _M0FPC15abort5abortGsE("repeat result too large");
        }
      }
    }
  }
}
function _M0MPC14char4Char10utf16__len(self) {
  const code = self;
  return code <= 65535 ? 1 : 2;
}
function _M0MPC16string10StringView8find__by(self, pred) {
  const _bind$2 = self.str;
  const _bind$3 = self.start;
  const _bind$4 = self.end;
  let _tmp = _bind$3;
  let _tmp$2 = 0;
  while (true) {
    const _string_index = _tmp;
    const offset = _tmp$2;
    if (_string_index < _bind$4) {
      let _decoded_next_string_index;
      let _decoded_char;
      _L: {
        const _bind$5 = _bind$2.charCodeAt(_string_index);
        if (_bind$5 >= 55296 && _bind$5 <= 56319 && (_string_index + 1 | 0) < _bind$4) {
          const _bind$6 = _bind$2.charCodeAt(_string_index + 1 | 0);
          if (_bind$6 >= 56320 && _bind$6 <= 57343) {
            _decoded_next_string_index = _string_index + 2 | 0;
            _decoded_char = _M0MPC13int3Int16unsafe__to__char((((Math.imul(_bind$5 - 55296 | 0, 1024) | 0) + _bind$6 | 0) - 56320 | 0) + 65536 | 0);
            break _L;
          } else {
            _decoded_next_string_index = _string_index + 1 | 0;
            _decoded_char = _M0MPC13int3Int16unsafe__to__char(_bind$5);
            break _L;
          }
        } else {
          _decoded_next_string_index = _string_index + 1 | 0;
          _decoded_char = _M0MPC13int3Int16unsafe__to__char(_bind$5);
          break _L;
        }
      }
      if (pred(_decoded_char)) {
        return offset;
      }
      _tmp = _decoded_next_string_index;
      _tmp$2 = offset + _M0MPC14char4Char10utf16__len(_decoded_char) | 0;
      continue;
    } else {
      return undefined;
    }
  }
}
function _M0MPC16string6String8find__by(self, pred) {
  return _M0MPC16string10StringView8find__by(new _M0TPC16string10StringView(self, 0, self.length), pred);
}
function _M0FPB31rev__find__pattern__kmp__before(target, pattern, candidate_end) {
  if (candidate_end > 0) {
    const m = pattern.end - pattern.start | 0;
    const table = _M0FPB19kmp__failure__table(pattern);
    const scan_end = (candidate_end + m | 0) - 1 | 0;
    let k = 0;
    let best = -1;
    let _tmp = 0;
    while (true) {
      const i = _tmp;
      if (i < scan_end) {
        const c = target.str.charCodeAt(target.start + i | 0);
        while (true) {
          if (k > 0 && _M0IPC16uint166UInt16PB2Eq10not__equal(c, pattern.str.charCodeAt(pattern.start + k | 0))) {
            const _tmp$2 = k - 1 | 0;
            k = _tmp$2 >>> 0 < table.length ? table[_tmp$2] : $oob();
            continue;
          } else {
            break;
          }
        }
        if (_M0IPC16uint166UInt16PB2Eq5equal(c, pattern.str.charCodeAt(pattern.start + k | 0))) {
          k = k + 1 | 0;
        }
        if (k === m) {
          best = (i - m | 0) + 1 | 0;
          const _tmp$2 = k - 1 | 0;
          k = _tmp$2 >>> 0 < table.length ? table[_tmp$2] : $oob();
        }
        _tmp = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    return best >= 0 ? best : undefined;
  } else {
    return undefined;
  }
}
function _M0FPB41rev__find__two__anchor__candidate__scalar(data, start, candidate_end, first, last_offset, last) {
  let _tmp = candidate_end - 1 | 0;
  while (true) {
    const pos = _tmp;
    if (pos >= start) {
      if (_M0IPC16uint166UInt16PB2Eq5equal(data.charCodeAt(pos), first) && _M0IPC16uint166UInt16PB2Eq5equal(data.charCodeAt(pos + last_offset | 0), last)) {
        return pos;
      }
      _tmp = pos - 1 | 0;
      continue;
    } else {
      return -1;
    }
  }
}
function _M0FPB47rev__find__two__anchor__candidate__from__string(data, start, candidate_end, first, last_offset, last) {
  return _M0FPB41rev__find__two__anchor__candidate__scalar(data, start, candidate_end, first, last_offset, last);
}
function _M0FPB27rev__find__by__two__anchors(target, pattern) {
  const target_len = target.end - target.start | 0;
  const pattern_len = pattern.end - pattern.start | 0;
  const target_start = _M0MPC16string10StringView13start__offset(target);
  const pattern_start = _M0MPC16string10StringView13start__offset(pattern);
  const last_offset = pattern_len - 1 | 0;
  const first = pattern.str.charCodeAt(pattern.start);
  const last = pattern.str.charCodeAt(pattern.start + last_offset | 0);
  const middle_len = last_offset - 1 | 0;
  const last_candidate = target_len - pattern_len | 0;
  let _tmp = (target_start + last_candidate | 0) + 1 | 0;
  let _tmp$2 = 0;
  while (true) {
    const candidate_end = _tmp;
    const failures = _tmp$2;
    if (candidate_end > target_start) {
      const found = _M0FPB47rev__find__two__anchor__candidate__from__string(_M0MPC16string10StringView4data(target), target_start, candidate_end, first, last_offset, last);
      if (found < 0) {
        return undefined;
      }
      if (_M0FPB21string__ranges__equal(_M0MPC16string10StringView4data(target), found + 1 | 0, _M0MPC16string10StringView4data(pattern), pattern_start + 1 | 0, middle_len)) {
        return found - target_start | 0;
      }
      const candidate = found - target_start | 0;
      const failures$2 = failures + 1 | 0;
      const scanned = last_candidate - candidate | 0;
      if (_M0FPB29two__anchor__should__fallback(failures$2, scanned)) {
        return _M0FPB31rev__find__pattern__kmp__before(target, pattern, candidate);
      }
      _tmp = found;
      _tmp$2 = failures$2;
      continue;
    } else {
      return undefined;
    }
  }
}
function _M0FPB29rev__find__code__unit__scalar(data, start, end, code) {
  let _tmp = end - 1 | 0;
  while (true) {
    const pos = _tmp;
    if (pos >= start) {
      if (_M0IPC16uint166UInt16PB2Eq5equal(data.charCodeAt(pos), code)) {
        return pos;
      }
      _tmp = pos - 1 | 0;
      continue;
    } else {
      return -1;
    }
  }
}
function _M0FPB35rev__find__code__unit__from__string(data, start, end, code) {
  return _M0FPB29rev__find__code__unit__scalar(data, start, end, code);
}
function _M0FPB33rev__find__code__unit__from__view(target, start, end, code) {
  const target_start = _M0MPC16string10StringView13start__offset(target);
  const found = _M0FPB35rev__find__code__unit__from__string(_M0MPC16string10StringView4data(target), target_start + start | 0, target_start + end | 0, code);
  return found < 0 ? -1 : found - target_start | 0;
}
function _M0MPC16string10StringView9rev__find(self, str) {
  const pattern_len = str.end - str.start | 0;
  switch (pattern_len) {
    case 0: {
      return self.end - self.start | 0;
    }
    case 1: {
      const found = _M0FPB33rev__find__code__unit__from__view(self, 0, self.end - self.start | 0, str.str.charCodeAt(str.start));
      return found < 0 ? undefined : found;
    }
    default: {
      return pattern_len > (self.end - self.start | 0) ? undefined : _M0FPB27rev__find__by__two__anchors(self, str);
    }
  }
}
function _M0MPC16string6String9rev__find(self, str) {
  return _M0MPC16string10StringView9rev__find(new _M0TPC16string10StringView(self, 0, self.length), str);
}
function _M0MPC16string10StringView11has__suffix(self, str) {
  const self_len = self.end - self.start | 0;
  const str_len = str.end - str.start | 0;
  if (str_len <= self_len) {
    const start = self_len - str_len | 0;
    return str_len === 0 || _M0IPC16uint166UInt16PB2Eq5equal(self.str.charCodeAt(self.start + start | 0), str.str.charCodeAt(str.start)) ? _M0MPC16string6String20unsafe__range__equal(self.str, self.start + start | 0, str.str, str.start, str_len) : false;
  } else {
    return false;
  }
}
function _M0MPC16string6String11has__suffix(self, str) {
  return _M0MPC16string10StringView11has__suffix(new _M0TPC16string10StringView(self, 0, self.length), str);
}
function _M0MPC16string10StringView11has__prefix(self, str) {
  const str_len = str.end - str.start | 0;
  return str_len <= (self.end - self.start | 0) ? (str_len === 0 || _M0IPC16uint166UInt16PB2Eq5equal(self.str.charCodeAt(self.start), str.str.charCodeAt(str.start)) ? _M0MPC16string6String20unsafe__range__equal(self.str, self.start, str.str, str.start, str_len) : false) : false;
}
function _M0MPC16string6String11has__prefix(self, str) {
  return _M0MPC16string10StringView11has__prefix(new _M0TPC16string10StringView(self, 0, self.length), str);
}
function _M0MPC16string10StringView13strip__suffix(self, suffix) {
  const self_len = self.end - self.start | 0;
  const suffix_len = suffix.end - suffix.start | 0;
  return self_len >= suffix_len && _M0IPC16string10StringViewPB2Eq5equal(_M0MPC16string10StringView12view_2einner(self, self_len - suffix_len | 0, undefined), suffix) ? _M0MPC16string10StringView12view_2einner(self, 0, self_len - suffix_len | 0) : undefined;
}
function _M0MPC16string6String13strip__suffix(self, suffix) {
  return _M0MPC16string10StringView13strip__suffix(new _M0TPC16string10StringView(self, 0, self.length), suffix);
}
function _M0MPC16string10StringView13strip__prefix(self, prefix) {
  const prefix_len = prefix.end - prefix.start | 0;
  return (self.end - self.start | 0) >= prefix_len && _M0IPC16string10StringViewPB2Eq5equal(_M0MPC16string10StringView12view_2einner(self, 0, prefix_len), prefix) ? _M0MPC16string10StringView12view_2einner(self, prefix_len, undefined) : undefined;
}
function _M0MPC15array5Array13Array_2einnerGcE(capacity) {
  return [];
}
function _M0MPC15array5Array13Array_2einnerGRPC16string10StringViewE(capacity) {
  return [];
}
function _M0MPC15array5Array4pushGRPC14json10WriteFrameE(self, value) {
  _M0MPB7JSArray4push(self, value);
}
function _M0MPC15array5Array4pushGcE(self, value) {
  _M0MPB7JSArray4push(self, value);
}
function _M0MPB4Iter4foldGcRPB5ArrayGcEE(self, init, f) {
  let acc = init;
  while (true) {
    const _bind$2 = _M0MPB4Iter4nextGcE(self);
    if (_bind$2 === -1) {
      break;
    } else {
      const _Some = _bind$2;
      const _x = _Some;
      acc = f(acc, _x);
      continue;
    }
  }
  return acc;
}
function _M0FPB36string__contains__code__unit__scalar(str, start, end, code) {
  let _tmp = start;
  while (true) {
    const i = _tmp;
    if (i < end) {
      if (_M0IPC16uint166UInt16PB2Eq5equal(str.charCodeAt(i), code)) {
        return true;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return false;
}
function _M0FPB28string__contains__code__unit(str, start, end, code) {
  return _M0FPB36string__contains__code__unit__scalar(str, start, end, code);
}
function _M0MPC16string10StringView20contains__code__unit(self, code) {
  return _M0FPB28string__contains__code__unit(self.str, self.start, self.end, code);
}
function _M0MPC16string10StringView8contains(self, str) {
  const _bind$2 = str.end - str.start | 0;
  switch (_bind$2) {
    case 0: {
      return true;
    }
    case 1: {
      return _M0MPC16string10StringView20contains__code__unit(self, str.str.charCodeAt(str.start));
    }
    default: {
      const _bind$3 = _M0MPC16string10StringView4find(self, str);
      return !(_bind$3 === undefined);
    }
  }
}
function _M0MPC16string6String8contains(self, str) {
  return _M0MPC16string10StringView8contains(new _M0TPC16string10StringView(self, 0, self.length), str);
}
function _M0MPC14char4Char8to__uint(self) {
  return self;
}
function _M0FPB23build__ascii__char__set(chars) {
  let bits0 = 0;
  let bits1 = 0;
  let bits2 = 0;
  let bits3 = 0;
  const _bind$2 = chars.str;
  const _bind$3 = chars.start;
  const _bind$4 = chars.end;
  let _tmp = _bind$3;
  while (true) {
    const _string_index = _tmp;
    if (_string_index < _bind$4) {
      let _decoded_next_string_index;
      let _decoded_char;
      _L: {
        const _bind$5 = _bind$2.charCodeAt(_string_index);
        if (_bind$5 >= 55296 && _bind$5 <= 56319 && (_string_index + 1 | 0) < _bind$4) {
          const _bind$6 = _bind$2.charCodeAt(_string_index + 1 | 0);
          if (_bind$6 >= 56320 && _bind$6 <= 57343) {
            _decoded_next_string_index = _string_index + 2 | 0;
            _decoded_char = _M0MPC13int3Int16unsafe__to__char((((Math.imul(_bind$5 - 55296 | 0, 1024) | 0) + _bind$6 | 0) - 56320 | 0) + 65536 | 0);
            break _L;
          } else {
            _decoded_next_string_index = _string_index + 1 | 0;
            _decoded_char = _M0MPC13int3Int16unsafe__to__char(_bind$5);
            break _L;
          }
        } else {
          _decoded_next_string_index = _string_index + 1 | 0;
          _decoded_char = _M0MPC13int3Int16unsafe__to__char(_bind$5);
          break _L;
        }
      }
      const code = _M0MPC14char4Char8to__uint(_decoded_char);
      if (code >>> 0 < 128 >>> 0) {
        const bit = 1 << (code & 31);
        const _bind$5 = code >>> 5 | 0;
        switch (_bind$5) {
          case 0: {
            bits0 = bits0 | bit;
            break;
          }
          case 1: {
            bits1 = bits1 | bit;
            break;
          }
          case 2: {
            bits2 = bits2 | bit;
            break;
          }
          default: {
            bits3 = bits3 | bit;
          }
        }
      } else {
        return undefined;
      }
      _tmp = _decoded_next_string_index;
      continue;
    } else {
      break;
    }
  }
  return { _0: bits0, _1: bits1, _2: bits2, _3: bits3 };
}
function _M0FPB26ascii__char__set__contains(bits0, bits1, bits2, bits3, code) {
  if (code >>> 0 < 128 >>> 0) {
    const bit = 1 << (code & 31);
    const _bind$2 = code >>> 5 | 0;
    switch (_bind$2) {
      case 0: {
        return (bits0 & bit) !== 0;
      }
      case 1: {
        return (bits1 & bit) !== 0;
      }
      case 2: {
        return (bits2 & bit) !== 0;
      }
      default: {
        return (bits3 & bit) !== 0;
      }
    }
  } else {
    return false;
  }
}
function _M0FPB34string__trim__start__ascii__scalar(str, start, end, bits0, bits1, bits2, bits3) {
  let _tmp = start;
  while (true) {
    const pos = _tmp;
    if (pos < end && _M0FPB26ascii__char__set__contains(bits0, bits1, bits2, bits3, _M0MPC16uint166UInt168to__uint(str.charCodeAt(pos)))) {
      _tmp = pos + 1 | 0;
      continue;
    } else {
      return pos;
    }
  }
}
function _M0FPB32string__trim__end__ascii__scalar(str, start, end, bits0, bits1, bits2, bits3) {
  let _tmp = end;
  while (true) {
    const pos = _tmp;
    if (pos > start && _M0FPB26ascii__char__set__contains(bits0, bits1, bits2, bits3, _M0MPC16uint166UInt168to__uint(str.charCodeAt(pos - 1 | 0)))) {
      _tmp = pos - 1 | 0;
      continue;
    } else {
      return pos;
    }
  }
}
function _M0FPB26string__trim__start__ascii(str, start, end, _chars, bits0, bits1, bits2, bits3) {
  return _M0FPB34string__trim__start__ascii__scalar(str, start, end, bits0, bits1, bits2, bits3);
}
function _M0FPB24string__trim__end__ascii(str, start, end, _chars, bits0, bits1, bits2, bits3) {
  return _M0FPB32string__trim__end__ascii__scalar(str, start, end, bits0, bits1, bits2, bits3);
}
function _M0MPC16string10StringView14contains__char(self, c) {
  const len = self.end - self.start | 0;
  if (len > 0) {
    const c$2 = c;
    if (c$2 >= 0 && c$2 <= 65535) {
      return _M0MPC16string10StringView20contains__code__unit(self, c$2 & 65535);
    } else {
      if (c$2 < 0) {
        return false;
      } else {
        if (len >= 2) {
          const adj = c$2 - 65536 | 0;
          const high = 55296 + (adj >> 10) | 0;
          if (high <= 65535) {
            const high$2 = high & 65535;
            const low = (56320 + (adj & 1023) | 0) & 65535;
            let _tmp = 0;
            while (true) {
              const i = _tmp;
              if (i < (len - 1 | 0)) {
                if (_M0IPC16uint166UInt16PB2Eq5equal(self.str.charCodeAt(self.start + i | 0), high$2)) {
                  if (_M0IPC16uint166UInt16PB2Eq5equal(self.str.charCodeAt(self.start + (i + 1 | 0) | 0), low)) {
                    return true;
                  }
                  _tmp = i + 2 | 0;
                  continue;
                }
                _tmp = i + 1 | 0;
                continue;
              } else {
                break;
              }
            }
          } else {
            return false;
          }
        } else {
          return false;
        }
      }
    }
    return false;
  } else {
    return false;
  }
}
function _M0MPC16string10StringView24trim__start__with__chars(self, chars) {
  let _tmp = self;
  while (true) {
    const x = _tmp;
    if ((x.end - x.start | 0) === 0) {
      return x;
    } else {
      const _c = _M0MPC16string6String16unsafe__char__at(x.str, _M0MPC16string6String29offset__of__nth__char_2einner(x.str, 0, x.start, x.end));
      const _tmp$2 = x.str;
      const _bind$2 = _M0MPC16string6String29offset__of__nth__char_2einner(x.str, 1, x.start, x.end);
      let _tmp$3;
      if (_bind$2 === undefined) {
        _tmp$3 = x.end;
      } else {
        const _Some = _bind$2;
        _tmp$3 = _Some;
      }
      const _x = new _M0TPC16string10StringView(_tmp$2, _tmp$3, x.end);
      if (_M0MPC16string10StringView14contains__char(chars, _c)) {
        _tmp = _x;
        continue;
      } else {
        return x;
      }
    }
  }
}
function _M0MPC16string10StringView22trim__end__with__chars(self, chars) {
  let _tmp = self;
  while (true) {
    const x = _tmp;
    if ((x.end - x.start | 0) === 0) {
      return x;
    } else {
      const _c = _M0MPC16string6String16unsafe__char__at(x.str, _M0MPC16string6String29offset__of__nth__char_2einner(x.str, -1, x.start, x.end));
      const _x = new _M0TPC16string10StringView(x.str, x.start, _M0MPC16string6String29offset__of__nth__char_2einner(x.str, -1, x.start, x.end));
      if (_M0MPC16string10StringView14contains__char(chars, _c)) {
        _tmp = _x;
        continue;
      } else {
        return x;
      }
    }
  }
}
function _M0MPC16string10StringView12trim_2einner(self, chars) {
  const _bind$2 = _M0FPB23build__ascii__char__set(chars);
  if (_bind$2 === undefined) {
    return _M0MPC16string10StringView22trim__end__with__chars(_M0MPC16string10StringView24trim__start__with__chars(self, chars), chars);
  } else {
    const _Some = _bind$2;
    const _x = _Some;
    const _bits0 = _x._0;
    const _bits1 = _x._1;
    const _bits2 = _x._2;
    const _bits3 = _x._3;
    const start = _M0FPB26string__trim__start__ascii(self.str, self.start, self.end, chars, _bits0, _bits1, _bits2, _bits3);
    const end = _M0FPB24string__trim__end__ascii(self.str, start, self.end, chars, _bits0, _bits1, _bits2, _bits3);
    return new _M0TPC16string10StringView(self.str, start, end);
  }
}
function _M0MPC16string10StringView17trim__end_2einner(self, chars) {
  const _bind$2 = _M0FPB23build__ascii__char__set(chars);
  if (_bind$2 === undefined) {
    return _M0MPC16string10StringView22trim__end__with__chars(self, chars);
  } else {
    const _Some = _bind$2;
    const _x = _Some;
    const _bits0 = _x._0;
    const _bits1 = _x._1;
    const _bits2 = _x._2;
    const _bits3 = _x._3;
    const end = _M0FPB24string__trim__end__ascii(self.str, self.start, self.end, chars, _bits0, _bits1, _bits2, _bits3);
    return new _M0TPC16string10StringView(self.str, self.start, end);
  }
}
function _M0MPC16string6String17trim__end_2einner(self, chars) {
  return _M0MPC16string10StringView17trim__end_2einner(new _M0TPC16string10StringView(self, 0, self.length), chars);
}
function _M0MPC16string6String9trim__end(self, chars$46$opt) {
  let chars;
  if (chars$46$opt === undefined) {
    chars = new _M0TPC16string10StringView(_M0MPC16string6String9trim__endN7_2abindS6844, 0, _M0MPC16string6String9trim__endN7_2abindS6844.length);
  } else {
    const _Some = chars$46$opt;
    chars = _Some;
  }
  return _M0MPC16string6String17trim__end_2einner(self, chars);
}
function _M0MPC16string6String12trim_2einner(self, chars) {
  return _M0MPC16string10StringView12trim_2einner(new _M0TPC16string10StringView(self, 0, self.length), chars);
}
function _M0MPC16string6String4trim(self, chars$46$opt) {
  let chars;
  if (chars$46$opt === undefined) {
    chars = new _M0TPC16string10StringView(_M0MPC16string6String4trimN7_2abindS6861, 0, _M0MPC16string6String4trimN7_2abindS6861.length);
  } else {
    const _Some = chars$46$opt;
    chars = _Some;
  }
  return _M0MPC16string6String12trim_2einner(self, chars);
}
function _M0MPC16string10StringView9is__empty(self) {
  return (self.end - self.start | 0) === 0;
}
function _M0MPC16string6String9is__empty(self) {
  return self === "";
}
function _M0MPC16string6String4iter(self) {
  const len = self.length;
  const index = new _M0TPB8MutLocalGiE(0);
  return _M0MPB4Iter3newGcE(() => {
    if (index.val < len) {
      const c1 = self.charCodeAt(index.val);
      if (_M0MPC16uint166UInt1622is__leading__surrogate(c1) && (index.val + 1 | 0) < len) {
        const c2 = self.charCodeAt(index.val + 1 | 0);
        if (_M0MPC16uint166UInt1623is__trailing__surrogate(c2)) {
          const c = _M0FPB32code__point__of__surrogate__pair(c1, c2);
          index.val = index.val + 2 | 0;
          return c;
        }
      }
      index.val = index.val + 1 | 0;
      return _M0MPC16uint166UInt1616unsafe__to__char(c1);
    } else {
      return -1;
    }
  }, undefined);
}
function _M0MPC16string10StringView3rev(self) {
  const buf = _M0MPB13StringBuilder21StringBuilder_2einner(self.end - self.start | 0);
  const _it = _M0MPC16string10StringView9rev__iter(self);
  while (true) {
    const _bind$2 = _M0MPB4Iter4nextGcE(_it);
    if (_bind$2 === -1) {
      break;
    } else {
      const _Some = _bind$2;
      const _c = _Some;
      _M0IPB13StringBuilderPB6Logger11write__char(buf, _c);
      continue;
    }
  }
  return _M0MPB13StringBuilder10to__string(buf);
}
function _M0MPC16string6String3rev(self) {
  return _M0MPC16string10StringView3rev(new _M0TPC16string10StringView(self, 0, self.length));
}
function _M0MPB4Iter3mapGRP211localreview3tcl7CommandsE(self, f) {
  return new _M0TPB4IterGsE(() => {
    const _bind$2 = _M0MPB4Iter4nextGUsRPB4JsonEE(self);
    if (_bind$2 === undefined) {
      return undefined;
    } else {
      const _Some = _bind$2;
      const _x = _Some;
      return f(_x);
    }
  }, self.size_hint);
}
function _M0MPB4Iter3mapGcRPC16string10StringViewE(self, f) {
  return new _M0TPB4IterGRPC16string10StringViewE(() => {
    const _bind$2 = _M0MPB4Iter4nextGcE(self);
    if (_bind$2 === -1) {
      return undefined;
    } else {
      const _Some = _bind$2;
      const _x = _Some;
      return f(_x);
    }
  }, self.size_hint);
}
function _M0IPC14char4CharPB4Show10to__string(self) {
  return String.fromCodePoint(self);
}
function _M0MPC16string10StringView5split(self, sep) {
  const sep_len = sep.end - sep.start | 0;
  if (sep_len === 0) {
    return _M0MPB4Iter3mapGcRPC16string10StringViewE(_M0MPC16string10StringView4iter(self), (c) => _M0MPC16string6String12view_2einner(_M0IPC14char4CharPB4Show10to__string(c), 0, undefined));
  }
  const remaining = new _M0TPB8MutLocalGORPC16string10StringViewE(self);
  return _M0MPB4Iter3newGUsRPB4JsonEE(() => {
    const _bind$2 = remaining.val;
    if (_bind$2 === undefined) {
      return undefined;
    } else {
      const _Some = _bind$2;
      const _view = _Some;
      const _bind$3 = _M0MPC16string10StringView4find(_view, sep);
      if (_bind$3 === undefined) {
        remaining.val = undefined;
        return _view;
      } else {
        const _Some$2 = _bind$3;
        const _end = _Some$2;
        remaining.val = _M0MPC16string10StringView12view_2einner(_view, _end + sep_len | 0, undefined);
        return _M0MPC16string10StringView12view_2einner(_view, 0, _end);
      }
    }
  }, undefined);
}
function _M0MPC16string6String5split(self, sep) {
  return _M0MPC16string10StringView5split(new _M0TPC16string10StringView(self, 0, self.length), sep);
}
function _M0MPB4Iter9to__arrayGRPC16string10StringViewE(self) {
  const _bind$2 = self.size_hint;
  let result;
  if (_bind$2 === undefined) {
    result = [];
  } else {
    const _Some = _bind$2;
    const _n = _Some;
    result = _M0MPC15array5Array13Array_2einnerGRPC16string10StringViewE(_n);
  }
  while (true) {
    const _bind$3 = _M0MPB4Iter4nextGUsRPB4JsonEE(self);
    if (_bind$3 === undefined) {
      break;
    } else {
      const _Some = _bind$3;
      const _x = _Some;
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(result, _x);
      continue;
    }
  }
  return result;
}
function _M0MPC16string6String12replace__all(self, old, new_) {
  const len = self.length;
  const buf = _M0MPB13StringBuilder21StringBuilder_2einner(len);
  const old_len = old.end - old.start | 0;
  const new$2 = _M0MPC16string10StringView9to__owned(new_);
  if (old_len === 0) {
    _M0IPB13StringBuilderPB6Logger13write__string(buf, new$2);
    const _bind$2 = self.length;
    let _tmp = 0;
    while (true) {
      const _string_index = _tmp;
      if (_string_index < _bind$2) {
        let _decoded_next_string_index;
        let _decoded_char;
        _L: {
          const _bind$3 = self.charCodeAt(_string_index);
          if (_bind$3 >= 55296 && _bind$3 <= 56319 && (_string_index + 1 | 0) < _bind$2) {
            const _bind$4 = self.charCodeAt(_string_index + 1 | 0);
            if (_bind$4 >= 56320 && _bind$4 <= 57343) {
              _decoded_next_string_index = _string_index + 2 | 0;
              _decoded_char = _M0MPC13int3Int16unsafe__to__char((((Math.imul(_bind$3 - 55296 | 0, 1024) | 0) + _bind$4 | 0) - 56320 | 0) + 65536 | 0);
              break _L;
            } else {
              _decoded_next_string_index = _string_index + 1 | 0;
              _decoded_char = _M0MPC13int3Int16unsafe__to__char(_bind$3);
              break _L;
            }
          } else {
            _decoded_next_string_index = _string_index + 1 | 0;
            _decoded_char = _M0MPC13int3Int16unsafe__to__char(_bind$3);
            break _L;
          }
        }
        _M0IPB13StringBuilderPB6Logger11write__char(buf, _decoded_char);
        _M0IPB13StringBuilderPB6Logger13write__string(buf, new$2);
        _tmp = _decoded_next_string_index;
        continue;
      } else {
        break;
      }
    }
    return _M0MPB13StringBuilder10to__string(buf);
  } else {
    const first_end = _M0MPC16string6String4find(self, old);
    if (first_end === undefined) {
      return self;
    } else {
      const _Some = first_end;
      const _end = _Some;
      let _tmp = new _M0TPC16string10StringView(self, 0, self.length);
      let _tmp$2 = _end;
      while (true) {
        const view = _tmp;
        const end = _tmp$2;
        const seg = _M0MPC16string10StringView12view_2einner(view, 0, end);
        _M0IP016_24default__implPB6Logger16write__substringGRPB13StringBuilderE(buf, _M0MPC16string10StringView4data(seg), _M0MPC16string10StringView13start__offset(seg), seg.end - seg.start | 0);
        _M0IPB13StringBuilderPB6Logger13write__string(buf, new$2);
        if ((end + old_len | 0) <= len) {
          const next_view = _M0MPC16string10StringView12view_2einner(view, end + old_len | 0, undefined);
          const _bind$2 = _M0MPC16string10StringView4find(next_view, old);
          if (_bind$2 === undefined) {
            _M0IP016_24default__implPB6Logger16write__substringGRPB13StringBuilderE(buf, _M0MPC16string10StringView4data(next_view), _M0MPC16string10StringView13start__offset(next_view), next_view.end - next_view.start | 0);
            break;
          } else {
            const _Some$2 = _bind$2;
            const _next_end = _Some$2;
            _tmp = next_view;
            _tmp$2 = _next_end;
            continue;
          }
        } else {
          break;
        }
      }
      return _M0MPB13StringBuilder10to__string(buf);
    }
  }
}
function _M0MPC14char4Char20is__ascii__uppercase(self) {
  return self >= 65 && self <= 90;
}
function _M0MPC16string6String9to__lower(self) {
  const _bind$2 = _M0MPC16string6String8find__by(self, (c) => _M0MPC14char4Char20is__ascii__uppercase(c));
  if (_bind$2 === undefined) {
    return self;
  } else {
    const _Some = _bind$2;
    const _idx = _Some;
    const buf = _M0MPB13StringBuilder21StringBuilder_2einner(self.length);
    const head = _M0MPC16string6String12view_2einner(self, 0, _idx);
    _M0IP016_24default__implPB6Logger16write__substringGRPB13StringBuilderE(buf, _M0MPC16string10StringView4data(head), _M0MPC16string10StringView13start__offset(head), head.end - head.start | 0);
    const _bind$3 = _M0MPC16string6String12view_2einner(self, _idx, undefined);
    const _bind$4 = _bind$3.str;
    const _bind$5 = _bind$3.start;
    const _bind$6 = _bind$3.end;
    let _tmp = _bind$5;
    while (true) {
      const _string_index = _tmp;
      if (_string_index < _bind$6) {
        let _decoded_next_string_index;
        let _decoded_char;
        _L: {
          const _bind$7 = _bind$4.charCodeAt(_string_index);
          if (_bind$7 >= 55296 && _bind$7 <= 56319 && (_string_index + 1 | 0) < _bind$6) {
            const _bind$8 = _bind$4.charCodeAt(_string_index + 1 | 0);
            if (_bind$8 >= 56320 && _bind$8 <= 57343) {
              _decoded_next_string_index = _string_index + 2 | 0;
              _decoded_char = _M0MPC13int3Int16unsafe__to__char((((Math.imul(_bind$7 - 55296 | 0, 1024) | 0) + _bind$8 | 0) - 56320 | 0) + 65536 | 0);
              break _L;
            } else {
              _decoded_next_string_index = _string_index + 1 | 0;
              _decoded_char = _M0MPC13int3Int16unsafe__to__char(_bind$7);
              break _L;
            }
          } else {
            _decoded_next_string_index = _string_index + 1 | 0;
            _decoded_char = _M0MPC13int3Int16unsafe__to__char(_bind$7);
            break _L;
          }
        }
        if (_M0MPC14char4Char20is__ascii__uppercase(_decoded_char)) {
          _M0IPB13StringBuilderPB6Logger11write__char(buf, _decoded_char + 32 | 0);
        } else {
          _M0IPB13StringBuilderPB6Logger11write__char(buf, _decoded_char);
        }
        _tmp = _decoded_next_string_index;
        continue;
      } else {
        break;
      }
    }
    return _M0MPB13StringBuilder10to__string(buf);
  }
}
function _M0MPC14char4Char20is__ascii__lowercase(self) {
  return self >= 97 && self <= 122;
}
function _M0MPC16string6String9to__upper(self) {
  const _bind$2 = _M0MPC16string6String8find__by(self, (c) => _M0MPC14char4Char20is__ascii__lowercase(c));
  if (_bind$2 === undefined) {
    return self;
  } else {
    const _Some = _bind$2;
    const _idx = _Some;
    const buf = _M0MPB13StringBuilder21StringBuilder_2einner(self.length);
    const head = _M0MPC16string6String12view_2einner(self, 0, _idx);
    _M0IP016_24default__implPB6Logger16write__substringGRPB13StringBuilderE(buf, _M0MPC16string10StringView4data(head), _M0MPC16string10StringView13start__offset(head), head.end - head.start | 0);
    const _bind$3 = _M0MPC16string6String12view_2einner(self, _idx, undefined);
    const _bind$4 = _bind$3.str;
    const _bind$5 = _bind$3.start;
    const _bind$6 = _bind$3.end;
    let _tmp = _bind$5;
    while (true) {
      const _string_index = _tmp;
      if (_string_index < _bind$6) {
        let _decoded_next_string_index;
        let _decoded_char;
        _L: {
          const _bind$7 = _bind$4.charCodeAt(_string_index);
          if (_bind$7 >= 55296 && _bind$7 <= 56319 && (_string_index + 1 | 0) < _bind$6) {
            const _bind$8 = _bind$4.charCodeAt(_string_index + 1 | 0);
            if (_bind$8 >= 56320 && _bind$8 <= 57343) {
              _decoded_next_string_index = _string_index + 2 | 0;
              _decoded_char = _M0MPC13int3Int16unsafe__to__char((((Math.imul(_bind$7 - 55296 | 0, 1024) | 0) + _bind$8 | 0) - 56320 | 0) + 65536 | 0);
              break _L;
            } else {
              _decoded_next_string_index = _string_index + 1 | 0;
              _decoded_char = _M0MPC13int3Int16unsafe__to__char(_bind$7);
              break _L;
            }
          } else {
            _decoded_next_string_index = _string_index + 1 | 0;
            _decoded_char = _M0MPC13int3Int16unsafe__to__char(_bind$7);
            break _L;
          }
        }
        if (_M0MPC14char4Char20is__ascii__lowercase(_decoded_char)) {
          _M0IPB13StringBuilderPB6Logger11write__char(buf, _decoded_char - 32 | 0);
        } else {
          _M0IPB13StringBuilderPB6Logger11write__char(buf, _decoded_char);
        }
        _tmp = _decoded_next_string_index;
        continue;
      } else {
        break;
      }
    }
    return _M0MPB13StringBuilder10to__string(buf);
  }
}
function _M0MPC16string6String3get(self, idx) {
  return idx >= 0 && idx < self.length ? self.charCodeAt(idx) : -1;
}
function _M0IPC16string6StringPB12ToStringView16to__string__view(self) {
  return new _M0TPC16string10StringView(self, 0, self.length);
}
function _M0IPC16string10StringViewPB12ToStringView16to__string__view(self) {
  return self;
}
function _M0IPC16string6StringPB7Compare7compare(self, other) {
  const len = self.length;
  const _bind$2 = $compare_int(len, other.length);
  if (_bind$2 === 0) {
    let _tmp = 0;
    while (true) {
      const i = _tmp;
      if (i < len) {
        const order = _M0IPC16uint166UInt16PB7Compare7compare(self.charCodeAt(i), other.charCodeAt(i));
        if (order !== 0) {
          return order;
        }
        _tmp = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    return 0;
  } else {
    return _bind$2;
  }
}
function _M0MPC16string6String9to__array(self) {
  return _M0MPB4Iter4foldGcRPB5ArrayGcEE(_M0MPC16string6String4iter(self), _M0MPC15array5Array13Array_2einnerGcE(self.length), (rv, c) => {
    _M0MPC15array5Array4pushGcE(rv, c);
    return rv;
  });
}
function _M0IPC14bool4BoolPB4Show10to__string(self) {
  return self ? "true" : "false";
}
function _M0IPC13int3IntPB4Show10to__string(self) {
  return _M0MPC13int3Int18to__string_2einner(self, 10);
}
function _M0MPC15array9ArrayView4iterGsE(self) {
  const i = new _M0TPB8MutLocalGiE(0);
  const len = self.end - self.start | 0;
  return _M0MPB4Iter3newGUsRPB4JsonEE(() => {
    if (i.val < len) {
      const elem = self.buf[self.start + i.val | 0];
      i.val = i.val + 1 | 0;
      return elem;
    } else {
      return undefined;
    }
  }, len);
}
function _M0MPC15array9ArrayView4iterGcE(self) {
  const i = new _M0TPB8MutLocalGiE(0);
  const len = self.end - self.start | 0;
  return _M0MPB4Iter3newGcE(() => {
    if (i.val < len) {
      const elem = self.buf[self.start + i.val | 0];
      i.val = i.val + 1 | 0;
      return elem;
    } else {
      return -1;
    }
  }, len);
}
function _M0MPC15array5Array4iterGUssEE(self) {
  return _M0MPC15array9ArrayView4iterGsE(new _M0TPB9ArrayViewGUssEE(self, 0, self.length));
}
function _M0MPC15array5Array4iterGcE(self) {
  return _M0MPC15array9ArrayView4iterGcE(new _M0TPB9ArrayViewGcE(self, 0, self.length));
}
function _M0MPC15array13ReadOnlyArray2atGmE(self, index) {
  return index >>> 0 < self.length ? self[index] : $oob();
}
function _M0MPC15array13ReadOnlyArray2atGiE(self, index) {
  return index >>> 0 < self.length ? self[index] : $oob();
}
function _M0MPC15array13ReadOnlyArray2atGdE(self, index) {
  return index >>> 0 < self.length ? self[index] : $oob();
}
function _M0MPC15array13ReadOnlyArray6lengthGiE(self) {
  return self.length;
}
function _M0MPC13int3Int3min(self, other) {
  return self < other ? self : other;
}
function _M0MPC15array9ArrayView4joinGsE(self, separator) {
  if ((self.end - self.start | 0) === 0) {
    return "";
  } else {
    const _hd = self.buf[self.start];
    const _x_buf = self.buf;
    const _x_start = 1 + self.start | 0;
    const _x_end = self.end;
    const hd = _M0IPC16string6StringPB12ToStringView16to__string__view(_hd);
    const _bind$2 = _x_end - _x_start | 0;
    let size_hint;
    let _tmp = 0;
    let _tmp$2 = hd.end - hd.start | 0;
    while (true) {
      const _ = _tmp;
      const size_hint$2 = _tmp$2;
      if (_ < _bind$2) {
        const s = _x_buf[_x_start + _ | 0];
        _tmp = _ + 1 | 0;
        const _bind$3 = _M0IPC16string6StringPB12ToStringView16to__string__view(s);
        _tmp$2 = (size_hint$2 + (_bind$3.end - _bind$3.start | 0) | 0) + (separator.end - separator.start | 0) | 0;
        continue;
      } else {
        size_hint = size_hint$2;
        break;
      }
    }
    const size_hint$2 = size_hint << 1;
    const buf = _M0MPB13StringBuilder21StringBuilder_2einner(size_hint$2);
    _M0IPB13StringBuilderPB6Logger11write__view(buf, hd);
    if ((separator.end - separator.start | 0) === 0) {
      const _bind$3 = _x_end - _x_start | 0;
      let _tmp$3 = 0;
      while (true) {
        const _ = _tmp$3;
        if (_ < _bind$3) {
          const s = _x_buf[_x_start + _ | 0];
          const s$2 = _M0IPC16string6StringPB12ToStringView16to__string__view(s);
          _M0IPB13StringBuilderPB6Logger11write__view(buf, s$2);
          _tmp$3 = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    } else {
      const _bind$3 = _x_end - _x_start | 0;
      let _tmp$3 = 0;
      while (true) {
        const _ = _tmp$3;
        if (_ < _bind$3) {
          const s = _x_buf[_x_start + _ | 0];
          const s$2 = _M0IPC16string6StringPB12ToStringView16to__string__view(s);
          _M0IPB13StringBuilderPB6Logger11write__view(buf, separator);
          _M0IPB13StringBuilderPB6Logger11write__view(buf, s$2);
          _tmp$3 = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    }
    return _M0MPB13StringBuilder10to__string(buf);
  }
}
function _M0MPC15array9ArrayView4joinGRPC16string10StringViewE(self, separator) {
  if ((self.end - self.start | 0) === 0) {
    return "";
  } else {
    const _hd = self.buf[self.start];
    const _x_buf = self.buf;
    const _x_start = 1 + self.start | 0;
    const _x_end = self.end;
    const hd = _M0IPC16string10StringViewPB12ToStringView16to__string__view(_hd);
    const _bind$2 = _x_end - _x_start | 0;
    let size_hint;
    let _tmp = 0;
    let _tmp$2 = hd.end - hd.start | 0;
    while (true) {
      const _ = _tmp;
      const size_hint$2 = _tmp$2;
      if (_ < _bind$2) {
        const s = _x_buf[_x_start + _ | 0];
        _tmp = _ + 1 | 0;
        const _bind$3 = _M0IPC16string10StringViewPB12ToStringView16to__string__view(s);
        _tmp$2 = (size_hint$2 + (_bind$3.end - _bind$3.start | 0) | 0) + (separator.end - separator.start | 0) | 0;
        continue;
      } else {
        size_hint = size_hint$2;
        break;
      }
    }
    const size_hint$2 = size_hint << 1;
    const buf = _M0MPB13StringBuilder21StringBuilder_2einner(size_hint$2);
    _M0IPB13StringBuilderPB6Logger11write__view(buf, hd);
    if ((separator.end - separator.start | 0) === 0) {
      const _bind$3 = _x_end - _x_start | 0;
      let _tmp$3 = 0;
      while (true) {
        const _ = _tmp$3;
        if (_ < _bind$3) {
          const s = _x_buf[_x_start + _ | 0];
          const s$2 = _M0IPC16string10StringViewPB12ToStringView16to__string__view(s);
          _M0IPB13StringBuilderPB6Logger11write__view(buf, s$2);
          _tmp$3 = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    } else {
      const _bind$3 = _x_end - _x_start | 0;
      let _tmp$3 = 0;
      while (true) {
        const _ = _tmp$3;
        if (_ < _bind$3) {
          const s = _x_buf[_x_start + _ | 0];
          const s$2 = _M0IPC16string10StringViewPB12ToStringView16to__string__view(s);
          _M0IPB13StringBuilderPB6Logger11write__view(buf, separator);
          _M0IPB13StringBuilderPB6Logger11write__view(buf, s$2);
          _tmp$3 = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    }
    return _M0MPB13StringBuilder10to__string(buf);
  }
}
function _M0IPC16option6OptionPB2Eq5equalGsE(self, other) {
  if (self === undefined) {
    return other === undefined;
  } else {
    const _Some = self;
    const _x = _Some;
    if (other === undefined) {
      return false;
    } else {
      const _Some$2 = other;
      const _y = _Some$2;
      return _x === _y;
    }
  }
}
function _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(self) {
  if (self === undefined) {
    return $panic();
  } else {
    const _Some = self;
    return _Some;
  }
}
function _M0MPC16option6Option6unwrapGkE(self) {
  return self === -1 ? $panic() : self;
}
function _M0MPC16option6Option10unwrap__orGsE(self, default_) {
  if (self === undefined) {
    return default_;
  } else {
    const _Some = self;
    const _t = _Some;
    return _t;
  }
}
function _M0MPC16option6Option10unwrap__orGcE(self, default_) {
  if (self === -1) {
    return default_;
  } else {
    const _Some = self;
    const _t = _Some;
    return _t;
  }
}
function _M0MPC16option6Option10unwrap__orGRPB5ArrayGsEE(self, default_) {
  if (self.$tag === 1) {
    const _Some = self;
    const _t = _Some._0;
    return _t;
  } else {
    return default_;
  }
}
function _M0MPC16option6Option10unwrap__orGiE(self, default_) {
  if (self === undefined) {
    return default_;
  } else {
    const _Some = self;
    const _t = _Some;
    return _t;
  }
}
function _M0MPC16option6Option3mapGRP211localreview3tcl7CommandsE(self, f) {
  if (self === undefined) {
    return undefined;
  } else {
    const _Some = self;
    const _t = _Some;
    return f(_t);
  }
}
function _M0MPC16option6Option3mapGRPB3MapGssEiE(self, f) {
  if (self === undefined) {
    return undefined;
  } else {
    const _Some = self;
    const _t = _Some;
    return f(_t);
  }
}
function _M0MPC16option6Option3mapGisE(self, f) {
  if (self === undefined) {
    return undefined;
  } else {
    const _Some = self;
    const _t = _Some;
    return f(_t);
  }
}
function _M0MPC16option6Option3mapGRP211localreview3tcl6NumberRP211localreview3tcl6NumberE(self, f) {
  if (self === undefined) {
    return undefined;
  } else {
    const _Some = self;
    const _t = _Some;
    return f(_t);
  }
}
function _M0MPC15array5Array31unsafe__make__and__blit_2einnerGsE(src, allocate_len, len, src_offset, dst_offset) {
  const dst = new Array(allocate_len);
  _M0MPB18UninitializedArray12unsafe__blitGsE(dst, dst_offset, src, src_offset, len);
  return dst;
}
function _M0MPC15array5Array31unsafe__make__and__blit_2einnerGcE(src, allocate_len, len, src_offset, dst_offset) {
  const dst = new Array(allocate_len);
  _M0MPB18UninitializedArray12unsafe__blitGcE(dst, dst_offset, src, src_offset, len);
  return dst;
}
function _M0MPC15array9ArrayView9to__ownedGsE(self) {
  const len = self.end - self.start | 0;
  return len === 0 ? [] : _M0MPC15array5Array31unsafe__make__and__blit_2einnerGsE(self.buf, len, len, self.start, 0);
}
function _M0MPC15array9ArrayView9to__ownedGcE(self) {
  const len = self.end - self.start | 0;
  return len === 0 ? [] : _M0MPC15array5Array31unsafe__make__and__blit_2einnerGcE(self.buf, len, len, self.start, 0);
}
function _M0FPB21calc__grow__threshold(capacity) {
  if (16 === 0) {
    $panic();
  }
  return (Math.imul(capacity, 13) | 0) / 16 | 0;
}
function _M0MPC13int3Int20next__power__of__two(self) {
  if (self >= 0) {
    if (self <= 1) {
      return 1;
    }
    if (self > 1073741824) {
      return 1073741824;
    }
    return (2147483647 >> (Math.clz32(self - 1 | 0) - 1 | 0)) + 1 | 0;
  } else {
    return $panic();
  }
}
function _M0FPB8new__mapGsRP211localreview3tcl7CommandE(capacity) {
  const capacity$2 = _M0MPC13int3Int20next__power__of__two(capacity);
  const _bind$2 = capacity$2 - 1 | 0;
  const _bind$3 = _M0FPB21calc__grow__threshold(capacity$2);
  const _bind$4 = $make_array_len_and_init(capacity$2, undefined);
  const _bind$5 = undefined;
  return new _M0TPB3MapGsRP211localreview3tcl7CommandE(_bind$4, 0, capacity$2, _bind$2, _bind$3, _bind$5, -1);
}
function _M0FPB8new__mapGsRPB5ArrayGsEE(capacity) {
  const capacity$2 = _M0MPC13int3Int20next__power__of__two(capacity);
  const _bind$2 = capacity$2 - 1 | 0;
  const _bind$3 = _M0FPB21calc__grow__threshold(capacity$2);
  const _bind$4 = $make_array_len_and_init(capacity$2, undefined);
  const _bind$5 = undefined;
  return new _M0TPB3MapGsRPB5ArrayGsEE(_bind$4, 0, capacity$2, _bind$2, _bind$3, _bind$5, -1);
}
function _M0FPB8new__mapGsbE(capacity) {
  const capacity$2 = _M0MPC13int3Int20next__power__of__two(capacity);
  const _bind$2 = capacity$2 - 1 | 0;
  const _bind$3 = _M0FPB21calc__grow__threshold(capacity$2);
  const _bind$4 = $make_array_len_and_init(capacity$2, undefined);
  const _bind$5 = undefined;
  return new _M0TPB3MapGsbE(_bind$4, 0, capacity$2, _bind$2, _bind$3, _bind$5, -1);
}
function _M0FPB8new__mapGiRP211localreview3tcl11InterpreterE(capacity) {
  const capacity$2 = _M0MPC13int3Int20next__power__of__two(capacity);
  const _bind$2 = capacity$2 - 1 | 0;
  const _bind$3 = _M0FPB21calc__grow__threshold(capacity$2);
  const _bind$4 = $make_array_len_and_init(capacity$2, undefined);
  const _bind$5 = undefined;
  return new _M0TPB3MapGiRP211localreview3tcl11InterpreterE(_bind$4, 0, capacity$2, _bind$2, _bind$3, _bind$5, -1);
}
function _M0FPB8new__mapGsiE(capacity) {
  const capacity$2 = _M0MPC13int3Int20next__power__of__two(capacity);
  const _bind$2 = capacity$2 - 1 | 0;
  const _bind$3 = _M0FPB21calc__grow__threshold(capacity$2);
  const _bind$4 = $make_array_len_and_init(capacity$2, undefined);
  const _bind$5 = undefined;
  return new _M0TPB3MapGsiE(_bind$4, 0, capacity$2, _bind$2, _bind$3, _bind$5, -1);
}
function _M0FPB21capacity__for__length(length) {
  let capacity = _M0MPC13int3Int20next__power__of__two(length);
  if (length > _M0FPB21calc__grow__threshold(capacity)) {
    capacity = Math.imul(capacity, 2) | 0;
  }
  return capacity;
}
function _M0MPC13int3Int3max(self, other) {
  return self > other ? self : other;
}
function _M0MPB3Map20add__entry__to__tailGiRP211localreview3tcl11InterpreterE(self, idx, entry) {
  const _bind$2 = self.tail;
  if (_bind$2 === -1) {
    self.head = entry;
  } else {
    const _tmp = self.entries;
    _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_bind$2 >>> 0 < _tmp.length ? _tmp[_bind$2] : $oob()).next = entry;
  }
  self.tail = idx;
  self.entries[idx] = entry;
  self.size = self.size + 1 | 0;
}
function _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry) {
  const _bind$2 = self.tail;
  if (_bind$2 === -1) {
    self.head = entry;
  } else {
    const _tmp = self.entries;
    _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_bind$2 >>> 0 < _tmp.length ? _tmp[_bind$2] : $oob()).next = entry;
  }
  self.tail = idx;
  self.entries[idx] = entry;
  self.size = self.size + 1 | 0;
}
function _M0MPB3Map20add__entry__to__tailGsRPB5ArrayGsEE(self, idx, entry) {
  const _bind$2 = self.tail;
  if (_bind$2 === -1) {
    self.head = entry;
  } else {
    const _tmp = self.entries;
    _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_bind$2 >>> 0 < _tmp.length ? _tmp[_bind$2] : $oob()).next = entry;
  }
  self.tail = idx;
  self.entries[idx] = entry;
  self.size = self.size + 1 | 0;
}
function _M0MPB3Map20add__entry__to__tailGsbE(self, idx, entry) {
  const _bind$2 = self.tail;
  if (_bind$2 === -1) {
    self.head = entry;
  } else {
    const _tmp = self.entries;
    _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_bind$2 >>> 0 < _tmp.length ? _tmp[_bind$2] : $oob()).next = entry;
  }
  self.tail = idx;
  self.entries[idx] = entry;
  self.size = self.size + 1 | 0;
}
function _M0MPB3Map20add__entry__to__tailGsiE(self, idx, entry) {
  const _bind$2 = self.tail;
  if (_bind$2 === -1) {
    self.head = entry;
  } else {
    const _tmp = self.entries;
    _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_bind$2 >>> 0 < _tmp.length ? _tmp[_bind$2] : $oob()).next = entry;
  }
  self.tail = idx;
  self.entries[idx] = entry;
  self.size = self.size + 1 | 0;
}
function _M0MPB3Map10set__entryGiRP211localreview3tcl11InterpreterE(self, entry, new_idx) {
  const _bind$2 = entry.next;
  if (_bind$2 === undefined) {
    self.tail = new_idx;
  } else {
    const _Some = _bind$2;
    const _next = _Some;
    _next.prev = new_idx;
  }
  self.entries[new_idx] = entry;
}
function _M0MPB3Map10set__entryGsRP211localreview3tcl7CommandE(self, entry, new_idx) {
  const _bind$2 = entry.next;
  if (_bind$2 === undefined) {
    self.tail = new_idx;
  } else {
    const _Some = _bind$2;
    const _next = _Some;
    _next.prev = new_idx;
  }
  self.entries[new_idx] = entry;
}
function _M0MPB3Map10set__entryGsRPB5ArrayGsEE(self, entry, new_idx) {
  const _bind$2 = entry.next;
  if (_bind$2 === undefined) {
    self.tail = new_idx;
  } else {
    const _Some = _bind$2;
    const _next = _Some;
    _next.prev = new_idx;
  }
  self.entries[new_idx] = entry;
}
function _M0MPB3Map10set__entryGsbE(self, entry, new_idx) {
  const _bind$2 = entry.next;
  if (_bind$2 === undefined) {
    self.tail = new_idx;
  } else {
    const _Some = _bind$2;
    const _next = _Some;
    _next.prev = new_idx;
  }
  self.entries[new_idx] = entry;
}
function _M0MPB3Map10set__entryGsiE(self, entry, new_idx) {
  const _bind$2 = entry.next;
  if (_bind$2 === undefined) {
    self.tail = new_idx;
  } else {
    const _Some = _bind$2;
    const _next = _Some;
    _next.prev = new_idx;
  }
  self.entries[new_idx] = entry;
}
function _M0MPB3Map10push__awayGiRP211localreview3tcl11InterpreterE(self, idx, entry) {
  let _tmp = entry.psl + 1 | 0;
  let _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
  let _tmp$3 = entry;
  while (true) {
    const psl = _tmp;
    const idx$2 = _tmp$2;
    const entry$2 = _tmp$3;
    const _bind$2 = self.entries[idx$2];
    if (_bind$2 === undefined) {
      entry$2.psl = psl;
      _M0MPB3Map10set__entryGiRP211localreview3tcl11InterpreterE(self, entry$2, idx$2);
      return;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (psl > _curr_entry.psl) {
        entry$2.psl = psl;
        _M0MPB3Map10set__entryGiRP211localreview3tcl11InterpreterE(self, entry$2, idx$2);
        _tmp = _curr_entry.psl + 1 | 0;
        _tmp$2 = (idx$2 + 1 | 0) & self.capacity_mask;
        _tmp$3 = _curr_entry;
        continue;
      } else {
        _tmp = psl + 1 | 0;
        _tmp$2 = (idx$2 + 1 | 0) & self.capacity_mask;
        continue;
      }
    }
  }
}
function _M0MPB3Map10push__awayGsRP211localreview3tcl7CommandE(self, idx, entry) {
  let _tmp = entry.psl + 1 | 0;
  let _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
  let _tmp$3 = entry;
  while (true) {
    const psl = _tmp;
    const idx$2 = _tmp$2;
    const entry$2 = _tmp$3;
    const _bind$2 = self.entries[idx$2];
    if (_bind$2 === undefined) {
      entry$2.psl = psl;
      _M0MPB3Map10set__entryGsRP211localreview3tcl7CommandE(self, entry$2, idx$2);
      return;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (psl > _curr_entry.psl) {
        entry$2.psl = psl;
        _M0MPB3Map10set__entryGsRP211localreview3tcl7CommandE(self, entry$2, idx$2);
        _tmp = _curr_entry.psl + 1 | 0;
        _tmp$2 = (idx$2 + 1 | 0) & self.capacity_mask;
        _tmp$3 = _curr_entry;
        continue;
      } else {
        _tmp = psl + 1 | 0;
        _tmp$2 = (idx$2 + 1 | 0) & self.capacity_mask;
        continue;
      }
    }
  }
}
function _M0MPB3Map10push__awayGsRPB5ArrayGsEE(self, idx, entry) {
  let _tmp = entry.psl + 1 | 0;
  let _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
  let _tmp$3 = entry;
  while (true) {
    const psl = _tmp;
    const idx$2 = _tmp$2;
    const entry$2 = _tmp$3;
    const _bind$2 = self.entries[idx$2];
    if (_bind$2 === undefined) {
      entry$2.psl = psl;
      _M0MPB3Map10set__entryGsRPB5ArrayGsEE(self, entry$2, idx$2);
      return;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (psl > _curr_entry.psl) {
        entry$2.psl = psl;
        _M0MPB3Map10set__entryGsRPB5ArrayGsEE(self, entry$2, idx$2);
        _tmp = _curr_entry.psl + 1 | 0;
        _tmp$2 = (idx$2 + 1 | 0) & self.capacity_mask;
        _tmp$3 = _curr_entry;
        continue;
      } else {
        _tmp = psl + 1 | 0;
        _tmp$2 = (idx$2 + 1 | 0) & self.capacity_mask;
        continue;
      }
    }
  }
}
function _M0MPB3Map10push__awayGsbE(self, idx, entry) {
  let _tmp = entry.psl + 1 | 0;
  let _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
  let _tmp$3 = entry;
  while (true) {
    const psl = _tmp;
    const idx$2 = _tmp$2;
    const entry$2 = _tmp$3;
    const _bind$2 = self.entries[idx$2];
    if (_bind$2 === undefined) {
      entry$2.psl = psl;
      _M0MPB3Map10set__entryGsbE(self, entry$2, idx$2);
      return;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (psl > _curr_entry.psl) {
        entry$2.psl = psl;
        _M0MPB3Map10set__entryGsbE(self, entry$2, idx$2);
        _tmp = _curr_entry.psl + 1 | 0;
        _tmp$2 = (idx$2 + 1 | 0) & self.capacity_mask;
        _tmp$3 = _curr_entry;
        continue;
      } else {
        _tmp = psl + 1 | 0;
        _tmp$2 = (idx$2 + 1 | 0) & self.capacity_mask;
        continue;
      }
    }
  }
}
function _M0MPB3Map10push__awayGsiE(self, idx, entry) {
  let _tmp = entry.psl + 1 | 0;
  let _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
  let _tmp$3 = entry;
  while (true) {
    const psl = _tmp;
    const idx$2 = _tmp$2;
    const entry$2 = _tmp$3;
    const _bind$2 = self.entries[idx$2];
    if (_bind$2 === undefined) {
      entry$2.psl = psl;
      _M0MPB3Map10set__entryGsiE(self, entry$2, idx$2);
      return;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (psl > _curr_entry.psl) {
        entry$2.psl = psl;
        _M0MPB3Map10set__entryGsiE(self, entry$2, idx$2);
        _tmp = _curr_entry.psl + 1 | 0;
        _tmp$2 = (idx$2 + 1 | 0) & self.capacity_mask;
        _tmp$3 = _curr_entry;
        continue;
      } else {
        _tmp = psl + 1 | 0;
        _tmp$2 = (idx$2 + 1 | 0) & self.capacity_mask;
        continue;
      }
    }
  }
}
function _M0MPB3Map20rehash__place__entryGiRP211localreview3tcl11InterpreterE(self, outer) {
  const hash = outer.hash;
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      outer.psl = psl;
      outer.prev = self.tail;
      _M0MPB3Map20add__entry__to__tailGiRP211localreview3tcl11InterpreterE(self, idx, outer);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr = _Some;
      if (psl > _curr.psl) {
        _M0MPB3Map10push__awayGiRP211localreview3tcl11InterpreterE(self, idx, _curr);
        outer.psl = psl;
        outer.prev = self.tail;
        _M0MPB3Map20add__entry__to__tailGiRP211localreview3tcl11InterpreterE(self, idx, outer);
        return undefined;
      } else {
        _tmp = psl + 1 | 0;
        _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
        continue;
      }
    }
  }
}
function _M0MPB3Map20rehash__place__entryGsRP211localreview3tcl7CommandE(self, outer) {
  const hash = outer.hash;
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      outer.psl = psl;
      outer.prev = self.tail;
      _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, outer);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr = _Some;
      if (psl > _curr.psl) {
        _M0MPB3Map10push__awayGsRP211localreview3tcl7CommandE(self, idx, _curr);
        outer.psl = psl;
        outer.prev = self.tail;
        _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, outer);
        return undefined;
      } else {
        _tmp = psl + 1 | 0;
        _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
        continue;
      }
    }
  }
}
function _M0MPB3Map20rehash__place__entryGsRPB5ArrayGsEE(self, outer) {
  const hash = outer.hash;
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      outer.psl = psl;
      outer.prev = self.tail;
      _M0MPB3Map20add__entry__to__tailGsRPB5ArrayGsEE(self, idx, outer);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr = _Some;
      if (psl > _curr.psl) {
        _M0MPB3Map10push__awayGsRPB5ArrayGsEE(self, idx, _curr);
        outer.psl = psl;
        outer.prev = self.tail;
        _M0MPB3Map20add__entry__to__tailGsRPB5ArrayGsEE(self, idx, outer);
        return undefined;
      } else {
        _tmp = psl + 1 | 0;
        _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
        continue;
      }
    }
  }
}
function _M0MPB3Map20rehash__place__entryGsbE(self, outer) {
  const hash = outer.hash;
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      outer.psl = psl;
      outer.prev = self.tail;
      _M0MPB3Map20add__entry__to__tailGsbE(self, idx, outer);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr = _Some;
      if (psl > _curr.psl) {
        _M0MPB3Map10push__awayGsbE(self, idx, _curr);
        outer.psl = psl;
        outer.prev = self.tail;
        _M0MPB3Map20add__entry__to__tailGsbE(self, idx, outer);
        return undefined;
      } else {
        _tmp = psl + 1 | 0;
        _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
        continue;
      }
    }
  }
}
function _M0MPB3Map20rehash__place__entryGsiE(self, outer) {
  const hash = outer.hash;
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      outer.psl = psl;
      outer.prev = self.tail;
      _M0MPB3Map20add__entry__to__tailGsiE(self, idx, outer);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr = _Some;
      if (psl > _curr.psl) {
        _M0MPB3Map10push__awayGsiE(self, idx, _curr);
        outer.psl = psl;
        outer.prev = self.tail;
        _M0MPB3Map20add__entry__to__tailGsiE(self, idx, outer);
        return undefined;
      } else {
        _tmp = psl + 1 | 0;
        _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
        continue;
      }
    }
  }
}
function _M0MPB3Map4growGiRP211localreview3tcl11InterpreterE(self) {
  const old_head = self.head;
  const new_capacity = self.capacity << 1;
  self.entries = $make_array_len_and_init(new_capacity, undefined);
  self.capacity = new_capacity;
  self.capacity_mask = new_capacity - 1 | 0;
  self.grow_at = _M0FPB21calc__grow__threshold(self.capacity);
  self.size = 0;
  self.head = undefined;
  self.tail = -1;
  let _tmp = old_head;
  while (true) {
    const x = _tmp;
    if (x === undefined) {
      return;
    } else {
      const _Some = x;
      const _e = _Some;
      const next_in_chain = _e.next;
      _e.next = undefined;
      _M0MPB3Map20rehash__place__entryGiRP211localreview3tcl11InterpreterE(self, _e);
      _tmp = next_in_chain;
      continue;
    }
  }
}
function _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self) {
  const old_head = self.head;
  const new_capacity = self.capacity << 1;
  self.entries = $make_array_len_and_init(new_capacity, undefined);
  self.capacity = new_capacity;
  self.capacity_mask = new_capacity - 1 | 0;
  self.grow_at = _M0FPB21calc__grow__threshold(self.capacity);
  self.size = 0;
  self.head = undefined;
  self.tail = -1;
  let _tmp = old_head;
  while (true) {
    const x = _tmp;
    if (x === undefined) {
      return;
    } else {
      const _Some = x;
      const _e = _Some;
      const next_in_chain = _e.next;
      _e.next = undefined;
      _M0MPB3Map20rehash__place__entryGsRP211localreview3tcl7CommandE(self, _e);
      _tmp = next_in_chain;
      continue;
    }
  }
}
function _M0MPB3Map4growGsRPB5ArrayGsEE(self) {
  const old_head = self.head;
  const new_capacity = self.capacity << 1;
  self.entries = $make_array_len_and_init(new_capacity, undefined);
  self.capacity = new_capacity;
  self.capacity_mask = new_capacity - 1 | 0;
  self.grow_at = _M0FPB21calc__grow__threshold(self.capacity);
  self.size = 0;
  self.head = undefined;
  self.tail = -1;
  let _tmp = old_head;
  while (true) {
    const x = _tmp;
    if (x === undefined) {
      return;
    } else {
      const _Some = x;
      const _e = _Some;
      const next_in_chain = _e.next;
      _e.next = undefined;
      _M0MPB3Map20rehash__place__entryGsRPB5ArrayGsEE(self, _e);
      _tmp = next_in_chain;
      continue;
    }
  }
}
function _M0MPB3Map4growGsbE(self) {
  const old_head = self.head;
  const new_capacity = self.capacity << 1;
  self.entries = $make_array_len_and_init(new_capacity, undefined);
  self.capacity = new_capacity;
  self.capacity_mask = new_capacity - 1 | 0;
  self.grow_at = _M0FPB21calc__grow__threshold(self.capacity);
  self.size = 0;
  self.head = undefined;
  self.tail = -1;
  let _tmp = old_head;
  while (true) {
    const x = _tmp;
    if (x === undefined) {
      return;
    } else {
      const _Some = x;
      const _e = _Some;
      const next_in_chain = _e.next;
      _e.next = undefined;
      _M0MPB3Map20rehash__place__entryGsbE(self, _e);
      _tmp = next_in_chain;
      continue;
    }
  }
}
function _M0MPB3Map4growGsiE(self) {
  const old_head = self.head;
  const new_capacity = self.capacity << 1;
  self.entries = $make_array_len_and_init(new_capacity, undefined);
  self.capacity = new_capacity;
  self.capacity_mask = new_capacity - 1 | 0;
  self.grow_at = _M0FPB21calc__grow__threshold(self.capacity);
  self.size = 0;
  self.head = undefined;
  self.tail = -1;
  let _tmp = old_head;
  while (true) {
    const x = _tmp;
    if (x === undefined) {
      return;
    } else {
      const _Some = x;
      const _e = _Some;
      const next_in_chain = _e.next;
      _e.next = undefined;
      _M0MPB3Map20rehash__place__entryGsiE(self, _e);
      _tmp = next_in_chain;
      continue;
    }
  }
}
function _M0MPB3Map15set__with__hashGiRP211localreview3tcl11InterpreterE(self, key, value, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      if (self.size >= self.grow_at) {
        _M0MPB3Map4growGiRP211localreview3tcl11InterpreterE(self);
        _tmp = 0;
        _tmp$2 = hash & self.capacity_mask;
        continue;
      }
      const _bind$3 = self.tail;
      const _bind$4 = undefined;
      const entry = new _M0TPB5EntryGiRP211localreview3tcl11InterpreterE(_bind$3, _bind$4, psl, hash, key, value);
      _M0MPB3Map20add__entry__to__tailGiRP211localreview3tcl11InterpreterE(self, idx, entry);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (_curr_entry.hash === hash && _curr_entry.key === key) {
        _curr_entry.value = value;
        return undefined;
      }
      if (psl > _curr_entry.psl) {
        if (self.size >= self.grow_at) {
          _M0MPB3Map4growGiRP211localreview3tcl11InterpreterE(self);
          _tmp = 0;
          _tmp$2 = hash & self.capacity_mask;
          continue;
        }
        _M0MPB3Map10push__awayGiRP211localreview3tcl11InterpreterE(self, idx, _curr_entry);
        const _bind$3 = self.tail;
        const _bind$4 = undefined;
        const entry = new _M0TPB5EntryGiRP211localreview3tcl11InterpreterE(_bind$3, _bind$4, psl, hash, key, value);
        _M0MPB3Map20add__entry__to__tailGiRP211localreview3tcl11InterpreterE(self, idx, entry);
        return undefined;
      }
      _tmp = psl + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map15set__with__hashGsRP211localreview3tcl7CommandE(self, key, value, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      if (self.size >= self.grow_at) {
        _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
        _tmp = 0;
        _tmp$2 = hash & self.capacity_mask;
        continue;
      }
      const _bind$3 = self.tail;
      const _bind$4 = undefined;
      const entry = new _M0TPB5EntryGsRP211localreview3tcl7CommandE(_bind$3, _bind$4, psl, hash, key, value);
      _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (_curr_entry.hash === hash && _curr_entry.key === key) {
        _curr_entry.value = value;
        return undefined;
      }
      if (psl > _curr_entry.psl) {
        if (self.size >= self.grow_at) {
          _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
          _tmp = 0;
          _tmp$2 = hash & self.capacity_mask;
          continue;
        }
        _M0MPB3Map10push__awayGsRP211localreview3tcl7CommandE(self, idx, _curr_entry);
        const _bind$3 = self.tail;
        const _bind$4 = undefined;
        const entry = new _M0TPB5EntryGsRP211localreview3tcl7CommandE(_bind$3, _bind$4, psl, hash, key, value);
        _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
        return undefined;
      }
      _tmp = psl + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map15set__with__hashGsRP211localreview3tcl4CellE(self, key, value, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      if (self.size >= self.grow_at) {
        _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
        _tmp = 0;
        _tmp$2 = hash & self.capacity_mask;
        continue;
      }
      const _bind$3 = self.tail;
      const _bind$4 = undefined;
      const entry = new _M0TPB5EntryGsRP211localreview3tcl4CellE(_bind$3, _bind$4, psl, hash, key, value);
      _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (_curr_entry.hash === hash && _curr_entry.key === key) {
        _curr_entry.value = value;
        return undefined;
      }
      if (psl > _curr_entry.psl) {
        if (self.size >= self.grow_at) {
          _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
          _tmp = 0;
          _tmp$2 = hash & self.capacity_mask;
          continue;
        }
        _M0MPB3Map10push__awayGsRP211localreview3tcl7CommandE(self, idx, _curr_entry);
        const _bind$3 = self.tail;
        const _bind$4 = undefined;
        const entry = new _M0TPB5EntryGsRP211localreview3tcl4CellE(_bind$3, _bind$4, psl, hash, key, value);
        _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
        return undefined;
      }
      _tmp = psl + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map15set__with__hashGsRP211localreview3tcl7BindingE(self, key, value, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      if (self.size >= self.grow_at) {
        _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
        _tmp = 0;
        _tmp$2 = hash & self.capacity_mask;
        continue;
      }
      const _bind$3 = self.tail;
      const _bind$4 = undefined;
      const entry = new _M0TPB5EntryGsRP211localreview3tcl7BindingE(_bind$3, _bind$4, psl, hash, key, value);
      _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (_curr_entry.hash === hash && _curr_entry.key === key) {
        _curr_entry.value = value;
        return undefined;
      }
      if (psl > _curr_entry.psl) {
        if (self.size >= self.grow_at) {
          _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
          _tmp = 0;
          _tmp$2 = hash & self.capacity_mask;
          continue;
        }
        _M0MPB3Map10push__awayGsRP211localreview3tcl7CommandE(self, idx, _curr_entry);
        const _bind$3 = self.tail;
        const _bind$4 = undefined;
        const entry = new _M0TPB5EntryGsRP211localreview3tcl7BindingE(_bind$3, _bind$4, psl, hash, key, value);
        _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
        return undefined;
      }
      _tmp = psl + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map15set__with__hashGsRPB5ArrayGsEE(self, key, value, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      if (self.size >= self.grow_at) {
        _M0MPB3Map4growGsRPB5ArrayGsEE(self);
        _tmp = 0;
        _tmp$2 = hash & self.capacity_mask;
        continue;
      }
      const _bind$3 = self.tail;
      const _bind$4 = undefined;
      const entry = new _M0TPB5EntryGsRPB5ArrayGsEE(_bind$3, _bind$4, psl, hash, key, value);
      _M0MPB3Map20add__entry__to__tailGsRPB5ArrayGsEE(self, idx, entry);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (_curr_entry.hash === hash && _curr_entry.key === key) {
        _curr_entry.value = value;
        return undefined;
      }
      if (psl > _curr_entry.psl) {
        if (self.size >= self.grow_at) {
          _M0MPB3Map4growGsRPB5ArrayGsEE(self);
          _tmp = 0;
          _tmp$2 = hash & self.capacity_mask;
          continue;
        }
        _M0MPB3Map10push__awayGsRPB5ArrayGsEE(self, idx, _curr_entry);
        const _bind$3 = self.tail;
        const _bind$4 = undefined;
        const entry = new _M0TPB5EntryGsRPB5ArrayGsEE(_bind$3, _bind$4, psl, hash, key, value);
        _M0MPB3Map20add__entry__to__tailGsRPB5ArrayGsEE(self, idx, entry);
        return undefined;
      }
      _tmp = psl + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map15set__with__hashGssE(self, key, value, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      if (self.size >= self.grow_at) {
        _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
        _tmp = 0;
        _tmp$2 = hash & self.capacity_mask;
        continue;
      }
      const _bind$3 = self.tail;
      const _bind$4 = undefined;
      const entry = new _M0TPB5EntryGssE(_bind$3, _bind$4, psl, hash, key, value);
      _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (_curr_entry.hash === hash && _curr_entry.key === key) {
        _curr_entry.value = value;
        return undefined;
      }
      if (psl > _curr_entry.psl) {
        if (self.size >= self.grow_at) {
          _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
          _tmp = 0;
          _tmp$2 = hash & self.capacity_mask;
          continue;
        }
        _M0MPB3Map10push__awayGsRP211localreview3tcl7CommandE(self, idx, _curr_entry);
        const _bind$3 = self.tail;
        const _bind$4 = undefined;
        const entry = new _M0TPB5EntryGssE(_bind$3, _bind$4, psl, hash, key, value);
        _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
        return undefined;
      }
      _tmp = psl + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map15set__with__hashGsbE(self, key, value, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      if (self.size >= self.grow_at) {
        _M0MPB3Map4growGsbE(self);
        _tmp = 0;
        _tmp$2 = hash & self.capacity_mask;
        continue;
      }
      const _bind$3 = self.tail;
      const _bind$4 = undefined;
      const entry = new _M0TPB5EntryGsbE(_bind$3, _bind$4, psl, hash, key, value);
      _M0MPB3Map20add__entry__to__tailGsbE(self, idx, entry);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (_curr_entry.hash === hash && _curr_entry.key === key) {
        _curr_entry.value = value;
        return undefined;
      }
      if (psl > _curr_entry.psl) {
        if (self.size >= self.grow_at) {
          _M0MPB3Map4growGsbE(self);
          _tmp = 0;
          _tmp$2 = hash & self.capacity_mask;
          continue;
        }
        _M0MPB3Map10push__awayGsbE(self, idx, _curr_entry);
        const _bind$3 = self.tail;
        const _bind$4 = undefined;
        const entry = new _M0TPB5EntryGsbE(_bind$3, _bind$4, psl, hash, key, value);
        _M0MPB3Map20add__entry__to__tailGsbE(self, idx, entry);
        return undefined;
      }
      _tmp = psl + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map15set__with__hashGsRPB4JsonE(self, key, value, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      if (self.size >= self.grow_at) {
        _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
        _tmp = 0;
        _tmp$2 = hash & self.capacity_mask;
        continue;
      }
      const _bind$3 = self.tail;
      const _bind$4 = undefined;
      const entry = new _M0TPB5EntryGsRPB4JsonE(_bind$3, _bind$4, psl, hash, key, value);
      _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (_curr_entry.hash === hash && _curr_entry.key === key) {
        _curr_entry.value = value;
        return undefined;
      }
      if (psl > _curr_entry.psl) {
        if (self.size >= self.grow_at) {
          _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
          _tmp = 0;
          _tmp$2 = hash & self.capacity_mask;
          continue;
        }
        _M0MPB3Map10push__awayGsRP211localreview3tcl7CommandE(self, idx, _curr_entry);
        const _bind$3 = self.tail;
        const _bind$4 = undefined;
        const entry = new _M0TPB5EntryGsRPB4JsonE(_bind$3, _bind$4, psl, hash, key, value);
        _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
        return undefined;
      }
      _tmp = psl + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map15set__with__hashGsRP211localreview3tcl13ScriptProgramE(self, key, value, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      if (self.size >= self.grow_at) {
        _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
        _tmp = 0;
        _tmp$2 = hash & self.capacity_mask;
        continue;
      }
      const _bind$3 = self.tail;
      const _bind$4 = undefined;
      const entry = new _M0TPB5EntryGsRP211localreview3tcl13ScriptProgramE(_bind$3, _bind$4, psl, hash, key, value);
      _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (_curr_entry.hash === hash && _curr_entry.key === key) {
        _curr_entry.value = value;
        return undefined;
      }
      if (psl > _curr_entry.psl) {
        if (self.size >= self.grow_at) {
          _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
          _tmp = 0;
          _tmp$2 = hash & self.capacity_mask;
          continue;
        }
        _M0MPB3Map10push__awayGsRP211localreview3tcl7CommandE(self, idx, _curr_entry);
        const _bind$3 = self.tail;
        const _bind$4 = undefined;
        const entry = new _M0TPB5EntryGsRP211localreview3tcl13ScriptProgramE(_bind$3, _bind$4, psl, hash, key, value);
        _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
        return undefined;
      }
      _tmp = psl + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map15set__with__hashGsRP211localreview3tcl4ExprE(self, key, value, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      if (self.size >= self.grow_at) {
        _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
        _tmp = 0;
        _tmp$2 = hash & self.capacity_mask;
        continue;
      }
      const _bind$3 = self.tail;
      const _bind$4 = undefined;
      const entry = new _M0TPB5EntryGsRP211localreview3tcl4ExprE(_bind$3, _bind$4, psl, hash, key, value);
      _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (_curr_entry.hash === hash && _curr_entry.key === key) {
        _curr_entry.value = value;
        return undefined;
      }
      if (psl > _curr_entry.psl) {
        if (self.size >= self.grow_at) {
          _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
          _tmp = 0;
          _tmp$2 = hash & self.capacity_mask;
          continue;
        }
        _M0MPB3Map10push__awayGsRP211localreview3tcl7CommandE(self, idx, _curr_entry);
        const _bind$3 = self.tail;
        const _bind$4 = undefined;
        const entry = new _M0TPB5EntryGsRP211localreview3tcl4ExprE(_bind$3, _bind$4, psl, hash, key, value);
        _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
        return undefined;
      }
      _tmp = psl + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map15set__with__hashGsRPC15debug4ReprE(self, key, value, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      if (self.size >= self.grow_at) {
        _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
        _tmp = 0;
        _tmp$2 = hash & self.capacity_mask;
        continue;
      }
      const _bind$3 = self.tail;
      const _bind$4 = undefined;
      const entry = new _M0TPB5EntryGsRPC15debug4ReprE(_bind$3, _bind$4, psl, hash, key, value);
      _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (_curr_entry.hash === hash && _curr_entry.key === key) {
        _curr_entry.value = value;
        return undefined;
      }
      if (psl > _curr_entry.psl) {
        if (self.size >= self.grow_at) {
          _M0MPB3Map4growGsRP211localreview3tcl7CommandE(self);
          _tmp = 0;
          _tmp$2 = hash & self.capacity_mask;
          continue;
        }
        _M0MPB3Map10push__awayGsRP211localreview3tcl7CommandE(self, idx, _curr_entry);
        const _bind$3 = self.tail;
        const _bind$4 = undefined;
        const entry = new _M0TPB5EntryGsRPC15debug4ReprE(_bind$3, _bind$4, psl, hash, key, value);
        _M0MPB3Map20add__entry__to__tailGsRP211localreview3tcl7CommandE(self, idx, entry);
        return undefined;
      }
      _tmp = psl + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map15set__with__hashGsiE(self, key, value, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const psl = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      if (self.size >= self.grow_at) {
        _M0MPB3Map4growGsiE(self);
        _tmp = 0;
        _tmp$2 = hash & self.capacity_mask;
        continue;
      }
      const _bind$3 = self.tail;
      const _bind$4 = undefined;
      const entry = new _M0TPB5EntryGsiE(_bind$3, _bind$4, psl, hash, key, value);
      _M0MPB3Map20add__entry__to__tailGsiE(self, idx, entry);
      return undefined;
    } else {
      const _Some = _bind$2;
      const _curr_entry = _Some;
      if (_curr_entry.hash === hash && _curr_entry.key === key) {
        _curr_entry.value = value;
        return undefined;
      }
      if (psl > _curr_entry.psl) {
        if (self.size >= self.grow_at) {
          _M0MPB3Map4growGsiE(self);
          _tmp = 0;
          _tmp$2 = hash & self.capacity_mask;
          continue;
        }
        _M0MPB3Map10push__awayGsiE(self, idx, _curr_entry);
        const _bind$3 = self.tail;
        const _bind$4 = undefined;
        const entry = new _M0TPB5EntryGsiE(_bind$3, _bind$4, psl, hash, key, value);
        _M0MPB3Map20add__entry__to__tailGsiE(self, idx, entry);
        return undefined;
      }
      _tmp = psl + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map3setGiRP211localreview3tcl11InterpreterE(self, key, value) {
  _M0MPB3Map15set__with__hashGiRP211localreview3tcl11InterpreterE(self, key, value, _M0IPC13int3IntPB4Hash4hash(key));
}
function _M0MPB3Map3setGsRP211localreview3tcl7CommandE(self, key, value) {
  _M0MPB3Map15set__with__hashGsRP211localreview3tcl7CommandE(self, key, value, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map3setGsRP211localreview3tcl4CellE(self, key, value) {
  _M0MPB3Map15set__with__hashGsRP211localreview3tcl4CellE(self, key, value, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map3setGsRP211localreview3tcl7BindingE(self, key, value) {
  _M0MPB3Map15set__with__hashGsRP211localreview3tcl7BindingE(self, key, value, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map3setGsRPB5ArrayGsEE(self, key, value) {
  _M0MPB3Map15set__with__hashGsRPB5ArrayGsEE(self, key, value, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map3setGssE(self, key, value) {
  _M0MPB3Map15set__with__hashGssE(self, key, value, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map3setGsbE(self, key, value) {
  _M0MPB3Map15set__with__hashGsbE(self, key, value, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map3setGsRPB4JsonE(self, key, value) {
  _M0MPB3Map15set__with__hashGsRPB4JsonE(self, key, value, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map3setGsRP211localreview3tcl13ScriptProgramE(self, key, value) {
  _M0MPB3Map15set__with__hashGsRP211localreview3tcl13ScriptProgramE(self, key, value, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map3setGsRP211localreview3tcl4ExprE(self, key, value) {
  _M0MPB3Map15set__with__hashGsRP211localreview3tcl4ExprE(self, key, value, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map3setGsRPC15debug4ReprE(self, key, value) {
  _M0MPB3Map15set__with__hashGsRPC15debug4ReprE(self, key, value, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map3setGsiE(self, key, value) {
  _M0MPB3Map15set__with__hashGsiE(self, key, value, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map3MapGsRP211localreview3tcl7CommandE(arr, capacity) {
  const length = arr.end - arr.start | 0;
  let capacity$2;
  if (capacity === undefined) {
    capacity$2 = length === 0 ? 8 : _M0FPB21capacity__for__length(length);
  } else {
    const _Some = capacity;
    const _capacity = _Some;
    capacity$2 = _M0MPC13int3Int3max(_capacity, _M0FPB21capacity__for__length(length));
  }
  const m = _M0FPB8new__mapGsRP211localreview3tcl7CommandE(capacity$2);
  const _bind$2 = arr.end - arr.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const e = arr.buf[arr.start + _ | 0];
      _M0MPB3Map3setGsRP211localreview3tcl7CommandE(m, e._0, e._1);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return m;
}
function _M0MPB3Map3MapGsRP211localreview3tcl4CellE(arr, capacity) {
  const length = arr.end - arr.start | 0;
  let capacity$2;
  if (capacity === undefined) {
    capacity$2 = length === 0 ? 8 : _M0FPB21capacity__for__length(length);
  } else {
    const _Some = capacity;
    const _capacity = _Some;
    capacity$2 = _M0MPC13int3Int3max(_capacity, _M0FPB21capacity__for__length(length));
  }
  const m = _M0FPB8new__mapGsRP211localreview3tcl7CommandE(capacity$2);
  const _bind$2 = arr.end - arr.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const e = arr.buf[arr.start + _ | 0];
      _M0MPB3Map3setGsRP211localreview3tcl4CellE(m, e._0, e._1);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return m;
}
function _M0MPB3Map3MapGsRP211localreview3tcl7BindingE(arr, capacity) {
  const length = arr.end - arr.start | 0;
  let capacity$2;
  if (capacity === undefined) {
    capacity$2 = length === 0 ? 8 : _M0FPB21capacity__for__length(length);
  } else {
    const _Some = capacity;
    const _capacity = _Some;
    capacity$2 = _M0MPC13int3Int3max(_capacity, _M0FPB21capacity__for__length(length));
  }
  const m = _M0FPB8new__mapGsRP211localreview3tcl7CommandE(capacity$2);
  const _bind$2 = arr.end - arr.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const e = arr.buf[arr.start + _ | 0];
      _M0MPB3Map3setGsRP211localreview3tcl7BindingE(m, e._0, e._1);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return m;
}
function _M0MPB3Map3MapGsRPB5ArrayGsEE(arr, capacity) {
  const length = arr.end - arr.start | 0;
  let capacity$2;
  if (capacity === undefined) {
    capacity$2 = length === 0 ? 8 : _M0FPB21capacity__for__length(length);
  } else {
    const _Some = capacity;
    const _capacity = _Some;
    capacity$2 = _M0MPC13int3Int3max(_capacity, _M0FPB21capacity__for__length(length));
  }
  const m = _M0FPB8new__mapGsRPB5ArrayGsEE(capacity$2);
  const _bind$2 = arr.end - arr.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const e = arr.buf[arr.start + _ | 0];
      _M0MPB3Map3setGsRPB5ArrayGsEE(m, e._0, e._1);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return m;
}
function _M0MPB3Map3MapGssE(arr, capacity) {
  const length = arr.end - arr.start | 0;
  let capacity$2;
  if (capacity === undefined) {
    capacity$2 = length === 0 ? 8 : _M0FPB21capacity__for__length(length);
  } else {
    const _Some = capacity;
    const _capacity = _Some;
    capacity$2 = _M0MPC13int3Int3max(_capacity, _M0FPB21capacity__for__length(length));
  }
  const m = _M0FPB8new__mapGsRP211localreview3tcl7CommandE(capacity$2);
  const _bind$2 = arr.end - arr.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const e = arr.buf[arr.start + _ | 0];
      _M0MPB3Map3setGssE(m, e._0, e._1);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return m;
}
function _M0MPB3Map3MapGsbE(arr, capacity) {
  const length = arr.end - arr.start | 0;
  let capacity$2;
  if (capacity === undefined) {
    capacity$2 = length === 0 ? 8 : _M0FPB21capacity__for__length(length);
  } else {
    const _Some = capacity;
    const _capacity = _Some;
    capacity$2 = _M0MPC13int3Int3max(_capacity, _M0FPB21capacity__for__length(length));
  }
  const m = _M0FPB8new__mapGsbE(capacity$2);
  const _bind$2 = arr.end - arr.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const e = arr.buf[arr.start + _ | 0];
      _M0MPB3Map3setGsbE(m, e._0, e._1);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return m;
}
function _M0MPB3Map3MapGsRPB4JsonE(arr, capacity) {
  const length = arr.end - arr.start | 0;
  let capacity$2;
  if (capacity === undefined) {
    capacity$2 = length === 0 ? 8 : _M0FPB21capacity__for__length(length);
  } else {
    const _Some = capacity;
    const _capacity = _Some;
    capacity$2 = _M0MPC13int3Int3max(_capacity, _M0FPB21capacity__for__length(length));
  }
  const m = _M0FPB8new__mapGsRP211localreview3tcl7CommandE(capacity$2);
  const _bind$2 = arr.end - arr.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const e = arr.buf[arr.start + _ | 0];
      _M0MPB3Map3setGsRPB4JsonE(m, e._0, e._1);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return m;
}
function _M0MPB3Map3MapGiRP211localreview3tcl11InterpreterE(arr, capacity) {
  const length = arr.end - arr.start | 0;
  let capacity$2;
  if (capacity === undefined) {
    capacity$2 = length === 0 ? 8 : _M0FPB21capacity__for__length(length);
  } else {
    const _Some = capacity;
    const _capacity = _Some;
    capacity$2 = _M0MPC13int3Int3max(_capacity, _M0FPB21capacity__for__length(length));
  }
  const m = _M0FPB8new__mapGiRP211localreview3tcl11InterpreterE(capacity$2);
  const _bind$2 = arr.end - arr.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const e = arr.buf[arr.start + _ | 0];
      _M0MPB3Map3setGiRP211localreview3tcl11InterpreterE(m, e._0, e._1);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return m;
}
function _M0MPB3Map3MapGsRP211localreview3tcl13ScriptProgramE(arr, capacity) {
  const length = arr.end - arr.start | 0;
  let capacity$2;
  if (capacity === undefined) {
    capacity$2 = length === 0 ? 8 : _M0FPB21capacity__for__length(length);
  } else {
    const _Some = capacity;
    const _capacity = _Some;
    capacity$2 = _M0MPC13int3Int3max(_capacity, _M0FPB21capacity__for__length(length));
  }
  const m = _M0FPB8new__mapGsRP211localreview3tcl7CommandE(capacity$2);
  const _bind$2 = arr.end - arr.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const e = arr.buf[arr.start + _ | 0];
      _M0MPB3Map3setGsRP211localreview3tcl13ScriptProgramE(m, e._0, e._1);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return m;
}
function _M0MPB3Map3MapGsRP211localreview3tcl4ExprE(arr, capacity) {
  const length = arr.end - arr.start | 0;
  let capacity$2;
  if (capacity === undefined) {
    capacity$2 = length === 0 ? 8 : _M0FPB21capacity__for__length(length);
  } else {
    const _Some = capacity;
    const _capacity = _Some;
    capacity$2 = _M0MPC13int3Int3max(_capacity, _M0FPB21capacity__for__length(length));
  }
  const m = _M0FPB8new__mapGsRP211localreview3tcl7CommandE(capacity$2);
  const _bind$2 = arr.end - arr.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const e = arr.buf[arr.start + _ | 0];
      _M0MPB3Map3setGsRP211localreview3tcl4ExprE(m, e._0, e._1);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return m;
}
function _M0MPB3Map3MapGsRPC15debug4ReprE(arr, capacity) {
  const length = arr.end - arr.start | 0;
  let capacity$2;
  if (capacity === undefined) {
    capacity$2 = length === 0 ? 8 : _M0FPB21capacity__for__length(length);
  } else {
    const _Some = capacity;
    const _capacity = _Some;
    capacity$2 = _M0MPC13int3Int3max(_capacity, _M0FPB21capacity__for__length(length));
  }
  const m = _M0FPB8new__mapGsRP211localreview3tcl7CommandE(capacity$2);
  const _bind$2 = arr.end - arr.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const e = arr.buf[arr.start + _ | 0];
      _M0MPB3Map3setGsRPC15debug4ReprE(m, e._0, e._1);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return m;
}
function _M0MPB3Map3MapGsiE(arr, capacity) {
  const length = arr.end - arr.start | 0;
  let capacity$2;
  if (capacity === undefined) {
    capacity$2 = length === 0 ? 8 : _M0FPB21capacity__for__length(length);
  } else {
    const _Some = capacity;
    const _capacity = _Some;
    capacity$2 = _M0MPC13int3Int3max(_capacity, _M0FPB21capacity__for__length(length));
  }
  const m = _M0FPB8new__mapGsiE(capacity$2);
  const _bind$2 = arr.end - arr.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const e = arr.buf[arr.start + _ | 0];
      _M0MPB3Map3setGsiE(m, e._0, e._1);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return m;
}
function _M0MPB3Map3getGiRP211localreview3tcl11InterpreterE(self, key) {
  const hash = _M0IPC13int3IntPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return undefined;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return _entry.value;
      }
      if (i > _entry.psl) {
        return undefined;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map3getGsRP211localreview3tcl4CellE(self, key) {
  const hash = _M0IPC16string6StringPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return undefined;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return _entry.value;
      }
      if (i > _entry.psl) {
        return undefined;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map3getGsRP211localreview3tcl13ScriptProgramE(self, key) {
  const hash = _M0IPC16string6StringPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return undefined;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return _entry.value;
      }
      if (i > _entry.psl) {
        return undefined;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map3getGssE(self, key) {
  const hash = _M0IPC16string6StringPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return undefined;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return _entry.value;
      }
      if (i > _entry.psl) {
        return undefined;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map3getGsRP211localreview3tcl7CommandE(self, key) {
  const hash = _M0IPC16string6StringPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return undefined;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return _entry.value;
      }
      if (i > _entry.psl) {
        return undefined;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map3getGsRPB5ArrayGsEE(self, key) {
  const hash = _M0IPC16string6StringPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return _M0DTPC16option6OptionGRPB5ArrayGsEE4None__;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return new _M0DTPC16option6OptionGRPB5ArrayGsEE4Some(_entry.value);
      }
      if (i > _entry.psl) {
        return _M0DTPC16option6OptionGRPB5ArrayGsEE4None__;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map3getGsRP211localreview3tcl7BindingE(self, key) {
  const hash = _M0IPC16string6StringPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return undefined;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return _entry.value;
      }
      if (i > _entry.psl) {
        return undefined;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map3getGsiE(self, key) {
  const hash = _M0IPC16string6StringPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return undefined;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return _entry.value;
      }
      if (i > _entry.psl) {
        return undefined;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map3getGsRP211localreview3tcl4ExprE(self, key) {
  const hash = _M0IPC16string6StringPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return undefined;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return _entry.value;
      }
      if (i > _entry.psl) {
        return undefined;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map2atGsRPB5ArrayGsEE(self, key) {
  const hash = _M0IPC16string6StringPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      $panic();
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return _entry.value;
      }
      if (i <= _entry.psl) {
        _tmp = i + 1 | 0;
        _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
        continue;
      } else {
        $panic();
      }
    }
    continue;
  }
}
function _M0MPB3Map8containsGiRP211localreview3tcl11InterpreterE(self, key) {
  const hash = _M0IPC13int3IntPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return false;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return true;
      }
      if (i > _entry.psl) {
        return false;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map8containsGsbE(self, key) {
  const hash = _M0IPC16string6StringPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return false;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return true;
      }
      if (i > _entry.psl) {
        return false;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map8containsGssE(self, key) {
  const hash = _M0IPC16string6StringPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return false;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return true;
      }
      if (i > _entry.psl) {
        return false;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map8containsGsRP211localreview3tcl7CommandE(self, key) {
  const hash = _M0IPC16string6StringPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return false;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return true;
      }
      if (i > _entry.psl) {
        return false;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map8containsGsRP211localreview3tcl7BindingE(self, key) {
  const hash = _M0IPC16string6StringPB4Hash4hash(key);
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return false;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        return true;
      }
      if (i > _entry.psl) {
        return false;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map13remove__entryGiRP211localreview3tcl11InterpreterE(self, entry) {
  const _bind$2 = entry.prev;
  if (_bind$2 === -1) {
    self.head = entry.next;
  } else {
    const _tmp = self.entries;
    _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_bind$2 >>> 0 < _tmp.length ? _tmp[_bind$2] : $oob()).next = entry.next;
  }
  const _bind$3 = entry.next;
  if (_bind$3 === undefined) {
    self.tail = entry.prev;
    return;
  } else {
    const _Some = _bind$3;
    const _next = _Some;
    _next.prev = entry.prev;
    return;
  }
}
function _M0MPB3Map13remove__entryGsbE(self, entry) {
  const _bind$2 = entry.prev;
  if (_bind$2 === -1) {
    self.head = entry.next;
  } else {
    const _tmp = self.entries;
    _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_bind$2 >>> 0 < _tmp.length ? _tmp[_bind$2] : $oob()).next = entry.next;
  }
  const _bind$3 = entry.next;
  if (_bind$3 === undefined) {
    self.tail = entry.prev;
    return;
  } else {
    const _Some = _bind$3;
    const _next = _Some;
    _next.prev = entry.prev;
    return;
  }
}
function _M0MPB3Map13remove__entryGsRP211localreview3tcl4CellE(self, entry) {
  const _bind$2 = entry.prev;
  if (_bind$2 === -1) {
    self.head = entry.next;
  } else {
    const _tmp = self.entries;
    _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_bind$2 >>> 0 < _tmp.length ? _tmp[_bind$2] : $oob()).next = entry.next;
  }
  const _bind$3 = entry.next;
  if (_bind$3 === undefined) {
    self.tail = entry.prev;
    return;
  } else {
    const _Some = _bind$3;
    const _next = _Some;
    _next.prev = entry.prev;
    return;
  }
}
function _M0MPB3Map13remove__entryGsRPB5ArrayGsEE(self, entry) {
  const _bind$2 = entry.prev;
  if (_bind$2 === -1) {
    self.head = entry.next;
  } else {
    const _tmp = self.entries;
    _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_bind$2 >>> 0 < _tmp.length ? _tmp[_bind$2] : $oob()).next = entry.next;
  }
  const _bind$3 = entry.next;
  if (_bind$3 === undefined) {
    self.tail = entry.prev;
    return;
  } else {
    const _Some = _bind$3;
    const _next = _Some;
    _next.prev = entry.prev;
    return;
  }
}
function _M0MPB3Map11shift__backGiRP211localreview3tcl11InterpreterE(self, idx) {
  let _tmp = idx;
  while (true) {
    const cur = _tmp;
    const next = (cur + 1 | 0) & self.capacity_mask;
    _L: {
      const _bind$2 = self.entries[next];
      if (_bind$2 === undefined) {
        break _L;
      } else {
        const _Some = _bind$2;
        const _x = _Some;
        const _x$2 = _x.psl;
        if (_x$2 === 0) {
          break _L;
        } else {
          _x.psl = _x.psl - 1 | 0;
          _M0MPB3Map10set__entryGiRP211localreview3tcl11InterpreterE(self, _x, cur);
          _tmp = next;
          continue;
        }
      }
    }
    self.entries[cur] = undefined;
    return;
  }
}
function _M0MPB3Map11shift__backGsbE(self, idx) {
  let _tmp = idx;
  while (true) {
    const cur = _tmp;
    const next = (cur + 1 | 0) & self.capacity_mask;
    _L: {
      const _bind$2 = self.entries[next];
      if (_bind$2 === undefined) {
        break _L;
      } else {
        const _Some = _bind$2;
        const _x = _Some;
        const _x$2 = _x.psl;
        if (_x$2 === 0) {
          break _L;
        } else {
          _x.psl = _x.psl - 1 | 0;
          _M0MPB3Map10set__entryGsbE(self, _x, cur);
          _tmp = next;
          continue;
        }
      }
    }
    self.entries[cur] = undefined;
    return;
  }
}
function _M0MPB3Map11shift__backGsRP211localreview3tcl4CellE(self, idx) {
  let _tmp = idx;
  while (true) {
    const cur = _tmp;
    const next = (cur + 1 | 0) & self.capacity_mask;
    _L: {
      const _bind$2 = self.entries[next];
      if (_bind$2 === undefined) {
        break _L;
      } else {
        const _Some = _bind$2;
        const _x = _Some;
        const _x$2 = _x.psl;
        if (_x$2 === 0) {
          break _L;
        } else {
          _x.psl = _x.psl - 1 | 0;
          _M0MPB3Map10set__entryGsRP211localreview3tcl7CommandE(self, _x, cur);
          _tmp = next;
          continue;
        }
      }
    }
    self.entries[cur] = undefined;
    return;
  }
}
function _M0MPB3Map11shift__backGsRPB5ArrayGsEE(self, idx) {
  let _tmp = idx;
  while (true) {
    const cur = _tmp;
    const next = (cur + 1 | 0) & self.capacity_mask;
    _L: {
      const _bind$2 = self.entries[next];
      if (_bind$2 === undefined) {
        break _L;
      } else {
        const _Some = _bind$2;
        const _x = _Some;
        const _x$2 = _x.psl;
        if (_x$2 === 0) {
          break _L;
        } else {
          _x.psl = _x.psl - 1 | 0;
          _M0MPB3Map10set__entryGsRPB5ArrayGsEE(self, _x, cur);
          _tmp = next;
          continue;
        }
      }
    }
    self.entries[cur] = undefined;
    return;
  }
}
function _M0MPB3Map18remove__with__hashGiRP211localreview3tcl11InterpreterE(self, key, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        _M0MPB3Map13remove__entryGiRP211localreview3tcl11InterpreterE(self, _entry);
        _M0MPB3Map11shift__backGiRP211localreview3tcl11InterpreterE(self, idx);
        self.size = self.size - 1 | 0;
        return;
      }
      if (i > _entry.psl) {
        return;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map18remove__with__hashGsbE(self, key, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        _M0MPB3Map13remove__entryGsbE(self, _entry);
        _M0MPB3Map11shift__backGsbE(self, idx);
        self.size = self.size - 1 | 0;
        return;
      }
      if (i > _entry.psl) {
        return;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map18remove__with__hashGsRP211localreview3tcl4CellE(self, key, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        _M0MPB3Map13remove__entryGsRP211localreview3tcl4CellE(self, _entry);
        _M0MPB3Map11shift__backGsRP211localreview3tcl4CellE(self, idx);
        self.size = self.size - 1 | 0;
        return;
      }
      if (i > _entry.psl) {
        return;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map18remove__with__hashGsRPB5ArrayGsEE(self, key, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        _M0MPB3Map13remove__entryGsRPB5ArrayGsEE(self, _entry);
        _M0MPB3Map11shift__backGsRPB5ArrayGsEE(self, idx);
        self.size = self.size - 1 | 0;
        return;
      }
      if (i > _entry.psl) {
        return;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map18remove__with__hashGssE(self, key, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        _M0MPB3Map13remove__entryGsRP211localreview3tcl4CellE(self, _entry);
        _M0MPB3Map11shift__backGsRP211localreview3tcl4CellE(self, idx);
        self.size = self.size - 1 | 0;
        return;
      }
      if (i > _entry.psl) {
        return;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map18remove__with__hashGsRP211localreview3tcl7BindingE(self, key, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        _M0MPB3Map13remove__entryGsRP211localreview3tcl4CellE(self, _entry);
        _M0MPB3Map11shift__backGsRP211localreview3tcl4CellE(self, idx);
        self.size = self.size - 1 | 0;
        return;
      }
      if (i > _entry.psl) {
        return;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map18remove__with__hashGsRP211localreview3tcl7CommandE(self, key, hash) {
  let _tmp = 0;
  let _tmp$2 = hash & self.capacity_mask;
  while (true) {
    const i = _tmp;
    const idx = _tmp$2;
    const _bind$2 = self.entries[idx];
    if (_bind$2 === undefined) {
      return;
    } else {
      const _Some = _bind$2;
      const _entry = _Some;
      if (_entry.hash === hash && _entry.key === key) {
        _M0MPB3Map13remove__entryGsRP211localreview3tcl4CellE(self, _entry);
        _M0MPB3Map11shift__backGsRP211localreview3tcl4CellE(self, idx);
        self.size = self.size - 1 | 0;
        return;
      }
      if (i > _entry.psl) {
        return;
      }
      _tmp = i + 1 | 0;
      _tmp$2 = (idx + 1 | 0) & self.capacity_mask;
      continue;
    }
  }
}
function _M0MPB3Map6removeGiRP211localreview3tcl11InterpreterE(self, key) {
  _M0MPB3Map18remove__with__hashGiRP211localreview3tcl11InterpreterE(self, key, _M0IPC13int3IntPB4Hash4hash(key));
}
function _M0MPB3Map6removeGsbE(self, key) {
  _M0MPB3Map18remove__with__hashGsbE(self, key, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map6removeGsRP211localreview3tcl4CellE(self, key) {
  _M0MPB3Map18remove__with__hashGsRP211localreview3tcl4CellE(self, key, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map6removeGsRPB5ArrayGsEE(self, key) {
  _M0MPB3Map18remove__with__hashGsRPB5ArrayGsEE(self, key, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map6removeGssE(self, key) {
  _M0MPB3Map18remove__with__hashGssE(self, key, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map6removeGsRP211localreview3tcl7BindingE(self, key) {
  _M0MPB3Map18remove__with__hashGsRP211localreview3tcl7BindingE(self, key, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map6removeGsRP211localreview3tcl7CommandE(self, key) {
  _M0MPB3Map18remove__with__hashGsRP211localreview3tcl7CommandE(self, key, _M0IPC16string6StringPB4Hash4hash(key));
}
function _M0MPB3Map6lengthGiRP211localreview3tcl11InterpreterE(self) {
  return self.size;
}
function _M0MPB3Map6lengthGsRP211localreview3tcl13ScriptProgramE(self) {
  return self.size;
}
function _M0MPB3Map9is__emptyGsRPB4JsonE(self) {
  return self.size === 0;
}
function _M0MPC15array10FixedArray12fill_2einnerGORPB5EntryGsRP211localreview3tcl13ScriptProgramEE(self, value, start, end) {
  const array_length = self.length;
  if (array_length > 0) {
    if (start >= 0 && start < array_length) {
      let length;
      if (end === undefined) {
        length = array_length - start | 0;
      } else {
        const _Some = end;
        const _e = _Some;
        length = _e >= start && _e <= array_length ? _e - start | 0 : $panic();
      }
      self.fill(value, start, start + length);
      return;
    } else {
      $panic();
      return;
    }
  } else {
    return;
  }
}
function _M0MPB3Map5clearGsRP211localreview3tcl13ScriptProgramE(self) {
  _M0MPC15array10FixedArray12fill_2einnerGORPB5EntryGsRP211localreview3tcl13ScriptProgramEE(self.entries, undefined, 0, undefined);
  self.size = 0;
  self.head = undefined;
  self.tail = -1;
}
function _M0MPB3Map4iterGsRPB4JsonE(self) {
  const curr_entry = new _M0TPB8MutLocalGORPB5EntryGsRPB4JsonEE(self.head);
  const len = self.size;
  const remaining = new _M0TPB8MutLocalGiE(len);
  return _M0MPB4Iter3newGUsRPB4JsonEE(() => {
    _L: {
      if (remaining.val > 0) {
        const _bind$2 = curr_entry.val;
        if (_bind$2 === undefined) {
          break _L;
        } else {
          const _Some = _bind$2;
          const _x = _Some;
          const _key = _x.key;
          const _value = _x.value;
          const _next = _x.next;
          curr_entry.val = _next;
          remaining.val = remaining.val - 1 | 0;
          return { _0: _key, _1: _value };
        }
      } else {
        break _L;
      }
    }
    return undefined;
  }, len);
}
function _M0MPB3Map5iter2GsRPC15debug4ReprE(self) {
  return _M0MPB3Map4iterGsRPB4JsonE(self);
}
function _M0MPB3Map4keysGsbE(self) {
  const curr_entry = new _M0TPB8MutLocalGORPB5EntryGsbEE(self.head);
  const len = self.size;
  const remaining = new _M0TPB8MutLocalGiE(len);
  return _M0MPB4Iter3newGUsRPB4JsonEE(() => {
    _L: {
      if (remaining.val > 0) {
        const _bind$2 = curr_entry.val;
        if (_bind$2 === undefined) {
          break _L;
        } else {
          const _Some = _bind$2;
          const _x = _Some;
          const _key = _x.key;
          const _next = _x.next;
          curr_entry.val = _next;
          remaining.val = remaining.val - 1 | 0;
          return _key;
        }
      } else {
        break _L;
      }
    }
    return undefined;
  }, len);
}
function _M0MPB3Map4keysGsRP211localreview3tcl4CellE(self) {
  const curr_entry = new _M0TPB8MutLocalGORPB5EntryGsRP211localreview3tcl4CellEE(self.head);
  const len = self.size;
  const remaining = new _M0TPB8MutLocalGiE(len);
  return _M0MPB4Iter3newGUsRPB4JsonEE(() => {
    _L: {
      if (remaining.val > 0) {
        const _bind$2 = curr_entry.val;
        if (_bind$2 === undefined) {
          break _L;
        } else {
          const _Some = _bind$2;
          const _x = _Some;
          const _key = _x.key;
          const _next = _x.next;
          curr_entry.val = _next;
          remaining.val = remaining.val - 1 | 0;
          return _key;
        }
      } else {
        break _L;
      }
    }
    return undefined;
  }, len);
}
function _M0MPB3Map4keysGsRPB5ArrayGsEE(self) {
  const curr_entry = new _M0TPB8MutLocalGORPB5EntryGsRPB5ArrayGsEEE(self.head);
  const len = self.size;
  const remaining = new _M0TPB8MutLocalGiE(len);
  return _M0MPB4Iter3newGUsRPB4JsonEE(() => {
    _L: {
      if (remaining.val > 0) {
        const _bind$2 = curr_entry.val;
        if (_bind$2 === undefined) {
          break _L;
        } else {
          const _Some = _bind$2;
          const _x = _Some;
          const _key = _x.key;
          const _next = _x.next;
          curr_entry.val = _next;
          remaining.val = remaining.val - 1 | 0;
          return _key;
        }
      } else {
        break _L;
      }
    }
    return undefined;
  }, len);
}
function _M0MPB3Map6valuesGsRP211localreview3tcl7CommandE(self) {
  const curr_entry = new _M0TPB8MutLocalGORPB5EntryGsRP211localreview3tcl7CommandEE(self.head);
  const len = self.size;
  const remaining = new _M0TPB8MutLocalGiE(len);
  return _M0MPB4Iter3newGUsRPB4JsonEE(() => {
    _L: {
      if (remaining.val > 0) {
        const _bind$2 = curr_entry.val;
        if (_bind$2 === undefined) {
          break _L;
        } else {
          const _Some = _bind$2;
          const _x = _Some;
          const _value = _x.value;
          const _next = _x.next;
          curr_entry.val = _next;
          remaining.val = remaining.val - 1 | 0;
          return _value;
        }
      } else {
        break _L;
      }
    }
    return undefined;
  }, len);
}
function _M0MPB3Map10from__iterGssE(iter) {
  const _bind$2 = [];
  const m = _M0MPB3Map3MapGssE(new _M0TPB9ArrayViewGUssEE(_bind$2, 0, 0), undefined);
  while (true) {
    const _bind$3 = _M0MPB4Iter4nextGUsRPB4JsonEE(iter);
    if (_bind$3 === undefined) {
      break;
    } else {
      const _Some = _bind$3;
      const _x = _Some;
      const _k = _x._0;
      const _v = _x._1;
      _M0MPB3Map3setGssE(m, _k, _v);
      continue;
    }
  }
  return m;
}
function _M0IPC14byte4BytePB2Eq5equal(self, that) {
  return self === that;
}
function _M0MPC14json4Json6string(string) {
  return new _M0DTPB4Json6String(string);
}
function _M0MPC14json4Json7boolean(boolean) {
  return boolean ? _M0DTPB4Json4True__ : _M0DTPB4Json5False__;
}
function _M0MPC14json4Json6object(object) {
  return new _M0DTPB4Json6Object(object);
}
function _M0MPC15array5Array3mapGUOsRPC15debug4ReprERPC15debug4ReprE(self, f) {
  const arr = new Array(self.length);
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const v = self[i];
      arr[i] = f(v);
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return arr;
}
function _M0MPC15array5Array3mapGRPC15debug4ReprRPC15debug7ContentE(self, f) {
  const arr = new Array(self.length);
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const v = self[i];
      arr[i] = f(v);
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return arr;
}
function _M0MPC15array5Array3mapGUssERPC15debug4ReprE(self, f) {
  const arr = new Array(self.length);
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const v = self[i];
      arr[i] = f(v);
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return arr;
}
function _M0MPC15array5Array3mapGRPC15debug7ContentRPC15debug13ContentParensE(self, f) {
  const arr = new Array(self.length);
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const v = self[i];
      arr[i] = f(v);
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return arr;
}
function _M0MPC15array5Array3mapGUsOsEsE(self, f) {
  const arr = new Array(self.length);
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const v = self[i];
      arr[i] = f(v);
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return arr;
}
function _M0MPC15array5Array3mapGRPC15debug4ReprRPC15debug4ReprE(self, f) {
  const arr = new Array(self.length);
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const v = self[i];
      arr[i] = f(v);
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return arr;
}
function _M0MPC15array5Array3mapGRPC15debug13ContentParensRPB5ArrayGsEE(self, f) {
  const arr = new Array(self.length);
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const v = self[i];
      arr[i] = f(v);
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return arr;
}
function _M0MPC15array5Array3mapGssE(self, f) {
  const arr = new Array(self.length);
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const v = self[i];
      arr[i] = f(v);
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return arr;
}
function _M0MPC15array5Array3mapGUsRPB5ArrayGsEEsE(self, f) {
  const arr = new Array(self.length);
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const v = self[i];
      arr[i] = f(v);
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return arr;
}
function _M0MPC15array5Array3mapGRP211localreview3tcl7CommandsE(self, f) {
  const arr = new Array(self.length);
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const v = self[i];
      arr[i] = f(v);
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return arr;
}
function _M0MPC15array5Array3mapGRP211localreview3tcl4ExprsEHRP211localreview3tcl8TclError(self, f) {
  const arr = new Array(self.length);
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const v = self[i];
      const _bind$3 = f(v);
      let _tmp$2;
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        _tmp$2 = _ok._0;
      } else {
        return _bind$3;
      }
      arr[i] = _tmp$2;
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGRPB5ArrayGsERP211localreview3tcl8TclErrorE2Ok(arr);
}
function _M0MPC15array5Array3mapGsRP211localreview3tcl6NumberEHRP211localreview3tcl8TclError(self, f) {
  const arr = new Array(self.length);
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const v = self[i];
      const _bind$3 = f(v);
      let _tmp$2;
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        _tmp$2 = _ok._0;
      } else {
        return _bind$3;
      }
      arr[i] = _tmp$2;
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl6NumberERP211localreview3tcl8TclErrorE2Ok(arr);
}
function _M0MPB4Iter10size__hintGsE(self) {
  return self.size_hint;
}
function _M0MPB4Iter3anyGUssEE(self, f) {
  while (true) {
    const _bind$2 = _M0MPB4Iter4nextGUsRPB4JsonEE(self);
    if (_bind$2 === undefined) {
      return false;
    } else {
      const _Some = _bind$2;
      const _x = _Some;
      if (f(_x)) {
        return true;
      }
      continue;
    }
  }
}
function _M0MPB4Iter3allGcE(self, f) {
  while (true) {
    const _bind$2 = _M0MPB4Iter4nextGcE(self);
    if (_bind$2 === -1) {
      return true;
    } else {
      const _Some = _bind$2;
      const _x = _Some;
      if (f(_x)) {
      } else {
        return false;
      }
      continue;
    }
  }
}
function _M0MPB4Iter6filterGRPC16string10StringViewE(self, f) {
  return _M0MPB4Iter3newGUsRPB4JsonEE(() => {
    while (true) {
      const _bind$2 = _M0MPB4Iter4nextGUsRPB4JsonEE(self);
      if (_bind$2 === undefined) {
        return undefined;
      } else {
        const _Some = _bind$2;
        const _x = _Some;
        if (f(_x)) {
          return _x;
        }
        continue;
      }
    }
  }, undefined);
}
function _M0MPB4Iter4iterGsE(self) {
  return self;
}
function _M0MPB5Iter24nextGsRPC15debug4ReprE(self) {
  return _M0MPB4Iter4nextGUsRPB4JsonEE(self);
}
function _M0MPC13int3Int8to__char(self) {
  _L: {
    if (self >= 0 && self <= 55295) {
      break _L;
    } else {
      if (self >= 57344 && self <= 1114111) {
        break _L;
      } else {
        return -1;
      }
    }
  }
  return self;
}
function _M0MPC14byte4Byte9to__int64(self) {
  return BigInt.asUintN(64, BigInt(self));
}
function _M0MPC13int3Int13is__surrogate(self) {
  return 55296 <= self && self <= 57343;
}
function _M0MPC13int3Int3abs(self) {
  return self < 0 ? -self | 0 : self;
}
function _M0IPC16string6StringPB4Hash4hash(self) {
  let acc = (_M0FPB4seed >>> 0) + (374761393 >>> 0) | 0;
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      acc = (acc >>> 0) + (4 >>> 0) | 0;
      const v = self.charCodeAt(i);
      acc = _M0FPB13consume4__acc(acc, v);
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0FPB13finalize__acc(acc);
}
function _M0IPC13int3IntPB4Hash4hash(self) {
  const acc = (((_M0FPB4seed >>> 0) + (374761393 >>> 0) | 0) >>> 0) + (4 >>> 0) | 0;
  return _M0FPB13finalize__acc(_M0FPB13consume4__acc(acc, self));
}
function _M0MPC16double6Double4ceil(_tmp) {
  return Math.ceil(_tmp);
}
function _M0MPC16double6Double5floor(_tmp) {
  return Math.floor(_tmp);
}
function _M0MPC16double6Double7is__nan(self) {
  return self !== self;
}
function _M0MPC16double6Double7is__inf(self) {
  return self > _M0FPB18double__max__value || self < _M0FPB18double__min__value;
}
function _M0IPC16double6DoublePB4Show10to__string(self) {
  return String(self);
}
function _M0MPC14char4Char7to__hex(char) {
  const code = char;
  return code >= 0 && code <= 255 ? _M0MPC14byte4Byte7to__hex(code & 255) : code <= 65535 ? `${_M0MPC14byte4Byte7to__hex(code >> 8 & 255)}${_M0MPC14byte4Byte7to__hex(code & 255)}` : `${_M0MPC14byte4Byte7to__hex(code >> 16 & 255)}${_M0MPC14byte4Byte7to__hex(code >> 8 & 255)}${_M0MPC14byte4Byte7to__hex(code & 255)}`;
}
function _M0MPC14char4Char11is__control(self) {
  return self >= 0 && self <= 31 ? true : self >= 127 && self <= 159;
}
function _M0MPC14char4Char13is__printable(self) {
  if (_M0MPC14char4Char11is__control(self)) {
    return false;
  }
  const self$2 = self;
  _L: {
    _L$2: {
      if (self$2 >= 57344 && self$2 <= 63743) {
        break _L$2;
      } else {
        if (self$2 >= 983040 && self$2 <= 1048573) {
          break _L$2;
        } else {
          if (self$2 >= 1048576 && self$2 <= 1114109) {
            break _L$2;
          }
        }
      }
      break _L;
    }
    return false;
  }
  _L$2: {
    _L$3: {
      if (self$2 === 173) {
        break _L$3;
      } else {
        if (self$2 >= 1536 && self$2 <= 1541) {
          break _L$3;
        } else {
          if (self$2 === 1564) {
            break _L$3;
          } else {
            if (self$2 === 1757) {
              break _L$3;
            } else {
              if (self$2 === 1807) {
                break _L$3;
              } else {
                if (self$2 >= 2192 && self$2 <= 2193) {
                  break _L$3;
                } else {
                  if (self$2 === 2274) {
                    break _L$3;
                  } else {
                    if (self$2 === 6158) {
                      break _L$3;
                    } else {
                      if (self$2 >= 8203 && self$2 <= 8207) {
                        break _L$3;
                      } else {
                        if (self$2 >= 8234 && self$2 <= 8238) {
                          break _L$3;
                        } else {
                          if (self$2 >= 8288 && self$2 <= 8292) {
                            break _L$3;
                          } else {
                            if (self$2 >= 8294 && self$2 <= 8303) {
                              break _L$3;
                            } else {
                              if (self$2 === 65279) {
                                break _L$3;
                              } else {
                                if (self$2 >= 65529 && self$2 <= 65531) {
                                  break _L$3;
                                } else {
                                  if (self$2 === 69821) {
                                    break _L$3;
                                  } else {
                                    if (self$2 === 69837) {
                                      break _L$3;
                                    } else {
                                      if (self$2 >= 78896 && self$2 <= 78911) {
                                        break _L$3;
                                      } else {
                                        if (self$2 >= 113824 && self$2 <= 113827) {
                                          break _L$3;
                                        } else {
                                          if (self$2 >= 119155 && self$2 <= 119162) {
                                            break _L$3;
                                          } else {
                                            if (self$2 === 917505) {
                                              break _L$3;
                                            } else {
                                              if (self$2 >= 917536 && self$2 <= 917631) {
                                                break _L$3;
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      break _L$2;
    }
    return false;
  }
  if (_M0MPC13int3Int13is__surrogate(self$2)) {
    return false;
  }
  if (self$2 === 8232 || self$2 === 8233) {
    return false;
  }
  _L$3: {
    _L$4: {
      if (self$2 >= 64976 && self$2 <= 65007) {
        break _L$4;
      } else {
        if (self$2 >= 65534 && self$2 <= 65535) {
          break _L$4;
        } else {
          if (self$2 >= 131070 && self$2 <= 131071) {
            break _L$4;
          } else {
            if (self$2 >= 196606 && self$2 <= 196607) {
              break _L$4;
            } else {
              if (self$2 >= 262142 && self$2 <= 262143) {
                break _L$4;
              } else {
                if (self$2 >= 327678 && self$2 <= 327679) {
                  break _L$4;
                } else {
                  if (self$2 >= 393214 && self$2 <= 393215) {
                    break _L$4;
                  } else {
                    if (self$2 >= 458750 && self$2 <= 458751) {
                      break _L$4;
                    } else {
                      if (self$2 >= 524286 && self$2 <= 524287) {
                        break _L$4;
                      } else {
                        if (self$2 >= 589822 && self$2 <= 589823) {
                          break _L$4;
                        } else {
                          if (self$2 >= 655358 && self$2 <= 655359) {
                            break _L$4;
                          } else {
                            if (self$2 >= 720894 && self$2 <= 720895) {
                              break _L$4;
                            } else {
                              if (self$2 >= 786430 && self$2 <= 786431) {
                                break _L$4;
                              } else {
                                if (self$2 >= 851966 && self$2 <= 851967) {
                                  break _L$4;
                                } else {
                                  if (self$2 >= 917502 && self$2 <= 917503) {
                                    break _L$4;
                                  } else {
                                    if (self$2 >= 983038 && self$2 <= 983039) {
                                      break _L$4;
                                    } else {
                                      if (self$2 >= 1048574 && self$2 <= 1048575) {
                                        break _L$4;
                                      } else {
                                        if (self$2 >= 1114110 && self$2 <= 1114111) {
                                          break _L$4;
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      break _L$3;
    }
    return false;
  }
  return true;
}
function _M0MPC14char4Char18escape__to_2einner(self, logger, quote) {
  if (quote) {
    logger.method_table.method_3(logger.self, 39);
  }
  _L: {
    _L$2: {
      if (self === 39) {
        break _L$2;
      } else {
        if (self === 92) {
          break _L$2;
        } else {
          if (self === 10) {
            logger.method_table.method_0(logger.self, "\\n");
          } else {
            if (self === 13) {
              logger.method_table.method_0(logger.self, "\\r");
            } else {
              if (self === 8) {
                logger.method_table.method_0(logger.self, "\\b");
              } else {
                if (self === 9) {
                  logger.method_table.method_0(logger.self, "\\t");
                } else {
                  if (self >= 32 && self <= 126) {
                    logger.method_table.method_3(logger.self, self);
                  } else {
                    if (!_M0MPC14char4Char13is__printable(self)) {
                      logger.method_table.method_0(logger.self, "\\u{");
                      logger.method_table.method_0(logger.self, _M0MPC14char4Char7to__hex(self));
                      logger.method_table.method_3(logger.self, 125);
                    } else {
                      logger.method_table.method_3(logger.self, self);
                    }
                  }
                }
              }
            }
          }
        }
      }
      break _L;
    }
    logger.method_table.method_3(logger.self, 92);
    logger.method_table.method_3(logger.self, self);
  }
  if (quote) {
    logger.method_table.method_3(logger.self, 39);
    return;
  } else {
    return;
  }
}
function _M0MPC14char4Char14escape_2einner(self, quote) {
  const buf = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  _M0MPC14char4Char18escape__to_2einner(self, { self: buf, method_table: _M0FP092moonbitlang_2fcore_2fbuiltin_2fStringBuilder_24as_24_40moonbitlang_2fcore_2fbuiltin_2eLogger }, quote);
  return _M0MPB13StringBuilder10to__string(buf);
}
function _M0MPC15array5Array12view_2einnerGcE(self, start, end) {
  const len = self.length;
  let end$2;
  if (end === undefined) {
    end$2 = len;
  } else {
    const _Some = end;
    const _end = _Some;
    end$2 = _end;
  }
  if (start >= 0 && (start <= end$2 && end$2 <= len)) {
    const _bind$2 = self;
    const _bind$3 = end$2 - start | 0;
    return new _M0TPB9ArrayViewGcE(_bind$2, start, start + _bind$3 | 0);
  } else {
    return _M0FPC15abort5abortGsE("View index out of bounds");
  }
}
function _M0MPC15array5Array12view_2einnerGsE(self, start, end) {
  const len = self.length;
  let end$2;
  if (end === undefined) {
    end$2 = len;
  } else {
    const _Some = end;
    const _end = _Some;
    end$2 = _end;
  }
  if (start >= 0 && (start <= end$2 && end$2 <= len)) {
    const _bind$2 = self;
    const _bind$3 = end$2 - start | 0;
    return new _M0TPB9ArrayViewGsE(_bind$2, start, start + _bind$3 | 0);
  } else {
    return _M0FPC15abort5abortGsE("View index out of bounds");
  }
}
function _M0MPC15array5Array28unsafe__truncate__to__lengthGsE(self, new_len) {
  _M0MPB7JSArray11set__length(self, new_len);
}
function _M0MPC15array5Array17reserve__capacityGsE(self, capacity) {}
function _M0MPC15array5Array6appendGsE(self, other) {
  const old_len = self.length;
  const append_len = other.end - other.start | 0;
  if ((old_len + append_len | 0) >= old_len) {
    _M0MPB7JSArray12append__view(self, other.buf, other.start, append_len);
    return;
  } else {
    $panic();
    return;
  }
}
function _M0MPC15array5Array9is__emptyGRPB4JsonE(self) {
  return self.length === 0;
}
function _M0MPC15array5Array9is__emptyGcE(self) {
  return self.length === 0;
}
function _M0MPC15array5Array11unsafe__popGRPC14json10WriteFrameE(self) {
  return _M0MPB7JSArray3pop(self);
}
function _M0MPC15array5Array3popGRPC14json10WriteFrameE(self) {
  if (_M0MPC15array5Array9is__emptyGRPB4JsonE(self)) {
    return undefined;
  } else {
    const v = _M0MPC15array5Array11unsafe__popGRPC14json10WriteFrameE(self);
    return v;
  }
}
function _M0MPC15array5Array6removeGUssEE(self, index) {
  if (index >= 0 && index < self.length) {
    const value = index >>> 0 < self.length ? self[index] : $oob();
    _M0MPB7JSArray6splice(self, index, 1);
    return value;
  } else {
    const _string_builder = _M0MPB13StringBuilder21StringBuilder_2einner(60);
    _M0IPB13StringBuilderPB6Logger13write__string(_string_builder, "index out of bounds: the len is from 0 to ");
    _M0MPB13StringBuilder13write__objectGiE(_string_builder, self.length);
    _M0IPB13StringBuilderPB6Logger13write__string(_string_builder, " but the index is ");
    _M0MPB13StringBuilder13write__objectGiE(_string_builder, index);
    return _M0FPC15abort5abortGsE(_M0MPB13StringBuilder10to__string(_string_builder));
  }
}
function _M0MPC15array5Array4copyGUssEE(self) {
  return _M0MPB7JSArray4copy(self);
}
function _M0MPC15array5Array2atGRPB4JsonE(self, index) {
  const len = self.length;
  return index >= 0 && index < len ? self[index] : $panic();
}
function _M0MPC15array5Array2atGcE(self, index) {
  const len = self.length;
  return index >= 0 && index < len ? self[index] : $panic();
}
function _M0MPC15array5Array2atGiE(self, index) {
  const len = self.length;
  return index >= 0 && index < len ? self[index] : $panic();
}
function _M0MPC15array5Array2atGbE(self, index) {
  const len = self.length;
  return index >= 0 && index < len ? self[index] : $panic();
}
function _M0FPB7minimum(x, y) {
  return x > y ? y : x;
}
function _M0MPC15array12MutArrayView4swapGsE(arr, i, j) {
  const temp = arr.buf[arr.start + i | 0];
  arr.buf[arr.start + i | 0] = arr.buf[arr.start + j | 0];
  arr.buf[arr.start + j | 0] = temp;
}
function _M0MPC15array12MutArrayView5sliceGsE(arr, start, end) {
  const _bind$2 = arr.end - arr.start | 0;
  if (start < 0 || (start > end || end > _bind$2)) {
    $panic();
  }
  return new _M0TPB12MutArrayViewGsE(arr.buf, start + arr.start | 0, end + arr.start | 0);
}
function _M0MPC15array5Array3setGiE(self, index, value) {
  const len = self.length;
  if (index >= 0 && index < len) {
    self[index] = value;
    return;
  } else {
    $panic();
    return;
  }
}
function _M0MPC15array5Array3setGUssEE(self, index, value) {
  const len = self.length;
  if (index >= 0 && index < len) {
    self[index] = value;
    return;
  } else {
    $panic();
    return;
  }
}
function _M0MPC15array5Array3setGbE(self, index, value) {
  const len = self.length;
  if (index >= 0 && index < len) {
    self[index] = value;
    return;
  } else {
    $panic();
    return;
  }
}
function _M0MPC15array12MutArrayView14rev__in__placeGsE(arr) {
  const len = arr.end - arr.start | 0;
  if (2 === 0) {
    $panic();
  }
  const mid_len = len / 2 | 0;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < mid_len) {
      const j = (len - i | 0) - 1 | 0;
      const temp = arr.buf[arr.start + i | 0];
      arr.buf[arr.start + i | 0] = arr.buf[arr.start + j | 0];
      arr.buf[arr.start + j | 0] = temp;
      _tmp = i + 1 | 0;
      continue;
    } else {
      return;
    }
  }
}
function _M0FPB17fixed__get__limit(len) {
  let _tmp = len;
  let _tmp$2 = 0;
  while (true) {
    const len$2 = _tmp;
    const limit = _tmp$2;
    if (len$2 > 0) {
      if (2 === 0) {
        $panic();
      }
      _tmp = len$2 / 2 | 0;
      _tmp$2 = limit + 1 | 0;
      continue;
    } else {
      return limit;
    }
  }
}
function _M0FPB19fixed__bubble__sortGsE(arr) {
  const _bind$2 = arr.end - arr.start | 0;
  let _tmp = 1;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      let _tmp$2 = i;
      while (true) {
        const j = _tmp$2;
        if (j > 0 && _M0IP016_24default__implPB7Compare6op__gtGsE(arr.buf[arr.start + (j - 1 | 0) | 0], arr.buf[arr.start + j | 0])) {
          _M0MPC15array12MutArrayView4swapGsE(arr, j, j - 1 | 0);
          _tmp$2 = j - 1 | 0;
          continue;
        } else {
          break;
        }
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      return;
    }
  }
}
function _M0FPB20fixed__choose__pivotN7sort__2S568GsE(_env, a, b) {
  const swaps = _env._1;
  const arr = _env._0;
  if (_M0IP016_24default__implPB7Compare6op__gtGsE(arr.buf[arr.start + a | 0], arr.buf[arr.start + b | 0])) {
    _M0MPC15array12MutArrayView4swapGsE(arr, a, b);
    swaps.val = swaps.val + 1 | 0;
    return;
  } else {
    return;
  }
}
function _M0FPB20fixed__choose__pivotN7sort__3S572GsE(_env, a, b, c) {
  _M0FPB20fixed__choose__pivotN7sort__2S568GsE(_env, a, b);
  _M0FPB20fixed__choose__pivotN7sort__2S568GsE(_env, b, c);
  _M0FPB20fixed__choose__pivotN7sort__2S568GsE(_env, a, b);
}
function _M0FPB20fixed__choose__pivotGsE(arr) {
  const len = arr.end - arr.start | 0;
  const swaps = new _M0TPB8MutLocalGiE(0);
  if (4 === 0) {
    $panic();
  }
  const b = Math.imul(len / 4 | 0, 2) | 0;
  if (len >= 8) {
    if (4 === 0) {
      $panic();
    }
    const a = Math.imul(len / 4 | 0, 1) | 0;
    if (4 === 0) {
      $panic();
    }
    const c = Math.imul(len / 4 | 0, 3) | 0;
    const _env = { _0: arr, _1: swaps };
    if (len > 50) {
      _M0FPB20fixed__choose__pivotN7sort__3S572GsE(_env, a - 1 | 0, a, a + 1 | 0);
      _M0FPB20fixed__choose__pivotN7sort__3S572GsE(_env, b - 1 | 0, b, b + 1 | 0);
      _M0FPB20fixed__choose__pivotN7sort__3S572GsE(_env, c - 1 | 0, c, c + 1 | 0);
    }
    _M0FPB20fixed__choose__pivotN7sort__3S572GsE(_env, a, b, c);
  }
  if (swaps.val === 12) {
    _M0MPC15array12MutArrayView14rev__in__placeGsE(arr);
    return { _0: (len - b | 0) - 1 | 0, _1: true };
  } else {
    return { _0: b, _1: swaps.val === 0 };
  }
}
function _M0FPB17fixed__sift__downGsE(arr, index) {
  const len = arr.end - arr.start | 0;
  let _tmp = index;
  let _tmp$2 = (Math.imul(index, 2) | 0) + 1 | 0;
  while (true) {
    const index$2 = _tmp;
    const child = _tmp$2;
    if (child < len) {
      const child$2 = (child + 1 | 0) < len && _M0IP016_24default__implPB7Compare6op__ltGsE(arr.buf[arr.start + child | 0], arr.buf[arr.start + (child + 1 | 0) | 0]) ? child + 1 | 0 : child;
      if (_M0IP016_24default__implPB7Compare6op__geGsE(arr.buf[arr.start + index$2 | 0], arr.buf[arr.start + child$2 | 0])) {
        return undefined;
      }
      _M0MPC15array12MutArrayView4swapGsE(arr, index$2, child$2);
      _tmp = child$2;
      _tmp$2 = (Math.imul(child$2, 2) | 0) + 1 | 0;
      continue;
    } else {
      return;
    }
  }
}
function _M0FPB17fixed__heap__sortGsE(arr) {
  const len = arr.end - arr.start | 0;
  if (2 === 0) {
    $panic();
  }
  const _bind$2 = len / 2 | 0;
  let _tmp = _bind$2 - 1 | 0;
  while (true) {
    const i = _tmp;
    if (i >= 0) {
      _M0FPB17fixed__sift__downGsE(arr, i);
      _tmp = i - 1 | 0;
      continue;
    } else {
      break;
    }
  }
  let _tmp$2 = len - 1 | 0;
  while (true) {
    const i = _tmp$2;
    if (i >= 1) {
      _M0MPC15array12MutArrayView4swapGsE(arr, 0, i);
      _M0FPB17fixed__sift__downGsE(_M0MPC15array12MutArrayView5sliceGsE(arr, 0, i), 0);
      _tmp$2 = i - 1 | 0;
      continue;
    } else {
      return;
    }
  }
}
function _M0FPB16fixed__partitionGsE(arr, pivot_index) {
  _M0MPC15array12MutArrayView4swapGsE(arr, pivot_index, (arr.end - arr.start | 0) - 1 | 0);
  const pivot = arr.buf[arr.start + ((arr.end - arr.start | 0) - 1 | 0) | 0];
  const _bind$2 = (arr.end - arr.start | 0) - 1 | 0;
  let _tmp = 0;
  let _tmp$2 = 0;
  let _tmp$3 = true;
  while (true) {
    const j = _tmp;
    const i = _tmp$2;
    const partitioned = _tmp$3;
    if (j < _bind$2) {
      if (_M0IP016_24default__implPB7Compare6op__ltGsE(arr.buf[arr.start + j | 0], pivot)) {
        if (i !== j) {
          _M0MPC15array12MutArrayView4swapGsE(arr, i, j);
          _tmp = j + 1 | 0;
          _tmp$2 = i + 1 | 0;
          _tmp$3 = false;
          continue;
        } else {
          _tmp = j + 1 | 0;
          _tmp$2 = i + 1 | 0;
          continue;
        }
      } else {
        _tmp = j + 1 | 0;
        continue;
      }
    } else {
      _M0MPC15array12MutArrayView4swapGsE(arr, i, (arr.end - arr.start | 0) - 1 | 0);
      return { _0: i, _1: partitioned };
    }
  }
}
function _M0FPB24fixed__try__bubble__sortGsE(arr) {
  const _bind$2 = arr.end - arr.start | 0;
  let _tmp = 1;
  let _tmp$2 = 0;
  while (true) {
    const i = _tmp;
    const tries = _tmp$2;
    if (i < _bind$2) {
      let sorted;
      let _tmp$3 = i;
      let _tmp$4 = true;
      while (true) {
        const j = _tmp$3;
        const sorted$2 = _tmp$4;
        if (j > 0 && _M0IP016_24default__implPB7Compare6op__gtGsE(arr.buf[arr.start + (j - 1 | 0) | 0], arr.buf[arr.start + j | 0])) {
          _M0MPC15array12MutArrayView4swapGsE(arr, j, j - 1 | 0);
          _tmp$3 = j - 1 | 0;
          _tmp$4 = false;
          continue;
        } else {
          sorted = sorted$2;
          break;
        }
      }
      if (!sorted) {
        const tries$2 = tries + 1 | 0;
        if (tries$2 > 8) {
          return false;
        }
        _tmp = i + 1 | 0;
        _tmp$2 = tries$2;
        continue;
      } else {
        _tmp = i + 1 | 0;
        continue;
      }
    } else {
      return true;
    }
  }
}
function _M0FPB18fixed__quick__sortGsE(arr, pred, limit) {
  let _tmp = limit;
  let _tmp$2 = arr;
  let _tmp$3 = pred;
  let _tmp$4 = true;
  let _tmp$5 = true;
  while (true) {
    const limit$2 = _tmp;
    const arr$2 = _tmp$2;
    const pred$2 = _tmp$3;
    const was_partitioned = _tmp$4;
    const balanced = _tmp$5;
    const len = arr$2.end - arr$2.start | 0;
    if (len <= 16) {
      if (len >= 2) {
        _M0FPB19fixed__bubble__sortGsE(arr$2);
      }
      return undefined;
    }
    if (limit$2 === 0) {
      _M0FPB17fixed__heap__sortGsE(arr$2);
      return undefined;
    }
    const _bind$2 = _M0FPB20fixed__choose__pivotGsE(arr$2);
    const _pivot_index = _bind$2._0;
    const _likely_sorted = _bind$2._1;
    if (was_partitioned && (balanced && _likely_sorted)) {
      if (_M0FPB24fixed__try__bubble__sortGsE(arr$2)) {
        return undefined;
      }
    }
    const _bind$3 = _M0FPB16fixed__partitionGsE(arr$2, _pivot_index);
    const _pivot = _bind$3._0;
    const _partitioned = _bind$3._1;
    const _tmp$6 = _M0FPB7minimum(_pivot, len - _pivot | 0);
    if (8 === 0) {
      $panic();
    }
    const balanced$2 = _tmp$6 >= (len / 8 | 0);
    const limit$3 = !balanced$2 ? limit$2 - 1 | 0 : limit$2;
    if (pred$2 === undefined) {
    } else {
      const _Some = pred$2;
      const _p = _Some;
      if (_p === arr$2.buf[arr$2.start + _pivot | 0]) {
        let i;
        let _tmp$7 = _pivot;
        while (true) {
          const i$2 = _tmp$7;
          if (i$2 < len && _p === arr$2.buf[arr$2.start + i$2 | 0]) {
            _tmp$7 = i$2 + 1 | 0;
            continue;
          } else {
            i = i$2;
            break;
          }
        }
        _tmp = limit$3;
        _tmp$2 = _M0MPC15array12MutArrayView5sliceGsE(arr$2, i, len);
        _tmp$4 = _partitioned;
        _tmp$5 = balanced$2;
        continue;
      }
    }
    const left = _M0MPC15array12MutArrayView5sliceGsE(arr$2, 0, _pivot);
    const right = _M0MPC15array12MutArrayView5sliceGsE(arr$2, _pivot + 1 | 0, len);
    if ((left.end - left.start | 0) < (right.end - right.start | 0)) {
      _M0FPB18fixed__quick__sortGsE(left, pred$2, limit$3);
      _tmp = limit$3;
      _tmp$2 = right;
      _tmp$3 = arr$2.buf[arr$2.start + _pivot | 0];
      _tmp$4 = _partitioned;
      _tmp$5 = balanced$2;
      continue;
    } else {
      _M0FPB18fixed__quick__sortGsE(right, arr$2.buf[arr$2.start + _pivot | 0], limit$3);
      _tmp = limit$3;
      _tmp$2 = left;
      _tmp$4 = _partitioned;
      _tmp$5 = balanced$2;
      continue;
    }
  }
}
function _M0MPC15array12MutArrayView4sortGsE(self) {
  _M0FPB18fixed__quick__sortGsE(self, undefined, _M0FPB17fixed__get__limit(self.end - self.start | 0));
}
function _M0MPC15array5Array4sortGsE(self) {
  const _bind$2 = self.length;
  _M0MPC15array12MutArrayView4sortGsE(new _M0TPB12MutArrayViewGsE(self, 0, _bind$2));
}
function _M0MPC15array5Array4makeGbE(len, elem) {
  const arr = new Array(len);
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < len) {
      arr[i] = elem;
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return arr;
}
function _M0MPC15array5Array4makeGcE(len, elem) {
  const arr = new Array(len);
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < len) {
      arr[i] = elem;
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return arr;
}
function _M0MPC15array5Array3getGcE(self, index) {
  const len = self.length;
  return index >= 0 && index < len ? self[index] : -1;
}
function _M0MPC15array5Array3getGUssEE(self, index) {
  const len = self.length;
  return index >= 0 && index < len ? self[index] : undefined;
}
function _M0IPC15array5ArrayPB2Eq5equalGcE(self, other) {
  const self_len = self.length;
  const other_len = other.length;
  if (self_len === other_len) {
    let _tmp = 0;
    while (true) {
      const i = _tmp;
      if (i < self_len) {
        if (self[i] === other[i]) {
        } else {
          return false;
        }
        _tmp = i + 1 | 0;
        continue;
      } else {
        return true;
      }
    }
  } else {
    return false;
  }
}
function _M0IPC15array5ArrayPB3Add3addGsE(self, other) {
  const len_self = self.length;
  const len_other = other.length;
  if (len_self === 0) {
    return _M0MPC15array5Array31unsafe__make__and__blit_2einnerGsE(other, len_other, len_other, 0, 0);
  } else {
    const result = _M0MPC15array5Array31unsafe__make__and__blit_2einnerGsE(self, len_self + len_other | 0, len_self, 0, 0);
    _M0MPB18UninitializedArray12unsafe__blitGsE(result, len_self, other, 0, len_other);
    return result;
  }
}
function _M0MPC15array5Array3allGsE(self, f) {
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const v = self[_];
      if (!f(v)) {
        return false;
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return true;
}
function _M0MPC15array5Array5clearGsE(self) {
  _M0MPC15array5Array28unsafe__truncate__to__lengthGsE(self, 0);
}
function _M0MPC15array5Array6filterGsEHRP211localreview3tcl8TclError(self, f) {
  const arr = [];
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const v = self[_];
      const _bind$3 = f(v);
      let _tmp$2;
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        _tmp$2 = _ok._0;
      } else {
        return _bind$3;
      }
      if (_tmp$2) {
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(arr, v);
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGRPB5ArrayGsERP211localreview3tcl8TclErrorE2Ok(arr);
}
function _M0MPC15array5Array6filterGsE(self, f) {
  const arr = [];
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const v = self[_];
      if (f(v)) {
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(arr, v);
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return arr;
}
function _M0MPC15array5Array6filterGUssEE(self, f) {
  const arr = [];
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const v = self[_];
      if (f(v)) {
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(arr, v);
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return arr;
}
function _M0MPC15array5Array14rev__in__placeGsE(self) {
  const len = self.length;
  if (2 === 0) {
    $panic();
  }
  const _bind$2 = len / 2 | 0;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const temp = self[i];
      self[i] = self[(len - i | 0) - 1 | 0];
      self[(len - i | 0) - 1 | 0] = temp;
      _tmp = i + 1 | 0;
      continue;
    } else {
      return;
    }
  }
}
function _M0MPC15array5Array8containsGcE(self, value) {
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const v = self[_];
      if (v === value) {
        return true;
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      return false;
    }
  }
}
function _M0MPC15array5Array8containsGsE(self, value) {
  const _bind$2 = self.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const v = self[_];
      if (v === value) {
        return true;
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      return false;
    }
  }
}
function _M0MPC15array5Array10push__iterGsE(self, iter) {
  const _bind$2 = _M0MPB4Iter10size__hintGsE(iter);
  if (_bind$2 === undefined) {
  } else {
    const _Some = _bind$2;
    const _n = _Some;
    _M0MPC15array5Array17reserve__capacityGsE(self, self.length + _n | 0);
  }
  while (true) {
    const _bind$3 = _M0MPB4Iter4nextGUsRPB4JsonEE(iter);
    if (_bind$3 === undefined) {
      return;
    } else {
      const _Some = _bind$3;
      const _x = _Some;
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(self, _x);
      continue;
    }
  }
}
function _M0MPC15array5Array4lastGRPC16string10StringViewE(self) {
  if (self.length === 0) {
    return undefined;
  } else {
    const _last = self[self.length - 1 | 0];
    return _last;
  }
}
function _M0MPC15array5Array4joinGsE(self, separator) {
  return _M0MPC15array9ArrayView4joinGsE(new _M0TPB9ArrayViewGsE(self, 0, self.length), separator);
}
function _M0MPC15array5Array4joinGRPC16string10StringViewE(self, separator) {
  return _M0MPC15array9ArrayView4joinGRPC16string10StringViewE(new _M0TPB9ArrayViewGRPC16string10StringViewE(self, 0, self.length), separator);
}
function _M0IPC15float5FloatPB4Show10to__string(self) {
  return String(self);
}
function _M0MPC15debug4Repr4ReprGRP211localreview3tcl8TclErrorE(value) {
  return _M0IP211localreview3tcl8TclErrorPC15debug5Debug8to__repr(value);
}
function _M0MPC15debug4Repr4ReprGUssEE(value) {
  return _M0IPC15tuple6Tuple2PC15debug5Debug8to__reprGssE(value);
}
function _M0MPC15debug4Repr4ReprGsE(value) {
  return _M0IPC16string6StringPC15debug5Debug8to__repr(value);
}
function _M0MPC15debug4Repr5tuple(children) {
  return new _M0DTPC15debug4Repr5Tuple(children);
}
function _M0IPC15tuple6Tuple2PC15debug5Debug8to__reprGssE(self) {
  const _a = self._0;
  const _b = self._1;
  return _M0MPC15debug4Repr5tuple([_M0MPC15debug4Repr4ReprGsE(_a), _M0MPC15debug4Repr4ReprGsE(_b)]);
}
function _M0MPC15debug4Repr8children(self) {
  let value;
  _L: {
    _L$2: {
      switch (self.$tag) {
        case 0: {
          break _L$2;
        }
        case 1: {
          break _L$2;
        }
        case 2: {
          break _L$2;
        }
        case 3: {
          break _L$2;
        }
        case 4: {
          break _L$2;
        }
        case 5: {
          break _L$2;
        }
        case 6: {
          break _L$2;
        }
        case 15: {
          break _L$2;
        }
        case 17: {
          break _L$2;
        }
        case 7: {
          const _Tuple = self;
          const _xs = _Tuple._0;
          return _xs;
        }
        case 8: {
          const _Array = self;
          const _xs$2 = _Array._0;
          return _xs$2;
        }
        case 9: {
          const _Record = self;
          const _xs$3 = _Record._0;
          return _xs$3;
        }
        case 10: {
          const _Enum = self;
          const _xs$4 = _Enum._1;
          return _xs$4;
        }
        case 11: {
          const _Map = self;
          const _xs$5 = _Map._0;
          return _xs$5;
        }
        case 14: {
          const _Opaque = self;
          const _value = _Opaque._1;
          value = _value;
          break _L;
        }
        case 12: {
          const _RecordField = self;
          const _value$2 = _RecordField._1;
          value = _value$2;
          break _L;
        }
        case 13: {
          const _EnumLabeledArg = self;
          const _value$3 = _EnumLabeledArg._1;
          value = _value$3;
          break _L;
        }
        default: {
          const _MapEntry = self;
          const _key = _MapEntry._0;
          const _value$4 = _MapEntry._1;
          return [_key, _value$4];
        }
      }
    }
    return [];
  }
  return [value];
}
function _M0MPC15debug4Repr14with__children(self, children) {
  _L: {
    switch (self.$tag) {
      case 0: {
        break _L;
      }
      case 1: {
        break _L;
      }
      case 2: {
        break _L;
      }
      case 3: {
        break _L;
      }
      case 4: {
        break _L;
      }
      case 5: {
        break _L;
      }
      case 6: {
        break _L;
      }
      case 15: {
        break _L;
      }
      case 17: {
        break _L;
      }
      case 7: {
        return new _M0DTPC15debug4Repr5Tuple(children);
      }
      case 8: {
        return new _M0DTPC15debug4Repr5Array(children);
      }
      case 9: {
        return new _M0DTPC15debug4Repr6Record(children);
      }
      case 10: {
        const _Enum = self;
        const _name = _Enum._0;
        return new _M0DTPC15debug4Repr4Enum(_name, children);
      }
      case 11: {
        return new _M0DTPC15debug4Repr3Map(children);
      }
      case 12: {
        const _RecordField = self;
        const _name$2 = _RecordField._0;
        if (children.length === 1) {
          const _value = children[0];
          return new _M0DTPC15debug4Repr11RecordField(_name$2, _value);
        } else {
          return new _M0DTPC15debug4Repr11RecordField(_name$2, _M0DTPC15debug4Repr7Omitted__);
        }
      }
      case 13: {
        const _EnumLabeledArg = self;
        const _label = _EnumLabeledArg._0;
        if (children.length === 1) {
          const _value = children[0];
          return new _M0DTPC15debug4Repr14EnumLabeledArg(_label, _value);
        } else {
          return new _M0DTPC15debug4Repr14EnumLabeledArg(_label, _M0DTPC15debug4Repr7Omitted__);
        }
      }
      case 16: {
        if (children.length === 2) {
          const _key = children[0];
          const _value = children[1];
          return new _M0DTPC15debug4Repr8MapEntry(_key, _value);
        } else {
          return new _M0DTPC15debug4Repr8MapEntry(_M0DTPC15debug4Repr7Omitted__, _M0DTPC15debug4Repr7Omitted__);
        }
      }
      default: {
        const _Opaque = self;
        const _name$3 = _Opaque._0;
        if (children.length === 1) {
          const _value = children[0];
          return new _M0DTPC15debug4Repr6Opaque(_name$3, _value);
        } else {
          return new _M0DTPC15debug4Repr6Opaque(_name$3, _M0DTPC15debug4Repr7Omitted__);
        }
      }
    }
  }
  return self;
}
function _M0MPC15debug4Repr7integer(x) {
  return new _M0DTPC15debug4Repr7Integer(x);
}
function _M0MPC15debug4Repr4bool(x) {
  return new _M0DTPC15debug4Repr7BoolLit(x);
}
function _M0MPC15debug4Repr6string(x) {
  return new _M0DTPC15debug4Repr9StringLit(x);
}
function _M0MPC15debug4Repr5array(children) {
  return new _M0DTPC15debug4Repr5Array(children);
}
function _M0MPC15debug4Repr6record(fields) {
  const _acc = [];
  const _it = _M0MPB3Map5iter2GsRPC15debug4ReprE(fields);
  let _tmp;
  while (true) {
    const _bind$2 = _M0MPB5Iter24nextGsRPC15debug4ReprE(_it);
    if (_bind$2 === undefined) {
      _tmp = _acc;
      break;
    } else {
      const _Some = _bind$2;
      const _x = _Some;
      const _name = _x._0;
      const _value = _x._1;
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(_acc, new _M0DTPC15debug4Repr11RecordField(_name, _value));
      continue;
    }
  }
  return new _M0DTPC15debug4Repr6Record(_tmp);
}
function _M0MPC15debug4Repr7omitted() {
  return _M0DTPC15debug4Repr7Omitted__;
}
function _M0MPC15debug4Repr4ctor(name, args) {
  return new _M0DTPC15debug4Repr4Enum(name, _M0MPC15array5Array3mapGUOsRPC15debug4ReprERPC15debug4ReprE(args, (arg) => {
    const _label = arg._0;
    const _value = arg._1;
    if (_label === undefined) {
      return _value;
    } else {
      const _Some = _label;
      const _label$2 = _Some;
      return new _M0DTPC15debug4Repr14EnumLabeledArg(_label$2, _value);
    }
  }));
}
function _M0MPC15debug4Repr7shallow(self) {
  return _M0MPC15debug4Repr14with__children(self, []);
}
function _M0IPC15debug13ContentParensPB3Add3add(self, other) {
  return new _M0TPC15debug13ContentParens(self.size + other.size | 0, _M0IPC15array5ArrayPB3Add3addGsE(self.lines, other.lines));
}
function _M0FPC15debug14empty__content() {
  return new _M0TPC15debug7Content(0, [], false);
}
function _M0FPC15debug8verbatim(x) {
  return new _M0TPC15debug13ContentParens(1, [x]);
}
function _M0FPC15debug15content__parens(size, lines) {
  return new _M0TPC15debug13ContentParens(size, lines);
}
function _M0FPC15debug12leaf_2einner(x, needs_parens) {
  return new _M0TPC15debug7Content(1, [x], needs_parens);
}
function _M0FPC15debug11with__lines(r, f) {
  return new _M0TPC15debug13ContentParens(r.size, f(r.lines));
}
function _M0MPC15debug7Content20with__lines__content(r, f) {
  return new _M0TPC15debug7Content(r.size, f(r.lines), r.needs_parens);
}
function _M0FPC15debug15surround__lines(start, finish, lines) {
  if (lines.length === 0) {
    return [`${start}${finish}`];
  } else {
    if (lines.length === 1) {
      const _item = lines[0];
      return [`${start}${_item}${finish}`];
    } else {
      const _first = lines[0];
      const _last = lines[lines.length - 1 | 0];
      const _x = new _M0TPB9ArrayViewGsE(lines, 1, lines.length - 1 | 0);
      const _self = [];
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(_self, `${start}${_first}`);
      _M0MPC15array5Array10push__iterGsE(_self, _M0MPC15array9ArrayView4iterGsE(_x));
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(_self, `${_last}${finish}`);
      return _self;
    }
  }
}
function _M0FPC15debug8surround(start, finish, r) {
  return _M0FPC15debug11with__lines(r, (lines) => _M0FPC15debug15surround__lines(start, finish, lines));
}
function _M0MPC15debug7Content8no__wrap(c) {
  return new _M0TPC15debug13ContentParens(c.size, c.lines);
}
function _M0FPC15debug6parens(r) {
  return new _M0TPC15debug7Content(r.size, r.lines, true);
}
function _M0FPC15debug10no__parens(r) {
  return new _M0TPC15debug7Content(r.size, r.lines, false);
}
function _M0FPC15debug14compact__lines(lines) {
  if (lines.length === 0) {
    return [];
  } else {
    if (lines.length === 1) {
      const _x = lines[0];
      return [_x];
    } else {
      const _first = lines[0];
      const _last = lines[lines.length - 1 | 0];
      const _x_end = lines.length - 1 | 0;
      if (_first === "[" && _last === "]" || _first === "{" && _last === "}") {
        const parts = [];
        const _bind$2 = _x_end - 1 | 0;
        let _tmp = 0;
        while (true) {
          const _ = _tmp;
          if (_ < _bind$2) {
            const m = lines[1 + _ | 0];
            const t = _M0MPC16string6String4trim(m, undefined);
            if (_M0IP016_24default__implPB2Eq10not__equalGRPC16string10StringViewE(t, new _M0TPC16string10StringView(_M0FPC15debug14compact__linesN7_2abindS1134, 0, _M0FPC15debug14compact__linesN7_2abindS1134.length))) {
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(parts, t);
            }
            _tmp = _ + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        const joined0 = _M0MPC15array5Array4joinGRPC16string10StringViewE(parts, new _M0TPC16string10StringView(_M0FPC15debug14compact__linesN7_2abindS1147, 0, _M0FPC15debug14compact__linesN7_2abindS1147.length));
        const _bind$3 = _M0MPC16string6String13strip__suffix(joined0, new _M0TPC16string10StringView(_M0FPC15debug14compact__linesN7_2abindS1141, 0, _M0FPC15debug14compact__linesN7_2abindS1141.length));
        let joined;
        if (_bind$3 === undefined) {
          joined = new _M0TPC16string10StringView(joined0, 0, joined0.length);
        } else {
          const _Some = _bind$3;
          joined = _Some;
        }
        if (_first === "{") {
          const s1 = _M0MPC16option6Option10unwrap__orGsE(_M0MPC16string10StringView13strip__prefix(joined, new _M0TPC16string10StringView(_M0FPC15debug14compact__linesN7_2abindS1139, 0, _M0FPC15debug14compact__linesN7_2abindS1139.length)), joined);
          const inner = _M0MPC16option6Option10unwrap__orGsE(_M0MPC16string10StringView13strip__suffix(s1, new _M0TPC16string10StringView(_M0FPC15debug14compact__linesN7_2abindS1138, 0, _M0FPC15debug14compact__linesN7_2abindS1138.length)), s1);
          if (_M0IPC16string10StringViewPB2Eq5equal(inner, new _M0TPC16string10StringView(_M0FPC15debug14compact__linesN7_2abindS1136, 0, _M0FPC15debug14compact__linesN7_2abindS1136.length))) {
            return ["{}"];
          } else {
            const _string_builder = _M0MPB13StringBuilder21StringBuilder_2einner(4);
            _M0IPB13StringBuilderPB6Logger13write__string(_string_builder, "{ ");
            _M0MPB13StringBuilder13write__objectGRPC16string10StringViewE(_string_builder, inner);
            _M0IPB13StringBuilderPB6Logger13write__string(_string_builder, " }");
            return [_M0MPB13StringBuilder10to__string(_string_builder)];
          }
        } else {
          const _string_builder = _M0MPB13StringBuilder21StringBuilder_2einner(2);
          _M0IPB13StringBuilderPB6Logger13write__string(_string_builder, "[");
          _M0MPB13StringBuilder13write__objectGRPC16string10StringViewE(_string_builder, joined);
          _M0IPB13StringBuilderPB6Logger13write__string(_string_builder, "]");
          return [_M0MPB13StringBuilder10to__string(_string_builder)];
        }
      } else {
        if (_M0MPC16string6String11has__suffix(_first, new _M0TPC16string10StringView(_M0FPC15debug14compact__linesN7_2abindS1148, 0, _M0FPC15debug14compact__linesN7_2abindS1148.length)) && _last === ")") {
          const parts = [];
          const _bind$2 = _x_end - 1 | 0;
          let _tmp = 0;
          while (true) {
            const _ = _tmp;
            if (_ < _bind$2) {
              const m = lines[1 + _ | 0];
              const t = _M0MPC16string6String4trim(m, undefined);
              if (_M0IP016_24default__implPB2Eq10not__equalGRPC16string10StringViewE(t, new _M0TPC16string10StringView(_M0FPC15debug14compact__linesN7_2abindS1152, 0, _M0FPC15debug14compact__linesN7_2abindS1152.length))) {
                _M0MPC15array5Array4pushGRPC14json10WriteFrameE(parts, t);
              }
              _tmp = _ + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          const joined0 = _M0MPC15array5Array4joinGRPC16string10StringViewE(parts, new _M0TPC16string10StringView(_M0FPC15debug14compact__linesN7_2abindS1161, 0, _M0FPC15debug14compact__linesN7_2abindS1161.length));
          const _bind$3 = _M0MPC16string6String13strip__suffix(joined0, new _M0TPC16string10StringView(_M0FPC15debug14compact__linesN7_2abindS1155, 0, _M0FPC15debug14compact__linesN7_2abindS1155.length));
          let joined;
          if (_bind$3 === undefined) {
            joined = new _M0TPC16string10StringView(joined0, 0, joined0.length);
          } else {
            const _Some = _bind$3;
            joined = _Some;
          }
          const _string_builder = _M0MPB13StringBuilder21StringBuilder_2einner(0);
          _M0MPB13StringBuilder13write__objectGsE(_string_builder, _first);
          _M0MPB13StringBuilder13write__objectGRPC16string10StringViewE(_string_builder, joined);
          _M0MPB13StringBuilder13write__objectGsE(_string_builder, _last);
          return [_M0MPB13StringBuilder10to__string(_string_builder)];
        } else {
          const parts = [new _M0TPC16string10StringView(_first, 0, _first.length)];
          const _bind$2 = _x_end - 1 | 0;
          let _tmp = 0;
          while (true) {
            const _ = _tmp;
            if (_ < _bind$2) {
              const m = lines[1 + _ | 0];
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(parts, _M0MPC16string6String4trim(m, undefined));
              _tmp = _ + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          _M0MPC15array5Array4pushGRPC14json10WriteFrameE(parts, _M0MPC16string6String4trim(_last, undefined));
          return [_M0MPC15array5Array4joinGRPC16string10StringViewE(parts, new _M0TPC16string10StringView(_M0FPC15debug14compact__linesN7_2abindS1166, 0, _M0FPC15debug14compact__linesN7_2abindS1166.length))];
        }
      }
    }
  }
}
function _M0MPC15debug7Content7compact(r) {
  return _M0MPC15debug7Content20with__lines__content(r, _M0FPC15debug14compact__lines);
}
function _M0FPC15debug6indent(prefix, r) {
  return _M0FPC15debug11with__lines(r, (lines) => _M0MPC15array5Array3mapGssE(lines, (line) => `${prefix}${line}`));
}
function _M0FPC15debug14indent__spaces(n, r) {
  return _M0FPC15debug6indent(_M0MPC16string6String6repeat(" ", n), r);
}
function _M0FPC15debug19bracket__seq__lines(open, close, indent_by, contents) {
  if (contents.length === 0) {
    return [`${open}${close}`];
  } else {
    if (contents.length === 1) {
      const _item = contents[0];
      if (_item.length > 1) {
        const lines = _M0FPC15debug14indent__spaces(indent_by, new _M0TPC15debug13ContentParens(0, _item)).lines;
        if (!_M0MPC15array5Array9is__emptyGRPB4JsonE(lines)) {
          const last_i = lines.length - 1 | 0;
          _M0MPC15array5Array3setGUssEE(lines, last_i, `${_M0MPC15array5Array2atGRPB4JsonE(lines, last_i)},`);
        }
        const _self = [];
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(_self, open);
        _M0MPC15array5Array10push__iterGsE(_self, _M0MPC15array5Array4iterGUssEE(lines));
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(_self, close);
        return _self;
      } else {
        const inner = _M0FPC15debug14compact__lines(_item);
        if (inner.length === 0) {
          return [`${open}${close}`];
        } else {
          if (inner.length === 1) {
            const _x = inner[0];
            if (open === "{" && close === "}") {
              const inner$2 = _M0MPC16string6String4trim(_x, undefined);
              if (_M0IPC16string10StringViewPB2Eq5equal(inner$2, new _M0TPC16string10StringView(_M0FPC15debug19bracket__seq__linesN7_2abindS1175, 0, _M0FPC15debug19bracket__seq__linesN7_2abindS1175.length))) {
                return ["{}"];
              } else {
                const _string_builder = _M0MPB13StringBuilder21StringBuilder_2einner(4);
                _M0IPB13StringBuilderPB6Logger13write__string(_string_builder, "{ ");
                _M0MPB13StringBuilder13write__objectGRPC16string10StringViewE(_string_builder, inner$2);
                _M0IPB13StringBuilderPB6Logger13write__string(_string_builder, " }");
                return [_M0MPB13StringBuilder10to__string(_string_builder)];
              }
            } else {
              return [`${open}${_x}${close}`];
            }
          } else {
            const _self = [];
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(_self, open);
            _M0MPC15array5Array10push__iterGsE(_self, _M0MPC15array5Array4iterGUssEE(_M0FPC15debug14indent__spaces(indent_by, new _M0TPC15debug13ContentParens(0, _item)).lines));
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(_self, close);
            return _self;
          }
        }
      }
    } else {
      const out = [open];
      const _bind$2 = contents.length;
      let _tmp = 0;
      while (true) {
        const _ = _tmp;
        if (_ < _bind$2) {
          const item = contents[_];
          const item_lines = _M0MPC15array5Array6filterGsE(item, (line) => _M0IP016_24default__implPB2Eq10not__equalGsE(line, ""));
          if (item_lines.length === 0) {
          } else {
            if (item_lines.length === 1) {
              const _x = item_lines[0];
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(out, `${_M0MPC16string6String6repeat(" ", indent_by)}${_x},`);
            } else {
              const _first = item_lines[0];
              const _last = item_lines[item_lines.length - 1 | 0];
              const _x_end = item_lines.length - 1 | 0;
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(out, `${_M0MPC16string6String6repeat(" ", indent_by)}${_first}`);
              const _bind$3 = _x_end - 1 | 0;
              let _tmp$2 = 0;
              while (true) {
                const _$2 = _tmp$2;
                if (_$2 < _bind$3) {
                  const mid = item_lines[1 + _$2 | 0];
                  _M0MPC15array5Array4pushGRPC14json10WriteFrameE(out, `${_M0MPC16string6String6repeat(" ", indent_by)}${mid}`);
                  _tmp$2 = _$2 + 1 | 0;
                  continue;
                } else {
                  break;
                }
              }
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(out, `${_M0MPC16string6String6repeat(" ", indent_by)}${_last},`);
            }
          }
          _tmp = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(out, close);
      return out;
    }
  }
}
function _M0FPC15debug17comma__seq__lines(begin, end, contents) {
  if (begin === "[" && end === "]") {
    return _M0FPC15debug19bracket__seq__lines("[", "]", 2, contents);
  } else {
    if (begin === "{" && end === "}") {
      return _M0FPC15debug19bracket__seq__lines("{", "}", 2, contents);
    } else {
      if (begin === "" && end === "") {
        let lines;
        if (contents.length === 0) {
          lines = [`${begin}${end}`];
        } else {
          if (contents.length === 1) {
            const _item = contents[0];
            lines = _M0FPC15debug15surround__lines(begin, end, _item);
          } else {
            const _first = contents[0];
            const _last = contents[contents.length - 1 | 0];
            const _x_end = contents.length - 1 | 0;
            const space = _M0MPC16string6String6repeat(" ", begin.length);
            const middle_lines = [];
            const _bind$2 = _x_end - 1 | 0;
            let _tmp = 0;
            while (true) {
              const _ = _tmp;
              if (_ < _bind$2) {
                const item = contents[1 + _ | 0];
                const _bind$3 = _M0FPC15debug15surround__lines(space, ",", item);
                _M0MPC15array5Array6appendGsE(middle_lines, new _M0TPB9ArrayViewGsE(_bind$3, 0, _bind$3.length));
                _tmp = _ + 1 | 0;
                continue;
              } else {
                break;
              }
            }
            const _self = [];
            _M0MPC15array5Array10push__iterGsE(_self, _M0MPC15array5Array4iterGUssEE(_M0FPC15debug15surround__lines(begin, ",", _first)));
            _M0MPC15array5Array10push__iterGsE(_self, _M0MPC15array5Array4iterGUssEE(middle_lines));
            _M0MPC15array5Array10push__iterGsE(_self, _M0MPC15array5Array4iterGUssEE(_M0FPC15debug15surround__lines(space, end, _last)));
            lines = _self;
          }
        }
        return _M0MPC15array5Array6filterGsE(lines, (line) => _M0IP016_24default__implPB2Eq10not__equalGsE(line, ""));
      } else {
        if (contents.length === 0) {
          return [`${begin}${end}`];
        } else {
          if (contents.length === 1) {
            const _item = contents[0];
            const item_lines = _M0MPC15array5Array6filterGsE(_item, (line) => _M0IP016_24default__implPB2Eq10not__equalGsE(line, ""));
            if (item_lines.length === 0) {
              return [`${begin}${end}`];
            } else {
              if (item_lines.length === 1) {
                const _x = item_lines[0];
                return [`${begin}${_x}${end}`];
              } else {
                const _last_line = item_lines[item_lines.length - 1 | 0];
                const _x = new _M0TPB9ArrayViewGsE(item_lines, 0, item_lines.length - 1 | 0);
                const _self = [];
                _M0MPC15array5Array4pushGRPC14json10WriteFrameE(_self, begin);
                _M0MPC15array5Array10push__iterGsE(_self, _M0MPB4Iter4iterGsE(_M0MPB4Iter3mapGRP211localreview3tcl7CommandsE(_M0MPC15array9ArrayView4iterGsE(_x), (line) => `${_M0MPC16string6String6repeat(" ", 2)}${line}`)));
                _M0MPC15array5Array4pushGRPC14json10WriteFrameE(_self, `${_M0MPC16string6String6repeat(" ", 2)}${_last_line},`);
                _M0MPC15array5Array4pushGRPC14json10WriteFrameE(_self, end);
                return _self;
              }
            }
          } else {
            const out = [begin];
            const _bind$2 = contents.length;
            let _tmp = 0;
            while (true) {
              const _ = _tmp;
              if (_ < _bind$2) {
                const item = contents[_];
                const item_lines = _M0MPC15array5Array6filterGsE(item, (line) => _M0IP016_24default__implPB2Eq10not__equalGsE(line, ""));
                if (item_lines.length === 0) {
                } else {
                  if (item_lines.length === 1) {
                    const _x = item_lines[0];
                    _M0MPC15array5Array4pushGRPC14json10WriteFrameE(out, `${_M0MPC16string6String6repeat(" ", 2)}${_x},`);
                  } else {
                    const _first = item_lines[0];
                    const _last = item_lines[item_lines.length - 1 | 0];
                    const _x_end = item_lines.length - 1 | 0;
                    _M0MPC15array5Array4pushGRPC14json10WriteFrameE(out, `${_M0MPC16string6String6repeat(" ", 2)}${_first}`);
                    const _bind$3 = _x_end - 1 | 0;
                    let _tmp$2 = 0;
                    while (true) {
                      const _$2 = _tmp$2;
                      if (_$2 < _bind$3) {
                        const mid = item_lines[1 + _$2 | 0];
                        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(out, `${_M0MPC16string6String6repeat(" ", 2)}${mid}`);
                        _tmp$2 = _$2 + 1 | 0;
                        continue;
                      } else {
                        break;
                      }
                    }
                    _M0MPC15array5Array4pushGRPC14json10WriteFrameE(out, `${_M0MPC16string6String6repeat(" ", 2)}${_last},`);
                  }
                }
                _tmp = _ + 1 | 0;
                continue;
              } else {
                break;
              }
            }
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(out, end);
            return out;
          }
        }
      }
    }
  }
}
function _M0FPC15debug10comma__seq(begin, end, contents) {
  const _bind$2 = contents.length;
  let _tmp = 0;
  let _tmp$2 = 0;
  while (true) {
    const _ = _tmp;
    const size = _tmp$2;
    if (_ < _bind$2) {
      const c = contents[_];
      _tmp = _ + 1 | 0;
      _tmp$2 = size + c.size | 0;
      continue;
    } else {
      return new _M0TPC15debug7Content(size, _M0FPC15debug17comma__seq__lines(begin, end, _M0MPC15array5Array3mapGRPC15debug13ContentParensRPB5ArrayGsEE(contents, (c) => c.lines)), false);
    }
  }
}
function _M0FPC15debug14print__content(r) {
  return _M0MPC15array5Array4joinGsE(r.lines, new _M0TPC16string10StringView(_M0FPC15debug14print__contentN7_2abindS1244, 0, _M0FPC15debug14print__contentN7_2abindS1244.length));
}
function _M0FPC15debug14with__resizing(_root_size, threshold, rendered_children) {
  if (threshold <= 0) {
    return rendered_children;
  } else {
    const compacted = _M0MPC15debug7Content7compact(rendered_children);
    return _M0MPC15array5Array3allGsE(compacted.lines, (line) => line.length <= threshold) ? compacted : rendered_children;
  }
}
function _M0MPC15debug4Repr17info__adds__depth(info) {
  let _tmp;
  switch (info.$tag) {
    case 12: {
      _tmp = true;
      break;
    }
    case 13: {
      _tmp = true;
      break;
    }
    case 16: {
      _tmp = true;
      break;
    }
    default: {
      _tmp = false;
    }
  }
  return !_tmp;
}
function _M0MPC15debug4Repr19prune__info_2einnerN2goS259(replacement, d, node) {
  const children = _M0MPC15debug4Repr8children(node);
  if (d <= 0) {
    return _M0MPC15array5Array9is__emptyGRPB4JsonE(children) ? node : !_M0MPC15debug4Repr17info__adds__depth(node) ? _M0MPC15debug4Repr14with__children(node, _M0MPC15array5Array3mapGRPC15debug4ReprRPC15debug4ReprE(children, (child) => _M0MPC15debug4Repr19prune__info_2einnerN2goS259(replacement, d, child))) : replacement;
  } else {
    if (_M0MPC15array5Array9is__emptyGRPB4JsonE(children)) {
      return node;
    } else {
      const next_depth = _M0MPC15debug4Repr17info__adds__depth(node) ? d - 1 | 0 : d;
      return _M0MPC15debug4Repr14with__children(node, _M0MPC15array5Array3mapGRPC15debug4ReprRPC15debug4ReprE(children, (child) => _M0MPC15debug4Repr19prune__info_2einnerN2goS259(replacement, next_depth, child)));
    }
  }
}
function _M0MPC15debug4Repr19prune__info_2einner(self, replacement, max_depth) {
  if (max_depth === undefined) {
    return self;
  } else {
    const _Some = max_depth;
    const _depth = _Some;
    return _M0MPC15debug4Repr19prune__info_2einnerN2goS259(replacement, _M0MPC13int3Int3max(1, _depth), self);
  }
}
function _M0MPC15debug4Repr11prune__info(self, replacement$46$opt, max_depth) {
  let replacement;
  if (replacement$46$opt === undefined) {
    replacement = _M0MPC15debug4Repr7omitted();
  } else {
    const _Some = replacement$46$opt;
    replacement = _Some;
  }
  return _M0MPC15debug4Repr19prune__info_2einner(self, replacement, max_depth);
}
function _M0FPC15debug10info__size(info) {
  switch (info.$tag) {
    case 0: {
      return 1;
    }
    case 1: {
      return 1;
    }
    case 2: {
      return 1;
    }
    case 3: {
      return 1;
    }
    case 4: {
      return 1;
    }
    case 5: {
      return 1;
    }
    case 6: {
      const _StringLit = info;
      const _s = _StringLit._0;
      return _s.length <= 15 ? 1 : 2;
    }
    case 7: {
      return 1;
    }
    case 8: {
      return 1;
    }
    case 9: {
      return 2;
    }
    case 12: {
      const _RecordField = info;
      const _name = _RecordField._0;
      return _name.length <= 15 ? 0 : 1;
    }
    case 13: {
      const _EnumLabeledArg = info;
      const _name$2 = _EnumLabeledArg._0;
      return _name$2.length <= 15 ? 0 : 1;
    }
    case 10: {
      const _Enum = info;
      const _name$3 = _Enum._0;
      return _name$3.length <= 15 ? 1 : 2;
    }
    case 14: {
      const _Opaque = info;
      const _name$4 = _Opaque._0;
      return _name$4.length <= 15 ? 1 : 2;
    }
    case 15: {
      const _Literal = info;
      const _s$2 = _Literal._0;
      return _s$2.length <= 15 ? 1 : 2;
    }
    case 11: {
      return 2;
    }
    case 16: {
      return 0;
    }
    default: {
      return 0;
    }
  }
}
function _M0FPC15debug17is__unquoted__key(key) {
  let rest;
  _L: {
    if (key.length >= 1) {
      const _x = key.charCodeAt(0);
      if (_x >= 97 && _x <= 122) {
        const _x$2 = new _M0TPC16string10StringView(key, 1, key.length);
        rest = _x$2;
        break _L;
      } else {
        if (_x === 95) {
          const _x$2 = new _M0TPC16string10StringView(key, 1, key.length);
          rest = _x$2;
          break _L;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
  }
  return _M0MPC16string10StringView3all(rest, (c) => c >= 97 && c <= 122 ? true : c >= 65 && c <= 90 ? true : c >= 48 && c <= 57 ? true : c === 95);
}
function _M0FPC15debug20pretty__print__label(name) {
  return _M0FPC15debug17is__unquoted__key(name) ? name : _M0MPC16string6String14escape_2einner(name, true);
}
function _M0MPC15debug4Repr13pretty__print(self, children) {
  switch (self.$tag) {
    case 0: {
      return _M0FPC15debug10comma__seq("(", ")", []);
    }
    case 1: {
      const _Integer = self;
      const _s = _Integer._0;
      let _tmp;
      if (_s.length >= 1) {
        const _x = _s.charCodeAt(0);
        if (_x === 45) {
          _tmp = 1;
        } else {
          _tmp = 0;
        }
      } else {
        _tmp = 0;
      }
      return _M0FPC15debug10no__parens(_M0FPC15debug15content__parens(_tmp, [_s]));
    }
    case 2: {
      const _DoubleLit = self;
      const _x = _DoubleLit._0;
      const needs_parens = 1 / _x < 0;
      return _M0FPC15debug12leaf_2einner(String(_x), needs_parens);
    }
    case 3: {
      const _FloatLit = self;
      const _x$2 = _FloatLit._0;
      const needs_parens$2 = Math.fround(Math.fround(1) / _x$2) < Math.fround(0);
      return _M0FPC15debug12leaf_2einner(_M0IPC15float5FloatPB4Show10to__string(_x$2), needs_parens$2);
    }
    case 4: {
      const _BoolLit = self;
      const _x$3 = _BoolLit._0;
      return _M0FPC15debug12leaf_2einner(_M0IPC14bool4BoolPB4Show10to__string(_x$3), false);
    }
    case 5: {
      const _CharLit = self;
      const _x$4 = _CharLit._0;
      return _M0FPC15debug12leaf_2einner(_M0MPC14char4Char14escape_2einner(_x$4, true), false);
    }
    case 6: {
      const _StringLit = self;
      const _x$5 = _StringLit._0;
      return _M0FPC15debug10no__parens(_M0FPC15debug8verbatim(_M0MPC16string6String14escape_2einner(_x$5, true)));
    }
    case 7: {
      return _M0FPC15debug10comma__seq("(", ")", _M0MPC15array5Array3mapGRPC15debug7ContentRPC15debug13ContentParensE(children, (x) => _M0MPC15debug7Content8no__wrap(x)));
    }
    case 10: {
      const _Enum = self;
      const _name = _Enum._0;
      return children.length === 0 ? _M0FPC15debug10no__parens(_M0FPC15debug8verbatim(_name)) : _name === "Tuple" ? _M0FPC15debug10comma__seq("(", ")", _M0MPC15array5Array3mapGRPC15debug7ContentRPC15debug13ContentParensE(children, (x) => _M0MPC15debug7Content8no__wrap(x))) : _M0FPC15debug10comma__seq(`${_name}(`, ")", _M0MPC15array5Array3mapGRPC15debug7ContentRPC15debug13ContentParensE(children, (x) => _M0MPC15debug7Content8no__wrap(x)));
    }
    case 8: {
      return _M0FPC15debug10comma__seq("[", "]", _M0MPC15array5Array3mapGRPC15debug7ContentRPC15debug13ContentParensE(children, (x) => _M0MPC15debug7Content8no__wrap(x)));
    }
    case 9: {
      return _M0FPC15debug10comma__seq("{", "}", _M0MPC15array5Array3mapGRPC15debug7ContentRPC15debug13ContentParensE(children, (x) => _M0MPC15debug7Content8no__wrap(x)));
    }
    case 14: {
      const _Opaque = self;
      const _name$2 = _Opaque._0;
      if (_M0MPC15array5Array9is__emptyGRPB4JsonE(children)) {
        return _M0FPC15debug10no__parens(_M0FPC15debug8surround("<", ">", _M0FPC15debug8verbatim(_name$2)));
      } else {
        const body = _M0IPC15debug13ContentParensPB3Add3add(_M0FPC15debug8verbatim(`${_name$2}:`), _M0FPC15debug6indent("  ", _M0MPC15debug7Content8no__wrap(_M0FPC15debug10comma__seq("", "", _M0MPC15array5Array3mapGRPC15debug7ContentRPC15debug13ContentParensE(children, (x) => _M0MPC15debug7Content8no__wrap(x))))));
        return _M0FPC15debug10no__parens(_M0FPC15debug8surround("<", ">", body));
      }
    }
    case 15: {
      const _Literal = self;
      const _str = _Literal._0;
      return _M0FPC15debug10no__parens(_M0FPC15debug8verbatim(_str));
    }
    case 11: {
      return _M0FPC15debug10comma__seq("{", "}", _M0MPC15array5Array3mapGRPC15debug7ContentRPC15debug13ContentParensE(children, (x) => _M0MPC15debug7Content8no__wrap(x)));
    }
    case 16: {
      if (children.length === 2) {
        const _key = children[0];
        const _val = children[1];
        const k = _M0MPC15debug7Content8no__wrap(_key);
        const v = _M0MPC15debug7Content8no__wrap(_val);
        const _bind$2 = v.lines;
        if (_bind$2.length === 0) {
          return _M0FPC15debug14empty__content();
        } else {
          if (_bind$2.length === 1) {
            const _one = _bind$2[0];
            return _M0FPC15debug10no__parens(_M0FPC15debug15content__parens((1 + k.size | 0) + v.size | 0, [`${_M0FPC15debug14print__content(_M0FPC15debug8surround("", ": ", k))}${_one}`]));
          } else {
            const _first = _bind$2[0];
            const _x$6 = new _M0TPB9ArrayViewGsE(_bind$2, 1, _bind$2.length);
            const head = `${_M0FPC15debug14print__content(_M0FPC15debug8surround("", ": ", k))}${_first}`;
            const _tmp$2 = (1 + k.size | 0) + v.size | 0;
            const _self = [];
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(_self, head);
            _M0MPC15array5Array10push__iterGsE(_self, _M0MPC15array9ArrayView4iterGsE(_x$6));
            return _M0FPC15debug10no__parens(_M0FPC15debug15content__parens(_tmp$2, _self));
          }
        }
      } else {
        return _M0FPC15debug14empty__content();
      }
    }
    case 13: {
      const _EnumLabeledArg = self;
      const _name$3 = _EnumLabeledArg._0;
      if (children.length === 1) {
        const _val = children[0];
        const _bind$2 = _val.lines;
        if (_bind$2.length === 0) {
          return _M0FPC15debug14empty__content();
        } else {
          if (_bind$2.length === 1) {
            const _first = _bind$2[0];
            return _M0FPC15debug10no__parens(_M0FPC15debug15content__parens(1 + _val.size | 0, [`${_name$3}=${_first}`]));
          } else {
            const _first = _bind$2[0];
            const _x$6 = new _M0TPB9ArrayViewGsE(_bind$2, 1, _bind$2.length);
            const _tmp$2 = 1 + _val.size | 0;
            const _self = [];
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(_self, `${_name$3}=${_first}`);
            _M0MPC15array5Array10push__iterGsE(_self, _M0MPC15array9ArrayView4iterGsE(_x$6));
            return _M0FPC15debug10no__parens(_M0FPC15debug15content__parens(_tmp$2, _self));
          }
        }
      } else {
        return _M0FPC15debug14empty__content();
      }
    }
    case 12: {
      const _RecordField = self;
      const _name$4 = _RecordField._0;
      if (children.length === 1) {
        const _val = children[0];
        const label = _M0FPC15debug20pretty__print__label(_name$4);
        const v = _M0MPC15debug7Content8no__wrap(_val);
        const _bind$2 = v.lines;
        if (_bind$2.length === 0) {
          return _M0FPC15debug14empty__content();
        } else {
          if (_bind$2.length === 1) {
            const _one = _bind$2[0];
            return _M0FPC15debug10no__parens(_M0FPC15debug15content__parens(1 + v.size | 0, [`${label}: ${_one}`]));
          } else {
            const _first = _bind$2[0];
            const _x$6 = new _M0TPB9ArrayViewGsE(_bind$2, 1, _bind$2.length);
            const _tmp$2 = 1 + v.size | 0;
            const _self = [];
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(_self, `${label}: ${_first}`);
            _M0MPC15array5Array10push__iterGsE(_self, _M0MPC15array9ArrayView4iterGsE(_x$6));
            return _M0FPC15debug10no__parens(_M0FPC15debug15content__parens(_tmp$2, _self));
          }
        }
      } else {
        return _M0FPC15debug14empty__content();
      }
    }
    default: {
      return _M0FPC15debug6parens(_M0FPC15debug8verbatim("..."));
    }
  }
}
function _M0MPC15debug4Repr12render__repr(self, threshold) {
  const label = _M0MPC15debug4Repr7shallow(self);
  const children = _M0MPC15array5Array3mapGRPC15debug4ReprRPC15debug7ContentE(_M0MPC15debug4Repr8children(self), (child) => _M0MPC15debug4Repr12render__repr(child, threshold));
  return _M0FPC15debug14with__resizing(_M0FPC15debug10info__size(label), threshold, _M0MPC15debug4Repr13pretty__print(label, children));
}
function _M0FPC15debug6render(r, max_depth) {
  const max_depth$2 = max_depth === undefined ? _M0FPC15debug6renderN6constrS1705 : max_depth;
  const info = _M0MPC15debug4Repr11prune__info(r, undefined, max_depth$2);
  return _M0FPC15debug14print__content(_M0MPC15debug7Content8no__wrap(_M0MPC15debug4Repr12render__repr(info, 70)));
}
function _M0IPC15debug4ReprPB4Show6output(self, logger) {
  logger.method_table.method_0(logger.self, _M0FPC15debug6render(self, undefined));
}
function _M0IPC13int3IntPC15debug5Debug8to__repr(self) {
  return _M0MPC15debug4Repr7integer(_M0MPC13int3Int18to__string_2einner(self, 10));
}
function _M0IPC14bool4BoolPC15debug5Debug8to__repr(self) {
  return _M0MPC15debug4Repr4bool(self);
}
function _M0IPC16string6StringPC15debug5Debug8to__repr(self) {
  return _M0MPC15debug4Repr6string(self);
}
function _M0IPC15array5ArrayPC15debug5Debug8to__reprGUssEE(self) {
  return _M0MPC15debug4Repr5array(_M0MPC15array5Array3mapGUssERPC15debug4ReprE(self, (x) => _M0MPC15debug4Repr4ReprGUssEE(x)));
}
function _M0MPC13ref3Ref3RefGRPB5ArrayGUssEEE(x) {
  return new _M0TPC13ref3RefGRPB5ArrayGUssEEE(x);
}
function _M0MPC13ref3Ref3RefGsE(x) {
  return new _M0TPC13ref3RefGsE(x);
}
function _M0MPC13ref3Ref3RefGiE(x) {
  return new _M0TPC13ref3RefGiE(x);
}
function _M0FPC28internal7strconv10range__errGuE() {
  return new _M0DTPC16result6ResultGuRPB7FailureE3Err(new _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(_M0FPC28internal7strconv15range__err__str));
}
function _M0FPC28internal7strconv11syntax__errGdE() {
  return new _M0DTPC16result6ResultGdRPB7FailureE3Err(new _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(_M0FPC28internal7strconv16syntax__err__str));
}
function _M0FPC28internal7strconv11syntax__errGORPC28internal7strconv6NumberE() {
  return new _M0DTPC16result6ResultGORPC28internal7strconv6NumberRPB7FailureE3Err(new _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(_M0FPC28internal7strconv16syntax__err__str));
}
function _M0FPC28internal7strconv11syntax__errGuE() {
  return new _M0DTPC16result6ResultGuRPB7FailureE3Err(new _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(_M0FPC28internal7strconv16syntax__err__str));
}
function _M0FPC28internal7strconv11syntax__errGRPC16string10StringViewE() {
  return new _M0DTPC16result6ResultGRPC16string10StringViewRPB7FailureE3Err(new _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(_M0FPC28internal7strconv16syntax__err__str));
}
function _M0EPC16string10StringViewPC28internal7strconv12fold__digitsGmE(self, init, f) {
  let _tmp = self;
  let _tmp$2 = init;
  let _tmp$3 = 0;
  while (true) {
    const str = _tmp;
    const ret = _tmp$2;
    const len = _tmp$3;
    _L: {
      if ((str.end - str.start | 0) >= 1) {
        const _x = str.str.charCodeAt(str.start);
        if (_x >= 48 && _x <= 57) {
          const _x$2 = new _M0TPC16string10StringView(str.str, str.start + 1 | 0, str.end);
          _tmp = _x$2;
          _tmp$2 = f(_x - 48 | 0, ret);
          _tmp$3 = len + 1 | 0;
          continue;
        } else {
          if (_x === 95) {
            const _x$2 = new _M0TPC16string10StringView(str.str, str.start + 1 | 0, str.end);
            _tmp = _x$2;
            continue;
          } else {
            break _L;
          }
        }
      } else {
        break _L;
      }
    }
    return { _0: str, _1: ret, _2: len };
  }
}
function _M0FPC28internal7strconv13parse__digits(s, x) {
  return _M0EPC16string10StringViewPC28internal7strconv12fold__digitsGmE(s, x, (digit, acc) => BigInt.asUintN(64, BigInt.asUintN(64, acc * 10n) + BigInt.asUintN(64, BigInt(digit >>> 0))));
}
function _M0FPC28internal7strconv20try__parse__19digits(s, x) {
  let x$2 = x;
  let len = 0;
  let _tmp = s;
  while (true) {
    const s$2 = _tmp;
    let s$3;
    _L: {
      if ((s$2.end - s$2.start | 0) >= 1) {
        const _x = s$2.str.charCodeAt(s$2.start);
        if (_x >= 48 && _x <= 57) {
          const _x$2 = new _M0TPC16string10StringView(s$2.str, s$2.start + 1 | 0, s$2.end);
          if (BigInt.asUintN(64, x$2) < BigInt.asUintN(64, _M0FPC28internal7strconv17min__19digit__int)) {
            len = len + 1 | 0;
            x$2 = BigInt.asUintN(64, BigInt.asUintN(64, x$2 * 10n) + BigInt.asUintN(64, BigInt((_x - 48 | 0) >>> 0)));
            _tmp = _x$2;
            continue;
          } else {
            s$3 = s$2;
            break _L;
          }
        } else {
          if (_x === 95) {
            const _x$2 = new _M0TPC16string10StringView(s$2.str, s$2.start + 1 | 0, s$2.end);
            _tmp = _x$2;
            continue;
          } else {
            s$3 = s$2;
            break _L;
          }
        }
      } else {
        s$3 = s$2;
        break _L;
      }
    }
    return { _0: s$3, _1: x$2, _2: len };
  }
}
function _M0FPC28internal7strconv17parse__scientific(s) {
  let s$2 = s;
  let neg_exp = false;
  let rest;
  let ch;
  _L: {
    _L$2: {
      const _bind$2 = s$2;
      if ((_bind$2.end - _bind$2.start | 0) >= 1) {
        const _x = _bind$2.str.charCodeAt(_bind$2.start);
        switch (_x) {
          case 43: {
            const _x$2 = new _M0TPC16string10StringView(_bind$2.str, _bind$2.start + 1 | 0, _bind$2.end);
            rest = _x$2;
            ch = _x;
            break _L$2;
          }
          case 45: {
            const _x$3 = new _M0TPC16string10StringView(_bind$2.str, _bind$2.start + 1 | 0, _bind$2.end);
            rest = _x$3;
            ch = _x;
            break _L$2;
          }
        }
      }
      break _L;
    }
    neg_exp = ch === 45;
    s$2 = rest;
  }
  _L$2: {
    const _bind$2 = s$2;
    if ((_bind$2.end - _bind$2.start | 0) >= 1) {
      const _x = _bind$2.str.charCodeAt(_bind$2.start);
      if (_x >= 48 && _x <= 57) {
        const _bind$3 = _M0EPC16string10StringViewPC28internal7strconv12fold__digitsGmE(s$2, _M0FPC28internal7strconv17parse__scientificN8exp__numS354, (digit, exp_num) => BigInt.asIntN(64, exp_num) < BigInt.asIntN(64, 65536n) ? BigInt.asUintN(64, BigInt.asUintN(64, 10n * exp_num) + BigInt.asUintN(64, BigInt(digit))) : exp_num);
        const _s = _bind$3._0;
        const _exp_num = _bind$3._1;
        return neg_exp ? { _0: _s, _1: BigInt.asUintN(64, -_exp_num) } : { _0: _s, _1: _exp_num };
      } else {
        break _L$2;
      }
    } else {
      break _L$2;
    }
  }
  return undefined;
}
function _M0FPC28internal7strconv13parse__number(s) {
  let s$2;
  let negative;
  _L: {
    let rest;
    _L$2: {
      if ((s.end - s.start | 0) >= 1) {
        const _x = s.str.charCodeAt(s.start);
        switch (_x) {
          case 45: {
            const _x$2 = new _M0TPC16string10StringView(s.str, s.start + 1 | 0, s.end);
            s$2 = _x$2;
            negative = true;
            break _L;
          }
          case 43: {
            const _x$3 = new _M0TPC16string10StringView(s.str, s.start + 1 | 0, s.end);
            rest = _x$3;
            break _L$2;
          }
          default: {
            rest = s;
            break _L$2;
          }
        }
      } else {
        rest = s;
        break _L$2;
      }
    }
    s$2 = rest;
    negative = false;
    break _L;
  }
  if (_M0MPC16string10StringView9is__empty(s$2)) {
    return new _M0DTPC16result6ResultGORPC28internal7strconv6NumberRPC15error5ErrorE2Ok(undefined);
  }
  const _bind$2 = _M0FPC28internal7strconv13parse__digits(s$2, 0n);
  const _s = _bind$2._0;
  const _mantissa = _bind$2._1;
  const _consumed = _bind$2._2;
  let mantissa = _mantissa;
  let s$3 = _s;
  let n_digits = _consumed;
  let n_after_dot = 0;
  let exponent = 0n;
  const _bind$3 = s$3;
  if ((_bind$3.end - _bind$3.start | 0) >= 1) {
    const _x = _bind$3.str.charCodeAt(_bind$3.start);
    if (_x === 46) {
      const _x$2 = new _M0TPC16string10StringView(_bind$3.str, _bind$3.start + 1 | 0, _bind$3.end);
      s$3 = _x$2;
      const _bind$4 = _M0FPC28internal7strconv13parse__digits(s$3, mantissa);
      const _new_s = _bind$4._0;
      const _new_mantissa = _bind$4._1;
      const _consumed_digit = _bind$4._2;
      s$3 = _new_s;
      mantissa = _new_mantissa;
      n_after_dot = _consumed_digit;
      exponent = BigInt.asUintN(64, -BigInt.asUintN(64, BigInt(n_after_dot)));
    }
  }
  n_digits = n_digits + n_after_dot | 0;
  if (n_digits === 0) {
    return new _M0DTPC16result6ResultGORPC28internal7strconv6NumberRPC15error5ErrorE2Ok(undefined);
  }
  let exp_number = 0n;
  let rest;
  _L$2: {
    _L$3: {
      const _bind$4 = s$3;
      if ((_bind$4.end - _bind$4.start | 0) >= 1) {
        const _x = _bind$4.str.charCodeAt(_bind$4.start);
        switch (_x) {
          case 101: {
            const _x$2 = new _M0TPC16string10StringView(_bind$4.str, _bind$4.start + 1 | 0, _bind$4.end);
            rest = _x$2;
            break _L$3;
          }
          case 69: {
            const _x$3 = new _M0TPC16string10StringView(_bind$4.str, _bind$4.start + 1 | 0, _bind$4.end);
            rest = _x$3;
            break _L$3;
          }
        }
      }
      break _L$2;
    }
    const _bind$4 = _M0FPC28internal7strconv17parse__scientific(rest);
    let _bind$5;
    if (_bind$4 === undefined) {
      return new _M0DTPC16result6ResultGORPC28internal7strconv6NumberRPC15error5ErrorE2Ok(undefined);
    } else {
      const _Some = _bind$4;
      _bind$5 = _Some;
    }
    const _new_s = _bind$5._0;
    const _exp_number_val = _bind$5._1;
    s$3 = _new_s;
    exp_number = _exp_number_val;
    exponent = BigInt.asUintN(64, exponent + exp_number);
  }
  const _bind$4 = s$3;
  if ((_bind$4.end - _bind$4.start | 0) === 0) {
    if (n_digits <= 19) {
      return new _M0DTPC16result6ResultGORPC28internal7strconv6NumberRPC15error5ErrorE2Ok(new _M0TPC28internal7strconv6Number(exponent, mantissa, negative, false));
    }
    n_digits = n_digits - 19 | 0;
    let many_digits = false;
    let _tmp = s.str;
    let _tmp$2 = s.start;
    let _tmp$3 = s.end;
    _L$3: while (true) {
      const s_str = _tmp;
      const s_start = _tmp$2;
      const s_end = _tmp$3;
      _L$4: {
        let rest$2;
        let ch;
        _L$5: {
          if ((s_end - s_start | 0) >= 1) {
            const _x = s_str.charCodeAt(s_start);
            switch (_x) {
              case 48: {
                const _x$2 = new _M0TPC16string10StringView(s_str, s_start + 1 | 0, s_end);
                rest$2 = _x$2;
                ch = _x;
                break _L$5;
              }
              case 46: {
                const _x$3 = new _M0TPC16string10StringView(s_str, s_start + 1 | 0, s_end);
                rest$2 = _x$3;
                ch = _x;
                break _L$5;
              }
              default: {
                break _L$4;
              }
            }
          } else {
            break _L$4;
          }
        }
        const _tmp$4 = n_digits;
        if (2 === 0) {
          $panic();
        }
        n_digits = _tmp$4 - ((ch - 46 | 0) / 2 | 0) | 0;
        _tmp = rest$2.str;
        _tmp$2 = rest$2.start;
        _tmp$3 = rest$2.end;
        continue;
      }
      break;
    }
    let mantissa$2 = mantissa;
    if (n_digits > 0) {
      many_digits = true;
      mantissa$2 = 0n;
      const _bind$5 = _M0FPC28internal7strconv20try__parse__19digits(s, mantissa$2);
      const _s$2 = _bind$5._0;
      const _new_mantissa = _bind$5._1;
      const _consumed_digit = _bind$5._2;
      mantissa$2 = _new_mantissa;
      let _tmp$4;
      if (BigInt.asUintN(64, mantissa$2) >= BigInt.asUintN(64, _M0FPC28internal7strconv17min__19digit__int)) {
        _tmp$4 = _consumed_digit;
      } else {
        if (_M0MPC16string6String24char__length__ge_2einner(_s$2.str, 1, _s$2.start, _s$2.end)) {
          const _tmp$5 = _s$2.str;
          const _bind$6 = _M0MPC16string6String29offset__of__nth__char_2einner(_s$2.str, 1, _s$2.start, _s$2.end);
          let _tmp$6;
          if (_bind$6 === undefined) {
            _tmp$6 = _s$2.end;
          } else {
            const _Some = _bind$6;
            _tmp$6 = _Some;
          }
          const _x = new _M0TPC16string10StringView(_tmp$5, _tmp$6, _s$2.end);
          const _bind$7 = _M0FPC28internal7strconv20try__parse__19digits(_x, mantissa$2);
          const _new_mantissa$2 = _bind$7._1;
          const _consumed_digit$2 = _bind$7._2;
          mantissa$2 = _new_mantissa$2;
          _tmp$4 = _consumed_digit$2;
        } else {
          return new _M0DTPC16result6ResultGORPC28internal7strconv6NumberRPC15error5ErrorE2Ok(undefined);
        }
      }
      exponent = BigInt.asUintN(64, BigInt(_tmp$4));
      exponent = BigInt.asUintN(64, exponent + exp_number);
    }
    return new _M0DTPC16result6ResultGORPC28internal7strconv6NumberRPC15error5ErrorE2Ok(new _M0TPC28internal7strconv6Number(exponent, mantissa$2, negative, many_digits));
  } else {
    return _M0FPC28internal7strconv11syntax__errGORPC28internal7strconv6NumberE();
  }
}
function _M0FPC28internal7strconv15parse__inf__nan(rest) {
  let pos;
  let rest$2;
  _L: {
    let rest$3;
    _L$2: {
      if ((rest.end - rest.start | 0) >= 1) {
        const _x = rest.str.charCodeAt(rest.start);
        switch (_x) {
          case 45: {
            const _x$2 = new _M0TPC16string10StringView(rest.str, rest.start + 1 | 0, rest.end);
            pos = false;
            rest$2 = _x$2;
            break _L;
          }
          case 43: {
            const _x$3 = new _M0TPC16string10StringView(rest.str, rest.start + 1 | 0, rest.end);
            rest$3 = _x$3;
            break _L$2;
          }
          default: {
            rest$3 = rest;
            break _L$2;
          }
        }
      } else {
        rest$3 = rest;
        break _L$2;
      }
    }
    pos = true;
    rest$2 = rest$3;
    break _L;
  }
  let _cursor_295 = 0;
  const _input_end_297 = rest$2.end - rest$2.start | 0;
  const _start_296 = _cursor_295;
  let _accept_state_298 = -1;
  let _match_end_299 = -1;
  let _state_300 = 2;
  while (true) {
    if (_state_300 !== 14) {
      if (_state_300 < 2) {
        _accept_state_298 = _state_300;
        _match_end_299 = _cursor_295;
      }
      const _tmp = Math.imul(_state_300, 8) | 0;
      let _next_char_303;
      if (_cursor_295 < _input_end_297) {
        const _char_302 = rest$2.str.charCodeAt(rest$2.start + _cursor_295 | 0);
        _cursor_295 = _cursor_295 + 1 | 0;
        _next_char_303 = _char_302;
      } else {
        _next_char_303 = -1;
      }
      _state_300 = _M0MPC15array13ReadOnlyArray11unsafe__getGiE(_M0FPC28internal7strconv15parse__inf__nanN25_2atransition__table__304S312, _tmp + (_next_char_303 < 90 ? (_next_char_303 < 73 ? (_next_char_303 < 66 ? (_next_char_303 < 0 ? 0 : _next_char_303 > 64 ? 1 : 7) : _next_char_303 > 69 ? (_next_char_303 < 71 ? 2 : 7) : 7) : _next_char_303 > 73 ? (_next_char_303 < 84 ? (_next_char_303 < 78 ? 7 : _next_char_303 > 78 ? 7 : 4) : _next_char_303 > 84 ? (_next_char_303 < 89 ? 7 : 6) : 5) : 3) : _next_char_303 > 96 ? (_next_char_303 < 110 ? (_next_char_303 < 103 ? (_next_char_303 < 98 ? 1 : _next_char_303 > 101 ? 2 : 7) : _next_char_303 > 104 ? (_next_char_303 < 106 ? 3 : 7) : 7) : _next_char_303 > 110 ? (_next_char_303 < 117 ? (_next_char_303 < 116 ? 7 : 5) : _next_char_303 > 120 ? (_next_char_303 < 122 ? 6 : 7) : 7) : 4) : 7) | 0);
      continue;
    } else {
      break;
    }
  }
  const _bind$2 = _accept_state_298;
  switch (_bind$2) {
    case 0: {
      _cursor_295 = _match_end_299;
      return new _M0DTPC16result6ResultGdRPC15error5ErrorE2Ok(_M0FPC16double14not__a__number);
    }
    case 1: {
      _cursor_295 = _match_end_299;
      return pos ? new _M0DTPC16result6ResultGdRPC15error5ErrorE2Ok(_M0FPC16double8infinity) : new _M0DTPC16result6ResultGdRPC15error5ErrorE2Ok(_M0FPC16double13neg__infinity);
    }
    default: {
      _cursor_295 = _start_296;
      return _M0FPC28internal7strconv11syntax__errGdE();
    }
  }
}
function _M0FPC28internal7strconv12checked__mul(a, b) {
  if (BigInt.asUintN(64, a) === BigInt.asUintN(64, 0n) || BigInt.asUintN(64, b) === BigInt.asUintN(64, 0n)) {
    return _M0FPC28internal7strconv12checked__mulN6constrS1164;
  }
  if (BigInt.asUintN(64, a) === BigInt.asUintN(64, 1n)) {
    return b;
  }
  if (BigInt.asUintN(64, b) === BigInt.asUintN(64, 1n)) {
    return a;
  }
  if ($i64_clz(b) === 0 || $i64_clz(a) === 0) {
    return undefined;
  }
  if (b === 0n) {
    $panic();
  }
  const quotient = BigInt.asUintN(64, BigInt.asUintN(64, 18446744073709551615n) / BigInt.asUintN(64, b));
  if (BigInt.asUintN(64, a) > BigInt.asUintN(64, quotient)) {
    return undefined;
  }
  return BigInt.asUintN(64, a * b);
}
function _M0FPC28internal7strconv17check__underscore(str) {
  if (_M0MPC16string10StringView20contains__code__unit(str, 95)) {
    let rest;
    if ((str.end - str.start | 0) >= 1) {
      const _x = str.str.charCodeAt(str.start);
      switch (_x) {
        case 43: {
          const _x$2 = new _M0TPC16string10StringView(str.str, str.start + 1 | 0, str.end);
          rest = _x$2;
          break;
        }
        case 45: {
          const _x$3 = new _M0TPC16string10StringView(str.str, str.start + 1 | 0, str.end);
          rest = _x$3;
          break;
        }
        default: {
          rest = str;
        }
      }
    } else {
      rest = str;
    }
    let rest$2;
    let allow_underscore;
    let hex;
    _L: {
      let _cursor_213 = 0;
      const _input_end_215 = rest.end - rest.start | 0;
      const _start_214 = _cursor_213;
      let _accept_state_216 = -1;
      let _match_end_217 = -1;
      let _state_218 = 3;
      while (true) {
        if (_state_218 !== 5) {
          if (_state_218 < 3) {
            _accept_state_216 = _state_218;
            _match_end_217 = _cursor_213;
          }
          const _tmp = Math.imul(_state_218, 5) | 0;
          let _next_char_221;
          if (_cursor_213 < _input_end_215) {
            const _char_220 = rest.str.charCodeAt(rest.start + _cursor_213 | 0);
            _cursor_213 = _cursor_213 + 1 | 0;
            _next_char_221 = _char_220;
          } else {
            _next_char_221 = -1;
          }
          _state_218 = _M0MPC15array13ReadOnlyArray11unsafe__getGiE(_M0FPC28internal7strconv17check__underscoreN25_2atransition__table__222S230, _tmp + (_next_char_221 < 88 ? (_next_char_221 < 66 ? (_next_char_221 < 48 ? 4 : _next_char_221 > 48 ? 4 : 0) : _next_char_221 > 66 ? (_next_char_221 < 79 ? 4 : _next_char_221 > 79 ? 4 : 2) : 1) : _next_char_221 > 88 ? (_next_char_221 < 111 ? (_next_char_221 < 98 ? 4 : _next_char_221 > 98 ? 4 : 1) : _next_char_221 > 111 ? (_next_char_221 < 120 ? 4 : _next_char_221 > 120 ? 4 : 3) : 2) : 3) | 0);
          continue;
        } else {
          break;
        }
      }
      const _bind$2 = _accept_state_216;
      switch (_bind$2) {
        case 0: {
          _cursor_213 = _match_end_217;
          const rest$3 = _M0MPC16string10StringView12view_2einner(rest, _match_end_217, _input_end_215);
          rest$2 = rest$3;
          allow_underscore = true;
          hex = false;
          break _L;
        }
        case 1: {
          _cursor_213 = _match_end_217;
          const rest$4 = _M0MPC16string10StringView12view_2einner(rest, _match_end_217, _input_end_215);
          rest$2 = rest$4;
          allow_underscore = true;
          hex = false;
          break _L;
        }
        case 2: {
          _cursor_213 = _match_end_217;
          const rest$5 = _M0MPC16string10StringView12view_2einner(rest, _match_end_217, _input_end_215);
          rest$2 = rest$5;
          allow_underscore = true;
          hex = true;
          break _L;
        }
        default: {
          _cursor_213 = _start_214;
          rest$2 = rest;
          allow_underscore = false;
          hex = false;
          break _L;
        }
      }
    }
    let _tmp = rest$2.str;
    let _tmp$2 = rest$2.start;
    let _tmp$3 = rest$2.end;
    let _tmp$4 = allow_underscore;
    let _tmp$5 = false;
    while (true) {
      const rest_str = _tmp;
      const rest_start = _tmp$2;
      const rest_end = _tmp$3;
      const allow_underscore$2 = _tmp$4;
      const follow_underscore = _tmp$5;
      let rest$3;
      _L$2: {
        _L$3: {
          let rest$4;
          _L$4: {
            _L$5: {
              let rest$5;
              _L$6: {
                let rest$6;
                _L$7: {
                  if ((rest_end - rest_start | 0) === 0) {
                    return true;
                  } else {
                    if ((rest_end - rest_start | 0) === 1) {
                      const _x = rest_str.charCodeAt(rest_start);
                      if (_x === 95) {
                        return false;
                      } else {
                        if (_x >= 48 && _x <= 57) {
                          const _x$2 = new _M0TPC16string10StringView(rest_str, rest_start + 1 | 0, rest_end);
                          rest$6 = _x$2;
                          break _L$7;
                        } else {
                          if (_x >= 97 && _x <= 102) {
                            const _x$2 = new _M0TPC16string10StringView(rest_str, rest_start + 1 | 0, rest_end);
                            if (hex) {
                              rest$5 = _x$2;
                              break _L$6;
                            } else {
                              if (_x === 101) {
                                if (follow_underscore === true) {
                                  break _L$5;
                                } else {
                                  rest$4 = _x$2;
                                  break _L$4;
                                }
                              } else {
                                if (follow_underscore === true) {
                                  break _L$3;
                                } else {
                                  rest$3 = _x$2;
                                  break _L$2;
                                }
                              }
                            }
                          } else {
                            if (_x >= 65 && _x <= 70) {
                              const _x$2 = new _M0TPC16string10StringView(rest_str, rest_start + 1 | 0, rest_end);
                              if (hex) {
                                rest$5 = _x$2;
                                break _L$6;
                              } else {
                                if (_x === 69) {
                                  if (follow_underscore === true) {
                                    break _L$5;
                                  } else {
                                    rest$4 = _x$2;
                                    break _L$4;
                                  }
                                } else {
                                  if (follow_underscore === true) {
                                    break _L$3;
                                  } else {
                                    rest$3 = _x$2;
                                    break _L$2;
                                  }
                                }
                              }
                            } else {
                              if (_x === 46) {
                                if (follow_underscore === true) {
                                  break _L$5;
                                } else {
                                  const _x$2 = new _M0TPC16string10StringView(rest_str, rest_start + 1 | 0, rest_end);
                                  rest$4 = _x$2;
                                  break _L$4;
                                }
                              } else {
                                if (_x === 43) {
                                  if (follow_underscore === true) {
                                    break _L$5;
                                  } else {
                                    const _x$2 = new _M0TPC16string10StringView(rest_str, rest_start + 1 | 0, rest_end);
                                    rest$4 = _x$2;
                                    break _L$4;
                                  }
                                } else {
                                  if (_x === 45) {
                                    if (follow_underscore === true) {
                                      break _L$5;
                                    } else {
                                      const _x$2 = new _M0TPC16string10StringView(rest_str, rest_start + 1 | 0, rest_end);
                                      rest$4 = _x$2;
                                      break _L$4;
                                    }
                                  } else {
                                    if (follow_underscore === true) {
                                      break _L$3;
                                    } else {
                                      const _bind$2 = _M0MPC16string6String29offset__of__nth__char_2einner(rest_str, 1, rest_start, rest_end);
                                      let _tmp$6;
                                      if (_bind$2 === undefined) {
                                        _tmp$6 = rest_end;
                                      } else {
                                        const _Some = _bind$2;
                                        _tmp$6 = _Some;
                                      }
                                      const _x$2 = new _M0TPC16string10StringView(rest_str, _tmp$6, rest_end);
                                      rest$3 = _x$2;
                                      break _L$2;
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    } else {
                      const _x = rest_str.charCodeAt(rest_start);
                      if (_x === 95) {
                        if (allow_underscore$2 === false) {
                          return false;
                        } else {
                          const _bind$2 = rest_start + 1 | 0;
                          _tmp$2 = _bind$2;
                          _tmp$4 = false;
                          _tmp$5 = true;
                          continue;
                        }
                      } else {
                        if (_x >= 48 && _x <= 57) {
                          const _x$2 = new _M0TPC16string10StringView(rest_str, rest_start + 1 | 0, rest_end);
                          rest$6 = _x$2;
                          break _L$7;
                        } else {
                          if (_x >= 97 && _x <= 102) {
                            const _x$2 = new _M0TPC16string10StringView(rest_str, rest_start + 1 | 0, rest_end);
                            if (hex) {
                              rest$5 = _x$2;
                              break _L$6;
                            } else {
                              if (_x === 101) {
                                if (follow_underscore === true) {
                                  break _L$5;
                                } else {
                                  rest$4 = _x$2;
                                  break _L$4;
                                }
                              } else {
                                if (follow_underscore === true) {
                                  break _L$3;
                                } else {
                                  rest$3 = _x$2;
                                  break _L$2;
                                }
                              }
                            }
                          } else {
                            if (_x >= 65 && _x <= 70) {
                              const _x$2 = new _M0TPC16string10StringView(rest_str, rest_start + 1 | 0, rest_end);
                              if (hex) {
                                rest$5 = _x$2;
                                break _L$6;
                              } else {
                                if (_x === 69) {
                                  if (follow_underscore === true) {
                                    break _L$5;
                                  } else {
                                    rest$4 = _x$2;
                                    break _L$4;
                                  }
                                } else {
                                  if (follow_underscore === true) {
                                    break _L$3;
                                  } else {
                                    rest$3 = _x$2;
                                    break _L$2;
                                  }
                                }
                              }
                            } else {
                              if (_x === 46) {
                                if (follow_underscore === true) {
                                  break _L$5;
                                } else {
                                  const _x$2 = new _M0TPC16string10StringView(rest_str, rest_start + 1 | 0, rest_end);
                                  rest$4 = _x$2;
                                  break _L$4;
                                }
                              } else {
                                if (_x === 43) {
                                  if (follow_underscore === true) {
                                    break _L$5;
                                  } else {
                                    const _x$2 = new _M0TPC16string10StringView(rest_str, rest_start + 1 | 0, rest_end);
                                    rest$4 = _x$2;
                                    break _L$4;
                                  }
                                } else {
                                  if (_x === 45) {
                                    if (follow_underscore === true) {
                                      break _L$5;
                                    } else {
                                      const _x$2 = new _M0TPC16string10StringView(rest_str, rest_start + 1 | 0, rest_end);
                                      rest$4 = _x$2;
                                      break _L$4;
                                    }
                                  } else {
                                    if (follow_underscore === true) {
                                      break _L$3;
                                    } else {
                                      const _bind$2 = _M0MPC16string6String29offset__of__nth__char_2einner(rest_str, 1, rest_start, rest_end);
                                      let _tmp$6;
                                      if (_bind$2 === undefined) {
                                        _tmp$6 = rest_end;
                                      } else {
                                        const _Some = _bind$2;
                                        _tmp$6 = _Some;
                                      }
                                      const _x$2 = new _M0TPC16string10StringView(rest_str, _tmp$6, rest_end);
                                      rest$3 = _x$2;
                                      break _L$2;
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
                _tmp = rest$6.str;
                _tmp$2 = rest$6.start;
                _tmp$3 = rest$6.end;
                _tmp$4 = true;
                _tmp$5 = false;
                continue;
              }
              _tmp = rest$5.str;
              _tmp$2 = rest$5.start;
              _tmp$3 = rest$5.end;
              _tmp$4 = true;
              _tmp$5 = false;
              continue;
            }
            return false;
          }
          _tmp = rest$4.str;
          _tmp$2 = rest$4.start;
          _tmp$3 = rest$4.end;
          _tmp$4 = false;
          _tmp$5 = false;
          continue;
        }
        return false;
      }
      _tmp = rest$3.str;
      _tmp$2 = rest$3.start;
      _tmp$3 = rest$3.end;
      _tmp$4 = false;
      _tmp$5 = false;
      continue;
    }
  } else {
    return true;
  }
}
function _M0FPC28internal7strconv14eisel__umul128(a, b) {
  const a_lo = BigInt.asUintN(64, a & 4294967295n);
  const a_hi = BigInt.asUintN(64, BigInt.asUintN(64, a) >> BigInt(32 & 63));
  const b_lo = BigInt.asUintN(64, b & 4294967295n);
  const b_hi = BigInt.asUintN(64, BigInt.asUintN(64, b) >> BigInt(32 & 63));
  const x = BigInt.asUintN(64, a_lo * b_lo);
  const y = BigInt.asUintN(64, BigInt.asUintN(64, a_hi * b_lo) + BigInt.asUintN(64, BigInt.asUintN(64, x) >> BigInt(32 & 63)));
  const z = BigInt.asUintN(64, BigInt.asUintN(64, a_lo * b_hi) + BigInt.asUintN(64, y & 4294967295n));
  const hi = BigInt.asUintN(64, BigInt.asUintN(64, BigInt.asUintN(64, a_hi * b_hi) + BigInt.asUintN(64, BigInt.asUintN(64, y) >> BigInt(32 & 63))) + BigInt.asUintN(64, BigInt.asUintN(64, z) >> BigInt(32 & 63)));
  return new _M0TPC28internal7strconv12EiselProduct(BigInt.asUintN(64, a * b), hi);
}
function _M0FPC28internal7strconv20eisel__mul__log2__10(exponent) {
  return (Math.imul(exponent, 108853) | 0) >> 15;
}
function _M0FPC28internal7strconv20try__eisel__lemire64(mantissa, exponent, negative) {
  if (BigInt.asUintN(64, mantissa) === BigInt.asUintN(64, 0n)) {
    return negative ? $i64_reinterpret_f64(9223372036854775808n) : 0;
  }
  if (BigInt.asIntN(64, exponent) < BigInt.asIntN(64, 18446744073709551268n) || BigInt.asIntN(64, exponent) > BigInt.asIntN(64, 347n)) {
    return _M0FPC16double14not__a__number;
  }
  const exponent$2 = Number(BigInt.asIntN(32, exponent)) | 0;
  const table_index = Math.imul(exponent$2 - -348 | 0, 2) | 0;
  const pow_hi = _M0MPC15array13ReadOnlyArray2atGmE(_M0FPC28internal7strconv27eisel__lemire__pow10__table, table_index);
  const pow_lo = _M0MPC15array13ReadOnlyArray2atGmE(_M0FPC28internal7strconv27eisel__lemire__pow10__table, table_index + 1 | 0);
  const pow_exp2 = 1 + _M0FPC28internal7strconv20eisel__mul__log2__10(exponent$2) | 0;
  const leading_zeros = $i64_clz(mantissa);
  const normalized = BigInt.asUintN(64, mantissa << BigInt(leading_zeros & 63));
  let result_exp2 = ((pow_exp2 + 63 | 0) + 1023 | 0) - leading_zeros | 0;
  const product = _M0FPC28internal7strconv14eisel__umul128(normalized, pow_hi);
  let product_hi = product.hi;
  let product_lo = product.lo;
  if (BigInt.asUintN(64, BigInt.asUintN(64, product_hi & 511n)) === BigInt.asUintN(64, 511n) && BigInt.asUintN(64, BigInt.asUintN(64, product_lo + normalized)) < BigInt.asUintN(64, normalized)) {
    const wider = _M0FPC28internal7strconv14eisel__umul128(normalized, pow_lo);
    let merged_hi = product_hi;
    const merged_lo = BigInt.asUintN(64, product_lo + wider.hi);
    if (BigInt.asUintN(64, merged_lo) < BigInt.asUintN(64, product_lo)) {
      merged_hi = BigInt.asUintN(64, merged_hi + 1n);
    }
    if (BigInt.asUintN(64, BigInt.asUintN(64, merged_hi & 511n)) === BigInt.asUintN(64, 511n) && (BigInt.asUintN(64, BigInt.asUintN(64, merged_lo + 1n)) === BigInt.asUintN(64, 0n) && BigInt.asUintN(64, BigInt.asUintN(64, wider.lo + normalized)) < BigInt.asUintN(64, normalized))) {
      return _M0FPC16double14not__a__number;
    }
    product_hi = merged_hi;
    product_lo = merged_lo;
  }
  const top_bit = Number(BigInt.asIntN(32, BigInt.asUintN(64, BigInt.asUintN(64, product_hi) >> BigInt(63 & 63)))) | 0;
  let result_mantissa = BigInt.asUintN(64, BigInt.asUintN(64, product_hi) >> BigInt((top_bit + 9 | 0) & 63));
  result_exp2 = result_exp2 - (1 - top_bit | 0) | 0;
  if (BigInt.asUintN(64, product_lo) === BigInt.asUintN(64, 0n) && (BigInt.asUintN(64, BigInt.asUintN(64, product_hi & 511n)) === BigInt.asUintN(64, 0n) && BigInt.asUintN(64, BigInt.asUintN(64, result_mantissa & 3n)) === BigInt.asUintN(64, 1n))) {
    return _M0FPC16double14not__a__number;
  }
  result_mantissa = BigInt.asUintN(64, result_mantissa + BigInt.asUintN(64, result_mantissa & 1n));
  result_mantissa = BigInt.asUintN(64, BigInt.asUintN(64, result_mantissa) >> BigInt(1 & 63));
  if (BigInt.asUintN(64, BigInt.asUintN(64, BigInt.asUintN(64, result_mantissa) >> BigInt(53 & 63))) > BigInt.asUintN(64, 0n)) {
    result_mantissa = BigInt.asUintN(64, BigInt.asUintN(64, result_mantissa) >> BigInt(1 & 63));
    result_exp2 = result_exp2 + 1 | 0;
  }
  if (result_exp2 <= 0 || result_exp2 >= 2047) {
    return _M0FPC16double14not__a__number;
  }
  const exponent_bits = BigInt.asUintN(64, BigInt.asUintN(64, BigInt(result_exp2 >>> 0)) << BigInt(52 & 63));
  let result_bits = BigInt.asUintN(64, exponent_bits | BigInt.asUintN(64, result_mantissa & 4503599627370495n));
  if (negative) {
    result_bits = BigInt.asUintN(64, result_bits | 9223372036854775808n);
  }
  return $i64_reinterpret_f64(result_bits);
}
function _M0MPC28internal7strconv7Decimal9new__priv() {
  return new _M0TPC28internal7strconv7Decimal($makebytes(800, 0), 0, 0, false, false, 0);
}
function _M0MPC28internal7strconv7Decimal4trim(self) {
  while (true) {
    let _tmp;
    if (self.digits_num > 0) {
      const _tmp$2 = self.digits;
      const _tmp$3 = self.digits_num - 1 | 0;
      _tmp = _M0IPC14byte4BytePB2Eq5equal(_tmp$3 >>> 0 < _tmp$2.length ? _tmp$2[_tmp$3] : $oob(), 0);
    } else {
      _tmp = false;
    }
    if (_tmp) {
      self.digits_num = self.digits_num - 1 | 0;
      continue;
    } else {
      break;
    }
  }
  if (self.digits_num === 0) {
    self.decimal_point = 0;
    return;
  } else {
    return;
  }
}
function _M0FPC28internal7strconv26parse__decimal__from__view(str) {
  const d = _M0MPC28internal7strconv7Decimal9new__priv();
  let has_dp = false;
  let has_digits = false;
  let rest;
  _L: {
    _L$2: {
      if ((str.end - str.start | 0) >= 1) {
        const _x = str.str.charCodeAt(str.start);
        switch (_x) {
          case 45: {
            const _x$2 = new _M0TPC16string10StringView(str.str, str.start + 1 | 0, str.end);
            d.negative = true;
            rest = _x$2;
            break;
          }
          case 43: {
            rest = new _M0TPC16string10StringView(str.str, str.start + 1 | 0, str.end);
            break;
          }
          default: {
            break _L$2;
          }
        }
      } else {
        break _L$2;
      }
      break _L;
    }
    rest = str;
  }
  let rest$2;
  let _tmp = rest;
  while (true) {
    const rest$3 = _tmp;
    let rest$4;
    _L$2: {
      _L$3: {
        if ((rest$3.end - rest$3.start | 0) >= 1) {
          const _x = rest$3.str.charCodeAt(rest$3.start);
          if (_x === 95) {
            const _x$2 = new _M0TPC16string10StringView(rest$3.str, rest$3.start + 1 | 0, rest$3.end);
            _tmp = _x$2;
            continue;
          } else {
            if (_x === 46) {
              const _x$2 = new _M0TPC16string10StringView(rest$3.str, rest$3.start + 1 | 0, rest$3.end);
              if (!has_dp) {
                has_dp = true;
                d.decimal_point = d.digits_num;
                _tmp = _x$2;
                continue;
              } else {
                const _bind$2 = _M0FPC28internal7strconv11syntax__errGuE();
                if (_bind$2.$tag === 1) {
                  const _ok = _bind$2;
                  _ok._0;
                } else {
                  return _bind$2;
                }
              }
            } else {
              if (_x >= 48 && _x <= 57) {
                const _x$2 = new _M0TPC16string10StringView(rest$3.str, rest$3.start + 1 | 0, rest$3.end);
                has_digits = true;
                if (_x === 48 && d.digits_num === 0) {
                  d.decimal_point = d.decimal_point - 1 | 0;
                  _tmp = _x$2;
                  continue;
                }
                if (d.digits_num < d.digits.length) {
                  const _tmp$2 = d.digits;
                  const _tmp$3 = d.digits_num;
                  if (_tmp$3 >>> 0 < _tmp$2.length) {
                    _tmp$2[_tmp$3] = (_x - 48 | 0) & 255;
                  } else {
                    $oob();
                  }
                  d.digits_num = d.digits_num + 1 | 0;
                } else {
                  if (!has_dp) {
                    d.overflowed = d.overflowed + 1 | 0;
                  }
                  if (_x !== 48) {
                    d.truncated = true;
                  }
                }
                _tmp = _x$2;
                continue;
              } else {
                rest$4 = rest$3;
                break _L$3;
              }
            }
          }
        } else {
          rest$4 = rest$3;
          break _L$3;
        }
        break _L$2;
      }
      rest$2 = rest$4;
      break;
    }
    continue;
  }
  if (has_digits) {
    if (!has_dp) {
      d.decimal_point = d.digits_num;
    }
    let rest$3;
    let rest$4;
    _L$2: {
      _L$3: {
        if ((rest$2.end - rest$2.start | 0) >= 1) {
          const _x = rest$2.str.charCodeAt(rest$2.start);
          switch (_x) {
            case 101: {
              const _x$2 = new _M0TPC16string10StringView(rest$2.str, rest$2.start + 1 | 0, rest$2.end);
              rest$4 = _x$2;
              break _L$3;
            }
            case 69: {
              const _x$3 = new _M0TPC16string10StringView(rest$2.str, rest$2.start + 1 | 0, rest$2.end);
              rest$4 = _x$3;
              break _L$3;
            }
            default: {
              rest$3 = rest$2;
            }
          }
        } else {
          rest$3 = rest$2;
        }
        break _L$2;
      }
      let exp_sign = 1;
      let rest$5;
      if ((rest$4.end - rest$4.start | 0) >= 1) {
        const _x = rest$4.str.charCodeAt(rest$4.start);
        switch (_x) {
          case 43: {
            rest$5 = new _M0TPC16string10StringView(rest$4.str, rest$4.start + 1 | 0, rest$4.end);
            break;
          }
          case 45: {
            const _x$2 = new _M0TPC16string10StringView(rest$4.str, rest$4.start + 1 | 0, rest$4.end);
            exp_sign = -1;
            rest$5 = _x$2;
            break;
          }
          default: {
            rest$5 = rest$4;
          }
        }
      } else {
        rest$5 = rest$4;
      }
      _L$4: {
        _L$5: {
          if ((rest$5.end - rest$5.start | 0) >= 1) {
            const _x = rest$5.str.charCodeAt(rest$5.start);
            if (_x >= 48 && _x <= 57) {
              const effective_dp = d.decimal_point + d.overflowed | 0;
              const exp_limit = exp_sign > 0 ? (effective_dp < 311 ? 311 - effective_dp | 0 : 0) : effective_dp > -331 ? effective_dp + 331 | 0 : 0;
              let exp = 0;
              let rest$6;
              let _tmp$2 = rest$5;
              while (true) {
                const rest$7 = _tmp$2;
                let rest$8;
                _L$6: {
                  if ((rest$7.end - rest$7.start | 0) >= 1) {
                    const _x$2 = rest$7.str.charCodeAt(rest$7.start);
                    if (_x$2 === 95) {
                      const _x$3 = new _M0TPC16string10StringView(rest$7.str, rest$7.start + 1 | 0, rest$7.end);
                      _tmp$2 = _x$3;
                      continue;
                    } else {
                      if (_x$2 >= 48 && _x$2 <= 57) {
                        const _x$3 = new _M0TPC16string10StringView(rest$7.str, rest$7.start + 1 | 0, rest$7.end);
                        if (exp < exp_limit) {
                          exp = (Math.imul(exp, 10) | 0) + (_x$2 - 48 | 0) | 0;
                          if (exp > exp_limit) {
                            exp = exp_limit;
                          }
                        }
                        _tmp$2 = _x$3;
                        continue;
                      } else {
                        rest$8 = rest$7;
                        break _L$6;
                      }
                    }
                  } else {
                    rest$8 = rest$7;
                    break _L$6;
                  }
                }
                rest$6 = rest$8;
                break;
              }
              d.decimal_point = d.decimal_point + (Math.imul(exp_sign, exp) | 0) | 0;
              rest$3 = rest$6;
            } else {
              break _L$5;
            }
          } else {
            break _L$5;
          }
          break _L$4;
        }
        const _bind$2 = _M0FPC28internal7strconv11syntax__errGRPC16string10StringViewE();
        if (_bind$2.$tag === 1) {
          const _ok = _bind$2;
          rest$3 = _ok._0;
        } else {
          return _bind$2;
        }
      }
    }
    if ((rest$3.end - rest$3.start | 0) === 0) {
      _M0MPC28internal7strconv7Decimal4trim(d);
      return new _M0DTPC16result6ResultGRPC28internal7strconv7DecimalRPC15error5ErrorE2Ok(d);
    } else {
      return _M0FPC28internal7strconv11syntax__errGRPC16string10StringViewE();
    }
  } else {
    return _M0FPC28internal7strconv11syntax__errGRPC16string10StringViewE();
  }
}
function _M0FPC28internal7strconv20parse__decimal__priv(str) {
  return _M0FPC28internal7strconv26parse__decimal__from__view(str);
}
function _M0FPC28internal7strconv14assemble__bits(mantissa, exponent, negative) {
  const biased_exp = exponent - _M0FPC28internal7strconv12double__info.bias | 0;
  let bits = BigInt.asUintN(64, mantissa & BigInt.asUintN(64, BigInt.asUintN(64, 1n << BigInt(_M0FPC28internal7strconv12double__info.mantissa_bits & 63)) - 1n));
  const exp_bits = BigInt.asUintN(64, BigInt(biased_exp & ((1 << _M0FPC28internal7strconv12double__info.exponent_bits) - 1 | 0)));
  bits = BigInt.asUintN(64, bits | BigInt.asUintN(64, exp_bits << BigInt(_M0FPC28internal7strconv12double__info.mantissa_bits & 63)));
  if (negative) {
    bits = BigInt.asUintN(64, bits | BigInt.asUintN(64, BigInt.asUintN(64, 1n << BigInt(_M0FPC28internal7strconv12double__info.mantissa_bits & 63)) << BigInt(_M0FPC28internal7strconv12double__info.exponent_bits & 63)));
  }
  return bits;
}
function _M0MPC28internal7strconv7Decimal17should__round__up(self, d) {
  if (d < 0 || d >= self.digits_num) {
    return false;
  }
  let _tmp;
  const _tmp$2 = self.digits;
  if ((d >>> 0 < _tmp$2.length ? _tmp$2[d] : $oob()) === 5) {
    _tmp = (d + 1 | 0) === self.digits_num;
  } else {
    _tmp = false;
  }
  if (_tmp) {
    if (self.truncated) {
      return true;
    }
    let _tmp$3;
    if (d > 0) {
      const _tmp$4 = self.digits;
      const _tmp$5 = d - 1 | 0;
      if (2 === 0) {
        $panic();
      }
      _tmp$3 = ((_tmp$5 >>> 0 < _tmp$4.length ? _tmp$4[_tmp$5] : $oob()) % 2 | 0) !== 0;
    } else {
      _tmp$3 = false;
    }
    return _tmp$3;
  }
  const _tmp$3 = self.digits;
  return (d >>> 0 < _tmp$3.length ? _tmp$3[d] : $oob()) >= 5;
}
function _M0MPC28internal7strconv7Decimal16rounded__integer(self) {
  if (self.decimal_point > 20) {
    return 18446744073709551615n;
  }
  let _tmp = 0n;
  let _tmp$2 = 0;
  while (true) {
    const n = _tmp;
    const i = _tmp$2;
    if (i < self.decimal_point && i < self.digits_num) {
      const _tmp$3 = BigInt.asUintN(64, n * 10n);
      const _tmp$4 = self.digits;
      _tmp = BigInt.asUintN(64, _tmp$3 + _M0MPC14byte4Byte9to__int64(i >>> 0 < _tmp$4.length ? _tmp$4[i] : $oob()));
      _tmp$2 = i + 1 | 0;
      continue;
    } else {
      let n$2;
      let _tmp$3 = n;
      let _tmp$4 = i;
      while (true) {
        const n$3 = _tmp$3;
        const i$2 = _tmp$4;
        if (i$2 < self.decimal_point) {
          _tmp$3 = BigInt.asUintN(64, n$3 * 10n);
          _tmp$4 = i$2 + 1 | 0;
          continue;
        } else {
          n$2 = n$3;
          break;
        }
      }
      return _M0MPC28internal7strconv7Decimal17should__round__up(self, self.decimal_point) ? BigInt.asUintN(64, n$2 + 1n) : n$2;
    }
  }
}
function _M0MPC28internal7strconv7Decimal11new__digits(self, s) {
  const new_digits = _M0MPC15array13ReadOnlyArray2atGmE(_M0FPC28internal7strconv19left__shift__cheats, s)._0;
  const cheat_num = _M0MPC15array13ReadOnlyArray2atGmE(_M0FPC28internal7strconv19left__shift__cheats, s)._1;
  const _bind$2 = cheat_num.length;
  let less;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const code_unit = cheat_num.charCodeAt(i);
      if (i >= self.digits_num) {
        less = true;
        break;
      }
      const d = code_unit - 48 | 0;
      const _tmp$2 = self.digits;
      if ((i >>> 0 < _tmp$2.length ? _tmp$2[i] : $oob()) !== d) {
        const _tmp$3 = self.digits;
        less = (i >>> 0 < _tmp$3.length ? _tmp$3[i] : $oob()) < d;
        break;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      less = false;
      break;
    }
  }
  return less ? new_digits - 1 | 0 : new_digits;
}
function _M0MPC28internal7strconv7Decimal11left__shift(self, s) {
  const new_digits = _M0MPC28internal7strconv7Decimal11new__digits(self, s);
  let read_index = self.digits_num;
  let write_index = self.digits_num + new_digits | 0;
  let acc = 0n;
  read_index = read_index - 1 | 0;
  while (true) {
    if (read_index >= 0) {
      const _tmp = self.digits;
      const _tmp$2 = read_index;
      const d = _M0MPC14byte4Byte9to__int64(_tmp$2 >>> 0 < _tmp.length ? _tmp[_tmp$2] : $oob());
      acc = BigInt.asUintN(64, acc + BigInt.asUintN(64, d << BigInt(s & 63)));
      if (10n === 0n) {
        $panic();
      }
      const quo = BigInt.asUintN(64, BigInt.asIntN(64, acc) / BigInt.asIntN(64, 10n));
      const rem = Number(BigInt.asIntN(32, BigInt.asUintN(64, acc - BigInt.asUintN(64, quo * 10n)))) | 0;
      write_index = write_index - 1 | 0;
      if (write_index < self.digits.length) {
        const _tmp$3 = self.digits;
        const _tmp$4 = write_index;
        if (_tmp$4 >>> 0 < _tmp$3.length) {
          _tmp$3[_tmp$4] = rem & 255;
        } else {
          $oob();
        }
      } else {
        if (rem !== 0) {
          self.truncated = true;
        }
      }
      acc = quo;
      read_index = read_index - 1 | 0;
      continue;
    } else {
      break;
    }
  }
  while (true) {
    if (BigInt.asIntN(64, acc) > BigInt.asIntN(64, 0n)) {
      if (10n === 0n) {
        $panic();
      }
      const quo = BigInt.asUintN(64, BigInt.asIntN(64, acc) / BigInt.asIntN(64, 10n));
      const rem = Number(BigInt.asIntN(32, BigInt.asUintN(64, acc - BigInt.asUintN(64, 10n * quo)))) | 0;
      write_index = write_index - 1 | 0;
      if (write_index < self.digits.length) {
        const _tmp = self.digits;
        const _tmp$2 = write_index;
        if (_tmp$2 >>> 0 < _tmp.length) {
          _tmp[_tmp$2] = rem & 255;
        } else {
          $oob();
        }
      } else {
        if (rem !== 0) {
          self.truncated = true;
        }
      }
      acc = quo;
      continue;
    } else {
      break;
    }
  }
  self.digits_num = self.digits_num + new_digits | 0;
  if (self.digits_num > self.digits.length) {
    self.digits_num = self.digits.length;
  }
  self.decimal_point = self.decimal_point + new_digits | 0;
  _M0MPC28internal7strconv7Decimal4trim(self);
}
function _M0MPC28internal7strconv7Decimal12right__shift(self, s) {
  let read_index = 0;
  let write_index = 0;
  let acc = 0n;
  while (true) {
    if (BigInt.asUintN(64, BigInt.asUintN(64, BigInt.asUintN(64, acc) >> BigInt(s & 63))) === BigInt.asUintN(64, 0n)) {
      if (read_index >= self.digits_num) {
        while (true) {
          if (BigInt.asUintN(64, BigInt.asUintN(64, BigInt.asUintN(64, acc) >> BigInt(s & 63))) === BigInt.asUintN(64, 0n)) {
            acc = BigInt.asUintN(64, acc * 10n);
            read_index = read_index + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        break;
      }
      const _tmp = self.digits;
      const _tmp$2 = read_index;
      const d = _tmp$2 >>> 0 < _tmp.length ? _tmp[_tmp$2] : $oob();
      acc = BigInt.asUintN(64, BigInt.asUintN(64, acc * 10n) + _M0MPC14byte4Byte9to__int64(d));
      read_index = read_index + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  self.decimal_point = self.decimal_point - (read_index - 1 | 0) | 0;
  const mask = BigInt.asUintN(64, BigInt.asUintN(64, 1n << BigInt(s & 63)) - 1n);
  while (true) {
    if (read_index < self.digits_num) {
      const out = BigInt.asUintN(64, BigInt.asUintN(64, acc) >> BigInt(s & 63));
      const _tmp = self.digits;
      const _tmp$2 = write_index;
      if (_tmp$2 >>> 0 < _tmp.length) {
        _tmp[_tmp$2] = _M0MPC16uint646UInt648to__byte(out);
      } else {
        $oob();
      }
      write_index = write_index + 1 | 0;
      acc = BigInt.asUintN(64, acc & mask);
      const _tmp$3 = self.digits;
      const _tmp$4 = read_index;
      const d = _tmp$4 >>> 0 < _tmp$3.length ? _tmp$3[_tmp$4] : $oob();
      acc = BigInt.asUintN(64, BigInt.asUintN(64, acc * 10n) + _M0MPC14byte4Byte9to__int64(d));
      read_index = read_index + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  while (true) {
    if (BigInt.asUintN(64, acc) > BigInt.asUintN(64, 0n)) {
      const out = BigInt.asUintN(64, BigInt.asUintN(64, acc) >> BigInt(s & 63));
      if (write_index < self.digits.length) {
        const _tmp = self.digits;
        const _tmp$2 = write_index;
        if (_tmp$2 >>> 0 < _tmp.length) {
          _tmp[_tmp$2] = _M0MPC16uint646UInt648to__byte(out);
        } else {
          $oob();
        }
        write_index = write_index + 1 | 0;
      } else {
        if (BigInt.asUintN(64, out) > BigInt.asUintN(64, 0n)) {
          self.truncated = true;
        }
      }
      acc = BigInt.asUintN(64, acc & mask);
      acc = BigInt.asUintN(64, acc * 10n);
      continue;
    } else {
      break;
    }
  }
  self.digits_num = write_index;
  _M0MPC28internal7strconv7Decimal4trim(self);
}
function _M0MPC28internal7strconv7Decimal11shift__priv(self, s) {
  if (self.digits_num === 0) {
    return undefined;
  }
  let s$2 = s;
  if (s$2 > 0) {
    while (true) {
      if (s$2 > 59) {
        _M0MPC28internal7strconv7Decimal11left__shift(self, 59);
        s$2 = s$2 - 59 | 0;
        continue;
      } else {
        break;
      }
    }
    _M0MPC28internal7strconv7Decimal11left__shift(self, s$2);
  }
  if (s$2 < 0) {
    while (true) {
      if (s$2 < -59) {
        _M0MPC28internal7strconv7Decimal12right__shift(self, 59);
        s$2 = s$2 + 59 | 0;
        continue;
      } else {
        break;
      }
    }
    _M0MPC28internal7strconv7Decimal12right__shift(self, -s$2 | 0);
    return;
  } else {
    return;
  }
}
function _M0MPC28internal7strconv7Decimal16to__double__priv(self) {
  let exponent = 0;
  let mantissa = 0n;
  const effective_dp = self.decimal_point + self.overflowed | 0;
  if (self.digits_num === 0 || effective_dp < -330) {
    mantissa = 0n;
    exponent = _M0FPC28internal7strconv12double__info.bias;
    const bits = _M0FPC28internal7strconv14assemble__bits(mantissa, exponent, self.negative);
    return new _M0DTPC16result6ResultGdRPC15error5ErrorE2Ok($i64_reinterpret_f64(bits));
  }
  if (self.decimal_point > 310) {
    const _bind$2 = _M0FPC28internal7strconv10range__errGuE();
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _ok._0;
    } else {
      return _bind$2;
    }
  }
  self.decimal_point = self.decimal_point + self.overflowed | 0;
  while (true) {
    if (self.decimal_point > 0) {
      let n = 0;
      if (self.decimal_point >= _M0MPC15array13ReadOnlyArray6lengthGiE(_M0FPC28internal7strconv6powtab)) {
        n = 60;
      } else {
        n = _M0MPC15array13ReadOnlyArray2atGiE(_M0FPC28internal7strconv6powtab, self.decimal_point);
      }
      _M0MPC28internal7strconv7Decimal11shift__priv(self, -n | 0);
      exponent = exponent + n | 0;
      continue;
    } else {
      break;
    }
  }
  while (true) {
    let _tmp;
    if (self.decimal_point < 0) {
      _tmp = true;
    } else {
      let _tmp$2;
      if (self.decimal_point === 0) {
        const _tmp$3 = self.digits;
        _tmp$2 = (0 >>> 0 < _tmp$3.length ? _tmp$3[0] : $oob()) < 5;
      } else {
        _tmp$2 = false;
      }
      _tmp = _tmp$2;
    }
    if (_tmp) {
      let n = 0;
      if ((-self.decimal_point | 0) >= _M0MPC15array13ReadOnlyArray6lengthGiE(_M0FPC28internal7strconv6powtab)) {
        n = 60;
      } else {
        n = _M0MPC15array13ReadOnlyArray2atGiE(_M0FPC28internal7strconv6powtab, -self.decimal_point | 0);
      }
      _M0MPC28internal7strconv7Decimal11shift__priv(self, n);
      exponent = exponent - n | 0;
      continue;
    } else {
      break;
    }
  }
  exponent = exponent - 1 | 0;
  if (exponent < (_M0FPC28internal7strconv12double__info.bias + 1 | 0)) {
    const n = (_M0FPC28internal7strconv12double__info.bias + 1 | 0) - exponent | 0;
    _M0MPC28internal7strconv7Decimal11shift__priv(self, -n | 0);
    exponent = exponent + n | 0;
  }
  if ((exponent - _M0FPC28internal7strconv12double__info.bias | 0) >= ((1 << _M0FPC28internal7strconv12double__info.exponent_bits) - 1 | 0)) {
    const _bind$2 = _M0FPC28internal7strconv10range__errGuE();
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _ok._0;
    } else {
      return _bind$2;
    }
  }
  _M0MPC28internal7strconv7Decimal11shift__priv(self, _M0FPC28internal7strconv12double__info.mantissa_bits + 1 | 0);
  mantissa = _M0MPC28internal7strconv7Decimal16rounded__integer(self);
  if (BigInt.asUintN(64, mantissa) === BigInt.asUintN(64, BigInt.asUintN(64, 2n << BigInt(_M0FPC28internal7strconv12double__info.mantissa_bits & 63)))) {
    mantissa = BigInt.asUintN(64, BigInt.asIntN(64, mantissa) >> BigInt(1 & 63));
    exponent = exponent + 1 | 0;
    if ((exponent - _M0FPC28internal7strconv12double__info.bias | 0) >= ((1 << _M0FPC28internal7strconv12double__info.exponent_bits) - 1 | 0)) {
      const _bind$2 = _M0FPC28internal7strconv10range__errGuE();
      if (_bind$2.$tag === 1) {
        const _ok = _bind$2;
        _ok._0;
      } else {
        return _bind$2;
      }
    }
  }
  if (BigInt.asUintN(64, BigInt.asUintN(64, mantissa & BigInt.asUintN(64, 1n << BigInt(_M0FPC28internal7strconv12double__info.mantissa_bits & 63)))) === BigInt.asUintN(64, 0n)) {
    exponent = _M0FPC28internal7strconv12double__info.bias;
  }
  const bits = _M0FPC28internal7strconv14assemble__bits(mantissa, exponent, self.negative);
  return new _M0DTPC16result6ResultGdRPC15error5ErrorE2Ok($i64_reinterpret_f64(bits));
}
function _M0FPC28internal7strconv17pow10__fast__path(exponent) {
  return _M0MPC15array13ReadOnlyArray2atGdE(_M0FPC28internal7strconv5table, exponent & 31);
}
function _M0MPC28internal7strconv6Number14is__fast__path(self) {
  return BigInt.asIntN(64, _M0FPC28internal7strconv25min__exponent__fast__path) <= BigInt.asIntN(64, self.exponent) && (BigInt.asIntN(64, self.exponent) <= BigInt.asIntN(64, _M0FPC28internal7strconv36max__exponent__disguised__fast__path) && (BigInt.asUintN(64, self.mantissa) <= BigInt.asUintN(64, _M0FPC28internal7strconv25max__mantissa__fast__path) && !self.many_digits));
}
function _M0MPC28internal7strconv6Number15try__fast__path(self) {
  if (_M0MPC28internal7strconv6Number14is__fast__path(self)) {
    let value;
    if (BigInt.asIntN(64, self.exponent) <= BigInt.asIntN(64, _M0FPC28internal7strconv25max__exponent__fast__path)) {
      const value$2 = $f64_convert_i64_u(BigInt.asUintN(64, self.mantissa));
      value = BigInt.asIntN(64, self.exponent) < BigInt.asIntN(64, 0n) ? value$2 / _M0FPC28internal7strconv17pow10__fast__path(-(Number(BigInt.asIntN(32, self.exponent)) | 0) | 0) : value$2 * _M0FPC28internal7strconv17pow10__fast__path(Number(BigInt.asIntN(32, self.exponent)) | 0);
    } else {
      const shift = BigInt.asUintN(64, self.exponent - _M0FPC28internal7strconv25max__exponent__fast__path);
      const _bind$2 = _M0FPC28internal7strconv12checked__mul(self.mantissa, _M0MPC15array13ReadOnlyArray2atGmE(_M0FPC28internal7strconv10int__pow10, Number(BigInt.asIntN(32, shift)) | 0));
      if (_bind$2 === undefined) {
        return _M0DTPC16option6OptionGdE4None__;
      } else {
        const _Some = _bind$2;
        const _mantissa = _Some;
        if (BigInt.asUintN(64, _mantissa) > BigInt.asUintN(64, _M0FPC28internal7strconv25max__mantissa__fast__path)) {
          return _M0DTPC16option6OptionGdE4None__;
        }
        value = $f64_convert_i64_u(BigInt.asUintN(64, _mantissa)) * _M0FPC28internal7strconv17pow10__fast__path(Number(BigInt.asIntN(32, _M0FPC28internal7strconv25max__exponent__fast__path)) | 0);
      }
    }
    if (self.negative) {
      value = -value;
    }
    return new _M0DTPC16option6OptionGdE4Some(value);
  } else {
    return _M0DTPC16option6OptionGdE4None__;
  }
}
function _M0FPC28internal7strconv13parse__double(str) {
  if (!_M0MPC16string10StringView9is__empty(str)) {
    if (_M0FPC28internal7strconv17check__underscore(str)) {
      const _bind$2 = _M0FPC28internal7strconv13parse__number(str);
      let _bind$3;
      if (_bind$2.$tag === 1) {
        const _ok = _bind$2;
        _bind$3 = _ok._0;
      } else {
        return _bind$2;
      }
      if (_bind$3 === undefined) {
        return _M0FPC28internal7strconv15parse__inf__nan(str);
      } else {
        const _Some = _bind$3;
        const _num = _Some;
        const _bind$4 = _M0MPC28internal7strconv6Number15try__fast__path(_num);
        if (_bind$4.$tag === 1) {
          const _Some$2 = _bind$4;
          const _value = _Some$2._0;
          return new _M0DTPC16result6ResultGdRPC15error5ErrorE2Ok(_value);
        } else {
          const fast = _num.many_digits ? _M0FPC16double14not__a__number : _M0FPC28internal7strconv20try__eisel__lemire64(_num.mantissa, _num.exponent, _num.negative);
          if (_M0MPC16double6Double7is__nan(fast)) {
            const _bind$5 = _M0FPC28internal7strconv20parse__decimal__priv(str);
            let _tmp;
            if (_bind$5.$tag === 1) {
              const _ok = _bind$5;
              _tmp = _ok._0;
            } else {
              return _bind$5;
            }
            return _M0MPC28internal7strconv7Decimal16to__double__priv(_tmp);
          } else {
            return new _M0DTPC16result6ResultGdRPC15error5ErrorE2Ok(fast);
          }
        }
      }
    } else {
      return _M0FPC28internal7strconv11syntax__errGdE();
    }
  } else {
    return _M0FPC28internal7strconv11syntax__errGdE();
  }
}
function _M0FPC14json20need__escape__scalar(str, escape_slash, start, end) {
  let _tmp = start;
  while (true) {
    const i = _tmp;
    if (i < end) {
      const code = str.charCodeAt(i);
      if (_M0IPC16uint166UInt16PB2Eq5equal(code, 34) || (_M0IPC16uint166UInt16PB2Eq5equal(code, 92) || (code < 32 || escape_slash && _M0IPC16uint166UInt16PB2Eq5equal(code, 47)))) {
        return true;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return false;
}
function _M0FPC14json12need__escape(str, escape_slash) {
  return _M0FPC14json20need__escape__scalar(str, escape_slash, 0, str.length);
}
function _M0FPC14json14write__escaped(buf, str, escape_slash) {
  if (!_M0FPC14json12need__escape(str, escape_slash)) {
    _M0IPB13StringBuilderPB6Logger13write__string(buf, str);
    return undefined;
  }
  const _bind$2 = str.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const code = str.charCodeAt(_);
      switch (code) {
        case 34: {
          _M0IPB13StringBuilderPB6Logger13write__string(buf, "\\\"");
          break;
        }
        case 92: {
          _M0IPB13StringBuilderPB6Logger13write__string(buf, "\\\\");
          break;
        }
        case 47: {
          if (escape_slash) {
            _M0IPB13StringBuilderPB6Logger13write__string(buf, "\\/");
          } else {
            _M0IPB13StringBuilderPB6Logger11write__char(buf, 47);
          }
          break;
        }
        case 10: {
          _M0IPB13StringBuilderPB6Logger13write__string(buf, "\\n");
          break;
        }
        case 13: {
          _M0IPB13StringBuilderPB6Logger13write__string(buf, "\\r");
          break;
        }
        case 8: {
          _M0IPB13StringBuilderPB6Logger13write__string(buf, "\\b");
          break;
        }
        case 9: {
          _M0IPB13StringBuilderPB6Logger13write__string(buf, "\\t");
          break;
        }
        case 12: {
          _M0IPB13StringBuilderPB6Logger13write__string(buf, "\\f");
          break;
        }
        default: {
          if (code < 32) {
            _M0IPB13StringBuilderPB6Logger13write__string(buf, "\\u00");
            _M0IPB13StringBuilderPB6Logger13write__string(buf, _M0MPC14byte4Byte7to__hex(code & 255));
          } else {
            _M0IPB13StringBuilderPB6Logger11write__char(buf, _M0MPC16uint166UInt1616unsafe__to__char(code));
          }
        }
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      return;
    }
  }
}
function _M0FPC14json13write__indent(buf, cache, level, indent) {
  while (true) {
    if (cache.length <= level) {
      if (cache.length >= 1) {
        const _last = cache[cache.length - 1 | 0];
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(cache, `${_last}${_M0MPC16string6String6repeat(" ", indent)}`);
      } else {
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(cache, "\n");
      }
      continue;
    } else {
      break;
    }
  }
  _M0IPB13StringBuilderPB6Logger13write__string(buf, _M0MPC15array5Array2atGRPB4JsonE(cache, level));
}
function _M0MPC14json4Json17stringify_2einner(self, escape_slash, indent, replacer) {
  const buf = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  const indent_cache = [];
  const stack = [];
  let depth = 0;
  let _tmp = self;
  while (true) {
    const x = _tmp;
    if (x === undefined) {
      if (stack.length === 0) {
        break;
      } else {
        const _x = stack[stack.length - 1 | 0];
        if (_x.$tag === 0) {
          const _Array = _x;
          const _arr = _Array._0;
          const _i = _Array._1;
          if (_i < _arr.length) {
            const element = _M0MPC15array5Array2atGRPB4JsonE(_arr, _i);
            _Array._1 = _i + 1 | 0;
            if (_i > 0) {
              _M0IPB13StringBuilderPB6Logger11write__char(buf, 44);
              if (indent > 0) {
                _M0FPC14json13write__indent(buf, indent_cache, depth, indent);
              }
            }
            _tmp = element;
            continue;
          } else {
            depth = depth - 1 | 0;
            _M0MPC15array5Array3popGRPC14json10WriteFrameE(stack);
            if (indent > 0) {
              _M0FPC14json13write__indent(buf, indent_cache, depth, indent);
            }
            _M0IPB13StringBuilderPB6Logger11write__char(buf, 93);
            _tmp = undefined;
            continue;
          }
        } else {
          const _Object = _x;
          const _iterator = _Object._0;
          const _first = _Object._1;
          const _bind$2 = _M0MPB4Iter4nextGUsRPB4JsonEE(_iterator);
          if (_bind$2 === undefined) {
            depth = depth - 1 | 0;
            _M0MPC15array5Array3popGRPC14json10WriteFrameE(stack);
            if (indent > 0) {
              _M0FPC14json13write__indent(buf, indent_cache, depth, indent);
            }
            _M0IPB13StringBuilderPB6Logger11write__char(buf, 125);
            _tmp = undefined;
            continue;
          } else {
            const _Some = _bind$2;
            const _x$2 = _Some;
            const _k = _x$2._0;
            const _v = _x$2._1;
            let v2 = _v;
            if (replacer === undefined) {
            } else {
              const _Some$2 = replacer;
              const _replacer = _Some$2;
              const _func = _replacer.f;
              const _bind$3 = _func(_k, _v);
              if (_bind$3 === undefined) {
                _tmp = undefined;
                continue;
              } else {
                const _Some$3 = _bind$3;
                const _v$2 = _Some$3;
                v2 = _v$2;
              }
            }
            if (!_first) {
              _M0IPB13StringBuilderPB6Logger11write__char(buf, 44);
              if (indent > 0) {
                _M0FPC14json13write__indent(buf, indent_cache, depth, indent);
              }
            }
            _M0IPB13StringBuilderPB6Logger11write__char(buf, 34);
            _M0FPC14json14write__escaped(buf, _k, escape_slash);
            _M0IPB13StringBuilderPB6Logger11write__char(buf, 34);
            _M0IPB13StringBuilderPB6Logger11write__char(buf, 58);
            if (indent > 0) {
              _M0IPB13StringBuilderPB6Logger11write__char(buf, 32);
            }
            _Object._1 = false;
            _tmp = v2;
            continue;
          }
        }
      }
    } else {
      const _Some = x;
      const _value = _Some;
      switch (_value.$tag) {
        case 6: {
          const _Object = _value;
          const _members = _Object._0;
          if (_M0MPB3Map9is__emptyGsRPB4JsonE(_members)) {
            _M0IPB13StringBuilderPB6Logger13write__string(buf, "{}");
          } else {
            depth = depth + 1 | 0;
            _M0IPB13StringBuilderPB6Logger11write__char(buf, 123);
            if (indent > 0) {
              _M0FPC14json13write__indent(buf, indent_cache, depth, indent);
            }
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(stack, new _M0DTPC14json10WriteFrame6Object(_M0MPB3Map4iterGsRPB4JsonE(_members), true));
          }
          break;
        }
        case 5: {
          const _Array = _value;
          const _arr = _Array._0;
          if (_M0MPC15array5Array9is__emptyGRPB4JsonE(_arr)) {
            _M0IPB13StringBuilderPB6Logger13write__string(buf, "[]");
          } else {
            depth = depth + 1 | 0;
            _M0IPB13StringBuilderPB6Logger11write__char(buf, 91);
            if (indent > 0) {
              _M0FPC14json13write__indent(buf, indent_cache, depth, indent);
            }
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(stack, new _M0DTPC14json10WriteFrame5Array(_arr, 0));
          }
          break;
        }
        case 4: {
          const _String = _value;
          const _s = _String._0;
          _M0IPB13StringBuilderPB6Logger11write__char(buf, 34);
          _M0FPC14json14write__escaped(buf, _s, escape_slash);
          _M0IPB13StringBuilderPB6Logger11write__char(buf, 34);
          break;
        }
        case 3: {
          const _Number = _value;
          const _n = _Number._0;
          const _repr = _Number._1;
          if (_repr === undefined) {
            _M0MPB13StringBuilder13write__objectGdE(buf, _n);
          } else {
            const _Some$2 = _repr;
            const _r = _Some$2;
            _M0IPB13StringBuilderPB6Logger13write__string(buf, _r);
          }
          break;
        }
        case 1: {
          _M0IPB13StringBuilderPB6Logger13write__string(buf, "true");
          break;
        }
        case 2: {
          _M0IPB13StringBuilderPB6Logger13write__string(buf, "false");
          break;
        }
        default: {
          _M0IPB13StringBuilderPB6Logger13write__string(buf, "null");
        }
      }
      _tmp = undefined;
      continue;
    }
  }
  return _M0MPB13StringBuilder10to__string(buf);
}
function _M0FPC16bigint11syntax__errGuE() {
  return new _M0DTPC16result6ResultGuRPB7FailureE3Err(new _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(_M0FPC16bigint16syntax__err__str));
}
function _M0FPC16bigint11syntax__errGRPC16bigint6BigIntE() {
  return new _M0DTPC16result6ResultGRPC16bigint6BigIntRPB7FailureE3Err(new _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(_M0FPC16bigint16syntax__err__str));
}
function _M0FPC16bigint9base__errGuE() {
  return new _M0DTPC16result6ResultGuRPB7FailureE3Err(new _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(_M0FPC16bigint14base__err__str));
}
function _M0FPC16bigint17digit__from__char(x) {
  return x >= 48 && x <= 57 ? x - 48 | 0 : x >= 65 && x <= 90 ? x + -55 | 0 : x >= 97 && x <= 122 ? x + -87 | 0 : -1;
}
function _M0FPC16bigint11pow2__shift(radix) {
  return radix >= 2 && (radix & (radix - 1 | 0)) === 0 ? $i32_ctz(radix) : undefined;
}
function _M0MPC16bigint6BigInt19from__string__radix(str, radix) {
  const len = str.end - str.start | 0;
  const sign = _M0IPC16uint166UInt16PB2Eq5equal(str.str.charCodeAt(str.start), 45) ? -1 : 1;
  const start = sign === -1 ? 1 : 0;
  if (start === len) {
    const _bind$2 = _M0FPC16bigint11syntax__errGuE();
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _ok._0;
    } else {
      return _bind$2;
    }
  }
  let acc = 0n;
  const _bind$2 = _M0FPC16bigint11pow2__shift(radix);
  if (_bind$2 === undefined) {
    const base = _M0MPC16bigint6BigInt9from__int(radix);
    let _tmp = start;
    while (true) {
      const i = _tmp;
      if (i < len) {
        const digit = _M0FPC16bigint17digit__from__char(str.str.charCodeAt(str.start + i | 0));
        if (digit < 0 || digit >= radix) {
          const _bind$3 = _M0FPC16bigint11syntax__errGuE();
          if (_bind$3.$tag === 1) {
            const _ok = _bind$3;
            _ok._0;
          } else {
            return _bind$3;
          }
        }
        acc = _M0IPC16bigint6BigIntPB3Add3add(_M0IPC16bigint6BigIntPB3Mul3mul(acc, base), _M0MPC16bigint6BigInt9from__int(digit));
        _tmp = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
  } else {
    const _Some = _bind$2;
    const _shift = _Some;
    let _tmp = start;
    while (true) {
      const i = _tmp;
      if (i < len) {
        const digit = _M0FPC16bigint17digit__from__char(str.str.charCodeAt(str.start + i | 0));
        if (digit < 0 || digit >= radix) {
          const _bind$3 = _M0FPC16bigint11syntax__errGuE();
          if (_bind$3.$tag === 1) {
            const _ok = _bind$3;
            _ok._0;
          } else {
            return _bind$3;
          }
        }
        acc = _M0IPC16bigint6BigIntPB5BitOr3lor(_M0IPC16bigint6BigIntPB3Shl3shl(acc, _shift), _M0MPC16bigint6BigInt9from__int(digit));
        _tmp = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
  }
  return new _M0DTPC16result6ResultGRPC16bigint6BigIntRPC15error5ErrorE2Ok(sign === -1 ? _M0IPC16bigint6BigIntPB3Neg3neg(acc) : acc);
}
function _M0FPC16bigint21parse__bigint_2einner(str, base) {
  if (base < 2 || base > 36) {
    const _bind$2 = _M0FPC16bigint9base__errGuE();
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _ok._0;
    } else {
      return _bind$2;
    }
  }
  if (_M0MPC16string10StringView9is__empty(str)) {
    const _bind$2 = _M0FPC16bigint11syntax__errGuE();
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _ok._0;
    } else {
      return _bind$2;
    }
  }
  const _bind$2 = str.str.charCodeAt(str.start + ((str.end - str.start | 0) - 1 | 0) | 0);
  if (_bind$2 >= 48 && _bind$2 <= 57) {
  } else {
    if (_bind$2 >= 65 && _bind$2 <= 90) {
    } else {
      if (_bind$2 >= 97 && _bind$2 <= 122) {
      } else {
        const _bind$3 = _M0FPC16bigint11syntax__errGuE();
        if (_bind$3.$tag === 1) {
          const _ok = _bind$3;
          _ok._0;
        } else {
          return _bind$3;
        }
      }
    }
  }
  if (base === 10) {
    _L: {
      _L$2: {
        _L$3: {
          _L$4: {
            if ((str.end - str.start | 0) >= 2) {
              const _x = str.str.charCodeAt(str.start);
              if (_x === 48) {
                const _x$2 = str.str.charCodeAt(str.start + 1 | 0);
                switch (_x$2) {
                  case 120: {
                    break _L$4;
                  }
                  case 88: {
                    break _L$4;
                  }
                  case 111: {
                    break _L$4;
                  }
                  case 79: {
                    break _L$4;
                  }
                  case 98: {
                    break _L$4;
                  }
                  case 66: {
                    break _L$4;
                  }
                }
              } else {
                if ((str.end - str.start | 0) >= 3) {
                  if (_x === 45) {
                    const _x$2 = str.str.charCodeAt(str.start + 1 | 0);
                    if (_x$2 === 48) {
                      const _x$3 = str.str.charCodeAt(str.start + 2 | 0);
                      switch (_x$3) {
                        case 120: {
                          break _L$4;
                        }
                        case 88: {
                          break _L$4;
                        }
                        case 111: {
                          break _L$4;
                        }
                        case 79: {
                          break _L$4;
                        }
                        case 98: {
                          break _L$4;
                        }
                        case 66: {
                          break _L$4;
                        }
                      }
                    } else {
                      if (_x$2 >= 48 && _x$2 <= 57) {
                      } else {
                        break _L$2;
                      }
                    }
                  } else {
                    if (_x >= 48 && _x <= 57) {
                    } else {
                      break _L$2;
                    }
                  }
                } else {
                  if (_x >= 48 && _x <= 57) {
                  } else {
                    if (_x === 45) {
                      const _x$2 = str.str.charCodeAt(str.start + 1 | 0);
                      if (_x$2 >= 48 && _x$2 <= 57) {
                      } else {
                        break _L$2;
                      }
                    } else {
                      break _L$2;
                    }
                  }
                }
              }
            } else {
              if ((str.end - str.start | 0) >= 1) {
                const _x = str.str.charCodeAt(str.start);
                if (_x >= 48 && _x <= 57) {
                } else {
                  break _L$2;
                }
              } else {
                break _L$2;
              }
            }
            break _L$3;
          }
          const _bind$3 = _M0FPC16bigint11syntax__errGuE();
          if (_bind$3.$tag === 1) {
            const _ok = _bind$3;
            _ok._0;
          } else {
            return _bind$3;
          }
        }
        break _L;
      }
      const _bind$3 = _M0FPC16bigint11syntax__errGuE();
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        _ok._0;
      } else {
        return _bind$3;
      }
    }
  }
  _L: {
    switch (base) {
      case 2: {
        break _L;
      }
      case 8: {
        break _L;
      }
      case 10: {
        break _L;
      }
      case 16: {
        break _L;
      }
      default: {
        return _M0MPC16bigint6BigInt19from__string__radix(str, base);
      }
    }
  }
  const _bind$3 = _M0MPC16bigint6BigInt17js__parse__string(_M0MPC16string10StringView4data(str), _M0MPC16string10StringView13start__offset(str), _M0MPC16string10StringView13start__offset(str) + (str.end - str.start | 0) | 0, base, (value) => new _M0DTPC16option6OptionGRPC16bigint6BigIntE4Some(value), _M0DTPC16option6OptionGRPC16bigint6BigIntE4None__);
  if (_bind$3.$tag === 1) {
    const _Some = _bind$3;
    const _value = _Some._0;
    return new _M0DTPC16result6ResultGRPC16bigint6BigIntRPC15error5ErrorE2Ok(_value);
  } else {
    return _M0FPC16bigint11syntax__errGRPC16bigint6BigIntE();
  }
}
function _M0MPC16bigint6BigInt18to__string_2einner(self, radix) {
  if (radix < 2 || radix > 36) {
    _M0FPC15abort5abortGuE("radix must be between 2 and 36");
  }
  return _M0MPC16bigint6BigInt21js__to__string__radix(self, radix);
}
function _M0IPC16bigint6BigIntPB7Compare7compare(self, other) {
  return _M0MPC16bigint6BigInt11compare__js(self, other);
}
function _M0IPC16bigint6BigIntPB2Eq5equal(self, other) {
  return _M0MPC16bigint6BigInt9equal__js(self, other);
}
function _M0IPC16bigint6BigIntPB3Neg3neg(self) {
  return _M0MPC16bigint6BigInt12op__neg__ffi(self);
}
function _M0IPC16bigint6BigIntPB3Add3add(self, other) {
  return _M0MPC16bigint6BigInt12op__add__ffi(self, other);
}
function _M0IPC16bigint6BigIntPB3Sub3sub(self, other) {
  return _M0MPC16bigint6BigInt12op__sub__ffi(self, other);
}
function _M0IPC16bigint6BigIntPB3Mul3mul(self, other) {
  return _M0MPC16bigint6BigInt12op__mul__ffi(self, other);
}
function _M0IPC16bigint6BigIntPB3Div3div(self, other) {
  return _M0MPC16bigint6BigInt12op__div__ffi(self, other);
}
function _M0IPC16bigint6BigIntPB3Mod3mod(self, other) {
  return _M0MPC16bigint6BigInt12op__mod__ffi(self, other);
}
function _M0MPC16bigint6BigInt3pow(self, exponent, modulus) {
  if (_M0IP016_24default__implPB7Compare6op__ltGRPC16bigint6BigIntE(exponent, 0n)) {
    _M0FPC15abort5abortGuE("negative exponent");
  }
  if (modulus.$tag === 1) {
    const _Some = modulus;
    const _modulus = _Some._0;
    return _M0IP016_24default__implPB7Compare6op__leGRPC16bigint6BigIntE(_modulus, 0n) ? _M0FPC15abort5abortGRPC16bigint6BigIntE("non-positive modulus") : _M0MPC16bigint6BigInt11modpow__ffi(self, exponent, _modulus);
  } else {
    return _M0MPC16bigint6BigInt8pow__ffi(self, exponent);
  }
}
function _M0IPC16bigint6BigIntPB3Shl3shl(self, n) {
  if (n < 0) {
    _M0FPC15abort5abortGuE("negative shift count");
  }
  return _M0MPC16bigint6BigInt7js__shl(self, n);
}
function _M0IPC16bigint6BigIntPB3Shr3shr(self, n) {
  if (n < 0) {
    _M0FPC15abort5abortGuE("negative shift count");
  }
  return _M0MPC16bigint6BigInt7js__shr(self, n);
}
function _M0IPC16bigint6BigIntPB6BitAnd4land(self, other) {
  return _M0MPC16bigint6BigInt8js__land(self, other);
}
function _M0IPC16bigint6BigIntPB5BitOr3lor(self, other) {
  return _M0MPC16bigint6BigInt7js__lor(self, other);
}
function _M0IPC16bigint6BigIntPB6BitXOr4lxor(self, other) {
  return _M0MPC16bigint6BigInt8js__lxor(self, other);
}
function _M0FPC16string21parse__bigint_2einner(str, base) {
  return _M0FPC16bigint21parse__bigint_2einner(str, base);
}
function _M0FPC14math3sin(_tmp) {
  return Math.sin(_tmp);
}
function _M0FPC14math3cos(_tmp) {
  return Math.cos(_tmp);
}
function _M0FPC14math3tan(_tmp) {
  return Math.tan(_tmp);
}
function _M0FPC14math4asin(_tmp) {
  return Math.asin(_tmp);
}
function _M0FPC14math4acos(_tmp) {
  return Math.acos(_tmp);
}
function _M0FPC14math4atan(_tmp) {
  return Math.atan(_tmp);
}
function _M0FPC14math5atan2(_tmp, _tmp$2) {
  return Math.atan2(_tmp, _tmp$2);
}
function _M0FPC14math3pow(_tmp, _tmp$2) {
  return Math.pow(_tmp, _tmp$2);
}
function _M0FPC14math2ln(_tmp) {
  return Math.log(_tmp);
}
function _M0FPC14math5log10(_tmp) {
  return Math.log10(_tmp);
}
function _M0FPC14math4sinh(_tmp) {
  return Math.sinh(_tmp);
}
function _M0FPC14math4cosh(_tmp) {
  return Math.cosh(_tmp);
}
function _M0FPC14math4tanh(_tmp) {
  return Math.tanh(_tmp);
}
function _M0FPC14math3exp(_tmp) {
  return Math.exp(_tmp);
}
function _M0FPC14math5hypot(_tmp, _tmp$2) {
  return Math.hypot(_tmp, _tmp$2);
}
function _M0IP211localreview3tcl8TclErrorPC15debug5Debug8to__repr(_x_1255) {
  let _arg_1258;
  _L: {
    let _arg_1257;
    _L$2: {
      let _arg_1256;
      _L$3: {
        switch (_x_1255.$tag) {
          case 4: {
            const _Invalid = _x_1255;
            const _$42$arg_1256 = _Invalid._0;
            _arg_1256 = _$42$arg_1256;
            break _L$3;
          }
          case 3: {
            const _Return = _x_1255;
            const _$42$arg_1257 = _Return._0;
            _arg_1257 = _$42$arg_1257;
            break _L$2;
          }
          case 2: {
            return _M0MPC15debug4Repr4ctor("Break", []);
          }
          case 1: {
            return _M0MPC15debug4Repr4ctor("Continue", []);
          }
          default: {
            const _Signal = _x_1255;
            const _$42$arg_1258 = _Signal._0;
            _arg_1258 = _$42$arg_1258;
            break _L;
          }
        }
      }
      return _M0MPC15debug4Repr4ctor("Invalid", [{ _0: undefined, _1: _M0IPC16string6StringPC15debug5Debug8to__repr(_arg_1256) }]);
    }
    return _M0MPC15debug4Repr4ctor("Return", [{ _0: undefined, _1: _M0IPC16string6StringPC15debug5Debug8to__repr(_arg_1257) }]);
  }
  return _M0MPC15debug4Repr4ctor("Signal", [{ _0: undefined, _1: _M0IP211localreview3tcl10CompletionPC15debug5Debug8to__repr(_arg_1258) }]);
}
function _M0IP211localreview3tcl10CompletionPC15debug5Debug8to__repr(_x_1253) {
  const _bind$2 = [{ _0: "code", _1: _M0IPC13int3IntPC15debug5Debug8to__repr(_x_1253.code) }, { _0: "level", _1: _M0IPC13int3IntPC15debug5Debug8to__repr(_x_1253.level) }, { _0: "value", _1: _M0IPC16string6StringPC15debug5Debug8to__repr(_x_1253.value) }, { _0: "options", _1: _M0IPC15array5ArrayPC15debug5Debug8to__reprGUssEE(_x_1253.options) }, { _0: "skip_trace", _1: _M0IPC14bool4BoolPC15debug5Debug8to__repr(_x_1253.skip_trace) }];
  return _M0MPC15debug4Repr6record(_M0MPB3Map3MapGsRPC15debug4ReprE(new _M0TPB9ArrayViewGUsRPC15debug4ReprEE(_bind$2, 0, 5), undefined));
}
function _M0FP211localreview3tcl15qualified__name(prefix, name) {
  let _tmp;
  if (!_M0MPC16string6String9is__empty(name)) {
    const _bind$2 = "::";
    _tmp = !_M0MPC16string6String8contains(name, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  } else {
    _tmp = false;
  }
  if (_tmp) {
    return prefix === "::" ? `::${name}` : `${prefix}::${name}`;
  }
  let _tmp$2;
  const _bind$2 = "::";
  if (_M0MPC16string6String11has__prefix(name, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
    let _tmp$3;
    const _bind$3 = ":::";
    if (!_M0MPC16string6String8contains(name, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
      const _bind$4 = "::";
      _tmp$3 = !_M0MPC16string6String11has__suffix(name, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
    } else {
      _tmp$3 = false;
    }
    _tmp$2 = _tmp$3;
  } else {
    _tmp$2 = false;
  }
  if (_tmp$2) {
    return name;
  }
  let value;
  const _bind$3 = "::";
  if (_M0MPC16string6String11has__prefix(name, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
    value = name;
  } else {
    value = `${prefix}::${name}`;
  }
  const chars = _M0MPC16string6String9to__array(value);
  const out = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  const i = new _M0TPB8MutLocalGiE(0);
  while (true) {
    if (i.val < chars.length) {
      if (_M0MPC15array5Array2atGcE(chars, i.val) === 58 && ((i.val + 1 | 0) < chars.length && _M0MPC15array5Array2atGcE(chars, i.val + 1 | 0) === 58)) {
        _M0IPB13StringBuilderPB6Logger13write__string(out, "::");
        while (true) {
          if (i.val < chars.length && _M0MPC15array5Array2atGcE(chars, i.val) === 58) {
            i.val = i.val + 1 | 0;
            continue;
          } else {
            break;
          }
        }
      } else {
        _M0IPB13StringBuilderPB6Logger11write__char(out, _M0MPC15array5Array2atGcE(chars, i.val));
        i.val = i.val + 1 | 0;
      }
      continue;
    } else {
      break;
    }
  }
  const normalized = _M0MPB13StringBuilder10to__string(out);
  const _bind$4 = "::";
  const _tmp$3 = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB4Iter6filterGRPC16string10StringViewE(_M0MPC16string6String5split(normalized, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length)), (s) => !_M0MPC16string10StringView9is__empty(s)));
  const _bind$5 = "::";
  return `::${_M0MPC15array5Array4joinGRPC16string10StringViewE(_tmp$3, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length))}`;
}
function _M0FP211localreview3tcl17namespace__parent(name) {
  let _tmp;
  const _bind$2 = "::";
  if (_M0MPC16string6String11has__prefix(name, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
    let _tmp$2;
    const _bind$3 = ":::";
    if (!_M0MPC16string6String8contains(name, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
      const _bind$4 = "::";
      _tmp$2 = !_M0MPC16string6String11has__suffix(name, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
    } else {
      _tmp$2 = false;
    }
    _tmp = _tmp$2;
  } else {
    _tmp = false;
  }
  if (_tmp) {
    const _bind$3 = "::";
    const index = _M0MPC16option6Option10unwrap__orGiE(_M0MPC16string6String9rev__find(name, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length)), 0);
    return index === 0 ? "::" : _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(name, 0, index));
  }
  const _bind$3 = "::";
  const parts = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB4Iter6filterGRPC16string10StringViewE(_M0MPC16string6String5split(name, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length)), (s) => !_M0MPC16string10StringView9is__empty(s)));
  if (parts.length < 2) {
    return "::";
  } else {
    const _tmp$2 = _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(parts, 0, parts.length - 1 | 0));
    const _bind$4 = "::";
    return `::${_M0MPC15array5Array4joinGRPC16string10StringViewE(_tmp$2, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length))}`;
  }
}
function _M0FP211localreview3tcl15namespace__tail(name) {
  const _bind$2 = "::";
  const _tmp = _M0MPC15array5Array4lastGRPC16string10StringViewE(_M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPC16string6String5split(name, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))));
  const _bind$3 = "";
  return _M0MPC16string10StringView9to__owned(_M0MPC16option6Option10unwrap__orGsE(_tmp, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length)));
}
function _M0FP211localreview3tcl15variable__parts(name) {
  _L: {
    const _bind$2 = ")";
    if (_M0MPC16string6String11has__suffix(name, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
      let at;
      _L$2: {
        const _bind$3 = "(";
        const _bind$4 = _M0MPC16string6String4find(name, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length));
        if (_bind$4 === undefined) {
          break _L;
        } else {
          const _Some = _bind$4;
          const _at = _Some;
          at = _at;
          break _L$2;
        }
      }
      return { _0: _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(name, 0, at)), _1: _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(name, at + 1 | 0, name.length - 1 | 0)) };
    } else {
      break _L;
    }
  }
  return { _0: name, _1: undefined };
}
function _M0MP211localreview3tcl11Interpreter15global__defined(self, name) {
  if (_M0MPB3Map8containsGsRP211localreview3tcl7BindingE(self.state.aliases, name)) {
    return true;
  }
  let cell;
  _L: {
    const _bind$2 = _M0MPB3Map3getGsRP211localreview3tcl4CellE(self.state.globals, name);
    if (_bind$2 === undefined) {
      return false;
    } else {
      const _Some = _bind$2;
      const _cell = _Some;
      cell = _cell;
      break _L;
    }
  }
  const _bind$2 = cell.value;
  return _bind$2 === undefined ? cell.declared : true;
}
function _M0MP211localreview3tcl11Interpreter7binding(self, name, create) {
  let base;
  let index;
  _L: {
    const _bind$2 = _M0FP211localreview3tcl15variable__parts(name);
    const _base = _bind$2._0;
    const _index = _bind$2._1;
    base = _base;
    index = _index;
    break _L;
  }
  let _tmp;
  const _bind$2 = "::";
  if (!_M0MPC16string6String8contains(base, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
    _tmp = self.frame.procedure || _M0MPB3Map8containsGsRP211localreview3tcl7BindingE(self.frame.vars, base);
  } else {
    _tmp = false;
  }
  if (_tmp) {
    let binding;
    const _bind$3 = _M0MPB3Map3getGsRP211localreview3tcl7BindingE(self.frame.vars, base);
    if (_bind$3 === undefined) {
      if (!create) {
        return new _M0DTPC16result6ResultGORP211localreview3tcl7BindingRP211localreview3tcl8TclErrorE2Ok(undefined);
      }
      const binding$2 = new _M0TP211localreview3tcl7Binding(new _M0TP211localreview3tcl4Cell(undefined, false), undefined, false);
      _M0MPB3Map3setGsRP211localreview3tcl7BindingE(self.frame.vars, base, binding$2);
      binding = binding$2;
    } else {
      const _Some = _bind$3;
      const _binding = _Some;
      binding = _binding;
    }
    if (index === undefined) {
    } else {
      const _bind$4 = binding.index;
      if (_bind$4 === undefined) {
      } else {
        return new _M0DTPC16result6ResultGORP211localreview3tcl7BindingRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("variable is not an array"));
      }
    }
    return new _M0DTPC16result6ResultGORP211localreview3tcl7BindingRP211localreview3tcl8TclErrorE2Ok(new _M0TP211localreview3tcl7Binding(binding.cell, index === undefined ? binding.index : index, binding.linked));
  }
  const key = new _M0TPB8MutLocalGsE(_M0FP211localreview3tcl15qualified__name(self.frame.namespace_name, base));
  let _tmp$2;
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(self.frame.namespace_name, "::")) {
    let _tmp$3;
    const _bind$3 = "::";
    if (!_M0MPC16string6String8contains(base, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
      _tmp$3 = !_M0MP211localreview3tcl11Interpreter15global__defined(self, key.val) && _M0MP211localreview3tcl11Interpreter15global__defined(self, `::${base}`);
    } else {
      _tmp$3 = false;
    }
    _tmp$2 = _tmp$3;
  } else {
    _tmp$2 = false;
  }
  if (_tmp$2) {
    key.val = `::${base}`;
  }
  let binding;
  _L$2: {
    _L$3: {
      const _bind$3 = _M0MPB3Map3getGsRP211localreview3tcl7BindingE(self.state.aliases, key.val);
      if (_bind$3 === undefined) {
      } else {
        const _Some = _bind$3;
        const _binding = _Some;
        binding = _binding;
        break _L$3;
      }
      break _L$2;
    }
    if (index === undefined) {
    } else {
      const _bind$3 = binding.index;
      if (_bind$3 === undefined) {
      } else {
        return new _M0DTPC16result6ResultGORP211localreview3tcl7BindingRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("variable is not an array"));
      }
    }
    return new _M0DTPC16result6ResultGORP211localreview3tcl7BindingRP211localreview3tcl8TclErrorE2Ok(new _M0TP211localreview3tcl7Binding(binding.cell, index === undefined ? binding.index : index, binding.linked));
  }
  let cell;
  const _bind$3 = _M0MPB3Map3getGsRP211localreview3tcl4CellE(self.state.globals, key.val);
  if (_bind$3 === undefined) {
    if (!create) {
      return new _M0DTPC16result6ResultGORP211localreview3tcl7BindingRP211localreview3tcl8TclErrorE2Ok(undefined);
    }
    if (!_M0MPB3Map8containsGsbE(self.state.namespaces, _M0FP211localreview3tcl17namespace__parent(key.val))) {
      return new _M0DTPC16result6ResultGORP211localreview3tcl7BindingRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("parent namespace does not exist"));
    }
    const cell$2 = new _M0TP211localreview3tcl4Cell(undefined, false);
    _M0MPB3Map3setGsRP211localreview3tcl4CellE(self.state.globals, key.val, cell$2);
    cell = cell$2;
  } else {
    const _Some = _bind$3;
    const _cell = _Some;
    cell = _cell;
  }
  return new _M0DTPC16result6ResultGORP211localreview3tcl7BindingRP211localreview3tcl8TclErrorE2Ok(new _M0TP211localreview3tcl7Binding(cell, index, false));
}
function _M0MP211localreview3tcl11Interpreter14link__variable(self, name, binding) {
  const _bind$2 = _M0MP211localreview3tcl11Interpreter7binding(self, name, false);
  let previous;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    previous = _ok._0;
  } else {
    return _bind$2;
  }
  let old;
  _L: {
    _L$2: {
      if (previous === undefined) {
      } else {
        const _Some = previous;
        const _old = _Some;
        old = _old;
        break _L$2;
      }
      break _L;
    }
    const _bind$3 = old.cell.value;
    if (_bind$3 === undefined) {
    } else {
      _L$3: {
        _L$4: {
          if (!(old.cell === binding.cell)) {
            break _L$4;
          } else {
            if (_M0IP016_24default__implPB2Eq10not__equalGOsE(old.index, binding.index)) {
              break _L$4;
            }
          }
          break _L$3;
        }
        return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("variable already exists"));
      }
    }
  }
  const linked = new _M0TP211localreview3tcl7Binding(binding.cell, binding.index, true);
  if (self.frame.procedure) {
    _M0MPB3Map3setGsRP211localreview3tcl7BindingE(self.frame.vars, name, linked);
  } else {
    _M0MPB3Map3setGsRP211localreview3tcl7BindingE(self.state.aliases, _M0FP211localreview3tcl15qualified__name(self.frame.namespace_name, name), linked);
  }
  return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
}
function _M0MP211localreview3tcl10DictObject4text(self) {
  const _bind$2 = self.representation;
  if (_bind$2 === undefined) {
    const _tmp = self.encoded;
    const _bind$3 = " ";
    const text = _M0MPC15array5Array4joinGsE(_tmp, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length));
    self.representation = text;
    return text;
  } else {
    const _Some = _bind$2;
    const _text = _Some;
    return _text;
  }
}
function _M0MP211localreview3tcl10ListObject4text(self) {
  const _bind$2 = self.representation;
  if (_bind$2 === undefined) {
    const _tmp = self.encoded;
    const _bind$3 = " ";
    const text = _M0MPC15array5Array4joinGsE(_tmp, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length));
    self.representation = text;
    return text;
  } else {
    const _Some = _bind$2;
    const _text = _Some;
    return _text;
  }
}
function _M0MP211localreview3tcl7Binding4read(self) {
  _L: {
    let values;
    let index;
    _L$2: {
      let value;
      _L$3: {
        let value$2;
        _L$4: {
          let value$3;
          _L$5: {
            const _bind$2 = self.cell.value;
            const _bind$3 = self.index;
            if (_bind$2 === undefined) {
              return new _M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE2Ok(undefined);
            } else {
              const _Some = _bind$2;
              const _x = _Some;
              switch (_x.$tag) {
                case 0: {
                  const _Scalar = _x;
                  const _value = _Scalar._0;
                  if (_bind$3 === undefined) {
                    value$3 = _value;
                    break _L$5;
                  } else {
                    break _L;
                  }
                }
                case 1: {
                  const _Sequence = _x;
                  const _value$2 = _Sequence._0;
                  if (_bind$3 === undefined) {
                    value$2 = _value$2;
                    break _L$4;
                  } else {
                    break _L;
                  }
                }
                case 2: {
                  const _Mapping = _x;
                  const _value$3 = _Mapping._0;
                  if (_bind$3 === undefined) {
                    value = _value$3;
                    break _L$3;
                  } else {
                    break _L;
                  }
                }
                default: {
                  const _Elements = _x;
                  const _values = _Elements._0;
                  if (_bind$3 === undefined) {
                    return new _M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("variable is array"));
                  } else {
                    const _Some$2 = _bind$3;
                    const _index = _Some$2;
                    values = _values;
                    index = _index;
                    break _L$2;
                  }
                }
              }
            }
          }
          return new _M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE2Ok(value$3);
        }
        return new _M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE2Ok(_M0MP211localreview3tcl10ListObject4text(value$2));
      }
      return new _M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE2Ok(_M0MP211localreview3tcl10DictObject4text(value));
    }
    return new _M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE2Ok(_M0MPB3Map3getGssE(values, index));
  }
  return new _M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("variable is not an array"));
}
function _M0MP211localreview3tcl11Interpreter8get__var(self, name) {
  let binding;
  _L: {
    const _bind$2 = _M0MP211localreview3tcl11Interpreter7binding(self, name, false);
    let _bind$3;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _bind$3 = _ok._0;
    } else {
      return _bind$2;
    }
    if (_bind$3 === undefined) {
      return new _M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE2Ok(undefined);
    } else {
      const _Some = _bind$3;
      const _binding = _Some;
      binding = _binding;
      break _L;
    }
  }
  return _M0MP211localreview3tcl7Binding4read(binding);
}
function _M0FP211localreview3tcl18completion_2einner(code, value, level, options, skip_trace) {
  return new _M0TP211localreview3tcl10Completion(code, level, value, options, skip_trace);
}
function _M0FP211localreview3tcl10completion(code, value, level$46$opt, options$46$opt, skip_trace$46$opt) {
  let level;
  if (level$46$opt === undefined) {
    level = 0;
  } else {
    const _Some = level$46$opt;
    level = _Some;
  }
  let options;
  if (options$46$opt.$tag === 1) {
    const _Some = options$46$opt;
    options = _Some._0;
  } else {
    options = [];
  }
  const skip_trace = skip_trace$46$opt === -1 ? false : skip_trace$46$opt;
  return _M0FP211localreview3tcl18completion_2einner(code, value, level, options, skip_trace);
}
function _M0FP211localreview3tcl25completion__error_2einner(message, errorcode) {
  return _M0FP211localreview3tcl18completion_2einner(1, message, 0, [{ _0: "-errorcode", _1: errorcode }], false);
}
function _M0FP211localreview3tcl11list__space(c) {
  return c === 32 || (c === 9 || (c === 13 || (c === 10 || (c === 11 || c === 12))));
}
function _M0FP211localreview3tcl14quote__element(text, first) {
  if (_M0MPC16string6String9is__empty(text)) {
    return "{}";
  }
  const cs = _M0MPC16string6String9to__array(text);
  const use_braces = new _M0TPB8MutLocalGbE(_M0MPC15array5Array2atGcE(cs, 0) === 123 || (_M0MPC15array5Array2atGcE(cs, 0) === 34 || first && _M0MPC15array5Array2atGcE(cs, 0) === 35));
  const escape = new _M0TPB8MutLocalGbE(false);
  const balanced = new _M0TPB8MutLocalGbE(true);
  const level = new _M0TPB8MutLocalGiE(0);
  const i = new _M0TPB8MutLocalGiE(0);
  while (true) {
    if (i.val < cs.length) {
      const c = _M0MPC15array5Array2atGcE(cs, i.val);
      if (_M0FP211localreview3tcl11list__space(c) || (c === 36 || (c === 91 || (c === 59 || c === 92)))) {
        use_braces.val = true;
      }
      if (c === 93 || c === 34) {
        escape.val = true;
      }
      if (c === 92) {
        i.val = i.val + 1 | 0;
        if (i.val === cs.length || _M0MPC15array5Array2atGcE(cs, i.val) === 10) {
          balanced.val = false;
        }
      } else {
        if (c === 123) {
          level.val = level.val + 1 | 0;
        } else {
          if (c === 125) {
            level.val = level.val - 1 | 0;
            if (level.val < 0) {
              balanced.val = false;
            }
          }
        }
      }
      i.val = i.val + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  balanced.val = balanced.val && level.val === 0;
  if (use_braces.val && balanced.val) {
    return `{${text}}`;
  }
  if (!use_braces.val && (!escape.val && balanced.val)) {
    return text;
  }
  const out = [];
  const _bind$2 = 0;
  const _bind$3 = cs.length;
  let _tmp = _bind$2;
  while (true) {
    const i$2 = _tmp;
    if (i$2 < _bind$3) {
      const c = _M0MPC15array5Array2atGcE(cs, i$2);
      let _tmp$2;
      _L: {
        _L$2: {
          switch (c) {
            case 10: {
              _tmp$2 = "\\n";
              break;
            }
            case 13: {
              _tmp$2 = "\\r";
              break;
            }
            case 9: {
              _tmp$2 = "\\t";
              break;
            }
            case 11: {
              _tmp$2 = "\\v";
              break;
            }
            case 12: {
              _tmp$2 = "\\f";
              break;
            }
            case 32: {
              break _L$2;
            }
            case 123: {
              break _L$2;
            }
            case 125: {
              break _L$2;
            }
            case 91: {
              break _L$2;
            }
            case 93: {
              break _L$2;
            }
            case 36: {
              break _L$2;
            }
            case 59: {
              break _L$2;
            }
            case 34: {
              break _L$2;
            }
            case 92: {
              break _L$2;
            }
            case 35: {
              _tmp$2 = first && i$2 === 0 ? "\\#" : "#";
              break;
            }
            default: {
              _tmp$2 = _M0IPC14char4CharPB4Show10to__string(c);
            }
          }
          break _L;
        }
        _tmp$2 = `\\${_M0IPC14char4CharPB4Show10to__string(c)}`;
      }
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(out, _tmp$2);
      _tmp = i$2 + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$4 = "";
  return _M0MPC15array5Array4joinGsE(out, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
}
function _M0FP211localreview3tcl12format__list(values) {
  if (values.length > 100000) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("list element limit"));
  }
  const out = [];
  const size = new _M0TPB8MutLocalGiE(0);
  const _bind$2 = 0;
  const _bind$3 = values.length;
  let _tmp = _bind$2;
  while (true) {
    const i = _tmp;
    if (i < _bind$3) {
      if (_M0MPC15array5Array2atGRPB4JsonE(values, i).length > 1000000) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("list size limit"));
      }
      const value = _M0FP211localreview3tcl14quote__element(_M0MPC15array5Array2atGRPB4JsonE(values, i), i === 0);
      size.val = size.val + (value.length + (i > 0 ? 1 : 0) | 0) | 0;
      if (size.val > 1000000) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("list size limit"));
      }
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(out, value);
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$4 = " ";
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC15array5Array4joinGsE(out, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length)));
}
function _M0MP211localreview3tcl11Interpreter9read__var(self, name) {
  const _bind$2 = _M0MP211localreview3tcl11Interpreter7binding(self, name, false);
  let binding;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    binding = _ok._0;
  } else {
    return _bind$2;
  }
  let reason;
  let code;
  _L: {
    let binding$2;
    _L$2: {
      if (binding === undefined) {
        reason = "no such variable";
        code = "";
        break _L;
      } else {
        const _Some = binding;
        const _binding = _Some;
        binding$2 = _binding;
        break _L$2;
      }
    }
    _L$3: {
      let values;
      let index;
      _L$4: {
        const _bind$3 = binding$2.cell.value;
        const _bind$4 = binding$2.index;
        if (_bind$3 === undefined) {
          break _L$3;
        } else {
          const _Some = _bind$3;
          const _x = _Some;
          if (_x.$tag === 3) {
            const _Elements = _x;
            if (_bind$4 === undefined) {
              reason = "variable is array";
              code = "TCL READ VARNAME";
              break _L;
            } else {
              const _values = _Elements._0;
              const _Some$2 = _bind$4;
              const _index = _Some$2;
              values = _values;
              index = _index;
              break _L$4;
            }
          } else {
            if (_bind$4 === undefined) {
              break _L$3;
            } else {
              reason = "variable isn't array";
              code = binding$2.linked ? "TCL LOOKUP VARNAME" : "";
              break _L;
            }
          }
        }
      }
      let value;
      _L$5: {
        const _bind$3 = _M0MPB3Map3getGssE(values, index);
        if (_bind$3 === undefined) {
          let _tmp;
          if (binding$2.linked) {
            const _bind$4 = _M0FP211localreview3tcl15variable__parts(name)._1;
            _tmp = _bind$4 === undefined ? "no such variable" : "no such element in array";
          } else {
            _tmp = "no such element in array";
          }
          reason = _tmp;
          code = "TCL READ VARNAME";
          break _L;
        } else {
          const _Some = _bind$3;
          const _value = _Some;
          value = _value;
          break _L$5;
        }
      }
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(value);
    }
    let value;
    _L$4: {
      const _bind$3 = _M0MP211localreview3tcl7Binding4read(binding$2);
      let _bind$4;
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        _bind$4 = _ok._0;
      } else {
        return _bind$3;
      }
      if (_bind$4 === undefined) {
        let _tmp;
        _L$5: {
          _L$6: {
            if (binding$2.linked) {
              const _bind$5 = _M0FP211localreview3tcl15variable__parts(name)._1;
              if (_bind$5 === undefined) {
                break _L$6;
              } else {
                _tmp = "TCL LOOKUP VARNAME";
              }
            } else {
              break _L$6;
            }
            break _L$5;
          }
          if (binding$2.linked) {
            _tmp = "TCL READ VARNAME";
          } else {
            if (binding$2.cell.declared) {
              const _bind$5 = binding$2.index;
              _tmp = _bind$5 === undefined ? "TCL READ VARNAME" : "";
            } else {
              _tmp = "";
            }
          }
        }
        reason = "no such variable";
        code = _tmp;
        break _L;
      } else {
        const _Some = _bind$4;
        const _value = _Some;
        value = _value;
        break _L$4;
      }
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(value);
  }
  let code$2;
  if (_M0MPC16string6String9is__empty(code)) {
    let base;
    _L$2: {
      const _bind$3 = _M0FP211localreview3tcl15variable__parts(name);
      const _base = _bind$3._0;
      base = _base;
      break _L$2;
    }
    const _bind$3 = _M0FP211localreview3tcl12format__list(["TCL", "LOOKUP", "VARNAME", base]);
    if (_bind$3.$tag === 1) {
      const _ok = _bind$3;
      code$2 = _ok._0;
    } else {
      return _bind$3;
    }
  } else {
    code$2 = code;
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_M0FP211localreview3tcl25completion__error_2einner(`can't read \"${name}\": ${reason}`, code$2)));
}
function _M0MP211localreview3tcl11Interpreter8set__var(self, name, value) {
  if (value.length > 1000000) {
    return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("variable size limit"));
  }
  const _bind$2 = _M0MP211localreview3tcl11Interpreter7binding(self, name, true);
  let _tmp;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    _tmp = _ok._0;
  } else {
    return _bind$2;
  }
  const binding = _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_tmp);
  let index;
  _L: {
    const _bind$3 = binding.index;
    if (_bind$3 === undefined) {
      const _bind$4 = binding.cell.value;
      if (_bind$4 === undefined) {
      } else {
        const _Some = _bind$4;
        const _x = _Some;
        if (_x.$tag === 3) {
          return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("variable is array"));
        }
      }
      binding.cell.value = new _M0DTP211localreview3tcl13VariableValue6Scalar(value);
      return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
    } else {
      const _Some = _bind$3;
      const _index = _Some;
      index = _index;
      break _L;
    }
  }
  let values;
  _L$2: {
    _L$3: {
      const _bind$3 = binding.cell.value;
      if (_bind$3 === undefined) {
        const _bind$4 = [];
        const values$2 = _M0MPB3Map3MapGssE(new _M0TPB9ArrayViewGUssEE(_bind$4, 0, 0), undefined);
        binding.cell.value = new _M0DTP211localreview3tcl13VariableValue8Elements(values$2);
        values = values$2;
      } else {
        const _Some = _bind$3;
        const _x = _Some;
        switch (_x.$tag) {
          case 0: {
            break _L$3;
          }
          case 1: {
            break _L$3;
          }
          case 2: {
            break _L$3;
          }
          default: {
            const _Elements = _x;
            const _values = _Elements._0;
            values = _values;
          }
        }
      }
      break _L$2;
    }
    return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("variable is not an array"));
  }
  if (_M0MPB3Map6lengthGsRP211localreview3tcl13ScriptProgramE(values) >= 10000 && !_M0MPB3Map8containsGssE(values, index)) {
    return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("array size limit"));
  }
  return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(_M0MPB3Map3setGssE(values, index, value));
}
function _M0MP211localreview3tcl11Interpreter10unset__var(self, name, quiet) {
  let binding;
  const _bind$2 = _M0MP211localreview3tcl11Interpreter7binding(self, name, false);
  let _bind$3;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    _bind$3 = _ok._0;
  } else {
    return _bind$2;
  }
  if (_bind$3 === undefined) {
    if (quiet) {
      return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
    }
    return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid(`undefined variable ${name}`));
  } else {
    const _Some = _bind$3;
    const _binding = _Some;
    binding = _binding;
  }
  let index;
  _L: {
    const _bind$4 = binding.index;
    if (_bind$4 === undefined) {
      const _bind$5 = binding.cell.value;
      if (_bind$5 === undefined) {
        if (!quiet) {
          return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid(`undefined variable ${name}`));
        }
      }
      binding.cell.value = undefined;
      binding.cell.declared = false;
      return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
    } else {
      const _Some = _bind$4;
      const _index = _Some;
      index = _index;
      break _L;
    }
  }
  _L$2: {
    let values;
    _L$3: {
      const _bind$4 = binding.cell.value;
      if (_bind$4 === undefined) {
        break _L$2;
      } else {
        const _Some = _bind$4;
        const _x = _Some;
        if (_x.$tag === 3) {
          const _Elements = _x;
          const _values = _Elements._0;
          values = _values;
          break _L$3;
        } else {
          break _L$2;
        }
      }
    }
    if (!_M0MPB3Map8containsGssE(values, index) && !quiet) {
      return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("undefined array element"));
    }
    return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(_M0MPB3Map6removeGssE(values, index));
  }
  if (!quiet) {
    return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("variable is not an array"));
  } else {
    return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
  }
}
function _M0MP211localreview3tcl11Interpreter11with__frame(self, frame) {
  return new _M0TP211localreview3tcl11Interpreter(self.state, frame, self.output, self.output_size, self.budget);
}
function _M0FP211localreview3tcl14small__decimal(text) {
  const length = text.length;
  if (length === 0 || length > 10) {
    return undefined;
  }
  const initial = _M0MPC16option6Option6unwrapGkE(_M0MPC16string6String3get(text, 0));
  const negative = initial === 45;
  const start = negative || initial === 43 ? 1 : 0;
  if (length === start || (length - start | 0) > 9) {
    return undefined;
  }
  if ((length - start | 0) > 1 && _M0MPC16option6Option6unwrapGkE(_M0MPC16string6String3get(text, start)) === 48) {
    return undefined;
  }
  const value = new _M0TPB8MutLocalGiE(0);
  let _tmp = start;
  while (true) {
    const i = _tmp;
    if (i < length) {
      const digit = _M0MPC16option6Option6unwrapGkE(_M0MPC16string6String3get(text, i)) - 48 | 0;
      if (digit < 0 || digit > 9) {
        return undefined;
      }
      value.val = (Math.imul(value.val, 10) | 0) + digit | 0;
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return negative ? -value.val | 0 : value.val;
}
function _M0FP211localreview3tcl5whole(text) {
  let value;
  _L: {
    _L$2: {
      const _bind$2 = _M0FP211localreview3tcl14small__decimal(text);
      if (_bind$2 === undefined) {
      } else {
        const _Some = _bind$2;
        const _value = _Some;
        value = _value;
        break _L$2;
      }
      break _L;
    }
    return new _M0DTPC16result6ResultGRPC16bigint6BigIntRP211localreview3tcl8TclErrorE2Ok(_M0MPC16bigint6BigInt9from__int(value));
  }
  const text$2 = _M0MPC16string10StringView9to__owned(_M0MPC16string6String4trim(text, undefined));
  if (text$2.length > 5000) {
    return new _M0DTPC16result6ResultGRPC16bigint6BigIntRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("integer size limit"));
  }
  const _bind$2 = "-";
  const negative = _M0MPC16string6String11has__prefix(text$2, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  let s;
  let _tmp;
  if (negative) {
    _tmp = true;
  } else {
    const _bind$3 = "+";
    _tmp = _M0MPC16string6String11has__prefix(text$2, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length));
  }
  if (_tmp) {
    s = _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(text$2, 1, undefined));
  } else {
    s = text$2;
  }
  let digits;
  let base;
  _L$2: {
    let _tmp$2;
    const _bind$3 = "0x";
    if (_M0MPC16string6String11has__prefix(s, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
      _tmp$2 = true;
    } else {
      const _bind$4 = "0X";
      _tmp$2 = _M0MPC16string6String11has__prefix(s, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
    }
    if (_tmp$2) {
      digits = _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(s, 2, undefined));
      base = 16;
      break _L$2;
    } else {
      let _tmp$3;
      const _bind$4 = "0b";
      if (_M0MPC16string6String11has__prefix(s, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length))) {
        _tmp$3 = true;
      } else {
        const _bind$5 = "0B";
        _tmp$3 = _M0MPC16string6String11has__prefix(s, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length));
      }
      if (_tmp$3) {
        digits = _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(s, 2, undefined));
        base = 2;
        break _L$2;
      } else {
        let _tmp$4;
        const _bind$5 = "0o";
        if (_M0MPC16string6String11has__prefix(s, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length))) {
          _tmp$4 = true;
        } else {
          const _bind$6 = "0O";
          _tmp$4 = _M0MPC16string6String11has__prefix(s, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length));
        }
        if (_tmp$4) {
          digits = _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(s, 2, undefined));
          base = 8;
          break _L$2;
        } else {
          let _tmp$5;
          if (s.length > 1) {
            const _bind$6 = "0";
            _tmp$5 = _M0MPC16string6String11has__prefix(s, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length));
          } else {
            _tmp$5 = false;
          }
          if (_tmp$5) {
            digits = s;
            base = 8;
            break _L$2;
          } else {
            digits = s;
            base = 10;
            break _L$2;
          }
        }
      }
    }
  }
  let _tmp$2;
  const _bind$3 = "-";
  if (_M0MPC16string6String11has__prefix(digits, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
    _tmp$2 = true;
  } else {
    const _bind$4 = "+";
    _tmp$2 = _M0MPC16string6String11has__prefix(digits, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
  }
  if (_tmp$2) {
    return new _M0DTPC16result6ResultGRPC16bigint6BigIntRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid(`expected integer: ${text$2}`));
  }
  let value$2;
  let _try_err;
  _L$3: {
    _L$4: {
      const _bind$4 = _M0FPC16string21parse__bigint_2einner(new _M0TPC16string10StringView(digits, 0, digits.length), base);
      if (_bind$4.$tag === 1) {
        const _ok = _bind$4;
        value$2 = _ok._0;
      } else {
        const _err = _bind$4;
        _try_err = _err._0;
        break _L$4;
      }
      break _L$3;
    }
    return new _M0DTPC16result6ResultGRPC16bigint6BigIntRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid(`expected integer: ${text$2}`));
  }
  if (_M0MPC16bigint6BigInt11bit__length(value$2) > 16384) {
    return new _M0DTPC16result6ResultGRPC16bigint6BigIntRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("integer bit limit"));
  }
  return new _M0DTPC16result6ResultGRPC16bigint6BigIntRP211localreview3tcl8TclErrorE2Ok(negative ? _M0IPC16bigint6BigIntPB3Neg3neg(value$2) : value$2);
}
function _M0FP211localreview3tcl7integer(s) {
  let value;
  _L: {
    _L$2: {
      const _bind$2 = _M0FP211localreview3tcl14small__decimal(s);
      if (_bind$2 === undefined) {
      } else {
        const _Some = _bind$2;
        const _value = _Some;
        value = _value;
        break _L$2;
      }
      break _L;
    }
    return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(value);
  }
  const _bind$2 = _M0FP211localreview3tcl5whole(s);
  let n;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    n = _ok._0;
  } else {
    return _bind$2;
  }
  if (_M0IP016_24default__implPB7Compare6op__ltGRPC16bigint6BigIntE(n, _M0IPC16bigint6BigIntPB3Neg3neg(2147483648n)) || _M0IP016_24default__implPB7Compare6op__gtGRPC16bigint6BigIntE(n, 2147483647n)) {
    return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("bounded integer required"));
  }
  return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(_M0MPC16bigint6BigInt7to__int(n));
}
function _M0MP211localreview3tcl11Interpreter12level__frame(self, level) {
  const frames = [self.frame];
  const cursor = new _M0TPB8MutLocalGRP211localreview3tcl5FrameE(self.frame);
  while (true) {
    let parent;
    _L: {
      const _bind$2 = cursor.val.parent;
      if (_bind$2 === undefined) {
        break;
      } else {
        const _Some = _bind$2;
        const _parent = _Some;
        parent = _parent;
        break _L;
      }
    }
    _M0MPC15array5Array4pushGRPC14json10WriteFrameE(frames, parent);
    cursor.val = parent;
    continue;
  }
  let index;
  const _bind$2 = "#";
  if (_M0MPC16string6String11has__prefix(level, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
    const _tmp = frames.length - 1 | 0;
    const _bind$3 = _M0FP211localreview3tcl7integer(_M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(level, 1, undefined)));
    let _tmp$2;
    if (_bind$3.$tag === 1) {
      const _ok = _bind$3;
      _tmp$2 = _ok._0;
    } else {
      return _bind$3;
    }
    index = _tmp - _tmp$2 | 0;
  } else {
    const _bind$3 = _M0FP211localreview3tcl7integer(level);
    if (_bind$3.$tag === 1) {
      const _ok = _bind$3;
      index = _ok._0;
    } else {
      return _bind$3;
    }
  }
  if (index < 0 || index >= frames.length) {
    return new _M0DTPC16result6ResultGRP211localreview3tcl5FrameRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("bad level"));
  }
  return new _M0DTPC16result6ResultGRP211localreview3tcl5FrameRP211localreview3tcl8TclErrorE2Ok(_M0MPC15array5Array2atGRPB4JsonE(frames, index));
}
function _M0FP211localreview3tcl13boolean__text(value) {
  return value ? "1" : "0";
}
function _M0FP211localreview3tcl13command__name(prefix, name) {
  const result = _M0FP211localreview3tcl15qualified__name(prefix, name);
  let _tmp;
  if (_M0MPC16string6String9is__empty(name)) {
    _tmp = true;
  } else {
    const _bind$2 = "::";
    _tmp = _M0MPC16string6String11has__suffix(name, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  }
  if (_tmp) {
    return result === "::" ? result : `${result}::`;
  } else {
    return result;
  }
}
function _M0FP211localreview3tcl11glob__match(pattern, value, nocase) {
  const p = _M0MPC16string6String9to__array(nocase ? _M0MPC16string6String9to__lower(pattern) : pattern);
  const s = _M0MPC16string6String9to__array(nocase ? _M0MPC16string6String9to__lower(value) : value);
  let _tmp;
  if (p.length > 4096) {
    _tmp = true;
  } else {
    let _tmp$2;
    if (s.length > 100000) {
      _tmp$2 = true;
    } else {
      const _tmp$3 = p.length;
      const _tmp$4 = s.length + 1 | 0;
      if (_tmp$4 === 0) {
        $panic();
      }
      _tmp$2 = _tmp$3 > (1000000 / _tmp$4 | 0);
    }
    _tmp = _tmp$2;
  }
  if (_tmp) {
    return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("glob work limit"));
  }
  const tokens = [];
  const i = new _M0TPB8MutLocalGiE(0);
  while (true) {
    if (i.val < p.length) {
      const c = _M0MPC15array5Array2atGcE(p, i.val);
      i.val = i.val + 1 | 0;
      if (c === 42) {
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(tokens, _M0DTP211localreview3tcl9GlobToken4Many__);
      } else {
        if (c === 63) {
          _M0MPC15array5Array4pushGRPC14json10WriteFrameE(tokens, _M0DTP211localreview3tcl9GlobToken3One__);
        } else {
          if (c === 92) {
            if (i.val === p.length) {
              return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE2Ok(false);
            }
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(tokens, new _M0DTP211localreview3tcl9GlobToken9Character(_M0MPC15array5Array2atGcE(p, i.val)));
            i.val = i.val + 1 | 0;
          } else {
            if (c === 91) {
              const ranges = [];
              const closed = new _M0TPB8MutLocalGbE(false);
              while (true) {
                if (i.val < p.length) {
                  if (_M0MPC15array5Array2atGcE(p, i.val) === 93) {
                    i.val = i.val + 1 | 0;
                    closed.val = true;
                    break;
                  }
                  const first = _M0MPC15array5Array2atGcE(p, i.val);
                  i.val = i.val + 1 | 0;
                  if ((i.val + 1 | 0) < p.length && (_M0MPC15array5Array2atGcE(p, i.val) === 45 && _M0MPC15array5Array2atGcE(p, i.val + 1 | 0) !== 93)) {
                    _M0MPC15array5Array4pushGRPC14json10WriteFrameE(ranges, { _0: first, _1: _M0MPC15array5Array2atGcE(p, i.val + 1 | 0) });
                    i.val = i.val + 2 | 0;
                  } else {
                    _M0MPC15array5Array4pushGRPC14json10WriteFrameE(ranges, { _0: first, _1: first });
                  }
                  continue;
                } else {
                  break;
                }
              }
              if (!closed.val) {
                return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE2Ok(false);
              }
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(tokens, new _M0DTP211localreview3tcl9GlobToken5Range(ranges));
            } else {
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(tokens, new _M0DTP211localreview3tcl9GlobToken9Character(c));
            }
          }
        }
      }
      continue;
    } else {
      break;
    }
  }
  const previous = new _M0TPB8MutLocalGRPB5ArrayGbEE(_M0MPC15array5Array4makeGbE(s.length + 1 | 0, false));
  _M0MPC15array5Array3setGbE(previous.val, 0, true);
  const _bind$2 = tokens.length;
  let _tmp$2 = 0;
  while (true) {
    const _ = _tmp$2;
    if (_ < _bind$2) {
      const token = tokens[_];
      const next = _M0MPC15array5Array4makeGbE(s.length + 1 | 0, false);
      if (token.$tag === 0) {
        _M0MPC15array5Array3setGbE(next, 0, _M0MPC15array5Array2atGbE(previous.val, 0));
      }
      const _bind$3 = 1;
      const _bind$4 = s.length;
      let _tmp$3 = _bind$3;
      while (true) {
        const j = _tmp$3;
        if (j <= _bind$4) {
          let _tmp$4;
          let ranges;
          _L: {
            _L$2: {
              let c;
              _L$3: {
                _L$4: {
                  switch (token.$tag) {
                    case 0: {
                      _tmp$4 = _M0MPC15array5Array2atGbE(previous.val, j) || _M0MPC15array5Array2atGbE(next, j - 1 | 0);
                      break;
                    }
                    case 1: {
                      _tmp$4 = _M0MPC15array5Array2atGbE(previous.val, j - 1 | 0);
                      break;
                    }
                    case 2: {
                      const _Character = token;
                      const _c = _Character._0;
                      c = _c;
                      break _L$4;
                    }
                    default: {
                      const _Range = token;
                      const _ranges = _Range._0;
                      ranges = _ranges;
                      break _L$2;
                    }
                  }
                  break _L$3;
                }
                _tmp$4 = _M0MPC15array5Array2atGbE(previous.val, j - 1 | 0) && _M0MPC15array5Array2atGcE(s, j - 1 | 0) === c;
              }
              break _L;
            }
            _tmp$4 = _M0MPC15array5Array2atGbE(previous.val, j - 1 | 0) && _M0MPB4Iter3anyGUssEE(_M0MPC15array5Array4iterGUssEE(ranges), (pair) => _M0MPC15array5Array2atGcE(s, j - 1 | 0) >= pair._0 && _M0MPC15array5Array2atGcE(s, j - 1 | 0) <= pair._1 || _M0MPC15array5Array2atGcE(s, j - 1 | 0) >= pair._1 && _M0MPC15array5Array2atGcE(s, j - 1 | 0) <= pair._0);
          }
          _M0MPC15array5Array3setGbE(next, j, _tmp$4);
          _tmp$3 = j + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      previous.val = next;
      _tmp$2 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE2Ok(_M0MPC15array5Array2atGbE(previous.val, s.length));
}
function _M0FP211localreview3tcl10hex__digit(c) {
  return c >= 48 && c <= 57 ? c - 48 | 0 : c >= 97 && c <= 102 ? c - 87 | 0 : c >= 65 && c <= 70 ? c - 55 | 0 : -1;
}
function _M0FP211localreview3tcl9backslash(cs, start) {
  const i = new _M0TPB8MutLocalGiE(start + 1 | 0);
  if (i.val >= cs.length) {
    return { _0: "\\", _1: i.val };
  }
  const c = _M0MPC15array5Array2atGcE(cs, i.val);
  i.val = i.val + 1 | 0;
  let result;
  _L: {
    _L$2: {
      switch (c) {
        case 97: {
          result = "\u0007";
          break;
        }
        case 98: {
          result = "\b";
          break;
        }
        case 102: {
          result = "\f";
          break;
        }
        case 110: {
          result = "\n";
          break;
        }
        case 114: {
          result = "\r";
          break;
        }
        case 116: {
          result = "\t";
          break;
        }
        case 118: {
          result = "\u000b";
          break;
        }
        case 10: {
          while (true) {
            if (i.val < cs.length && (_M0MPC15array5Array2atGcE(cs, i.val) === 32 || _M0MPC15array5Array2atGcE(cs, i.val) === 9)) {
              i.val = i.val + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          result = " ";
          break;
        }
        case 120: {
          break _L$2;
        }
        case 117: {
          break _L$2;
        }
        case 85: {
          break _L$2;
        }
        default: {
          if (c >= 48 && c <= 55) {
            const value = new _M0TPB8MutLocalGiE(c - 48 | 0);
            const count = new _M0TPB8MutLocalGiE(1);
            const limit = c <= 51 ? 3 : 2;
            while (true) {
              if (i.val < cs.length && (count.val < limit && (_M0MPC15array5Array2atGcE(cs, i.val) >= 48 && _M0MPC15array5Array2atGcE(cs, i.val) <= 55))) {
                value.val = ((Math.imul(value.val, 8) | 0) + _M0MPC15array5Array2atGcE(cs, i.val) | 0) - 48 | 0;
                i.val = i.val + 1 | 0;
                count.val = count.val + 1 | 0;
                continue;
              } else {
                break;
              }
            }
            result = _M0IPC14char4CharPB4Show10to__string(_M0MPC16option6Option10unwrap__orGcE(_M0MPC13int3Int8to__char(value.val), 65533));
          } else {
            result = _M0IPC14char4CharPB4Show10to__string(c);
          }
        }
      }
      break _L;
    }
    const limit = c === 120 ? 2 : c === 117 ? 4 : 8;
    const value = new _M0TPB8MutLocalGmE(0n);
    const count = new _M0TPB8MutLocalGiE(0);
    while (true) {
      if (i.val < cs.length && count.val < limit) {
        const digit = _M0FP211localreview3tcl10hex__digit(_M0MPC15array5Array2atGcE(cs, i.val));
        if (digit < 0) {
          break;
        }
        value.val = BigInt.asUintN(64, BigInt.asUintN(64, value.val * 16n) + _M0MPC13int3Int10to__uint64(digit));
        count.val = count.val + 1 | 0;
        i.val = i.val + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    result = count.val === 0 ? _M0IPC14char4CharPB4Show10to__string(c) : BigInt.asUintN(64, value.val) > BigInt.asUintN(64, 65535n) ? "�" : _M0IPC14char4CharPB4Show10to__string(_M0MPC16option6Option10unwrap__orGcE(_M0MPC13int3Int8to__char(Number(BigInt.asIntN(32, value.val)) | 0), 65533));
  }
  return { _0: result, _1: i.val };
}
function _M0FP211localreview3tcl11parse__list(text) {
  if (text.length > 1000000) {
    return new _M0DTPC16result6ResultGRPB5ArrayGsERP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("list size limit"));
  }
  const cs = _M0MPC16string6String9to__array(text);
  const values = [];
  const i = new _M0TPB8MutLocalGiE(0);
  while (true) {
    if (i.val < cs.length) {
      while (true) {
        if (i.val < cs.length && _M0FP211localreview3tcl11list__space(_M0MPC15array5Array2atGcE(cs, i.val))) {
          i.val = i.val + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      if (i.val === cs.length) {
        break;
      }
      const out = _M0MPB13StringBuilder21StringBuilder_2einner(0);
      if (_M0MPC15array5Array2atGcE(cs, i.val) === 123) {
        i.val = i.val + 1 | 0;
        const level = new _M0TPB8MutLocalGiE(1);
        while (true) {
          if (i.val < cs.length && level.val > 0) {
            const c = _M0MPC15array5Array2atGcE(cs, i.val);
            i.val = i.val + 1 | 0;
            if (c === 92 && i.val < cs.length) {
              _M0IPB13StringBuilderPB6Logger11write__char(out, 92);
              _M0IPB13StringBuilderPB6Logger11write__char(out, _M0MPC15array5Array2atGcE(cs, i.val));
              i.val = i.val + 1 | 0;
            } else {
              if (c === 123) {
                level.val = level.val + 1 | 0;
                _M0IPB13StringBuilderPB6Logger11write__char(out, 123);
              } else {
                if (c === 125) {
                  level.val = level.val - 1 | 0;
                  if (level.val > 0) {
                    _M0IPB13StringBuilderPB6Logger11write__char(out, 125);
                  }
                } else {
                  _M0IPB13StringBuilderPB6Logger11write__char(out, c);
                }
              }
            }
            continue;
          } else {
            break;
          }
        }
        if (level.val !== 0) {
          return new _M0DTPC16result6ResultGRPB5ArrayGsERP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unmatched open brace in list"));
        }
        if (i.val < cs.length && !_M0FP211localreview3tcl11list__space(_M0MPC15array5Array2atGcE(cs, i.val))) {
          return new _M0DTPC16result6ResultGRPB5ArrayGsERP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("characters after braced list element"));
        }
      } else {
        if (_M0MPC15array5Array2atGcE(cs, i.val) === 34) {
          i.val = i.val + 1 | 0;
          const closed = new _M0TPB8MutLocalGbE(false);
          while (true) {
            if (i.val < cs.length) {
              const c = _M0MPC15array5Array2atGcE(cs, i.val);
              if (c === 34) {
                i.val = i.val + 1 | 0;
                closed.val = true;
                break;
              }
              if (c === 92) {
                let v;
                let next;
                _L: {
                  const _bind$2 = _M0FP211localreview3tcl9backslash(cs, i.val);
                  const _v = _bind$2._0;
                  const _next = _bind$2._1;
                  v = _v;
                  next = _next;
                  break _L;
                }
                _M0IPB13StringBuilderPB6Logger13write__string(out, v);
                i.val = next;
              } else {
                _M0IPB13StringBuilderPB6Logger11write__char(out, c);
                i.val = i.val + 1 | 0;
              }
              continue;
            } else {
              break;
            }
          }
          if (!closed.val) {
            return new _M0DTPC16result6ResultGRPB5ArrayGsERP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unmatched quote in list"));
          }
          if (i.val < cs.length && !_M0FP211localreview3tcl11list__space(_M0MPC15array5Array2atGcE(cs, i.val))) {
            return new _M0DTPC16result6ResultGRPB5ArrayGsERP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("characters after quoted list element"));
          }
        } else {
          while (true) {
            if (i.val < cs.length && !_M0FP211localreview3tcl11list__space(_M0MPC15array5Array2atGcE(cs, i.val))) {
              if (_M0MPC15array5Array2atGcE(cs, i.val) === 92) {
                let v;
                let next;
                _L: {
                  const _bind$2 = _M0FP211localreview3tcl9backslash(cs, i.val);
                  const _v = _bind$2._0;
                  const _next = _bind$2._1;
                  v = _v;
                  next = _next;
                  break _L;
                }
                _M0IPB13StringBuilderPB6Logger13write__string(out, v);
                i.val = next;
              } else {
                _M0IPB13StringBuilderPB6Logger11write__char(out, _M0MPC15array5Array2atGcE(cs, i.val));
                i.val = i.val + 1 | 0;
              }
              continue;
            } else {
              break;
            }
          }
        }
      }
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values, _M0MPB13StringBuilder10to__string(out));
      if (values.length > 100000) {
        return new _M0DTPC16result6ResultGRPB5ArrayGsERP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("list element limit"));
      }
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGRPB5ArrayGsERP211localreview3tcl8TclErrorE2Ok(values);
}
function _M0FP211localreview3tcl15select__keyword(value, choices) {
  if (_M0MPC15array5Array8containsGsE(choices, value)) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(value);
  }
  const matches = _M0MPC15array5Array6filterGsE(choices, (choice) => _M0MPC16string6String11has__prefix(choice, new _M0TPC16string10StringView(value, 0, value.length)));
  if (matches.length !== 1) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unknown or ambiguous subcommand or option"));
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC15array5Array2atGRPB4JsonE(matches, 0));
}
function _M0MP211localreview3tcl7Command6origin(self) {
  const cursor = new _M0TPB8MutLocalGRP211localreview3tcl7CommandE(self);
  while (true) {
    let target;
    _L: {
      const _bind$2 = cursor.val.body;
      if (_bind$2.$tag === 2) {
        const _Imported = _bind$2;
        const _target = _Imported._0;
        target = _target;
        break _L;
      } else {
        break;
      }
    }
    cursor.val = target;
    continue;
  }
  return cursor.val;
}
function _M0MP211localreview3tcl7Command11depends__on(self, target) {
  const cursor = new _M0TPB8MutLocalGRP211localreview3tcl7CommandE(self);
  while (true) {
    if (cursor.val === target) {
      return true;
    }
    let parent;
    _L: {
      const _bind$2 = cursor.val.body;
      if (_bind$2.$tag === 2) {
        const _Imported = _bind$2;
        const _parent = _Imported._0;
        parent = _parent;
        break _L;
      } else {
        return false;
      }
    }
    cursor.val = parent;
    continue;
  }
}
function _M0MP211localreview3tcl11Interpreter15delete__command(self, command) {
  const doomed = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB4Iter6filterGRPC16string10StringViewE(_M0MPB3Map6valuesGsRP211localreview3tcl7CommandE(self.state.commands), (c) => _M0MP211localreview3tcl7Command11depends__on(c, command)));
  const _bind$2 = doomed.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const item = doomed[_];
      _M0MPB3Map6removeGsRP211localreview3tcl7CommandE(self.state.commands, item.name);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      return;
    }
  }
}
function _M0FP211localreview3tcl15command__parent(name) {
  let _tmp;
  const _bind$2 = "::";
  if (_M0MPC16string6String11has__suffix(name, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
    _tmp = _M0IP016_24default__implPB2Eq10not__equalGsE(name, "::");
  } else {
    _tmp = false;
  }
  if (_tmp) {
    return _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(name, 0, name.length - 2 | 0));
  } else {
    return _M0FP211localreview3tcl17namespace__parent(name);
  }
}
function _M0MP211localreview3tcl8Ensemble6option(self, option) {
  let key;
  _L: {
    const _bind$2 = _M0FP211localreview3tcl15select__keyword(option, ["-namespace", "-map", "-parameters", "-prefixes", "-subcommands", "-unknown"]);
    let _bind$3;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _bind$3 = _ok._0;
    } else {
      return _bind$2;
    }
    switch (_bind$3) {
      case "-namespace": {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(self.namespace_name);
      }
      case "-prefixes": {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(self.prefixes));
      }
      default: {
        key = _bind$3;
        break _L;
      }
    }
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC16option6Option10unwrap__orGsE(_M0MPB3Map3getGssE(self.option_text, key), ""));
}
function _M0FP211localreview3tcl6number(text) {
  let value;
  _L: {
    _L$2: {
      const _bind$2 = _M0FP211localreview3tcl14small__decimal(text);
      if (_bind$2 === undefined) {
      } else {
        const _Some = _bind$2;
        const _value = _Some;
        value = _value;
        break _L$2;
      }
      break _L;
    }
    return new _M0DTP211localreview3tcl6Number5Small(value);
  }
  let value$2;
  _L$2: {
    _L$3: {
      let _bind$2;
      let _try_err;
      _L$4: {
        _L$5: {
          const _bind$3 = _M0FP211localreview3tcl5whole(text);
          let _tmp;
          if (_bind$3.$tag === 1) {
            const _ok = _bind$3;
            _tmp = _ok._0;
          } else {
            const _err = _bind$3;
            _try_err = _err._0;
            break _L$5;
          }
          _bind$2 = new _M0DTPC16option6OptionGRPC16bigint6BigIntE4Some(_tmp);
          break _L$4;
        }
        _bind$2 = _M0DTPC16option6OptionGRPC16bigint6BigIntE4None__;
      }
      if (_bind$2.$tag === 1) {
        const _Some = _bind$2;
        const _value = _Some._0;
        value$2 = _value;
        break _L$3;
      }
      break _L$2;
    }
    return new _M0DTP211localreview3tcl6Number5Whole(value$2);
  }
  const text$2 = _M0MPC16string10StringView9to__owned(_M0MPC16string6String4trim(text, undefined));
  const lower = _M0MPC16string6String9to__lower(text$2);
  if (lower === "inf" || (lower === "+inf" || (lower === "infinity" || lower === "+infinity"))) {
    return new _M0DTP211localreview3tcl6Number4Real(1 / 0);
  }
  if (lower === "-inf" || lower === "-infinity") {
    return new _M0DTP211localreview3tcl6Number4Real(-1 / 0);
  }
  if (lower === "nan") {
    return new _M0DTP211localreview3tcl6Number4Real(0 / 0);
  }
  let _tmp;
  const _bind$2 = ".";
  if (!_M0MPC16string6String8contains(text$2, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
    const _bind$3 = "e";
    _tmp = !_M0MPC16string6String8contains(lower, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length));
  } else {
    _tmp = false;
  }
  if (_tmp) {
    return undefined;
  }
  let _try_err;
  _L$3: {
    const _bind$3 = _M0FPC28internal7strconv13parse__double(new _M0TPC16string10StringView(text$2, 0, text$2.length));
    let _tmp$2;
    if (_bind$3.$tag === 1) {
      const _ok = _bind$3;
      _tmp$2 = _ok._0;
    } else {
      const _err = _bind$3;
      _try_err = _err._0;
      break _L$3;
    }
    return new _M0DTP211localreview3tcl6Number4Real(_tmp$2);
  }
  return undefined;
}
function _M0MP211localreview3tcl6Number6double(self) {
  let x;
  _L: {
    let x$2;
    _L$2: {
      switch (self.$tag) {
        case 0: {
          const _Small = self;
          const _x = _Small._0;
          x$2 = _x;
          break _L$2;
        }
        case 2: {
          const _Real = self;
          const _x$2 = _Real._0;
          return _x$2;
        }
        default: {
          const _Whole = self;
          const _x$3 = _Whole._0;
          x = _x$3;
          break _L;
        }
      }
    }
    return x$2 + 0;
  }
  let _try_err;
  _L$2: {
    const _bind$2 = _M0MPC16bigint6BigInt18to__string_2einner(x, 10);
    const _bind$3 = _M0FPC28internal7strconv13parse__double(new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
    if (_bind$3.$tag === 1) {
      const _ok = _bind$3;
      return _ok._0;
    } else {
      const _err = _bind$3;
      _try_err = _err._0;
      break _L$2;
    }
  }
  return _M0IP016_24default__implPB7Compare6op__ltGRPC16bigint6BigIntE(x, 0n) ? -1 / 0 : 1 / 0;
}
function _M0FP211localreview3tcl7boolean(text) {
  let n;
  _L: {
    _L$2: {
      const _bind$2 = _M0FP211localreview3tcl6number(text);
      if (_bind$2 === undefined) {
      } else {
        const _Some = _bind$2;
        const _n = _Some;
        n = _n;
        break _L$2;
      }
      break _L;
    }
    const value = _M0MP211localreview3tcl6Number6double(n);
    if (_M0MPC16double6Double7is__nan(value)) {
      return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expected boolean"));
    }
    return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE2Ok(value !== 0);
  }
  const text$2 = _M0MPC16string6String9to__lower(text);
  if (_M0MPC16string6String9is__empty(text$2)) {
    return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expected boolean"));
  }
  if (_M0MPB4Iter3anyGUssEE(_M0MPC15array5Array4iterGUssEE(["true", "yes", "on"]), (s) => _M0MPC16string6String11has__prefix(s, new _M0TPC16string10StringView(text$2, 0, text$2.length))) && _M0IP016_24default__implPB2Eq10not__equalGsE(text$2, "o")) {
    return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE2Ok(true);
  }
  if (_M0MPB4Iter3anyGUssEE(_M0MPC15array5Array4iterGUssEE(["false", "no", "off"]), (s) => _M0MPC16string6String11has__prefix(s, new _M0TPC16string10StringView(text$2, 0, text$2.length))) && _M0IP016_24default__implPB2Eq10not__equalGsE(text$2, "o")) {
    return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE2Ok(false);
  }
  return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expected boolean"));
}
function _M0MP211localreview3tcl11Interpreter19configure__ensemble(self, ensemble, options) {
  if (2 === 0) {
    $panic();
  }
  if ((options.length % 2 | 0) !== 0) {
    return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("ensemble option value required"));
  }
  const candidate = new _M0TP211localreview3tcl8Ensemble(ensemble.namespace_name, ensemble.mapping, ensemble.parameters, ensemble.prefixes, ensemble.subcommands, ensemble.unknown, _M0MPB3Map10from__iterGssE(_M0MPB3Map4iterGsRPB4JsonE(ensemble.option_text)));
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < options.length) {
      const value = _M0MPC15array5Array2atGRPB4JsonE(options, i + 1 | 0);
      const _bind$2 = _M0FP211localreview3tcl15select__keyword(_M0MPC15array5Array2atGRPB4JsonE(options, i), ["-namespace", "-map", "-parameters", "-prefixes", "-subcommands", "-unknown"]);
      let key;
      if (_bind$2.$tag === 1) {
        const _ok = _bind$2;
        key = _ok._0;
      } else {
        return _bind$2;
      }
      _M0MPB3Map3setGssE(candidate.option_text, key, value);
      switch (key) {
        case "-map": {
          const _bind$3 = _M0FP211localreview3tcl11parse__list(value);
          let parts;
          if (_bind$3.$tag === 1) {
            const _ok = _bind$3;
            parts = _ok._0;
          } else {
            return _bind$3;
          }
          if (2 === 0) {
            $panic();
          }
          if ((parts.length % 2 | 0) !== 0) {
            return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("ensemble map must be dictionary"));
          }
          const mapping = [];
          const changed = new _M0TPB8MutLocalGbE(false);
          let _tmp$2 = 0;
          while (true) {
            const j = _tmp$2;
            if (j < parts.length) {
              const _bind$4 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(parts, j + 1 | 0));
              let words;
              if (_bind$4.$tag === 1) {
                const _ok = _bind$4;
                words = _ok._0;
              } else {
                return _bind$4;
              }
              if (_M0MPC15array5Array9is__emptyGRPB4JsonE(words)) {
                return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("ensemble command prefix must not be empty"));
              }
              const _tmp$3 = _M0MPC15array5Array2atGRPB4JsonE(words, 0);
              const _bind$5 = "::";
              if (!_M0MPC16string6String11has__prefix(_tmp$3, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length))) {
                changed.val = true;
                _M0MPC15array5Array3setGUssEE(words, 0, _M0FP211localreview3tcl13command__name(self.frame.namespace_name, _M0MPC15array5Array2atGRPB4JsonE(words, 0)));
              }
              const previous = new _M0TPB8MutLocalGiE(-1);
              const _bind$6 = 0;
              const _bind$7 = mapping.length;
              let _tmp$4 = _bind$6;
              while (true) {
                const k = _tmp$4;
                if (k < _bind$7) {
                  if (_M0MPC15array5Array2atGRPB4JsonE(mapping, k)._0 === _M0MPC15array5Array2atGRPB4JsonE(parts, j)) {
                    previous.val = k;
                  }
                  _tmp$4 = k + 1 | 0;
                  continue;
                } else {
                  break;
                }
              }
              if (previous.val < 0) {
                _M0MPC15array5Array4pushGRPC14json10WriteFrameE(mapping, { _0: _M0MPC15array5Array2atGRPB4JsonE(parts, j), _1: words });
              } else {
                _M0MPC15array5Array3setGUssEE(mapping, previous.val, { _0: _M0MPC15array5Array2atGRPB4JsonE(parts, j), _1: words });
              }
              _tmp$2 = j + 2 | 0;
              continue;
            } else {
              break;
            }
          }
          candidate.mapping = mapping;
          if (changed.val) {
            const values = [];
            const _bind$4 = mapping.length;
            let _tmp$3 = 0;
            while (true) {
              const _ = _tmp$3;
              if (_ < _bind$4) {
                const _foreach_element = mapping[_];
                let key$2;
                let words;
                _L: {
                  const _key = _foreach_element._0;
                  const _words = _foreach_element._1;
                  key$2 = _key;
                  words = _words;
                  break _L;
                }
                _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values, key$2);
                const _bind$5 = _M0FP211localreview3tcl12format__list(words);
                let _tmp$4;
                if (_bind$5.$tag === 1) {
                  const _ok = _bind$5;
                  _tmp$4 = _ok._0;
                } else {
                  return _bind$5;
                }
                _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values, _tmp$4);
                _tmp$3 = _ + 1 | 0;
                continue;
              } else {
                break;
              }
            }
            const _tmp$4 = candidate.option_text;
            const _bind$5 = _M0FP211localreview3tcl12format__list(values);
            let _tmp$5;
            if (_bind$5.$tag === 1) {
              const _ok = _bind$5;
              _tmp$5 = _ok._0;
            } else {
              return _bind$5;
            }
            _M0MPB3Map3setGssE(_tmp$4, "-map", _tmp$5);
          }
          break;
        }
        case "-parameters": {
          const _bind$4 = _M0FP211localreview3tcl11parse__list(value);
          let _tmp$3;
          if (_bind$4.$tag === 1) {
            const _ok = _bind$4;
            _tmp$3 = _ok._0;
          } else {
            return _bind$4;
          }
          candidate.parameters = _tmp$3;
          break;
        }
        case "-prefixes": {
          const _bind$5 = _M0FP211localreview3tcl7boolean(value);
          let _tmp$4;
          if (_bind$5.$tag === 1) {
            const _ok = _bind$5;
            _tmp$4 = _ok._0;
          } else {
            return _bind$5;
          }
          candidate.prefixes = _tmp$4;
          break;
        }
        case "-subcommands": {
          const _bind$6 = _M0FP211localreview3tcl11parse__list(value);
          let _tmp$5;
          if (_bind$6.$tag === 1) {
            const _ok = _bind$6;
            _tmp$5 = _ok._0;
          } else {
            return _bind$6;
          }
          candidate.subcommands = _tmp$5;
          break;
        }
        case "-unknown": {
          const _bind$7 = _M0FP211localreview3tcl11parse__list(value);
          let _tmp$6;
          if (_bind$7.$tag === 1) {
            const _ok = _bind$7;
            _tmp$6 = _ok._0;
          } else {
            return _bind$7;
          }
          candidate.unknown = _tmp$6;
          break;
        }
        default: {
          return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unknown or read-only ensemble option"));
        }
      }
      _tmp = i + 2 | 0;
      continue;
    } else {
      break;
    }
  }
  ensemble.option_text = candidate.option_text;
  ensemble.mapping = candidate.mapping;
  ensemble.parameters = candidate.parameters;
  ensemble.prefixes = candidate.prefixes;
  ensemble.subcommands = candidate.subcommands;
  ensemble.unknown = candidate.unknown;
  return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
}
function _M0MP211localreview3tcl11Interpreter15define__command(self, name, body) {
  let command;
  _L: {
    const _bind$2 = _M0MPB3Map3getGsRP211localreview3tcl7CommandE(self.state.commands, name);
    if (_bind$2 === undefined) {
      if (_M0MPB3Map6lengthGsRP211localreview3tcl13ScriptProgramE(self.state.commands) >= 10000) {
        return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("command count limit"));
      }
      return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(_M0MPB3Map3setGsRP211localreview3tcl7CommandE(self.state.commands, name, new _M0TP211localreview3tcl7Command(name, body)));
    } else {
      const _Some = _bind$2;
      const _command = _Some;
      command = _command;
      break _L;
    }
  }
  command.body = body;
  return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
}
function _M0MP211localreview3tcl11Interpreter13find__command(self, name) {
  const key = _M0FP211localreview3tcl13command__name(self.frame.namespace_name, name);
  let command;
  _L: {
    _L$2: {
      const _bind$2 = _M0MPB3Map3getGsRP211localreview3tcl7CommandE(self.state.commands, key);
      if (_bind$2 === undefined) {
      } else {
        const _Some = _bind$2;
        const _command = _Some;
        command = _command;
        break _L$2;
      }
      break _L;
    }
    return command;
  }
  const _bind$2 = "::";
  if (!_M0MPC16string6String11has__prefix(name, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
    let path;
    _L$2: {
      _L$3: {
        const _bind$3 = _M0MPB3Map3getGsRPB5ArrayGsEE(self.state.namespace_paths, self.frame.namespace_name);
        if (_bind$3.$tag === 1) {
          const _Some = _bind$3;
          const _path = _Some._0;
          path = _path;
          break _L$3;
        }
        break _L$2;
      }
      const _bind$3 = path.length;
      let _tmp = 0;
      while (true) {
        const _ = _tmp;
        if (_ < _bind$3) {
          const space = path[_];
          let command$2;
          _L$4: {
            _L$5: {
              const _bind$4 = _M0MPB3Map3getGsRP211localreview3tcl7CommandE(self.state.commands, _M0FP211localreview3tcl13command__name(space, name));
              if (_bind$4 === undefined) {
              } else {
                const _Some = _bind$4;
                const _command = _Some;
                command$2 = _command;
                break _L$5;
              }
              break _L$4;
            }
            return command$2;
          }
          _tmp = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    }
    return _M0MPB3Map3getGsRP211localreview3tcl7CommandE(self.state.commands, _M0FP211localreview3tcl13command__name("::", name));
  }
  return undefined;
}
function _M0MP211localreview3tcl11Interpreter17ensemble__command(self, args) {
  const n = args.length;
  if (n < 3) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace ensemble arity"));
  }
  const _bind$2 = _M0FP211localreview3tcl15select__keyword(_M0MPC15array5Array2atGRPB4JsonE(args, 2), ["create", "exists", "configure"]);
  let _bind$3;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    _bind$3 = _ok._0;
  } else {
    return _bind$2;
  }
  switch (_bind$3) {
    case "create": {
      if (2 === 0) {
        $panic();
      }
      if ((n % 2 | 0) !== 1) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("ensemble option value required"));
      }
      const name = new _M0TPB8MutLocalGsE(self.frame.namespace_name);
      const options = [];
      let _tmp = 3;
      while (true) {
        const i = _tmp;
        if (i < n) {
          const _bind$4 = _M0FP211localreview3tcl15select__keyword(_M0MPC15array5Array2atGRPB4JsonE(args, i), ["-command", "-map", "-parameters", "-prefixes", "-subcommands", "-unknown"]);
          let option;
          if (_bind$4.$tag === 1) {
            const _ok = _bind$4;
            option = _ok._0;
          } else {
            return _bind$4;
          }
          if (option === "-command") {
            name.val = _M0FP211localreview3tcl13command__name(self.frame.namespace_name, _M0MPC15array5Array2atGRPB4JsonE(args, i + 1 | 0));
          } else {
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(options, option);
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(options, _M0MPC15array5Array2atGRPB4JsonE(args, i + 1 | 0));
          }
          _tmp = i + 2 | 0;
          continue;
        } else {
          break;
        }
      }
      const _tmp$2 = self.frame.namespace_name;
      const _tmp$3 = [];
      const _tmp$4 = [];
      const _tmp$5 = [];
      const _tmp$6 = [];
      const _bind$4 = [];
      const ensemble = new _M0TP211localreview3tcl8Ensemble(_tmp$2, _tmp$3, _tmp$4, true, _tmp$5, _tmp$6, _M0MPB3Map3MapGssE(new _M0TPB9ArrayViewGUssEE(_bind$4, 0, 0), undefined));
      const _bind$5 = _M0MP211localreview3tcl11Interpreter19configure__ensemble(self, ensemble, options);
      if (_bind$5.$tag === 1) {
        const _ok = _bind$5;
        _ok._0;
      } else {
        return _bind$5;
      }
      const _tmp$7 = _M0FP211localreview3tcl15command__parent(name.val);
      const _bind$6 = "::";
      const parts = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB4Iter6filterGRPC16string10StringViewE(_M0MPC16string6String5split(_tmp$7, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length)), (s) => !_M0MPC16string10StringView9is__empty(s)));
      const prefix = new _M0TPB8MutLocalGsE("::");
      const _bind$7 = parts.length;
      let _tmp$8 = 0;
      while (true) {
        const _ = _tmp$8;
        if (_ < _bind$7) {
          const part = parts[_];
          prefix.val = _M0FP211localreview3tcl15qualified__name(prefix.val, _M0MPC16string10StringView9to__owned(part));
          _M0MPB3Map3setGsbE(self.state.namespaces, prefix.val, true);
          _tmp$8 = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      const _bind$8 = _M0MP211localreview3tcl11Interpreter15define__command(self, name.val, new _M0DTP211localreview3tcl11CommandBody15EnsembleCommand(ensemble));
      if (_bind$8.$tag === 1) {
        const _ok = _bind$8;
        _ok._0;
      } else {
        return _bind$8;
      }
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(name.val);
    }
    case "exists": {
      if (n !== 4) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace ensemble exists arity"));
      }
      let _tmp$9;
      let command;
      _L: {
        _L$2: {
          const _bind$9 = _M0MP211localreview3tcl11Interpreter13find__command(self, _M0MPC15array5Array2atGRPB4JsonE(args, 3));
          if (_bind$9 === undefined) {
            _tmp$9 = false;
          } else {
            const _Some = _bind$9;
            const _command = _Some;
            command = _command;
            break _L$2;
          }
          break _L;
        }
        const _bind$9 = _M0MP211localreview3tcl7Command6origin(command).body;
        if (_bind$9.$tag === 3) {
          _tmp$9 = true;
        } else {
          _tmp$9 = false;
        }
      }
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(_tmp$9));
    }
    case "configure": {
      if (n < 4) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace ensemble configure arity"));
      }
      let ensemble$2;
      let command$2;
      _L$2: {
        const _bind$9 = _M0MP211localreview3tcl11Interpreter13find__command(self, _M0MPC15array5Array2atGRPB4JsonE(args, 3));
        if (_bind$9 === undefined) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unknown ensemble"));
        } else {
          const _Some = _bind$9;
          const _command = _Some;
          command$2 = _command;
          break _L$2;
        }
      }
      const _bind$9 = _M0MP211localreview3tcl7Command6origin(command$2).body;
      if (_bind$9.$tag === 3) {
        const _EnsembleCommand = _bind$9;
        const _ensemble = _EnsembleCommand._0;
        ensemble$2 = _ensemble;
      } else {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("command is not an ensemble"));
      }
      if (n === 4) {
        const values = [];
        const _bind$10 = ["-map", "-namespace", "-parameters", "-prefixes", "-subcommands", "-unknown"];
        const _bind$11 = _bind$10.length;
        let _tmp$10 = 0;
        while (true) {
          const _ = _tmp$10;
          if (_ < _bind$11) {
            const option = _bind$10[_];
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values, option);
            const _bind$12 = _M0MP211localreview3tcl8Ensemble6option(ensemble$2, option);
            let _tmp$11;
            if (_bind$12.$tag === 1) {
              const _ok = _bind$12;
              _tmp$11 = _ok._0;
            } else {
              return _bind$12;
            }
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values, _tmp$11);
            _tmp$10 = _ + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        return _M0FP211localreview3tcl12format__list(values);
      } else {
        if (n === 5) {
          return _M0MP211localreview3tcl8Ensemble6option(ensemble$2, _M0MPC15array5Array2atGRPB4JsonE(args, 4));
        } else {
          const _bind$10 = _M0MP211localreview3tcl11Interpreter19configure__ensemble(self, ensemble$2, _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 4, undefined)));
          if (_bind$10.$tag === 1) {
            const _ok = _bind$10;
            _ok._0;
          } else {
            return _bind$10;
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
        }
      }
    }
    default: {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported ensemble subcommand"));
    }
  }
}
function _M0FP211localreview3tcl11option__get(options, name) {
  const _bind$2 = options.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const _foreach_element = options[_];
      let key;
      let value;
      _L: {
        const _key = _foreach_element._0;
        const _value = _foreach_element._1;
        key = _key;
        value = _value;
        break _L;
      }
      if (key === name) {
        return value;
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return undefined;
}
function _M0FP211localreview3tcl11option__set(options, name, value) {
  const _bind$2 = 0;
  const _bind$3 = options.length;
  let _tmp = _bind$2;
  while (true) {
    const i = _tmp;
    if (i < _bind$3) {
      if (_M0MPC15array5Array2atGRPB4JsonE(options, i)._0 === name) {
        _M0MPC15array5Array3setGUssEE(options, i, { _0: name, _1: value });
        return undefined;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  _M0MPC15array5Array4pushGRPC14json10WriteFrameE(options, { _0: name, _1: value });
}
function _M0MP211localreview3tcl10Completion12actual__code(self) {
  return self.level !== 0 ? 2 : self.code;
}
function _M0MP211localreview3tcl11Interpreter13record__error(self, result) {
  if (_M0MP211localreview3tcl10Completion12actual__code(result) !== 1) {
    return undefined;
  }
  const info = _M0MPC16option6Option10unwrap__orGsE(_M0FP211localreview3tcl11option__get(result.options, "-errorinfo"), result.value);
  const code = _M0MPC16option6Option10unwrap__orGsE(_M0FP211localreview3tcl11option__get(result.options, "-errorcode"), "NONE");
  self.state.error_stack.val = _M0MPC16option6Option10unwrap__orGsE(_M0FP211localreview3tcl11option__get(result.options, "-errorstack"), "");
  const _bind$2 = [{ _0: "::errorInfo", _1: info }, { _0: "::errorCode", _1: code }];
  const _bind$3 = _bind$2.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$3) {
      const _foreach_element = _bind$2[_];
      let name;
      let value;
      _L: {
        const _name = _foreach_element._0;
        const _value = _foreach_element._1;
        name = _name;
        value = _value;
        break _L;
      }
      let cell;
      _L$2: {
        _L$3: {
          const _bind$4 = _M0MPB3Map3getGsRP211localreview3tcl4CellE(self.state.globals, name);
          if (_bind$4 === undefined) {
            _M0MPB3Map3setGsRP211localreview3tcl4CellE(self.state.globals, name, new _M0TP211localreview3tcl4Cell(new _M0DTP211localreview3tcl13VariableValue6Scalar(value), false));
          } else {
            const _Some = _bind$4;
            const _cell = _Some;
            cell = _cell;
            break _L$3;
          }
          break _L$2;
        }
        cell.value = new _M0DTP211localreview3tcl13VariableValue6Scalar(value);
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      return;
    }
  }
}
function _M0MP211localreview3tcl11Interpreter15annotate__error(self, result, source, line, args) {
  if (_M0MP211localreview3tcl10Completion12actual__code(result) !== 1) {
    return new _M0DTPC16result6ResultGRP211localreview3tcl10CompletionRP211localreview3tcl8TclErrorE2Ok(result);
  }
  const options = _M0MPC15array5Array4copyGUssEE(result.options);
  const previous = _M0MPC16option6Option10unwrap__orGsE(_M0FP211localreview3tcl11option__get(options, "-errorinfo"), "");
  const text = result.skip_trace && !_M0MPC16string6String9is__empty(previous) ? previous : _M0MPC16string6String9is__empty(previous) ? `${result.value}\n    while executing\n\"${source}\"` : `${previous}\n    invoked from within\n\"${source}\"`;
  if (text.length > 1000000) {
    return new _M0DTPC16result6ResultGRP211localreview3tcl10CompletionRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("error diagnostic size limit"));
  }
  _M0FP211localreview3tcl11option__set(options, "-errorinfo", text);
  _M0FP211localreview3tcl11option__set(options, "-errorline", _M0MPC13int3Int18to__string_2einner(line, 10));
  const _bind$2 = _M0FP211localreview3tcl11option__get(options, "-errorcode");
  if (_bind$2 === undefined) {
    _M0FP211localreview3tcl11option__set(options, "-errorcode", "NONE");
  }
  const _bind$3 = _M0FP211localreview3tcl11option__get(options, "-errorstack");
  if (_bind$3 === undefined) {
    let _tmp;
    if (result.skip_trace) {
      _tmp = "";
    } else {
      const _bind$4 = _M0FP211localreview3tcl12format__list(args);
      let _tmp$2;
      if (_bind$4.$tag === 1) {
        const _ok = _bind$4;
        _tmp$2 = _ok._0;
      } else {
        return _bind$4;
      }
      const _bind$5 = _M0FP211localreview3tcl12format__list(["INNER", _tmp$2]);
      if (_bind$5.$tag === 1) {
        const _ok = _bind$5;
        _tmp = _ok._0;
      } else {
        return _bind$5;
      }
    }
    _M0FP211localreview3tcl11option__set(options, "-errorstack", _tmp);
  }
  const annotated = new _M0TP211localreview3tcl10Completion(result.code, result.level, result.value, options, false);
  _M0MP211localreview3tcl11Interpreter13record__error(self, annotated);
  return new _M0DTPC16result6ResultGRP211localreview3tcl10CompletionRP211localreview3tcl8TclErrorE2Ok(annotated);
}
function _M0MP211localreview3tcl11Interpreter14cached__script(self, source) {
  const cache = self.state.cache;
  let program;
  _L: {
    _L$2: {
      const _bind$2 = _M0MPB3Map3getGsRP211localreview3tcl13ScriptProgramE(cache.scripts, source);
      if (_bind$2 === undefined) {
      } else {
        const _Some = _bind$2;
        const _program = _Some;
        program = _program;
        break _L$2;
      }
      break _L;
    }
    if (cache.script_hits < 2147483647) {
      cache.script_hits = cache.script_hits + 1 | 0;
    }
    return program;
  }
  if (_M0MPB3Map6lengthGsRP211localreview3tcl13ScriptProgramE(cache.scripts) >= 256 || (cache.script_units + source.length | 0) > 262144) {
    _M0MPB3Map5clearGsRP211localreview3tcl13ScriptProgramE(cache.scripts);
    cache.script_units = 0;
  }
  const program$2 = new _M0TP211localreview3tcl13ScriptProgram(new _M0TP211localreview3tcl12ScriptParser(_M0MPC16string6String9to__array(source), 0, 0, 1, 0, 1), [], undefined);
  if (source.length <= 65536) {
    _M0MPB3Map3setGsRP211localreview3tcl13ScriptProgramE(cache.scripts, source, program$2);
    cache.script_units = cache.script_units + source.length | 0;
  }
  return program$2;
}
function _M0FP211localreview3tcl7outcome(error) {
  let value;
  _L: {
    let message;
    _L$2: {
      switch (error.$tag) {
        case 0: {
          const _Signal = error;
          const _result = _Signal._0;
          return _result;
        }
        case 4: {
          const _Invalid = error;
          const _message = _Invalid._0;
          message = _message;
          break _L$2;
        }
        case 3: {
          const _Return = error;
          const _value = _Return._0;
          value = _value;
          break _L;
        }
        case 2: {
          return _M0FP211localreview3tcl10completion(3, "", undefined, _M0DTPC16option6OptionGRPB5ArrayGUssEEE4None__, -1);
        }
        default: {
          return _M0FP211localreview3tcl10completion(4, "", undefined, _M0DTPC16option6OptionGRPB5ArrayGUssEEE4None__, -1);
        }
      }
    }
    return _M0FP211localreview3tcl25completion__error_2einner(message, "NONE");
  }
  return _M0FP211localreview3tcl10completion(0, value, 1, _M0DTPC16option6OptionGRPB5ArrayGUssEEE4None__, -1);
}
function _M0FP211localreview3tcl11float__text(value) {
  if (value === 0) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(BigInt.asUintN(64, BigInt.asUintN(64, BigInt.asUintN(64, $f64_reinterpret_i64(value)) >> BigInt(63 & 63))) === BigInt.asUintN(64, 1n) ? "-0.0" : "0.0");
  }
  const negative = value < 0;
  const raw = String(Math.abs(value));
  const _bind$2 = "e";
  const parts = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPC16string6String5split(raw, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length)));
  const mantissa = _M0MPC16string10StringView9to__owned(_M0MPC15array5Array2atGRPB4JsonE(parts, 0));
  const _bind$3 = ".";
  const decimal = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPC16string6String5split(mantissa, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length)));
  let _tmp;
  if (parts.length === 2) {
    const _bind$4 = _M0FP211localreview3tcl7integer(_M0MPC16string10StringView9to__owned(_M0MPC15array5Array2atGRPB4JsonE(parts, 1)));
    if (_bind$4.$tag === 1) {
      const _ok = _bind$4;
      _tmp = _ok._0;
    } else {
      return _bind$4;
    }
  } else {
    _tmp = 0;
  }
  const exponent = new _M0TPB8MutLocalGiE(_tmp);
  exponent.val = exponent.val + (_M0MPC16string10StringView6length(_M0MPC15array5Array2atGRPB4JsonE(decimal, 0)) - 1 | 0) | 0;
  const _bind$4 = ".";
  const _tmp$2 = new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length);
  const _bind$5 = "";
  const digits = new _M0TPB8MutLocalGsE(_M0MPC16string6String12replace__all(mantissa, _tmp$2, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length)));
  while (true) {
    const _tmp$3 = digits.val;
    const _bind$6 = "0";
    if (_M0MPC16string6String11has__prefix(_tmp$3, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length))) {
      digits.val = _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(digits.val, 1, undefined));
      exponent.val = exponent.val - 1 | 0;
      continue;
    } else {
      break;
    }
  }
  while (true) {
    let _tmp$3;
    if (digits.val.length > 1) {
      const _tmp$4 = digits.val;
      const _bind$6 = "0";
      _tmp$3 = _M0MPC16string6String11has__suffix(_tmp$4, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length));
    } else {
      _tmp$3 = false;
    }
    if (_tmp$3) {
      digits.val = _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(digits.val, 0, digits.val.length - 1 | 0));
      continue;
    } else {
      break;
    }
  }
  let result;
  if (exponent.val < -4 || exponent.val >= 17) {
    result = `${_M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(digits.val, 0, 1))}${digits.val.length > 1 ? `.${_M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(digits.val, 1, undefined))}` : ""}e${exponent.val >= 0 ? "+" : ""}${_M0MPC13int3Int18to__string_2einner(exponent.val, 10)}`;
  } else {
    if (exponent.val < 0) {
      const _bind$6 = _M0MPC15array5Array4makeGcE((-exponent.val | 0) - 1 | 0, 48);
      result = `0.${_M0MPC16string6String11from__array(new _M0TPB9ArrayViewGcE(_bind$6, 0, _bind$6.length))}${digits.val}`;
    } else {
      if ((exponent.val + 1 | 0) >= digits.val.length) {
        const _tmp$3 = digits.val;
        const _bind$6 = _M0MPC15array5Array4makeGcE((exponent.val + 1 | 0) - digits.val.length | 0, 48);
        result = `${_tmp$3}${_M0MPC16string6String11from__array(new _M0TPB9ArrayViewGcE(_bind$6, 0, _bind$6.length))}.0`;
      } else {
        result = `${_M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(digits.val, 0, exponent.val + 1 | 0))}.${_M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(digits.val, exponent.val + 1 | 0, undefined))}`;
      }
    }
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(`${negative ? "-" : ""}${result}`);
}
function _M0MP211localreview3tcl6Number4text(self) {
  let value;
  _L: {
    let value$2;
    _L$2: {
      let x;
      _L$3: {
        switch (self.$tag) {
          case 0: {
            const _Small = self;
            const _x = _Small._0;
            x = _x;
            break _L$3;
          }
          case 1: {
            const _Whole = self;
            const _value = _Whole._0;
            value$2 = _value;
            break _L$2;
          }
          default: {
            const _Real = self;
            const _value$2 = _Real._0;
            value = _value$2;
            break _L;
          }
        }
      }
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC13int3Int18to__string_2einner(x, 10));
    }
    if (_M0MPC16bigint6BigInt11bit__length(value$2) > 16384) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("integer bit limit"));
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC16bigint6BigInt18to__string_2einner(value$2, 10));
  }
  if (_M0MPC16double6Double7is__nan(value)) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_M0FP211localreview3tcl25completion__error_2einner("domain error: argument not in valid range", "ARITH DOMAIN {domain error: argument not in valid range}")));
  }
  if (_M0MPC16double6Double7is__inf(value)) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(value < 0 ? "-Inf" : "Inf");
  }
  return _M0FP211localreview3tcl11float__text(value);
}
function _M0FP211localreview3tcl12integer__add(left, right) {
  let x;
  let y;
  _L: {
    _L$2: {
      const _bind$2 = _M0FP211localreview3tcl14small__decimal(left);
      const _bind$3 = _M0FP211localreview3tcl14small__decimal(right);
      if (_bind$2 === undefined) {
      } else {
        const _Some = _bind$2;
        const _x = _Some;
        if (_bind$3 === undefined) {
        } else {
          const _Some$2 = _bind$3;
          const _y = _Some$2;
          x = _x;
          y = _y;
          break _L$2;
        }
      }
      break _L;
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC15int645Int6418to__string_2einner(BigInt.asUintN(64, BigInt.asUintN(64, BigInt(x)) + BigInt.asUintN(64, BigInt(y))), 10));
  }
  const _bind$2 = _M0FP211localreview3tcl5whole(left);
  let _tmp;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    _tmp = _ok._0;
  } else {
    return _bind$2;
  }
  const _tmp$2 = _tmp;
  const _bind$3 = _M0FP211localreview3tcl5whole(right);
  let _tmp$3;
  if (_bind$3.$tag === 1) {
    const _ok = _bind$3;
    _tmp$3 = _ok._0;
  } else {
    return _bind$3;
  }
  return _M0MP211localreview3tcl6Number4text(new _M0DTP211localreview3tcl6Number5Whole(_M0IPC16bigint6BigIntPB3Add3add(_tmp$2, _tmp$3)));
}
function _M0MP211localreview3tcl11Interpreter14array__command(self, args) {
  const n = args.length;
  if (n < 3) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("array arity"));
  }
  const op = _M0MPC15array5Array2atGRPB4JsonE(args, 1);
  const _bind$2 = _M0MP211localreview3tcl11Interpreter7binding(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2), op === "set");
  let binding;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    binding = _ok._0;
  } else {
    return _bind$2;
  }
  let values;
  _L: {
    _L$2: {
      let b;
      _L$3: {
        if (binding === undefined) {
          break _L$2;
        } else {
          const _Some = binding;
          const _b = _Some;
          const _bind$3 = _b.index;
          if (_bind$3 === undefined) {
            b = _b;
            break _L$3;
          } else {
            break _L$2;
          }
        }
      }
      _L$4: {
        _L$5: {
          let v;
          _L$6: {
            const _bind$3 = b.cell.value;
            if (_bind$3 === undefined) {
              break _L$5;
            } else {
              const _Some = _bind$3;
              const _x = _Some;
              if (_x.$tag === 3) {
                const _Elements = _x;
                const _v = _Elements._0;
                v = _v;
                break _L$6;
              } else {
                break _L$5;
              }
            }
          }
          values = v;
          break _L$4;
        }
        values = undefined;
      }
      break _L;
    }
    values = undefined;
  }
  _L$2: {
    switch (op) {
      case "exists": {
        if (n !== 3) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("array exists arity"));
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(!(values === undefined)));
      }
      case "size": {
        if (n !== 3) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("array size arity"));
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC13int3Int18to__string_2einner(_M0MPC16option6Option10unwrap__orGiE(_M0MPC16option6Option3mapGRPB3MapGssEiE(values, (v) => _M0MPB3Map6lengthGsRP211localreview3tcl13ScriptProgramE(v)), 0), 10));
      }
      case "set": {
        if (n !== 4) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("array set arity"));
        }
        const _bind$3 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, 3));
        let pairs;
        if (_bind$3.$tag === 1) {
          const _ok = _bind$3;
          pairs = _ok._0;
        } else {
          return _bind$3;
        }
        if (2 === 0) {
          $panic();
        }
        if ((pairs.length % 2 | 0) !== 0) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("array set expects pairs"));
        }
        const binding$2 = _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(binding);
        _L$3: {
          _L$4: {
            const _bind$4 = binding$2.index;
            if (_bind$4 === undefined) {
              const _bind$5 = binding$2.cell.value;
              if (_bind$5 === undefined) {
              } else {
                if (values === undefined) {
                  break _L$4;
                }
              }
            } else {
              break _L$4;
            }
            break _L$3;
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("variable is not array"));
        }
        let values$2;
        if (values === undefined) {
          const _bind$4 = [];
          const v = _M0MPB3Map3MapGssE(new _M0TPB9ArrayViewGUssEE(_bind$4, 0, 0), undefined);
          binding$2.cell.value = new _M0DTP211localreview3tcl13VariableValue8Elements(v);
          values$2 = v;
        } else {
          const _Some = values;
          const _v = _Some;
          values$2 = _v;
        }
        const i = new _M0TPB8MutLocalGiE(0);
        while (true) {
          if (i.val < pairs.length) {
            if (_M0MPB3Map6lengthGsRP211localreview3tcl13ScriptProgramE(values$2) >= 10000 && !_M0MPB3Map8containsGssE(values$2, _M0MPC15array5Array2atGRPB4JsonE(pairs, i.val))) {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("array size limit"));
            }
            _M0MPB3Map3setGssE(values$2, _M0MPC15array5Array2atGRPB4JsonE(pairs, i.val), _M0MPC15array5Array2atGRPB4JsonE(pairs, i.val + 1 | 0));
            i.val = i.val + 2 | 0;
            continue;
          } else {
            break;
          }
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
      }
      case "names": {
        break _L$2;
      }
      case "get": {
        break _L$2;
      }
      case "unset": {
        if (n !== 3 && n !== 4) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("array unset arity"));
        }
        let values$3;
        _L$4: {
          _L$5: {
            if (values === undefined) {
            } else {
              const _Some = values;
              const _values = _Some;
              values$3 = _values;
              break _L$5;
            }
            break _L$4;
          }
          if (n === 3) {
            const _bind$4 = _M0MP211localreview3tcl11Interpreter10unset__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2), true);
            if (_bind$4.$tag === 1) {
              const _ok = _bind$4;
              _ok._0;
            } else {
              return _bind$4;
            }
          } else {
            const _bind$4 = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB3Map4keysGsRP211localreview3tcl4CellE(values$3));
            const _bind$5 = _bind$4.length;
            let _tmp = 0;
            while (true) {
              const _ = _tmp;
              if (_ < _bind$5) {
                const key = _bind$4[_];
                const _bind$6 = _M0FP211localreview3tcl11glob__match(_M0MPC15array5Array2atGRPB4JsonE(args, 3), key, false);
                let _tmp$2;
                if (_bind$6.$tag === 1) {
                  const _ok = _bind$6;
                  _tmp$2 = _ok._0;
                } else {
                  return _bind$6;
                }
                if (_tmp$2) {
                  _M0MPB3Map6removeGssE(values$3, key);
                }
                _tmp = _ + 1 | 0;
                continue;
              } else {
                break;
              }
            }
          }
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
      }
      default: {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported array subcommand"));
      }
    }
  }
  const mode = new _M0TPB8MutLocalGsE("-glob");
  let pattern;
  if (n === 3) {
    pattern = "*";
  } else {
    if (n === 4) {
      pattern = _M0MPC15array5Array2atGRPB4JsonE(args, 3);
    } else {
      if (n === 5 && op === "names") {
        mode.val = _M0MPC15array5Array2atGRPB4JsonE(args, 3);
        pattern = _M0MPC15array5Array2atGRPB4JsonE(args, 4);
      } else {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("array names/get arity"));
      }
    }
  }
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(mode.val, "-glob") && _M0IP016_24default__implPB2Eq10not__equalGsE(mode.val, "-exact")) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported array match mode"));
  }
  let values$2;
  if (values === undefined) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
  } else {
    const _Some = values;
    const _v = _Some;
    values$2 = _v;
  }
  const keys = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB3Map4keysGsRP211localreview3tcl4CellE(values$2));
  _M0MPC15array5Array4sortGsE(keys);
  const result = [];
  const _bind$3 = keys.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$3) {
      const key = keys[_];
      let _tmp$2;
      if (mode.val === "-exact") {
        _tmp$2 = key === pattern;
      } else {
        const _bind$4 = _M0FP211localreview3tcl11glob__match(pattern, key, false);
        if (_bind$4.$tag === 1) {
          const _ok = _bind$4;
          _tmp$2 = _ok._0;
        } else {
          return _bind$4;
        }
      }
      if (_tmp$2) {
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(result, key);
        if (op === "get") {
          _M0MPC15array5Array4pushGRPC14json10WriteFrameE(result, _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_M0MPB3Map3getGssE(values$2, key)));
        }
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0FP211localreview3tcl12format__list(result);
}
function _M0FP211localreview3tcl16dictionary__text(pairs) {
  const values = [];
  const _bind$2 = pairs.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const _foreach_element = pairs[_];
      let key;
      let value;
      _L: {
        const _key = _foreach_element._0;
        const _value = _foreach_element._1;
        key = _key;
        value = _value;
        break _L;
      }
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values, key);
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values, value);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0FP211localreview3tcl12format__list(values);
}
function _M0MP211localreview3tcl10Completion12option__text(self) {
  const options = _M0MPC15array5Array4copyGUssEE(self.options);
  _M0FP211localreview3tcl11option__set(options, "-code", _M0MPC13int3Int18to__string_2einner(self.code, 10));
  _M0FP211localreview3tcl11option__set(options, "-level", _M0MPC13int3Int18to__string_2einner(self.level, 10));
  return _M0FP211localreview3tcl16dictionary__text(options);
}
function _M0MP211localreview3tcl11Interpreter14error__command(self, args) {
  self.state.return_options.val = [];
  const n = args.length;
  if (_M0MPC15array5Array2atGRPB4JsonE(args, 0) === "throw") {
    if (n !== 3) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("throw requires error type and message"));
    }
    const _bind$2 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, 1));
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    if (_M0MPC15array5Array9is__emptyGRPB4JsonE(_tmp)) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_M0FP211localreview3tcl25completion__error_2einner("type must be non-empty list", "TCL OPERATION THROW BADEXCEPTION")));
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_M0FP211localreview3tcl25completion__error_2einner(_M0MPC15array5Array2atGRPB4JsonE(args, 2), _M0MPC15array5Array2atGRPB4JsonE(args, 1))));
  }
  if (n < 2 || n > 4) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("error arity"));
  }
  const options = [];
  if (n >= 3) {
    _M0MPC15array5Array4pushGRPC14json10WriteFrameE(options, { _0: "-errorinfo", _1: _M0MPC15array5Array2atGRPB4JsonE(args, 2) });
  }
  _M0MPC15array5Array4pushGRPC14json10WriteFrameE(options, { _0: "-errorcode", _1: n === 4 ? _M0MPC15array5Array2atGRPB4JsonE(args, 3) : "NONE" });
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_M0FP211localreview3tcl18completion_2einner(1, _M0MPC15array5Array2atGRPB4JsonE(args, 1), 0, options, n >= 3 && !_M0MPC16string6String9is__empty(_M0MPC15array5Array2atGRPB4JsonE(args, 2)))));
}
function _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, offset) {
  return _M0MPC16option6Option10unwrap__orGcE(_M0MPC15array5Array3getGcE(self.chars, self.pos + offset | 0), 0);
}
function _M0MP211localreview3tcl12ScriptParser11expr__space(self) {
  while (true) {
    if (_M0FP211localreview3tcl11list__space(_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0))) {
      self.pos = self.pos + 1 | 0;
      continue;
    } else {
      return;
    }
  }
}
function _M0FP211localreview3tcl8namechar(c) {
  return c >= 97 && c <= 122 || (c >= 65 && c <= 90 || (c >= 48 && c <= 57 || (c === 95 || c === 58)));
}
function _M0MP211localreview3tcl12ScriptParser6braces(self) {
  self.pos = self.pos + 1 | 0;
  const level = new _M0TPB8MutLocalGiE(1);
  const out = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  while (true) {
    if (self.pos < self.chars.length) {
      const c = _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0);
      self.pos = self.pos + 1 | 0;
      if (c === 92 && self.pos < self.chars.length) {
        if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) === 10) {
          let text;
          let next;
          _L: {
            const _bind$2 = _M0FP211localreview3tcl9backslash(self.chars, self.pos - 1 | 0);
            const _text = _bind$2._0;
            const _next = _bind$2._1;
            text = _text;
            next = _next;
            break _L;
          }
          _M0IPB13StringBuilderPB6Logger13write__string(out, text);
          self.pos = next;
        } else {
          _M0IPB13StringBuilderPB6Logger11write__char(out, c);
          _M0IPB13StringBuilderPB6Logger11write__char(out, _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0));
          self.pos = self.pos + 1 | 0;
        }
        continue;
      }
      if (c === 123) {
        level.val = level.val + 1 | 0;
      }
      if (c === 125) {
        level.val = level.val - 1 | 0;
        if (level.val === 0) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPB13StringBuilder10to__string(out));
        }
      }
      _M0IPB13StringBuilderPB6Logger11write__char(out, c);
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("missing close-brace"));
}
function _M0MP211localreview3tcl12ScriptParser15parsed__command(self, words, start, line, end) {
  return new _M0TP211localreview3tcl13ParsedCommand(words, _M0MPC16string10StringView9to__owned(_M0MPC16string6String9trim__end(_M0MPC16string6String11from__array(_M0MPC15array5Array12view_2einnerGcE(self.chars, start, end)), undefined)), line);
}
function _M0MP211localreview3tcl12ScriptParser12source__line(self) {
  while (true) {
    if (self.line_pos < self.pos) {
      if (_M0MPC15array5Array2atGcE(self.chars, self.line_pos) === 10) {
        self.line = self.line + 1 | 0;
      }
      self.line_pos = self.line_pos + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return self.line;
}
function _M0MP211localreview3tcl12ScriptParser13parts_2einner(self, stop, raw, depth, bracket) {
  if (depth > 64) {
    return new _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl4PartERP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("substitution depth"));
  }
  const parts = [];
  const text = new _M0TPB8MutLocalGRPB13StringBuilderE(_M0MPB13StringBuilder21StringBuilder_2einner(0));
  while (true) {
    if (self.pos < self.chars.length) {
      const c = _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0);
      if (stop !== 0 && c === stop) {
        self.pos = self.pos + 1 | 0;
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(parts, new _M0DTP211localreview3tcl4Part4Text(_M0MPB13StringBuilder10to__string(text.val)));
        return new _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl4PartERP211localreview3tcl8TclErrorE2Ok(parts);
      }
      if (raw && (_M0FP211localreview3tcl11list__space(c) || (c === 59 || bracket && c === 93))) {
        break;
      }
      if (raw && (c === 92 && _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 1) === 10)) {
        break;
      }
      if (c === 36 || c === 91) {
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(parts, new _M0DTP211localreview3tcl4Part4Text(_M0MPB13StringBuilder10to__string(text.val)));
        text.val = _M0MPB13StringBuilder21StringBuilder_2einner(0);
        if (c === 36) {
          const _bind$2 = _M0MP211localreview3tcl12ScriptParser8variable(self, depth);
          let _tmp;
          if (_bind$2.$tag === 1) {
            const _ok = _bind$2;
            _tmp = _ok._0;
          } else {
            return _bind$2;
          }
          _M0MPC15array5Array4pushGRPC14json10WriteFrameE(parts, _tmp);
        } else {
          self.pos = self.pos + 1 | 0;
          const _bind$2 = _M0MP211localreview3tcl12ScriptParser14script_2einner(self, true, depth + 1 | 0, false);
          let _tmp;
          if (_bind$2.$tag === 1) {
            const _ok = _bind$2;
            _tmp = _ok._0;
          } else {
            return _bind$2;
          }
          _M0MPC15array5Array4pushGRPC14json10WriteFrameE(parts, new _M0DTP211localreview3tcl4Part7Command(_tmp));
        }
      } else {
        if (c === 92) {
          let value;
          let next;
          _L: {
            const _bind$2 = _M0FP211localreview3tcl9backslash(self.chars, self.pos);
            const _value = _bind$2._0;
            const _next = _bind$2._1;
            value = _value;
            next = _next;
            break _L;
          }
          _M0IPB13StringBuilderPB6Logger13write__string(text.val, value);
          self.pos = next;
        } else {
          _M0IPB13StringBuilderPB6Logger11write__char(text.val, c);
          self.pos = self.pos + 1 | 0;
        }
      }
      continue;
    } else {
      break;
    }
  }
  if (stop !== 0) {
    return new _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl4PartERP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("missing closing substitution delimiter"));
  }
  _M0MPC15array5Array4pushGRPC14json10WriteFrameE(parts, new _M0DTP211localreview3tcl4Part4Text(_M0MPB13StringBuilder10to__string(text.val)));
  return new _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl4PartERP211localreview3tcl8TclErrorE2Ok(parts);
}
function _M0MP211localreview3tcl12ScriptParser14script_2einner(self, bracket, depth, one) {
  if (depth > 64) {
    return new _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl13ParsedCommandERP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("script nesting limit"));
  }
  const commands = [];
  const words = new _M0TPB8MutLocalGRPB5ArrayGRP211localreview3tcl4WordEE([]);
  const start = new _M0TPB8MutLocalGiE(self.pos);
  const line = new _M0TPB8MutLocalGiE(_M0MP211localreview3tcl12ScriptParser12source__line(self));
  while (true) {
    if (self.pos < self.chars.length) {
      const c = _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0);
      if (c === 93 && bracket) {
        self.pos = self.pos + 1 | 0;
        if (!_M0MPC15array5Array9is__emptyGRPB4JsonE(words.val)) {
          _M0MPC15array5Array4pushGRPC14json10WriteFrameE(commands, _M0MP211localreview3tcl12ScriptParser15parsed__command(self, words.val, start.val, line.val, self.pos - 1 | 0));
        }
        return new _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl13ParsedCommandERP211localreview3tcl8TclErrorE2Ok(commands);
      }
      if (c === 92 && _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 1) === 10) {
        let next;
        _L: {
          const _bind$2 = _M0FP211localreview3tcl9backslash(self.chars, self.pos);
          const _next = _bind$2._1;
          next = _next;
          break _L;
        }
        self.pos = next;
        continue;
      }
      if (c === 59 || c === 10) {
        self.pos = self.pos + 1 | 0;
        if (!_M0MPC15array5Array9is__emptyGRPB4JsonE(words.val)) {
          _M0MPC15array5Array4pushGRPC14json10WriteFrameE(commands, _M0MP211localreview3tcl12ScriptParser15parsed__command(self, words.val, start.val, line.val, self.pos - 1 | 0));
          words.val = [];
        }
        if (one && !_M0MPC15array5Array9is__emptyGRPB4JsonE(commands)) {
          return new _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl13ParsedCommandERP211localreview3tcl8TclErrorE2Ok(commands);
        }
      } else {
        if (_M0FP211localreview3tcl11list__space(c)) {
          self.pos = self.pos + 1 | 0;
        } else {
          if (c === 35 && _M0MPC15array5Array9is__emptyGRPB4JsonE(words.val)) {
            while (true) {
              if (self.pos < self.chars.length && _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) !== 10) {
                if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) === 92 && _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 1) === 10) {
                  let next;
                  _L: {
                    const _bind$2 = _M0FP211localreview3tcl9backslash(self.chars, self.pos);
                    const _next = _bind$2._1;
                    next = _next;
                    break _L;
                  }
                  self.pos = next;
                } else {
                  self.pos = self.pos + 1 | 0;
                }
                continue;
              } else {
                break;
              }
            }
          } else {
            if (_M0MPC15array5Array9is__emptyGRPB4JsonE(words.val)) {
              start.val = self.pos;
              line.val = _M0MP211localreview3tcl12ScriptParser12source__line(self);
              self.command_start = start.val;
              self.command_line = line.val;
            }
            const _tmp = words.val;
            const _bind$2 = _M0MP211localreview3tcl12ScriptParser4word(self, depth, bracket);
            let _tmp$2;
            if (_bind$2.$tag === 1) {
              const _ok = _bind$2;
              _tmp$2 = _ok._0;
            } else {
              return _bind$2;
            }
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(_tmp, _tmp$2);
            if (words.val.length > 4096) {
              return new _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl13ParsedCommandERP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("command argument limit"));
            }
          }
        }
      }
      if (commands.length > 10000) {
        return new _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl13ParsedCommandERP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("script command limit"));
      }
      continue;
    } else {
      break;
    }
  }
  if (bracket) {
    return new _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl13ParsedCommandERP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("missing close-bracket"));
  }
  if (!_M0MPC15array5Array9is__emptyGRPB4JsonE(words.val)) {
    _M0MPC15array5Array4pushGRPC14json10WriteFrameE(commands, _M0MP211localreview3tcl12ScriptParser15parsed__command(self, words.val, start.val, line.val, self.pos));
  }
  return new _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl13ParsedCommandERP211localreview3tcl8TclErrorE2Ok(commands);
}
function _M0MP211localreview3tcl12ScriptParser4word(self, depth, bracket) {
  const expand = new _M0TPB8MutLocalGbE(false);
  if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) === 123 && (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 1) === 42 && (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 2) === 125 && ((self.pos + 3 | 0) < self.chars.length && (!_M0FP211localreview3tcl11list__space(_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 3)) && (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 3) !== 59 && (!bracket || _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 3) !== 93))))))) {
    expand.val = true;
    self.pos = self.pos + 3 | 0;
  }
  const grouped = _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) === 123 || _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) === 34;
  let parts;
  if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) === 123) {
    const _bind$2 = _M0MP211localreview3tcl12ScriptParser6braces(self);
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    parts = [new _M0DTP211localreview3tcl4Part4Text(_tmp)];
  } else {
    if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) === 34) {
      self.pos = self.pos + 1 | 0;
      const _bind$2 = _M0MP211localreview3tcl12ScriptParser13parts_2einner(self, 34, false, depth, false);
      if (_bind$2.$tag === 1) {
        const _ok = _bind$2;
        parts = _ok._0;
      } else {
        return _bind$2;
      }
    } else {
      const _bind$2 = _M0MP211localreview3tcl12ScriptParser13parts_2einner(self, 0, true, depth, bracket);
      if (_bind$2.$tag === 1) {
        const _ok = _bind$2;
        parts = _ok._0;
      } else {
        return _bind$2;
      }
    }
  }
  if (grouped && (self.pos < self.chars.length && (!_M0FP211localreview3tcl11list__space(_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0)) && (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) !== 59 && (!bracket || _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) !== 93))))) {
    return new _M0DTPC16result6ResultGRP211localreview3tcl4WordRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("extra characters after grouped word"));
  }
  return new _M0DTPC16result6ResultGRP211localreview3tcl4WordRP211localreview3tcl8TclErrorE2Ok(new _M0TP211localreview3tcl4Word(parts, expand.val));
}
function _M0MP211localreview3tcl12ScriptParser8variable(self, depth) {
  self.pos = self.pos + 1 | 0;
  if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) === 123) {
    self.pos = self.pos + 1 | 0;
    const start = self.pos;
    while (true) {
      if (self.pos < self.chars.length && _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) !== 125) {
        self.pos = self.pos + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    if (self.pos === self.chars.length) {
      return new _M0DTPC16result6ResultGRP211localreview3tcl4PartRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("missing variable close-brace"));
    }
    const name = _M0MPC16string6String11from__array(_M0MPC15array5Array12view_2einnerGcE(self.chars, start, self.pos));
    self.pos = self.pos + 1 | 0;
    return new _M0DTPC16result6ResultGRP211localreview3tcl4PartRP211localreview3tcl8TclErrorE2Ok(new _M0DTP211localreview3tcl4Part8Variable(name, _M0DTPC16option6OptionGRPB5ArrayGRP211localreview3tcl4PartEE4None__));
  }
  const start = self.pos;
  while (true) {
    if (_M0FP211localreview3tcl8namechar(_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0))) {
      if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) === 58) {
        if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 1) !== 58) {
          break;
        }
        while (true) {
          if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) === 58) {
            self.pos = self.pos + 1 | 0;
            continue;
          } else {
            break;
          }
        }
      } else {
        self.pos = self.pos + 1 | 0;
      }
      continue;
    } else {
      break;
    }
  }
  const name = _M0MPC16string6String11from__array(_M0MPC15array5Array12view_2einnerGcE(self.chars, start, self.pos));
  if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) === 40) {
    self.pos = self.pos + 1 | 0;
    const _bind$2 = _M0MP211localreview3tcl12ScriptParser13parts_2einner(self, 41, false, depth + 1 | 0, false);
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    return new _M0DTPC16result6ResultGRP211localreview3tcl4PartRP211localreview3tcl8TclErrorE2Ok(new _M0DTP211localreview3tcl4Part8Variable(name, new _M0DTPC16option6OptionGRPB5ArrayGRP211localreview3tcl4PartEE4Some(_tmp)));
  }
  return new _M0DTPC16result6ResultGRP211localreview3tcl4PartRP211localreview3tcl8TclErrorE2Ok(_M0MPC16string6String9is__empty(name) ? new _M0DTP211localreview3tcl4Part4Text("$") : new _M0DTP211localreview3tcl4Part8Variable(name, _M0DTPC16option6OptionGRPB5ArrayGRP211localreview3tcl4PartEE4None__));
}
function _M0MP211localreview3tcl12ScriptParser10expression(self, minimum, depth) {
  if (depth > 64) {
    return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expression nesting limit"));
  }
  _M0MP211localreview3tcl12ScriptParser11expr__space(self);
  const _bind$2 = _M0MP211localreview3tcl12ScriptParser7operand(self, depth + 1 | 0);
  let _tmp;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    _tmp = _ok._0;
  } else {
    return _bind$2;
  }
  const left = new _M0TPB8MutLocalGRP211localreview3tcl4ExprE(_tmp);
  while (true) {
    _M0MP211localreview3tcl12ScriptParser11expr__space(self);
    if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) === 63 && minimum <= 1) {
      self.pos = self.pos + 1 | 0;
      const _bind$3 = _M0MP211localreview3tcl12ScriptParser10expression(self, 1, depth + 1 | 0);
      let yes;
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        yes = _ok._0;
      } else {
        return _bind$3;
      }
      _M0MP211localreview3tcl12ScriptParser11expr__space(self);
      if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) !== 58) {
        return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("missing expression colon"));
      }
      self.pos = self.pos + 1 | 0;
      const _bind$4 = _M0MP211localreview3tcl12ScriptParser10expression(self, 1, depth + 1 | 0);
      let _tmp$2;
      if (_bind$4.$tag === 1) {
        const _ok = _bind$4;
        _tmp$2 = _ok._0;
      } else {
        return _bind$4;
      }
      left.val = new _M0DTP211localreview3tcl4Expr11Conditional(left.val, yes, _tmp$2);
      continue;
    }
    const found = new _M0TPB8MutLocalGUsiEE({ _0: "", _1: 0 });
    const _bind$3 = [{ _0: "||", _1: 2 }, { _0: "&&", _1: 3 }, { _0: "|", _1: 4 }, { _0: "^", _1: 5 }, { _0: "&", _1: 6 }, { _0: "in", _1: 7 }, { _0: "ni", _1: 7 }, { _0: "eq", _1: 8 }, { _0: "ne", _1: 8 }, { _0: "==", _1: 9 }, { _0: "!=", _1: 9 }, { _0: "<=", _1: 10 }, { _0: ">=", _1: 10 }, { _0: "<<", _1: 11 }, { _0: ">>", _1: 11 }, { _0: "<", _1: 10 }, { _0: ">", _1: 10 }, { _0: "+", _1: 12 }, { _0: "-", _1: 12 }, { _0: "**", _1: 14 }, { _0: "*", _1: 13 }, { _0: "/", _1: 13 }, { _0: "%", _1: 13 }];
    const _bind$4 = _bind$3.length;
    let _tmp$2 = 0;
    while (true) {
      const _ = _tmp$2;
      if (_ < _bind$4) {
        const _foreach_element = _bind$3[_];
        let op;
        let precedence;
        _L: {
          const _op = _foreach_element._0;
          const _precedence = _foreach_element._1;
          op = _op;
          precedence = _precedence;
          break _L;
        }
        _L$2: {
          const cs = _M0MPC16string6String9to__array(op);
          if ((self.pos + cs.length | 0) <= self.chars.length && _M0IPC15array5ArrayPB2Eq5equalGcE(_M0MPC15array9ArrayView9to__ownedGcE(_M0MPC15array5Array12view_2einnerGcE(self.chars, self.pos, self.pos + cs.length | 0)), cs)) {
            if (_M0FP211localreview3tcl8namechar(_M0MPC15array5Array2atGcE(cs, 0)) && _M0FP211localreview3tcl8namechar(_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, cs.length))) {
              break _L$2;
            }
            found.val = { _0: op, _1: precedence };
            break;
          }
          break _L$2;
        }
        _tmp$2 = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    let op;
    let precedence;
    _L: {
      const _bind$5 = found.val;
      const _op = _bind$5._0;
      const _precedence = _bind$5._1;
      op = _op;
      precedence = _precedence;
      break _L;
    }
    if (precedence === 0 || precedence < minimum) {
      break;
    }
    self.pos = self.pos + op.length | 0;
    const _bind$5 = _M0MP211localreview3tcl12ScriptParser10expression(self, op === "**" ? precedence : precedence + 1 | 0, depth + 1 | 0);
    let _tmp$3;
    if (_bind$5.$tag === 1) {
      const _ok = _bind$5;
      _tmp$3 = _ok._0;
    } else {
      return _bind$5;
    }
    left.val = new _M0DTP211localreview3tcl4Expr6Binary(op, left.val, _tmp$3);
    continue;
  }
  return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE2Ok(left.val);
}
function _M0MP211localreview3tcl12ScriptParser7operand(self, depth) {
  if (depth > 64) {
    return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expression nesting limit"));
  }
  _M0MP211localreview3tcl12ScriptParser11expr__space(self);
  const c = _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0);
  if (_M0MPC15array5Array8containsGcE([43, 45, 33, 126], c)) {
    self.pos = self.pos + 1 | 0;
    const _bind$2 = _M0MP211localreview3tcl12ScriptParser7operand(self, depth + 1 | 0);
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE2Ok(new _M0DTP211localreview3tcl4Expr5Unary(_M0IPC14char4CharPB4Show10to__string(c), _tmp));
  }
  if (c === 40) {
    self.pos = self.pos + 1 | 0;
    const _bind$2 = _M0MP211localreview3tcl12ScriptParser10expression(self, 1, depth + 1 | 0);
    let value;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      value = _ok._0;
    } else {
      return _bind$2;
    }
    _M0MP211localreview3tcl12ScriptParser11expr__space(self);
    if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) !== 41) {
      return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("missing expression close-parenthesis"));
    }
    self.pos = self.pos + 1 | 0;
    return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE2Ok(value);
  }
  if (c === 123) {
    const _bind$2 = _M0MP211localreview3tcl12ScriptParser6braces(self);
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE2Ok(new _M0DTP211localreview3tcl4Expr5Value(_tmp));
  }
  if (c === 34) {
    self.pos = self.pos + 1 | 0;
    const _bind$2 = _M0MP211localreview3tcl12ScriptParser13parts_2einner(self, 34, false, depth + 1 | 0, false);
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE2Ok(new _M0DTP211localreview3tcl4Expr10Substitute(_tmp));
  }
  if (c === 36) {
    const _bind$2 = _M0MP211localreview3tcl12ScriptParser8variable(self, depth + 1 | 0);
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE2Ok(new _M0DTP211localreview3tcl4Expr10Substitute([_tmp]));
  }
  if (c === 91) {
    self.pos = self.pos + 1 | 0;
    const _bind$2 = _M0MP211localreview3tcl12ScriptParser14script_2einner(self, true, depth + 1 | 0, false);
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE2Ok(new _M0DTP211localreview3tcl4Expr10Substitute([new _M0DTP211localreview3tcl4Part7Command(_tmp)]));
  }
  const start = self.pos;
  while (true) {
    if (self.pos < self.chars.length) {
      const x = _M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0);
      if (_M0FP211localreview3tcl11list__space(x) || _M0MPC15array5Array8containsGcE([40, 41, 44, 63, 58, 42, 47, 37, 60, 62, 61, 33, 38, 94, 124, 126], x)) {
        break;
      }
      if (x === 43 || x === 45) {
        const hex = self.pos >= (start + 2 | 0) && (_M0MPC15array5Array2atGcE(self.chars, start) === 48 && _M0MPC15array5Array8containsGcE([120, 88], _M0MPC15array5Array2atGcE(self.chars, start + 1 | 0)));
        if (self.pos === start || (hex || !_M0MPC15array5Array8containsGcE([101, 69], _M0MPC15array5Array2atGcE(self.chars, self.pos - 1 | 0)))) {
          break;
        }
      }
      self.pos = self.pos + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  if (start === self.pos) {
    return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expected expression operand"));
  }
  const text = _M0MPC16string6String11from__array(_M0MPC15array5Array12view_2einnerGcE(self.chars, start, self.pos));
  _M0MP211localreview3tcl12ScriptParser11expr__space(self);
  if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) === 40) {
    self.pos = self.pos + 1 | 0;
    _M0MP211localreview3tcl12ScriptParser11expr__space(self);
    const args = [];
    if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) !== 41) {
      while (true) {
        const _bind$2 = _M0MP211localreview3tcl12ScriptParser10expression(self, 1, depth + 1 | 0);
        let _tmp;
        if (_bind$2.$tag === 1) {
          const _ok = _bind$2;
          _tmp = _ok._0;
        } else {
          return _bind$2;
        }
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(args, _tmp);
        _M0MP211localreview3tcl12ScriptParser11expr__space(self);
        if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) !== 44) {
          break;
        }
        self.pos = self.pos + 1 | 0;
        continue;
      }
    }
    if (_M0MP211localreview3tcl12ScriptParser12peek_2einner(self, 0) !== 41) {
      return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("missing math function close-parenthesis"));
    }
    self.pos = self.pos + 1 | 0;
    return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE2Ok(new _M0DTP211localreview3tcl4Expr8Function(text, args));
  }
  const _bind$2 = _M0FP211localreview3tcl6number(text);
  if (_bind$2 === undefined) {
    let _tmp;
    let _try_err;
    _L: {
      _L$2: {
        const _bind$3 = _M0FP211localreview3tcl7boolean(text);
        if (_bind$3.$tag === 1) {
          const _ok = _bind$3;
          _ok._0;
        } else {
          const _err = _bind$3;
          _try_err = _err._0;
          break _L$2;
        }
        _tmp = true;
        break _L;
      }
      _tmp = false;
    }
    if (!_tmp) {
      return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid(`invalid bareword ${text}`));
    }
  }
  return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE2Ok(new _M0DTP211localreview3tcl4Expr5Value(text));
}
function _M0MP211localreview3tcl11Interpreter18cached__expression(self, source) {
  const cache = self.state.cache;
  let expr;
  _L: {
    _L$2: {
      const _bind$2 = _M0MPB3Map3getGsRP211localreview3tcl4ExprE(cache.expressions, source);
      if (_bind$2 === undefined) {
      } else {
        const _Some = _bind$2;
        const _expr = _Some;
        expr = _expr;
        break _L$2;
      }
      break _L;
    }
    if (cache.expression_hits < 2147483647) {
      cache.expression_hits = cache.expression_hits + 1 | 0;
    }
    return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE2Ok(expr);
  }
  const parser = new _M0TP211localreview3tcl12ScriptParser(_M0MPC16string6String9to__array(source), 0, 0, 1, 0, 1);
  const _bind$2 = _M0MP211localreview3tcl12ScriptParser10expression(parser, 1, 0);
  let expr$2;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    expr$2 = _ok._0;
  } else {
    return _bind$2;
  }
  _M0MP211localreview3tcl12ScriptParser11expr__space(parser);
  if (parser.pos !== parser.chars.length) {
    return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("trailing expression token"));
  }
  if (_M0MPB3Map6lengthGsRP211localreview3tcl13ScriptProgramE(cache.expressions) >= 256 || (cache.expression_units + source.length | 0) > 131072) {
    _M0MPB3Map5clearGsRP211localreview3tcl13ScriptProgramE(cache.expressions);
    cache.expression_units = 0;
  }
  if (source.length <= 16384) {
    _M0MPB3Map3setGsRP211localreview3tcl4ExprE(cache.expressions, source, expr$2);
    cache.expression_units = cache.expression_units + source.length | 0;
  }
  return new _M0DTPC16result6ResultGRP211localreview3tcl4ExprRP211localreview3tcl8TclErrorE2Ok(expr$2);
}
function _M0FP211localreview3tcl15double__integer(value) {
  if (_M0MPC16double6Double7is__nan(value) || _M0MPC16double6Double7is__inf(value)) {
    return new _M0DTPC16result6ResultGRPC16bigint6BigIntRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("cannot convert non-finite integer"));
  }
  const bits = $f64_reinterpret_i64(value);
  const exponent = (Number(BigInt.asIntN(32, BigInt.asUintN(64, BigInt.asUintN(64, BigInt.asUintN(64, bits) >> BigInt(52 & 63)) & 2047n))) | 0) - 1023 | 0;
  if (exponent < 0) {
    return new _M0DTPC16result6ResultGRPC16bigint6BigIntRP211localreview3tcl8TclErrorE2Ok(0n);
  }
  const mantissa = BigInt.asUintN(64, BigInt.asUintN(64, bits & 4503599627370495n) | 4503599627370496n);
  let n;
  let _try_err;
  _L: {
    _L$2: {
      const _bind$2 = _M0MPC16uint646UInt6418to__string_2einner(mantissa, 10);
      const _bind$3 = _M0FPC16string21parse__bigint_2einner(new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length), 10);
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        n = _ok._0;
      } else {
        const _err = _bind$3;
        _try_err = _err._0;
        break _L$2;
      }
      break _L;
    }
    return new _M0DTPC16result6ResultGRPC16bigint6BigIntRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("integer conversion"));
  }
  const magnitude = exponent >= 52 ? _M0IPC16bigint6BigIntPB3Shl3shl(n, exponent - 52 | 0) : _M0IPC16bigint6BigIntPB3Shr3shr(n, 52 - exponent | 0);
  return new _M0DTPC16result6ResultGRPC16bigint6BigIntRP211localreview3tcl8TclErrorE2Ok(value < 0 ? _M0IPC16bigint6BigIntPB3Neg3neg(magnitude) : magnitude);
}
function _M0FP211localreview3tcl24integer__double__compare(a, b) {
  if (_M0MPC16double6Double7is__inf(b)) {
    return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(b < 0 ? 1 : -1);
  }
  const _bind$2 = _M0FP211localreview3tcl15double__integer(b);
  let integral;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    integral = _ok._0;
  } else {
    return _bind$2;
  }
  const order = _M0IPC16bigint6BigIntPB7Compare7compare(a, integral);
  if (order !== 0) {
    return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(order);
  }
  return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(b === _M0MPC16double6Double5floor(b) ? 0 : b < 0 ? 1 : -1);
}
function _M0FP211localreview3tcl16small__operation(operator, x, y) {
  const a = BigInt.asUintN(64, BigInt(x));
  const b = BigInt.asUintN(64, BigInt(y));
  let result;
  _L: {
    _L$2: {
      switch (operator) {
        case "+": {
          result = _M0MPC15int645Int6418to__string_2einner(BigInt.asUintN(64, a + b), 10);
          break;
        }
        case "-": {
          result = _M0MPC15int645Int6418to__string_2einner(BigInt.asUintN(64, a - b), 10);
          break;
        }
        case "*": {
          result = _M0MPC15int645Int6418to__string_2einner(BigInt.asUintN(64, a * b), 10);
          break;
        }
        case "/": {
          break _L$2;
        }
        case "%": {
          break _L$2;
        }
        case "&": {
          result = _M0MPC13int3Int18to__string_2einner(x & y, 10);
          break;
        }
        case "|": {
          result = _M0MPC13int3Int18to__string_2einner(x | y, 10);
          break;
        }
        case "^": {
          result = _M0MPC13int3Int18to__string_2einner(x ^ y, 10);
          break;
        }
        case "==": {
          result = _M0FP211localreview3tcl13boolean__text(x === y);
          break;
        }
        case "!=": {
          result = _M0FP211localreview3tcl13boolean__text(x !== y);
          break;
        }
        case "<": {
          result = _M0FP211localreview3tcl13boolean__text(x < y);
          break;
        }
        case ">": {
          result = _M0FP211localreview3tcl13boolean__text(x > y);
          break;
        }
        case "<=": {
          result = _M0FP211localreview3tcl13boolean__text(x <= y);
          break;
        }
        case ">=": {
          result = _M0FP211localreview3tcl13boolean__text(x >= y);
          break;
        }
        default: {
          return new _M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE2Ok(undefined);
        }
      }
      break _L;
    }
    if (y === 0) {
      return new _M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_M0FP211localreview3tcl25completion__error_2einner("divide by zero", "ARITH DIVZERO {divide by zero}")));
    }
    if (b === 0n) {
      $panic();
    }
    const q = BigInt.asUintN(64, BigInt.asIntN(64, a) / BigInt.asIntN(64, b));
    if (b === 0n) {
      $panic();
    }
    const r = BigInt.asUintN(64, BigInt.asIntN(64, a) % BigInt.asIntN(64, b));
    result = operator === "/" ? _M0MPC15int645Int6418to__string_2einner(BigInt.asUintN(64, r) !== BigInt.asUintN(64, 0n) && _M0IP016_24default__implPB2Eq10not__equalGbE(x < 0, y < 0) ? BigInt.asUintN(64, q - 1n) : q, 10) : _M0MPC15int645Int6418to__string_2einner(BigInt.asUintN(64, r) !== BigInt.asUintN(64, 0n) && _M0IP016_24default__implPB2Eq10not__equalGbE(BigInt.asIntN(64, r) < BigInt.asIntN(64, 0n), y < 0) ? BigInt.asUintN(64, r + b) : r, 10);
  }
  return new _M0DTPC16result6ResultGOsRP211localreview3tcl8TclErrorE2Ok(result);
}
function _M0FP211localreview3tcl20tcl__string__compare(a, b) {
  const _bind$2 = 0;
  const _bind$3 = _M0MPC13int3Int3min(a.length, b.length);
  let _tmp = _bind$2;
  while (true) {
    const i = _tmp;
    if (i < _bind$3) {
      const x = _M0MPC16option6Option6unwrapGkE(_M0MPC16string6String3get(a, i));
      const y = _M0MPC16option6Option6unwrapGkE(_M0MPC16string6String3get(b, i));
      if (x < y) {
        return -1;
      }
      if (x > y) {
        return 1;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return $compare_int(a.length, b.length);
}
function _M0MP211localreview3tcl6Number7promote(self) {
  let x;
  _L: {
    if (self.$tag === 0) {
      const _Small = self;
      const _x = _Small._0;
      x = _x;
      break _L;
    } else {
      return self;
    }
  }
  return new _M0DTP211localreview3tcl6Number5Whole(_M0MPC16bigint6BigInt9from__int(x));
}
function _M0FP211localreview3tcl15numeric__binary(operator, left, right) {
  if (operator === "eq" || operator === "ne") {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(left === right === (operator === "eq")));
  }
  if (operator === "in" || operator === "ni") {
    const _bind$2 = _M0FP211localreview3tcl11parse__list(right);
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(_M0MPC15array5Array8containsGsE(_tmp, left) === (operator === "in")));
  }
  const a = _M0FP211localreview3tcl6number(left);
  const b = _M0FP211localreview3tcl6number(right);
  let x;
  let y;
  _L: {
    _L$2: {
      if (a === undefined) {
      } else {
        const _Some = a;
        const _x = _Some;
        if (_x.$tag === 0) {
          const _Small = _x;
          const _x$2 = _Small._0;
          if (b === undefined) {
          } else {
            const _Some$2 = b;
            const _x$3 = _Some$2;
            if (_x$3.$tag === 0) {
              const _Small$2 = _x$3;
              const _y = _Small$2._0;
              x = _x$2;
              y = _y;
              break _L$2;
            }
          }
        }
      }
      break _L;
    }
    let result;
    _L$3: {
      _L$4: {
        const _bind$2 = _M0FP211localreview3tcl16small__operation(operator, x, y);
        let _bind$3;
        if (_bind$2.$tag === 1) {
          const _ok = _bind$2;
          _bind$3 = _ok._0;
        } else {
          return _bind$2;
        }
        if (_bind$3 === undefined) {
        } else {
          const _Some = _bind$3;
          const _result = _Some;
          result = _result;
          break _L$4;
        }
        break _L$3;
      }
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(result);
    }
  }
  const a$2 = _M0MPC16option6Option3mapGRP211localreview3tcl6NumberRP211localreview3tcl6NumberE(a, _M0MP211localreview3tcl6Number7promote);
  const b$2 = _M0MPC16option6Option3mapGRP211localreview3tcl6NumberRP211localreview3tcl6NumberE(b, _M0MP211localreview3tcl6Number7promote);
  if (_M0MPC15array5Array8containsGsE(["==", "!=", "<", ">", "<=", ">="], operator)) {
    let comparison;
    _L$2: {
      _L$3: {
        let a$3;
        let b$3;
        _L$4: {
          _L$5: {
            let a$4;
            let b$4;
            _L$6: {
              _L$7: {
                let a$5;
                let b$5;
                _L$8: {
                  _L$9: {
                    let a$6;
                    let b$6;
                    _L$10: {
                      if (a$2 === undefined) {
                        break _L$3;
                      } else {
                        const _Some = a$2;
                        const _x = _Some;
                        switch (_x.$tag) {
                          case 1: {
                            const _Whole = _x;
                            const _a = _Whole._0;
                            if (b$2 === undefined) {
                              break _L$3;
                            } else {
                              const _Some$2 = b$2;
                              const _x$2 = _Some$2;
                              switch (_x$2.$tag) {
                                case 1: {
                                  const _Whole$2 = _x$2;
                                  const _b = _Whole$2._0;
                                  a$6 = _a;
                                  b$6 = _b;
                                  break _L$10;
                                }
                                case 2: {
                                  const _Real = _x$2;
                                  const _b$2 = _Real._0;
                                  a$5 = _a;
                                  b$5 = _b$2;
                                  break _L$9;
                                }
                                default: {
                                  a$3 = _x;
                                  b$3 = _x$2;
                                  break _L$5;
                                }
                              }
                            }
                          }
                          case 2: {
                            const _Real = _x;
                            const _a$2 = _Real._0;
                            if (b$2 === undefined) {
                              break _L$3;
                            } else {
                              const _Some$2 = b$2;
                              const _x$2 = _Some$2;
                              if (_x$2.$tag === 1) {
                                const _Whole$2 = _x$2;
                                const _b = _Whole$2._0;
                                a$4 = _a$2;
                                b$4 = _b;
                                break _L$7;
                              } else {
                                a$3 = _x;
                                b$3 = _x$2;
                                break _L$5;
                              }
                            }
                          }
                          default: {
                            if (b$2 === undefined) {
                              break _L$3;
                            } else {
                              const _Some$2 = b$2;
                              const _b = _Some$2;
                              a$3 = _x;
                              b$3 = _b;
                              break _L$5;
                            }
                          }
                        }
                      }
                    }
                    comparison = _M0IPC16bigint6BigIntPB7Compare7compare(a$6, b$6);
                    break _L$8;
                  }
                  if (_M0MPC16double6Double7is__nan(b$5)) {
                    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(operator === "!="));
                  }
                  const _bind$2 = _M0FP211localreview3tcl24integer__double__compare(a$5, b$5);
                  if (_bind$2.$tag === 1) {
                    const _ok = _bind$2;
                    comparison = _ok._0;
                  } else {
                    return _bind$2;
                  }
                }
                break _L$6;
              }
              if (_M0MPC16double6Double7is__nan(a$4)) {
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(operator === "!="));
              }
              const _bind$2 = _M0FP211localreview3tcl24integer__double__compare(b$4, a$4);
              let _tmp;
              if (_bind$2.$tag === 1) {
                const _ok = _bind$2;
                _tmp = _ok._0;
              } else {
                return _bind$2;
              }
              comparison = -_tmp | 0;
            }
            break _L$4;
          }
          const x$2 = _M0MP211localreview3tcl6Number6double(a$3);
          const y$2 = _M0MP211localreview3tcl6Number6double(b$3);
          if (_M0MPC16double6Double7is__nan(x$2) || _M0MPC16double6Double7is__nan(y$2)) {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(operator === "!="));
          }
          comparison = x$2 < y$2 ? -1 : x$2 > y$2 ? 1 : 0;
        }
        break _L$2;
      }
      comparison = _M0FP211localreview3tcl20tcl__string__compare(left, right);
    }
    let _tmp;
    switch (operator) {
      case "==": {
        _tmp = comparison === 0;
        break;
      }
      case "!=": {
        _tmp = comparison !== 0;
        break;
      }
      case "<": {
        _tmp = comparison < 0;
        break;
      }
      case ">": {
        _tmp = comparison > 0;
        break;
      }
      case "<=": {
        _tmp = comparison <= 0;
        break;
      }
      default: {
        _tmp = comparison >= 0;
      }
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(_tmp));
  }
  _L$2: {
    let a$3;
    _L$3: {
      if (a$2 === undefined) {
        break _L$2;
      } else {
        const _Some = a$2;
        const _a = _Some;
        a$3 = _a;
        break _L$3;
      }
    }
    let b$3;
    _L$4: {
      if (b$2 === undefined) {
        break _L$2;
      } else {
        const _Some = b$2;
        const _b = _Some;
        b$3 = _b;
        break _L$4;
      }
    }
    let x$2;
    let y$2;
    _L$5: {
      _L$6: {
        if (a$3.$tag === 1) {
          const _Whole = a$3;
          const _x = _Whole._0;
          if (b$3.$tag === 1) {
            const _Whole$2 = b$3;
            const _y = _Whole$2._0;
            x$2 = _x;
            y$2 = _y;
            break _L$6;
          }
        }
        break _L$5;
      }
      let value;
      _L$7: {
        _L$8: {
          switch (operator) {
            case "+": {
              value = _M0IPC16bigint6BigIntPB3Add3add(x$2, y$2);
              break;
            }
            case "-": {
              value = _M0IPC16bigint6BigIntPB3Sub3sub(x$2, y$2);
              break;
            }
            case "*": {
              if ((_M0MPC16bigint6BigInt11bit__length(x$2) + _M0MPC16bigint6BigInt11bit__length(y$2) | 0) > 16384) {
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("integer bit limit"));
              }
              value = _M0IPC16bigint6BigIntPB3Mul3mul(x$2, y$2);
              break;
            }
            case "%": {
              if (_M0IPC16bigint6BigIntPB2Eq5equal(y$2, 0n)) {
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_M0FP211localreview3tcl25completion__error_2einner("divide by zero", "ARITH DIVZERO {divide by zero}")));
              }
              const r = _M0IPC16bigint6BigIntPB3Mod3mod(x$2, y$2);
              value = _M0IP016_24default__implPB2Eq10not__equalGRPC16bigint6BigIntE(r, 0n) && _M0IP016_24default__implPB2Eq10not__equalGbE(_M0IP016_24default__implPB7Compare6op__ltGRPC16bigint6BigIntE(r, 0n), _M0IP016_24default__implPB7Compare6op__ltGRPC16bigint6BigIntE(y$2, 0n)) ? _M0IPC16bigint6BigIntPB3Add3add(r, y$2) : r;
              break;
            }
            case "**": {
              if (_M0IP016_24default__implPB7Compare6op__ltGRPC16bigint6BigIntE(y$2, 0n)) {
                if (_M0IPC16bigint6BigIntPB2Eq5equal(x$2, 0n)) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_M0FP211localreview3tcl25completion__error_2einner("exponentiation of zero by negative power", "ARITH DOMAIN {exponentiation of zero by negative power}")));
                }
                value = _M0IPC16bigint6BigIntPB2Eq5equal(x$2, 1n) ? 1n : _M0IPC16bigint6BigIntPB2Eq5equal(x$2, _M0IPC16bigint6BigIntPB3Neg3neg(1n)) ? (_M0IPC16bigint6BigIntPB2Eq5equal(_M0IPC16bigint6BigIntPB3Mod3mod(y$2, 2n), 0n) ? 1n : _M0IPC16bigint6BigIntPB3Neg3neg(1n)) : 0n;
              } else {
                let _tmp;
                if (_M0IP016_24default__implPB7Compare6op__gtGRPC16bigint6BigIntE(y$2, 16384n)) {
                  _tmp = true;
                } else {
                  let _tmp$2;
                  if (_M0MPC16bigint6BigInt11bit__length(x$2) > 1) {
                    const _tmp$3 = _M0MPC16bigint6BigInt11bit__length(x$2);
                    if (_tmp$3 === 0) {
                      $panic();
                    }
                    _tmp$2 = _M0IP016_24default__implPB7Compare6op__gtGRPC16bigint6BigIntE(y$2, _M0MPC16bigint6BigInt9from__int(16384 / _tmp$3 | 0));
                  } else {
                    _tmp$2 = false;
                  }
                  _tmp = _tmp$2;
                }
                if (_tmp) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("exponent limit"));
                }
                value = _M0MPC16bigint6BigInt3pow(x$2, y$2, _M0DTPC16option6OptionGRPC16bigint6BigIntE4None__);
              }
              break;
            }
            case "<<": {
              break _L$8;
            }
            case ">>": {
              break _L$8;
            }
            case "&": {
              value = _M0IPC16bigint6BigIntPB6BitAnd4land(x$2, y$2);
              break;
            }
            case "|": {
              value = _M0IPC16bigint6BigIntPB5BitOr3lor(x$2, y$2);
              break;
            }
            case "^": {
              value = _M0IPC16bigint6BigIntPB6BitXOr4lxor(x$2, y$2);
              break;
            }
            default: {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported integer operator"));
            }
          }
          break _L$7;
        }
        if (_M0IP016_24default__implPB7Compare6op__ltGRPC16bigint6BigIntE(y$2, 0n) || _M0IP016_24default__implPB7Compare6op__gtGRPC16bigint6BigIntE(y$2, 16384n)) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("shift limit"));
        }
        if (operator === "<<") {
          if ((_M0MPC16bigint6BigInt11bit__length(x$2) + _M0MPC16bigint6BigInt7to__int(y$2) | 0) > 16384) {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("integer bit limit"));
          }
          value = _M0IPC16bigint6BigIntPB3Shl3shl(x$2, _M0MPC16bigint6BigInt7to__int(y$2));
        } else {
          value = _M0IPC16bigint6BigIntPB3Shr3shr(x$2, _M0MPC16bigint6BigInt7to__int(y$2));
        }
      }
      const _bind$2 = _M0MP211localreview3tcl6Number4text(new _M0DTP211localreview3tcl6Number5Whole(value));
      let _tmp;
      if (_bind$2.$tag === 1) {
        const _ok = _bind$2;
        _tmp = _ok._0;
      } else {
        return _bind$2;
      }
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp);
    }
    if (_M0MPC15array5Array8containsGsE(["%", "<<", ">>", "&", "|", "^"], operator)) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("integer operand required"));
    }
    const x$3 = _M0MP211localreview3tcl6Number6double(a$3);
    const y$3 = _M0MP211localreview3tcl6Number6double(b$3);
    let result;
    switch (operator) {
      case "+": {
        result = x$3 + y$3;
        break;
      }
      case "-": {
        result = x$3 - y$3;
        break;
      }
      case "*": {
        result = x$3 * y$3;
        break;
      }
      case "/": {
        result = x$3 / y$3;
        break;
      }
      case "**": {
        result = _M0FPC14math3pow(x$3, y$3);
        break;
      }
      default: {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported arithmetic operator"));
      }
    }
    return _M0MP211localreview3tcl6Number4text(new _M0DTP211localreview3tcl6Number4Real(result));
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expected numeric operand"));
}
function _M0FP211localreview3tcl15numeric__divide(left, right) {
  const a = _M0FP211localreview3tcl6number(left);
  const b = _M0FP211localreview3tcl6number(right);
  let x;
  let y;
  _L: {
    _L$2: {
      if (a === undefined) {
      } else {
        const _Some = a;
        const _x = _Some;
        if (_x.$tag === 0) {
          const _Small = _x;
          const _x$2 = _Small._0;
          if (b === undefined) {
          } else {
            const _Some$2 = b;
            const _x$3 = _Some$2;
            if (_x$3.$tag === 0) {
              const _Small$2 = _x$3;
              const _y = _Small$2._0;
              x = _x$2;
              y = _y;
              break _L$2;
            }
          }
        }
      }
      break _L;
    }
    const _bind$2 = _M0FP211localreview3tcl16small__operation("/", x, y);
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_tmp));
  }
  _L$2: {
    let x$2;
    let y$2;
    _L$3: {
      const _bind$2 = _M0MPC16option6Option3mapGRP211localreview3tcl6NumberRP211localreview3tcl6NumberE(a, _M0MP211localreview3tcl6Number7promote);
      const _bind$3 = _M0MPC16option6Option3mapGRP211localreview3tcl6NumberRP211localreview3tcl6NumberE(b, _M0MP211localreview3tcl6Number7promote);
      if (_bind$2 === undefined) {
        break _L$2;
      } else {
        const _Some = _bind$2;
        const _x = _Some;
        if (_x.$tag === 1) {
          const _Whole = _x;
          const _x$2 = _Whole._0;
          if (_bind$3 === undefined) {
            break _L$2;
          } else {
            const _Some$2 = _bind$3;
            const _x$3 = _Some$2;
            if (_x$3.$tag === 1) {
              const _Whole$2 = _x$3;
              const _y = _Whole$2._0;
              x$2 = _x$2;
              y$2 = _y;
              break _L$3;
            } else {
              break _L$2;
            }
          }
        } else {
          break _L$2;
        }
      }
    }
    if (_M0IPC16bigint6BigIntPB2Eq5equal(y$2, 0n)) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_M0FP211localreview3tcl25completion__error_2einner("divide by zero", "ARITH DIVZERO {divide by zero}")));
    }
    const q = _M0IPC16bigint6BigIntPB3Div3div(x$2, y$2);
    const r = _M0IPC16bigint6BigIntPB3Mod3mod(x$2, y$2);
    return _M0MP211localreview3tcl6Number4text(new _M0DTP211localreview3tcl6Number5Whole(_M0IP016_24default__implPB2Eq10not__equalGRPC16bigint6BigIntE(r, 0n) && _M0IP016_24default__implPB2Eq10not__equalGbE(_M0IP016_24default__implPB7Compare6op__ltGRPC16bigint6BigIntE(x$2, 0n), _M0IP016_24default__implPB7Compare6op__ltGRPC16bigint6BigIntE(y$2, 0n)) ? _M0IPC16bigint6BigIntPB3Sub3sub(q, 1n) : q));
  }
  return _M0FP211localreview3tcl15numeric__binary("/", left, right);
}
function _M0MP211localreview3tcl11Interpreter4tick(self) {
  const _bind$2 = self.budget;
  _bind$2.val = _bind$2.val - 1 | 0;
  if (self.budget.val < 0) {
    return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("execution budget"));
  } else {
    return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
  }
}
function _M0FP211localreview3tcl16completion__code(value) {
  switch (value) {
    case "ok": {
      return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(0);
    }
    case "error": {
      return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(1);
    }
    case "return": {
      return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(2);
    }
    case "break": {
      return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(3);
    }
    case "continue": {
      return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(4);
    }
    default: {
      let _try_err;
      _L: {
        const _bind$2 = _M0FP211localreview3tcl7integer(value);
        let _tmp;
        if (_bind$2.$tag === 1) {
          const _ok = _bind$2;
          _tmp = _ok._0;
        } else {
          const _err = _bind$2;
          _try_err = _err._0;
          break _L;
        }
        return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(_tmp);
      }
      return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_M0FP211localreview3tcl25completion__error_2einner(`bad completion code \"${value}\": must be ok, error, return, break, continue, or an integer`, "TCL RESULT ILLEGAL_CODE")));
    }
  }
}
function _M0FP211localreview3tcl10dictionary(text) {
  const _bind$2 = _M0FP211localreview3tcl11parse__list(text);
  let words;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    words = _ok._0;
  } else {
    return _bind$2;
  }
  if (2 === 0) {
    $panic();
  }
  if ((words.length % 2 | 0) !== 0) {
    return new _M0DTPC16result6ResultGRPB5ArrayGUssEERP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("missing dictionary value"));
  }
  const result = [];
  const _bind$3 = [];
  const seen = _M0MPB3Map3MapGsiE(new _M0TPB9ArrayViewGUsiEE(_bind$3, 0, 0), undefined);
  const i = new _M0TPB8MutLocalGiE(0);
  while (true) {
    if (i.val < words.length) {
      let index;
      _L: {
        _L$2: {
          const _bind$4 = _M0MPB3Map3getGsiE(seen, _M0MPC15array5Array2atGRPB4JsonE(words, i.val));
          if (_bind$4 === undefined) {
            _M0MPB3Map3setGsiE(seen, _M0MPC15array5Array2atGRPB4JsonE(words, i.val), result.length);
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(result, { _0: _M0MPC15array5Array2atGRPB4JsonE(words, i.val), _1: _M0MPC15array5Array2atGRPB4JsonE(words, i.val + 1 | 0) });
          } else {
            const _Some = _bind$4;
            const _index = _Some;
            index = _index;
            break _L$2;
          }
          break _L;
        }
        _M0MPC15array5Array3setGUssEE(result, index, { _0: _M0MPC15array5Array2atGRPB4JsonE(words, i.val), _1: _M0MPC15array5Array2atGRPB4JsonE(words, i.val + 1 | 0) });
      }
      i.val = i.val + 2 | 0;
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGRPB5ArrayGUssEERP211localreview3tcl8TclErrorE2Ok(result);
}
function _M0FP211localreview3tcl22merge__return__options(target, values, depth) {
  if (depth > 64) {
    return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("return option nesting limit"));
  }
  const _bind$2 = values.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const _foreach_element = values[_];
      let key;
      let value;
      _L: {
        const _key = _foreach_element._0;
        const _value = _foreach_element._1;
        key = _key;
        value = _value;
        break _L;
      }
      if (key === "-options") {
        const _bind$3 = _M0FP211localreview3tcl10dictionary(value);
        let _tmp$2;
        if (_bind$3.$tag === 1) {
          const _ok = _bind$3;
          _tmp$2 = _ok._0;
        } else {
          return _bind$3;
        }
        const _bind$4 = _M0FP211localreview3tcl22merge__return__options(target, _tmp$2, depth + 1 | 0);
        if (_bind$4.$tag === 1) {
          const _ok = _bind$4;
          _ok._0;
        } else {
          return _bind$4;
        }
      } else {
        _M0FP211localreview3tcl11option__set(target, key, value);
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
}
function _M0MP211localreview3tcl11Interpreter9propagate(self, result) {
  if (_M0MP211localreview3tcl10Completion12actual__code(result) === 0) {
    self.state.return_options.val = result.options;
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(result.value);
  } else {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(result));
  }
}
function _M0MP211localreview3tcl11Interpreter15return__command(self, args) {
  if (args.length <= 2) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eReturn(args.length === 2 ? _M0MPC15array5Array2atGRPB4JsonE(args, 1) : ""));
  }
  const count = args.length - 1 | 0;
  let value;
  if (2 === 0) {
    $panic();
  }
  if ((count % 2 | 0) === 1) {
    value = _M0MPC15array5Array2atGRPB4JsonE(args, args.length - 1 | 0);
  } else {
    value = "";
  }
  const pairs = [];
  let _tmp = 1;
  while (true) {
    const i = _tmp;
    if ((i + 1 | 0) < args.length) {
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(pairs, { _0: _M0MPC15array5Array2atGRPB4JsonE(args, i), _1: _M0MPC15array5Array2atGRPB4JsonE(args, i + 1 | 0) });
      _tmp = i + 2 | 0;
      continue;
    } else {
      break;
    }
  }
  const options = [];
  const _bind$2 = _M0FP211localreview3tcl22merge__return__options(options, pairs, 0);
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    _ok._0;
  } else {
    return _bind$2;
  }
  const _bind$3 = _M0FP211localreview3tcl16completion__code(_M0MPC16option6Option10unwrap__orGsE(_M0FP211localreview3tcl11option__get(options, "-code"), "0"));
  let _tmp$2;
  if (_bind$3.$tag === 1) {
    const _ok = _bind$3;
    _tmp$2 = _ok._0;
  } else {
    return _bind$3;
  }
  const code = new _M0TPB8MutLocalGiE(_tmp$2);
  const level_text = _M0MPC16option6Option10unwrap__orGsE(_M0FP211localreview3tcl11option__get(options, "-level"), "1");
  let _tmp$3;
  let _try_err;
  _L: {
    _L$2: {
      const _bind$4 = _M0FP211localreview3tcl7integer(level_text);
      let parsed;
      if (_bind$4.$tag === 1) {
        const _ok = _bind$4;
        parsed = _ok._0;
      } else {
        const _err = _bind$4;
        _try_err = _err._0;
        break _L$2;
      }
      if (parsed < 0) {
        _try_err = new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("negative level");
        break _L$2;
      }
      _tmp$3 = parsed;
      break _L;
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_M0FP211localreview3tcl25completion__error_2einner(`bad -level value: expected non-negative integer but got \"${level_text}\"`, "TCL RESULT ILLEGAL_LEVEL")));
  }
  const level = new _M0TPB8MutLocalGiE(_tmp$3);
  if (code.val === 2) {
    code.val = 0;
    level.val = level.val + 1 | 0;
  }
  const extras = _M0MPC15array5Array6filterGUssEE(options, (pair) => _M0IP016_24default__implPB2Eq10not__equalGsE(pair._0, "-code") && _M0IP016_24default__implPB2Eq10not__equalGsE(pair._0, "-level"));
  let text;
  _L$2: {
    _L$3: {
      const _bind$4 = _M0FP211localreview3tcl11option__get(extras, "-errorcode");
      if (_bind$4 === undefined) {
      } else {
        const _Some = _bind$4;
        const _text = _Some;
        text = _text;
        break _L$3;
      }
      break _L$2;
    }
    const _bind$4 = _M0FP211localreview3tcl11parse__list(text);
    if (_bind$4.$tag === 1) {
      const _ok = _bind$4;
      _ok._0;
    } else {
      return _bind$4;
    }
  }
  let text$2;
  _L$3: {
    _L$4: {
      const _bind$4 = _M0FP211localreview3tcl11option__get(extras, "-errorstack");
      if (_bind$4 === undefined) {
      } else {
        const _Some = _bind$4;
        const _text = _Some;
        text$2 = _text;
        break _L$4;
      }
      break _L$3;
    }
    const _bind$4 = _M0FP211localreview3tcl11parse__list(text$2);
    let _tmp$4;
    if (_bind$4.$tag === 1) {
      const _ok = _bind$4;
      _tmp$4 = _ok._0;
    } else {
      return _bind$4;
    }
    if (2 === 0) {
      $panic();
    }
    if ((_tmp$4.length % 2 | 0) !== 0) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("errorstack requires token/value pairs"));
    }
  }
  if (code.val === 1) {
    const _bind$4 = _M0FP211localreview3tcl11option__get(extras, "-errorcode");
    if (_bind$4 === undefined) {
      _M0FP211localreview3tcl11option__set(extras, "-errorcode", "NONE");
    }
    let text$3;
    _L$4: {
      _L$5: {
        const _bind$5 = _M0FP211localreview3tcl11option__get(extras, "-errorinfo");
        if (_bind$5 === undefined) {
        } else {
          const _Some = _bind$5;
          const _text = _Some;
          text$3 = _text;
          break _L$5;
        }
        break _L$4;
      }
      if (!_M0MPC16string6String9is__empty(text$3)) {
        const _bind$5 = _M0FP211localreview3tcl11option__get(extras, "-errorline");
        if (_bind$5 === undefined) {
          _M0FP211localreview3tcl11option__set(extras, "-errorline", "1");
        }
      }
    }
  }
  return _M0MP211localreview3tcl11Interpreter9propagate(self, _M0FP211localreview3tcl18completion_2einner(code.val, value, level.val, extras, level.val === 0 && _M0IP016_24default__implPB2Eq10not__equalGsE(_M0MPC16option6Option10unwrap__orGsE(_M0FP211localreview3tcl11option__get(extras, "-errorinfo"), ""), "")));
}
function _M0FP211localreview3tcl16dictionary__edit(text, keys, value, depth) {
  if (depth > 64) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dictionary nesting limit"));
  }
  if (_M0MPC15array5Array9is__emptyGRPB4JsonE(keys)) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dictionary key required"));
  }
  const _bind$2 = _M0FP211localreview3tcl10dictionary(text);
  let pairs;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    pairs = _ok._0;
  } else {
    return _bind$2;
  }
  const index = new _M0TPB8MutLocalGiE(-1);
  const _bind$3 = 0;
  const _bind$4 = pairs.length;
  let _tmp = _bind$3;
  while (true) {
    const i = _tmp;
    if (i < _bind$4) {
      if (_M0MPC15array5Array2atGRPB4JsonE(pairs, i)._0 === _M0MPC15array5Array2atGRPB4JsonE(keys, 0)) {
        index.val = i;
        break;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  let value$2;
  if (keys.length > 1) {
    if (index.val < 0) {
      if (value === undefined) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dictionary path not found"));
      }
    }
    const _bind$5 = _M0FP211localreview3tcl16dictionary__edit(index.val < 0 ? "" : _M0MPC15array5Array2atGRPB4JsonE(pairs, index.val)._1, _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(keys, 1, undefined)), value, depth + 1 | 0);
    if (_bind$5.$tag === 1) {
      const _ok = _bind$5;
      value$2 = _ok._0;
    } else {
      return _bind$5;
    }
  } else {
    value$2 = value;
  }
  let v;
  _L: {
    _L$2: {
      if (value$2 === undefined) {
        if (index.val >= 0) {
          _M0MPC15array5Array6removeGUssEE(pairs, index.val);
        }
      } else {
        const _Some = value$2;
        const _v = _Some;
        v = _v;
        break _L$2;
      }
      break _L;
    }
    if (index.val < 0) {
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(pairs, { _0: _M0MPC15array5Array2atGRPB4JsonE(keys, 0), _1: v });
    } else {
      _M0MPC15array5Array3setGUssEE(pairs, index.val, { _0: _M0MPC15array5Array2atGRPB4JsonE(keys, 0), _1: v });
    }
  }
  return _M0FP211localreview3tcl16dictionary__text(pairs);
}
function _M0FP211localreview3tcl15dictionary__get(text, path) {
  const value = new _M0TPB8MutLocalGsE(text);
  const _bind$2 = path.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const key = path[_];
      const _bind$3 = _M0FP211localreview3tcl10dictionary(value.val);
      let pairs;
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        pairs = _ok._0;
      } else {
        return _bind$3;
      }
      const found = _M0MPC15array5Array3getGUssEE(_M0MPC15array5Array6filterGUssEE(pairs, (p) => p._0 === key), 0);
      let _tmp$2;
      if (found === undefined) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dictionary key not found"));
      } else {
        const _Some = found;
        const _x = _Some;
        const _v = _x._1;
        _tmp$2 = _v;
      }
      value.val = _tmp$2;
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(value.val);
}
function _M0MP211localreview3tcl10DictObject3put(self, key, value) {
  const index = _M0MPB3Map3getGsiE(self.index, key);
  const encoded = _M0FP211localreview3tcl14quote__element(value, false);
  let units;
  let encoded_key;
  _L: {
    let i;
    _L$2: {
      if (index === undefined) {
        if (self.keys.length >= 50000) {
          return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dictionary element limit"));
        }
        const k = _M0FP211localreview3tcl14quote__element(key, _M0MPC15array5Array9is__emptyGRPB4JsonE(self.keys));
        units = ((self.units + k.length | 0) + encoded.length | 0) + (_M0MPC15array5Array9is__emptyGRPB4JsonE(self.keys) ? 1 : 2) | 0;
        encoded_key = k;
        break _L;
      } else {
        const _Some = index;
        const _i = _Some;
        i = _i;
        break _L$2;
      }
    }
    units = (self.units - _M0MPC15array5Array2atGRPB4JsonE(self.encoded, (Math.imul(i, 2) | 0) + 1 | 0).length | 0) + encoded.length | 0;
    encoded_key = "";
    break _L;
  }
  if (units > 1000000) {
    return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dictionary size limit"));
  }
  let i;
  _L$2: {
    _L$3: {
      if (index === undefined) {
        _M0MPB3Map3setGsiE(self.index, key, self.keys.length);
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(self.keys, key);
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(self.values, value);
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(self.encoded, encoded_key);
        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(self.encoded, encoded);
      } else {
        const _Some = index;
        const _i = _Some;
        i = _i;
        break _L$3;
      }
      break _L$2;
    }
    _M0MPC15array5Array3setGUssEE(self.values, i, value);
    _M0MPC15array5Array3setGUssEE(self.encoded, (Math.imul(i, 2) | 0) + 1 | 0, encoded);
  }
  self.units = units;
  self.representation = undefined;
  return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
}
function _M0MP211localreview3tcl10DictObject10from__text(text) {
  const _tmp = [];
  const _tmp$2 = [];
  const _bind$2 = [];
  const object = new _M0TP211localreview3tcl10DictObject(_tmp, _tmp$2, _M0MPB3Map3MapGsiE(new _M0TPB9ArrayViewGUsiEE(_bind$2, 0, 0), undefined), [], 0, text);
  const _bind$3 = _M0FP211localreview3tcl10dictionary(text);
  let _bind$4;
  if (_bind$3.$tag === 1) {
    const _ok = _bind$3;
    _bind$4 = _ok._0;
  } else {
    return _bind$3;
  }
  const _bind$5 = _bind$4.length;
  let _tmp$3 = 0;
  while (true) {
    const _ = _tmp$3;
    if (_ < _bind$5) {
      const _foreach_element = _bind$4[_];
      let key;
      let value;
      _L: {
        const _key = _foreach_element._0;
        const _value = _foreach_element._1;
        key = _key;
        value = _value;
        break _L;
      }
      const _bind$6 = _M0MP211localreview3tcl10DictObject3put(object, key, value);
      if (_bind$6.$tag === 1) {
        const _ok = _bind$6;
        _ok._0;
      } else {
        return _bind$6;
      }
      _tmp$3 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  object.representation = text;
  return new _M0DTPC16result6ResultGRP211localreview3tcl10DictObjectRP211localreview3tcl8TclErrorE2Ok(object);
}
function _M0MP211localreview3tcl10DictObject3get(self, key) {
  return _M0MPC16option6Option3mapGisE(_M0MPB3Map3getGsiE(self.index, key), (i) => _M0MPC15array5Array2atGRPB4JsonE(self.values, i));
}
function _M0FP211localreview3tcl16integer__compare(left, right) {
  let x;
  let y;
  _L: {
    _L$2: {
      const _bind$2 = _M0FP211localreview3tcl14small__decimal(left);
      const _bind$3 = _M0FP211localreview3tcl14small__decimal(right);
      if (_bind$2 === undefined) {
      } else {
        const _Some = _bind$2;
        const _x = _Some;
        if (_bind$3 === undefined) {
        } else {
          const _Some$2 = _bind$3;
          const _y = _Some$2;
          x = _x;
          y = _y;
          break _L$2;
        }
      }
      break _L;
    }
    return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok($compare_int(x, y));
  }
  const _bind$2 = _M0FP211localreview3tcl5whole(left);
  let _tmp;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    _tmp = _ok._0;
  } else {
    return _bind$2;
  }
  const _tmp$2 = _tmp;
  const _bind$3 = _M0FP211localreview3tcl5whole(right);
  let _tmp$3;
  if (_bind$3.$tag === 1) {
    const _ok = _bind$3;
    _tmp$3 = _ok._0;
  } else {
    return _bind$3;
  }
  return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(_M0IPC16bigint6BigIntPB7Compare7compare(_tmp$2, _tmp$3));
}
function _M0FP211localreview3tcl11list__index(text, length) {
  if (text === "end") {
    return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(length - 1 | 0);
  }
  const _bind$2 = "end-";
  if (_M0MPC16string6String11has__prefix(text, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
    const _tmp = length - 1 | 0;
    const _bind$3 = _M0FP211localreview3tcl7integer(_M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(text, 4, undefined)));
    let _tmp$2;
    if (_bind$3.$tag === 1) {
      const _ok = _bind$3;
      _tmp$2 = _ok._0;
    } else {
      return _bind$3;
    }
    return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(_tmp - _tmp$2 | 0);
  }
  const _bind$3 = "end+";
  if (_M0MPC16string6String11has__prefix(text, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
    const _tmp = length - 1 | 0;
    const _bind$4 = _M0FP211localreview3tcl7integer(_M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(text, 4, undefined)));
    let _tmp$2;
    if (_bind$4.$tag === 1) {
      const _ok = _bind$4;
      _tmp$2 = _ok._0;
    } else {
      return _bind$4;
    }
    return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(_tmp + _tmp$2 | 0);
  }
  return _M0FP211localreview3tcl7integer(text);
}
function _M0FP211localreview3tcl10list__edit(text, indices, replacement, depth) {
  if (depth > 64) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("nested list limit"));
  }
  if (_M0MPC15array5Array9is__emptyGRPB4JsonE(indices)) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(replacement);
  }
  const _bind$2 = _M0FP211localreview3tcl11parse__list(text);
  let values;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    values = _ok._0;
  } else {
    return _bind$2;
  }
  const _bind$3 = _M0FP211localreview3tcl11list__index(_M0MPC15array5Array2atGRPB4JsonE(indices, 0), values.length);
  let index;
  if (_bind$3.$tag === 1) {
    const _ok = _bind$3;
    index = _ok._0;
  } else {
    return _bind$3;
  }
  if (index < 0 || index > values.length) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("list index out of range"));
  }
  if (index === values.length) {
    _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values, "");
  }
  const _bind$4 = _M0FP211localreview3tcl10list__edit(_M0MPC15array5Array2atGRPB4JsonE(values, index), _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(indices, 1, undefined)), replacement, depth + 1 | 0);
  let _tmp;
  if (_bind$4.$tag === 1) {
    const _ok = _bind$4;
    _tmp = _ok._0;
  } else {
    return _bind$4;
  }
  _M0MPC15array5Array3setGUssEE(values, index, _tmp);
  return _M0FP211localreview3tcl12format__list(values);
}
function _M0FP211localreview3tcl13sort__strings(values, compare) {
  const buffer = _M0MPC15array5Array4copyGUssEE(values);
  const width = new _M0TPB8MutLocalGiE(1);
  while (true) {
    if (width.val < values.length) {
      const start = new _M0TPB8MutLocalGiE(0);
      while (true) {
        if (start.val < values.length) {
          const middle = _M0MPC13int3Int3min(start.val + width.val | 0, values.length);
          const end = _M0MPC13int3Int3min(start.val + (Math.imul(2, width.val) | 0) | 0, values.length);
          const a = new _M0TPB8MutLocalGiE(start.val);
          const b = new _M0TPB8MutLocalGiE(middle);
          const i = new _M0TPB8MutLocalGiE(start.val);
          while (true) {
            if (i.val < end) {
              let _tmp;
              if (b.val >= end) {
                _tmp = true;
              } else {
                let _tmp$2;
                if (a.val < middle) {
                  const _bind$2 = compare(_M0MPC15array5Array2atGRPB4JsonE(values, a.val), _M0MPC15array5Array2atGRPB4JsonE(values, b.val));
                  let _tmp$3;
                  if (_bind$2.$tag === 1) {
                    const _ok = _bind$2;
                    _tmp$3 = _ok._0;
                  } else {
                    return _bind$2;
                  }
                  _tmp$2 = _tmp$3 <= 0;
                } else {
                  _tmp$2 = false;
                }
                _tmp = _tmp$2;
              }
              if (_tmp) {
                _M0MPC15array5Array3setGUssEE(buffer, i.val, _M0MPC15array5Array2atGRPB4JsonE(values, a.val));
                a.val = a.val + 1 | 0;
              } else {
                _M0MPC15array5Array3setGUssEE(buffer, i.val, _M0MPC15array5Array2atGRPB4JsonE(values, b.val));
                b.val = b.val + 1 | 0;
              }
              i.val = i.val + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          start.val = end;
          continue;
        } else {
          break;
        }
      }
      const _bind$2 = 0;
      const _bind$3 = values.length;
      let _tmp = _bind$2;
      while (true) {
        const i = _tmp;
        if (i < _bind$3) {
          _M0MPC15array5Array3setGUssEE(values, i, _M0MPC15array5Array2atGRPB4JsonE(buffer, i));
          _tmp = i + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      width.val = Math.imul(width.val, 2) | 0;
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
}
function _M0MP211localreview3tcl11Interpreter14command__names(self, pattern, procedures_only) {
  const _bind$2 = "::";
  const qualified = _M0MPC16string6String8contains(pattern, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const full = _M0FP211localreview3tcl13command__name(self.frame.namespace_name, pattern);
  const space = _M0FP211localreview3tcl15command__parent(full);
  const tail = qualified ? _M0FP211localreview3tcl15namespace__tail(full) : pattern;
  let scopes;
  if (qualified) {
    scopes = [space];
  } else {
    const scopes$2 = [self.frame.namespace_name];
    if (!procedures_only) {
      const _bind$3 = _M0MPC16option6Option10unwrap__orGRPB5ArrayGsEE(_M0MPB3Map3getGsRPB5ArrayGsEE(self.state.namespace_paths, self.frame.namespace_name), []);
      const _bind$4 = _bind$3.length;
      let _tmp = 0;
      while (true) {
        const _ = _tmp;
        if (_ < _bind$4) {
          const item = _bind$3[_];
          _M0MPC15array5Array4pushGRPC14json10WriteFrameE(scopes$2, item);
          _tmp = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(scopes$2, "::");
    }
    scopes = scopes$2;
  }
  const values = [];
  const _it = _M0MPB3Map6valuesGsRP211localreview3tcl7CommandE(self.state.commands);
  while (true) {
    let command;
    _L: {
      const _bind$3 = _M0MPB4Iter4nextGUsRPB4JsonEE(_it);
      if (_bind$3 === undefined) {
        break;
      } else {
        const _Some = _bind$3;
        const _command = _Some;
        command = _command;
        break _L;
      }
    }
    if (_M0MPC15array5Array8containsGsE(scopes, _M0FP211localreview3tcl15command__parent(command.name))) {
      _L$2: {
        _L$3: {
          if (!procedures_only) {
            break _L$3;
          } else {
            const _bind$3 = _M0MP211localreview3tcl7Command6origin(command).body;
            if (_bind$3.$tag === 1) {
              break _L$3;
            }
          }
          break _L$2;
        }
        const _bind$3 = _M0FP211localreview3tcl11glob__match(tail, _M0FP211localreview3tcl15namespace__tail(command.name), false);
        let _tmp;
        if (_bind$3.$tag === 1) {
          const _ok = _bind$3;
          _tmp = _ok._0;
        } else {
          return _bind$3;
        }
        if (_tmp) {
          const value = qualified ? command.name : _M0FP211localreview3tcl15namespace__tail(command.name);
          if (!_M0MPC15array5Array8containsGsE(values, value)) {
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values, value);
          }
        }
      }
    }
    continue;
  }
  _M0MPC15array5Array4sortGsE(values);
  return new _M0DTPC16result6ResultGRPB5ArrayGsERP211localreview3tcl8TclErrorE2Ok(values);
}
function _M0MP211localreview3tcl11Interpreter13info__command(self, args) {
  const n = args.length;
  if (n < 2) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("info arity"));
  }
  _L: {
    _L$2: {
      _L$3: {
        const _bind$2 = _M0MPC15array5Array2atGRPB4JsonE(args, 1);
        switch (_bind$2) {
          case "exists": {
            if (n !== 3) {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("info exists arity"));
            }
            let exists;
            let binding;
            _L$4: {
              _L$5: {
                const _bind$3 = _M0MP211localreview3tcl11Interpreter7binding(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2), false);
                let _bind$4;
                if (_bind$3.$tag === 1) {
                  const _ok = _bind$3;
                  _bind$4 = _ok._0;
                } else {
                  return _bind$3;
                }
                if (_bind$4 === undefined) {
                  exists = false;
                } else {
                  const _Some = _bind$4;
                  const _binding = _Some;
                  binding = _binding;
                  break _L$5;
                }
                break _L$4;
              }
              const _bind$3 = binding.index;
              if (_bind$3 === undefined) {
                const _bind$4 = binding.cell.value;
                exists = !(_bind$4 === undefined);
              } else {
                let _try_err;
                _L$6: {
                  _L$7: {
                    const _bind$4 = _M0MP211localreview3tcl7Binding4read(binding);
                    let _bind$5;
                    if (_bind$4.$tag === 1) {
                      const _ok = _bind$4;
                      _bind$5 = _ok._0;
                    } else {
                      const _err = _bind$4;
                      _try_err = _err._0;
                      break _L$7;
                    }
                    exists = !(_bind$5 === undefined);
                    break _L$6;
                  }
                  exists = false;
                }
              }
            }
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(exists));
          }
          case "vars": {
            break _L$3;
          }
          case "globals": {
            break _L$3;
          }
          case "locals": {
            break _L$3;
          }
          case "procs": {
            break _L$2;
          }
          case "commands": {
            break _L$2;
          }
          case "body": {
            break _L;
          }
          case "args": {
            break _L;
          }
          case "default": {
            break _L;
          }
          case "level": {
            if (n !== 2) {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("info level argument not implemented"));
            }
            const level = new _M0TPB8MutLocalGiE(0);
            const frame = new _M0TPB8MutLocalGRP211localreview3tcl5FrameE(self.frame);
            while (true) {
              let parent;
              _L$5: {
                const _bind$3 = frame.val.parent;
                if (_bind$3 === undefined) {
                  break;
                } else {
                  const _Some = _bind$3;
                  const _parent = _Some;
                  parent = _parent;
                  break _L$5;
                }
              }
              level.val = level.val + 1 | 0;
              frame.val = parent;
              continue;
            }
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC13int3Int18to__string_2einner(level.val, 10));
          }
          case "errorstack": {
            if (n !== 2 && !(n === 3 && _M0MPC16string6String9is__empty(_M0MPC15array5Array2atGRPB4JsonE(args, 2)))) {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("info errorstack arity or unsupported interpreter"));
            }
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(self.state.error_stack.val);
          }
          case "patchlevel": {
            if (n !== 2) {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("info patchlevel arity"));
            }
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("0.6.0");
          }
          case "tclversion": {
            if (n !== 2) {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("info tclversion arity"));
            }
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("8.6");
          }
          default: {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported info subcommand"));
          }
        }
      }
      if (n > 3) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("info vars arity"));
      }
      const values = [];
      if (self.frame.procedure && _M0IP016_24default__implPB2Eq10not__equalGsE(_M0MPC15array5Array2atGRPB4JsonE(args, 1), "globals")) {
        const _it = _M0MPB3Map5iter2GsRPC15debug4ReprE(self.frame.vars);
        while (true) {
          let key;
          let binding;
          _L$4: {
            const _bind$2 = _M0MPB5Iter24nextGsRPC15debug4ReprE(_it);
            if (_bind$2 === undefined) {
              break;
            } else {
              const _Some = _bind$2;
              const _x = _Some;
              const _key = _x._0;
              const _binding = _x._1;
              key = _key;
              binding = _binding;
              break _L$4;
            }
          }
          const _bind$2 = binding.cell.value;
          if (_bind$2 === undefined) {
          } else {
            _L$5: {
              _L$6: {
                if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0MPC15array5Array2atGRPB4JsonE(args, 1), "locals")) {
                  break _L$6;
                } else {
                  if (!binding.linked) {
                    break _L$6;
                  }
                }
                break _L$5;
              }
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values, key);
            }
          }
          continue;
        }
      } else {
        const prefix = _M0MPC15array5Array2atGRPB4JsonE(args, 1) === "globals" ? "::" : self.frame.namespace_name;
        const _it = _M0MPB3Map5iter2GsRPC15debug4ReprE(self.state.globals);
        while (true) {
          let key;
          let cell;
          _L$4: {
            const _bind$2 = _M0MPB5Iter24nextGsRPC15debug4ReprE(_it);
            if (_bind$2 === undefined) {
              break;
            } else {
              const _Some = _bind$2;
              const _x = _Some;
              const _key = _x._0;
              const _cell = _x._1;
              key = _key;
              cell = _cell;
              break _L$4;
            }
          }
          _L$5: {
            _L$6: {
              const _bind$2 = cell.value;
              if (_bind$2 === undefined) {
                if (cell.declared) {
                  break _L$6;
                }
              } else {
                break _L$6;
              }
              break _L$5;
            }
            if (_M0FP211localreview3tcl17namespace__parent(key) === prefix) {
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values, _M0FP211localreview3tcl15namespace__tail(key));
            }
          }
          continue;
        }
        const _it$2 = _M0MPB3Map5iter2GsRPC15debug4ReprE(self.state.aliases);
        while (true) {
          let key;
          let binding;
          _L$4: {
            const _bind$2 = _M0MPB5Iter24nextGsRPC15debug4ReprE(_it$2);
            if (_bind$2 === undefined) {
              break;
            } else {
              const _Some = _bind$2;
              const _x = _Some;
              const _key = _x._0;
              const _binding = _x._1;
              key = _key;
              binding = _binding;
              break _L$4;
            }
          }
          const _bind$2 = binding.cell.value;
          if (_bind$2 === undefined) {
          } else {
            if (_M0FP211localreview3tcl17namespace__parent(key) === prefix) {
              if (!_M0MPC15array5Array8containsGsE(values, _M0FP211localreview3tcl15namespace__tail(key))) {
                _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values, _M0FP211localreview3tcl15namespace__tail(key));
              }
            }
          }
          continue;
        }
      }
      _M0MPC15array5Array4sortGsE(values);
      let _tmp;
      if (n === 3) {
        const _bind$2 = _M0MPC15array5Array6filterGsEHRP211localreview3tcl8TclError(values, (key) => _M0FP211localreview3tcl11glob__match(_M0MPC15array5Array2atGRPB4JsonE(args, 2), key, false));
        if (_bind$2.$tag === 1) {
          const _ok = _bind$2;
          _tmp = _ok._0;
        } else {
          return _bind$2;
        }
      } else {
        _tmp = values;
      }
      return _M0FP211localreview3tcl12format__list(_tmp);
    }
    if (n > 3) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("info commands arity"));
    }
    const _bind$2 = _M0MP211localreview3tcl11Interpreter14command__names(self, n === 3 ? _M0MPC15array5Array2atGRPB4JsonE(args, 2) : "*", _M0MPC15array5Array2atGRPB4JsonE(args, 1) === "procs");
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    return _M0FP211localreview3tcl12format__list(_tmp);
  }
  if (n !== (_M0MPC15array5Array2atGRPB4JsonE(args, 1) === "default" ? 5 : 3)) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("info procedure arity"));
  }
  let definition;
  let command;
  _L$2: {
    const _bind$2 = _M0MP211localreview3tcl11Interpreter13find__command(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2));
    if (_bind$2 === undefined) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unknown procedure"));
    } else {
      const _Some = _bind$2;
      const _command = _Some;
      command = _command;
      break _L$2;
    }
  }
  const _bind$2 = _M0MP211localreview3tcl7Command6origin(command).body;
  if (_bind$2.$tag === 1) {
    const _Script = _bind$2;
    const _p = _Script._0;
    definition = _p;
  } else {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("not a procedure"));
  }
  if (_M0MPC15array5Array2atGRPB4JsonE(args, 1) === "body") {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(definition.body);
  } else {
    if (_M0MPC15array5Array2atGRPB4JsonE(args, 1) === "args") {
      return _M0FP211localreview3tcl12format__list(_M0MPC15array5Array3mapGUsOsEsE(definition.parameters, (p) => p._0));
    } else {
      const _bind$3 = definition.parameters;
      const _bind$4 = _bind$3.length;
      let _tmp = 0;
      while (true) {
        const _ = _tmp;
        if (_ < _bind$4) {
          const _foreach_element = _bind$3[_];
          let name;
          let value;
          _L$3: {
            const _name = _foreach_element._0;
            const _value = _foreach_element._1;
            name = _name;
            value = _value;
            break _L$3;
          }
          if (name === _M0MPC15array5Array2atGRPB4JsonE(args, 3)) {
            const _bind$5 = _M0MP211localreview3tcl11Interpreter8set__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 4), _M0MPC16option6Option10unwrap__orGsE(value, ""));
            if (_bind$5.$tag === 1) {
              const _ok = _bind$5;
              _ok._0;
            } else {
              return _bind$5;
            }
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(!(value === undefined)));
          }
          _tmp = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unknown argument"));
    }
  }
}
function _M0MP211localreview3tcl11Interpreter18exported__commands(self, space) {
  const patterns = _M0MPC16option6Option10unwrap__orGRPB5ArrayGsEE(_M0MPB3Map3getGsRPB5ArrayGsEE(self.state.exports, space), []);
  const result = [];
  const _it = _M0MPB3Map6valuesGsRP211localreview3tcl7CommandE(self.state.commands);
  while (true) {
    let command;
    _L: {
      const _bind$2 = _M0MPB4Iter4nextGUsRPB4JsonEE(_it);
      if (_bind$2 === undefined) {
        break;
      } else {
        const _Some = _bind$2;
        const _command = _Some;
        command = _command;
        break _L;
      }
    }
    if (_M0FP211localreview3tcl15command__parent(command.name) === space) {
      const _bind$2 = patterns.length;
      let _tmp = 0;
      while (true) {
        const _ = _tmp;
        if (_ < _bind$2) {
          const pattern = patterns[_];
          const _bind$3 = _M0FP211localreview3tcl11glob__match(pattern, _M0FP211localreview3tcl15namespace__tail(command.name), false);
          let _tmp$2;
          if (_bind$3.$tag === 1) {
            const _ok = _bind$3;
            _tmp$2 = _ok._0;
          } else {
            return _bind$3;
          }
          if (_tmp$2) {
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(result, command);
            break;
          }
          _tmp = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    }
    continue;
  }
  return new _M0DTPC16result6ResultGRPB5ArrayGRP211localreview3tcl7CommandERP211localreview3tcl8TclErrorE2Ok(result);
}
function _M0MP211localreview3tcl11Interpreter16ensemble__prefix(self, ensemble, name) {
  let candidates;
  if (!_M0MPC15array5Array9is__emptyGRPB4JsonE(ensemble.subcommands)) {
    candidates = ensemble.subcommands;
  } else {
    if (!_M0MPC15array5Array9is__emptyGRPB4JsonE(ensemble.mapping)) {
      candidates = _M0MPC15array5Array3mapGUsRPB5ArrayGsEEsE(ensemble.mapping, (pair) => pair._0);
    } else {
      const _bind$2 = _M0MP211localreview3tcl11Interpreter18exported__commands(self, ensemble.namespace_name);
      let _tmp;
      if (_bind$2.$tag === 1) {
        const _ok = _bind$2;
        _tmp = _ok._0;
      } else {
        return _bind$2;
      }
      candidates = _M0MPC15array5Array3mapGRP211localreview3tcl7CommandsE(_tmp, (c) => _M0FP211localreview3tcl15namespace__tail(c.name));
    }
  }
  const selected = new _M0TPB8MutLocalGOsE(undefined);
  if (_M0MPC15array5Array8containsGsE(candidates, name)) {
    selected.val = name;
  } else {
    if (ensemble.prefixes) {
      const _bind$2 = candidates.length;
      let _tmp = 0;
      while (true) {
        const _ = _tmp;
        if (_ < _bind$2) {
          const candidate = candidates[_];
          if (_M0MPC16string6String11has__prefix(candidate, new _M0TPC16string10StringView(name, 0, name.length))) {
            let old;
            _L: {
              _L$2: {
                const _bind$3 = selected.val;
                if (_bind$3 === undefined) {
                  selected.val = candidate;
                } else {
                  const _Some = _bind$3;
                  const _old = _Some;
                  old = _old;
                  break _L$2;
                }
                break _L;
              }
              if (_M0IP016_24default__implPB2Eq10not__equalGsE(old, candidate)) {
                return new _M0DTPC16result6ResultGORPB5ArrayGsERP211localreview3tcl8TclErrorE2Ok(_M0DTPC16option6OptionGRPB5ArrayGsEE4None__);
              }
            }
          }
          _tmp = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    }
  }
  let key;
  _L: {
    const _bind$2 = selected.val;
    if (_bind$2 === undefined) {
      return new _M0DTPC16result6ResultGORPB5ArrayGsERP211localreview3tcl8TclErrorE2Ok(_M0DTPC16option6OptionGRPB5ArrayGsEE4None__);
    } else {
      const _Some = _bind$2;
      const _key = _Some;
      key = _key;
      break _L;
    }
  }
  const _bind$2 = ensemble.mapping;
  const _bind$3 = _bind$2.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$3) {
      const _foreach_element = _bind$2[_];
      let mapped;
      let words;
      _L$2: {
        const _mapped = _foreach_element._0;
        const _words = _foreach_element._1;
        mapped = _mapped;
        words = _words;
        break _L$2;
      }
      if (mapped === key) {
        return new _M0DTPC16result6ResultGORPB5ArrayGsERP211localreview3tcl8TclErrorE2Ok(new _M0DTPC16option6OptionGRPB5ArrayGsEE4Some(words));
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGORPB5ArrayGsERP211localreview3tcl8TclErrorE2Ok(new _M0DTPC16option6OptionGRPB5ArrayGsEE4Some([_M0FP211localreview3tcl13command__name(ensemble.namespace_name, key)]));
}
function _M0MP211localreview3tcl10ListObject6append(self, items) {
  if (_M0MPC15array5Array9is__emptyGRPB4JsonE(items)) {
    return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
  }
  if ((self.values.length + items.length | 0) > 100000) {
    return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("list element limit"));
  }
  const encoded = [];
  const units = new _M0TPB8MutLocalGiE(self.units);
  const _bind$2 = 0;
  const _bind$3 = items.length;
  let _tmp = _bind$2;
  while (true) {
    const i = _tmp;
    if (i < _bind$3) {
      const text = _M0FP211localreview3tcl14quote__element(_M0MPC15array5Array2atGRPB4JsonE(items, i), _M0MPC15array5Array9is__emptyGRPB4JsonE(self.values) && i === 0);
      units.val = units.val + (text.length + (_M0MPC15array5Array9is__emptyGRPB4JsonE(self.values) && i === 0 ? 0 : 1) | 0) | 0;
      if (units.val > 1000000) {
        return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("list size limit"));
      }
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(encoded, text);
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$4 = items.length;
  let _tmp$2 = 0;
  while (true) {
    const _ = _tmp$2;
    if (_ < _bind$4) {
      const item = items[_];
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(self.values, item);
      _tmp$2 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$5 = encoded.length;
  let _tmp$3 = 0;
  while (true) {
    const _ = _tmp$3;
    if (_ < _bind$5) {
      const text = encoded[_];
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(self.encoded, text);
      _tmp$3 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  self.units = units.val;
  self.representation = undefined;
  return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
}
function _M0MP211localreview3tcl10ListObject10from__text(text) {
  const object = new _M0TP211localreview3tcl10ListObject([], [], 0, text);
  const _bind$2 = _M0FP211localreview3tcl11parse__list(text);
  let _tmp;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    _tmp = _ok._0;
  } else {
    return _bind$2;
  }
  const _bind$3 = _M0MP211localreview3tcl10ListObject6append(object, _tmp);
  if (_bind$3.$tag === 1) {
    const _ok = _bind$3;
    _ok._0;
  } else {
    return _bind$3;
  }
  object.representation = text;
  return new _M0DTPC16result6ResultGRP211localreview3tcl10ListObjectRP211localreview3tcl8TclErrorE2Ok(object);
}
function _M0MP211localreview3tcl11Interpreter12append__list(self, name, items, discard_result) {
  const _bind$2 = _M0MP211localreview3tcl11Interpreter7binding(self, name, true);
  let _tmp;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    _tmp = _ok._0;
  } else {
    return _bind$2;
  }
  const binding = _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_tmp);
  const _bind$3 = binding.index;
  if (_bind$3 === undefined) {
  } else {
    const _bind$4 = _M0MP211localreview3tcl7Binding4read(binding);
    let _tmp$2;
    if (_bind$4.$tag === 1) {
      const _ok = _bind$4;
      _tmp$2 = _ok._0;
    } else {
      return _bind$4;
    }
    const _bind$5 = _M0FP211localreview3tcl11parse__list(_M0MPC16option6Option10unwrap__orGsE(_tmp$2, ""));
    let _tmp$3;
    if (_bind$5.$tag === 1) {
      const _ok = _bind$5;
      _tmp$3 = _ok._0;
    } else {
      return _bind$5;
    }
    const values = _M0IPC15array5ArrayPB3Add3addGsE(_tmp$3, items);
    const _bind$6 = _M0FP211localreview3tcl12format__list(values);
    let result;
    if (_bind$6.$tag === 1) {
      const _ok = _bind$6;
      result = _ok._0;
    } else {
      return _bind$6;
    }
    const _bind$7 = _M0MP211localreview3tcl11Interpreter8set__var(self, name, result);
    if (_bind$7.$tag === 1) {
      const _ok = _bind$7;
      _ok._0;
    } else {
      return _bind$7;
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(discard_result ? "" : result);
  }
  let object;
  _L: {
    _L$2: {
      const _bind$4 = binding.cell.value;
      if (_bind$4 === undefined) {
        break _L$2;
      } else {
        const _Some = _bind$4;
        const _x = _Some;
        switch (_x.$tag) {
          case 1: {
            const _Sequence = _x;
            const _object = _Sequence._0;
            object = _object;
            break;
          }
          case 3: {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("variable is array"));
          }
          default: {
            break _L$2;
          }
        }
      }
      break _L;
    }
    const _bind$4 = _M0MP211localreview3tcl7Binding4read(binding);
    let _tmp$2;
    if (_bind$4.$tag === 1) {
      const _ok = _bind$4;
      _tmp$2 = _ok._0;
    } else {
      return _bind$4;
    }
    const _bind$5 = _M0MP211localreview3tcl10ListObject10from__text(_M0MPC16option6Option10unwrap__orGsE(_tmp$2, ""));
    if (_bind$5.$tag === 1) {
      const _ok = _bind$5;
      object = _ok._0;
    } else {
      return _bind$5;
    }
  }
  const _bind$4 = _M0MP211localreview3tcl10ListObject6append(object, items);
  if (_bind$4.$tag === 1) {
    const _ok = _bind$4;
    _ok._0;
  } else {
    return _bind$4;
  }
  binding.cell.value = new _M0DTP211localreview3tcl13VariableValue8Sequence(object);
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(discard_result ? "" : _M0MP211localreview3tcl10ListObject4text(object));
}
function _M0MP211localreview3tcl11Interpreter21list__command_2einner(self, args, discard_result) {
  const n = args.length;
  const _bind$2 = _M0MPC15array5Array2atGRPB4JsonE(args, 0);
  switch (_bind$2) {
    case "list": {
      return _M0FP211localreview3tcl12format__list(_M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 1, undefined)));
    }
    case "llength": {
      if (n !== 2) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("llength arity"));
      }
      const _bind$3 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, 1));
      let _tmp;
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        _tmp = _ok._0;
      } else {
        return _bind$3;
      }
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC13int3Int18to__string_2einner(_tmp.length, 10));
    }
    case "lindex": {
      if (n < 2) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("lindex arity"));
      }
      let indices;
      if (n === 3) {
        const _bind$4 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, 2));
        if (_bind$4.$tag === 1) {
          const _ok = _bind$4;
          indices = _ok._0;
        } else {
          return _bind$4;
        }
      } else {
        indices = _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 2, undefined));
      }
      const value = new _M0TPB8MutLocalGsE(_M0MPC15array5Array2atGRPB4JsonE(args, 1));
      const _bind$4 = indices.length;
      let _tmp$2 = 0;
      while (true) {
        const _ = _tmp$2;
        if (_ < _bind$4) {
          const index = indices[_];
          const _bind$5 = _M0FP211localreview3tcl11parse__list(value.val);
          let values;
          if (_bind$5.$tag === 1) {
            const _ok = _bind$5;
            values = _ok._0;
          } else {
            return _bind$5;
          }
          const _bind$6 = _M0FP211localreview3tcl11list__index(index, values.length);
          let i;
          if (_bind$6.$tag === 1) {
            const _ok = _bind$6;
            i = _ok._0;
          } else {
            return _bind$6;
          }
          value.val = i >= 0 && i < values.length ? _M0MPC15array5Array2atGRPB4JsonE(values, i) : "";
          _tmp$2 = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(value.val);
    }
    case "lappend": {
      if (n < 2) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("lappend arity"));
      }
      if (n === 2) {
        const _bind$5 = _M0MP211localreview3tcl11Interpreter8get__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 1));
        let _tmp$3;
        if (_bind$5.$tag === 1) {
          const _ok = _bind$5;
          _tmp$3 = _ok._0;
        } else {
          return _bind$5;
        }
        const value$2 = _M0MPC16option6Option10unwrap__orGsE(_tmp$3, "");
        const _bind$6 = _M0FP211localreview3tcl11parse__list(value$2);
        if (_bind$6.$tag === 1) {
          const _ok = _bind$6;
          _ok._0;
        } else {
          return _bind$6;
        }
        const _bind$7 = _M0MP211localreview3tcl11Interpreter8set__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 1), value$2);
        if (_bind$7.$tag === 1) {
          const _ok = _bind$7;
          _ok._0;
        } else {
          return _bind$7;
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(value$2);
      }
      return _M0MP211localreview3tcl11Interpreter12append__list(self, _M0MPC15array5Array2atGRPB4JsonE(args, 1), _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 2, undefined)), discard_result);
    }
    case "join": {
      if (n !== 2 && n !== 3) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("join arity"));
      }
      const _bind$5 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, 1));
      let values;
      if (_bind$5.$tag === 1) {
        const _ok = _bind$5;
        values = _ok._0;
      } else {
        return _bind$5;
      }
      const sep = n === 3 ? _M0MPC15array5Array2atGRPB4JsonE(args, 2) : " ";
      const size = new _M0TPB8MutLocalGiE(0);
      const _bind$6 = values.length;
      let _tmp$3 = 0;
      while (true) {
        const _ = _tmp$3;
        if (_ < _bind$6) {
          const value$2 = values[_];
          size.val = size.val + value$2.length | 0;
          if (size.val > 1000000) {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("join size limit"));
          }
          _tmp$3 = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      let _tmp$4;
      if (values.length > 1) {
        const _tmp$5 = sep.length;
        const _tmp$6 = values.length - 1 | 0;
        if (_tmp$6 === 0) {
          $panic();
        }
        _tmp$4 = _tmp$5 > ((1000000 - size.val | 0) / _tmp$6 | 0);
      } else {
        _tmp$4 = false;
      }
      if (_tmp$4) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("join size limit"));
      }
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC15array5Array4joinGsE(values, new _M0TPC16string10StringView(sep, 0, sep.length)));
    }
    case "split": {
      if (n !== 2 && n !== 3) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("split arity"));
      }
      const separators = _M0MPC16string6String9to__array(n === 3 ? _M0MPC15array5Array2atGRPB4JsonE(args, 2) : " \n\t\r");
      const chars = _M0MPC16string6String9to__array(_M0MPC15array5Array2atGRPB4JsonE(args, 1));
      const values$2 = [];
      if (_M0MPC15array5Array9is__emptyGcE(separators)) {
        const _bind$7 = chars.length;
        let _tmp$5 = 0;
        while (true) {
          const _ = _tmp$5;
          if (_ < _bind$7) {
            const c = chars[_];
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values$2, _M0IPC14char4CharPB4Show10to__string(c));
            _tmp$5 = _ + 1 | 0;
            continue;
          } else {
            break;
          }
        }
      } else {
        if (!_M0MPC15array5Array9is__emptyGcE(chars)) {
          const word = new _M0TPB8MutLocalGsE("");
          const _bind$7 = chars.length;
          let _tmp$5 = 0;
          while (true) {
            const _ = _tmp$5;
            if (_ < _bind$7) {
              const c = chars[_];
              if (_M0MPC15array5Array8containsGcE(separators, c)) {
                _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values$2, word.val);
                word.val = "";
              } else {
                word.val = `${word.val}${_M0IPC14char4CharPB4Show10to__string(c)}`;
              }
              _tmp$5 = _ + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values$2, word.val);
        }
      }
      return _M0FP211localreview3tcl12format__list(values$2);
    }
    case "concat": {
      const values$3 = [];
      const size$2 = new _M0TPB8MutLocalGiE(0);
      const _bind$7 = _M0MPC15array5Array12view_2einnerGsE(args, 1, undefined);
      const _bind$8 = _bind$7.end - _bind$7.start | 0;
      let _tmp$5 = 0;
      while (true) {
        const _ = _tmp$5;
        if (_ < _bind$8) {
          const part = _bind$7.buf[_bind$7.start + _ | 0];
          const chars$2 = _M0MPC16string6String9to__array(part);
          const first = new _M0TPB8MutLocalGiE(0);
          const last = new _M0TPB8MutLocalGiE(chars$2.length);
          while (true) {
            if (first.val < last.val && _M0FP211localreview3tcl11list__space(_M0MPC15array5Array2atGcE(chars$2, first.val))) {
              first.val = first.val + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          while (true) {
            if (last.val > first.val && _M0FP211localreview3tcl11list__space(_M0MPC15array5Array2atGcE(chars$2, last.val - 1 | 0))) {
              last.val = last.val - 1 | 0;
              continue;
            } else {
              break;
            }
          }
          if (first.val < last.val) {
            const value$2 = _M0MPC16string6String11from__array(_M0MPC15array5Array12view_2einnerGcE(chars$2, first.val, last.val));
            size$2.val = size$2.val + (value$2.length + 1 | 0) | 0;
            if (size$2.val > 1000000) {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("concat size limit"));
            }
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values$3, value$2);
          }
          _tmp$5 = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      const _bind$9 = " ";
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC15array5Array4joinGsE(values$3, new _M0TPC16string10StringView(_bind$9, 0, _bind$9.length)));
    }
    case "lrange": {
      if (n !== 4) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("lrange arity"));
      }
      const _bind$10 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, 1));
      let values$4;
      if (_bind$10.$tag === 1) {
        const _ok = _bind$10;
        values$4 = _ok._0;
      } else {
        return _bind$10;
      }
      const _bind$11 = _M0FP211localreview3tcl11list__index(_M0MPC15array5Array2atGRPB4JsonE(args, 2), values$4.length);
      let _tmp$6;
      if (_bind$11.$tag === 1) {
        const _ok = _bind$11;
        _tmp$6 = _ok._0;
      } else {
        return _bind$11;
      }
      const first = _M0MPC13int3Int3max(_tmp$6, 0);
      const _bind$12 = _M0FP211localreview3tcl11list__index(_M0MPC15array5Array2atGRPB4JsonE(args, 3), values$4.length);
      let _tmp$7;
      if (_bind$12.$tag === 1) {
        const _ok = _bind$12;
        _tmp$7 = _ok._0;
      } else {
        return _bind$12;
      }
      const last = _M0MPC13int3Int3min(_tmp$7, values$4.length - 1 | 0);
      return first > last ? new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("") : _M0FP211localreview3tcl12format__list(_M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(values$4, first, last + 1 | 0)));
    }
    case "lreverse": {
      if (n !== 2) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("lreverse arity"));
      }
      const _bind$13 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, 1));
      let values$5;
      if (_bind$13.$tag === 1) {
        const _ok = _bind$13;
        values$5 = _ok._0;
      } else {
        return _bind$13;
      }
      _M0MPC15array5Array14rev__in__placeGsE(values$5);
      return _M0FP211localreview3tcl12format__list(values$5);
    }
    case "lrepeat": {
      if (n < 3) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("lrepeat arity"));
      }
      const _bind$14 = _M0FP211localreview3tcl7integer(_M0MPC15array5Array2atGRPB4JsonE(args, 1));
      let count;
      if (_bind$14.$tag === 1) {
        const _ok = _bind$14;
        count = _ok._0;
      } else {
        return _bind$14;
      }
      let _tmp$8;
      if (count < 0) {
        _tmp$8 = true;
      } else {
        const _tmp$9 = n - 2 | 0;
        if (_tmp$9 === 0) {
          $panic();
        }
        _tmp$8 = count > (100000 / _tmp$9 | 0);
      }
      if (_tmp$8) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("lrepeat count limit"));
      }
      const values$6 = [];
      const _bind$15 = 0;
      let _tmp$9 = _bind$15;
      while (true) {
        const _ = _tmp$9;
        if (_ < count) {
          const _bind$16 = _M0MPC15array5Array12view_2einnerGsE(args, 2, undefined);
          const _bind$17 = _bind$16.end - _bind$16.start | 0;
          let _tmp$10 = 0;
          while (true) {
            const _$2 = _tmp$10;
            if (_$2 < _bind$17) {
              const value$2 = _bind$16.buf[_bind$16.start + _$2 | 0];
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(values$6, value$2);
              _tmp$10 = _$2 + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          _tmp$9 = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      return _M0FP211localreview3tcl12format__list(values$6);
    }
    default: {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("list command not implemented"));
    }
  }
}
function _M0MP211localreview3tcl11Interpreter15rename__command(self, old, new_) {
  let command;
  const _bind$2 = _M0MP211localreview3tcl11Interpreter13find__command(self, old);
  if (_bind$2 === undefined) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unknown command"));
  } else {
    const _Some = _bind$2;
    const _command = _Some;
    command = _command;
  }
  if (_M0MPC16string6String9is__empty(new_)) {
    _M0MP211localreview3tcl11Interpreter15delete__command(self, command);
  } else {
    const target = _M0FP211localreview3tcl13command__name(self.frame.namespace_name, new_);
    if (_M0MPB3Map8containsGsRP211localreview3tcl7CommandE(self.state.commands, target)) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("target command exists"));
    }
    const owner = _M0FP211localreview3tcl15command__parent(target);
    if (!_M0MPB3Map8containsGsbE(self.state.namespaces, owner)) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("target namespace does not exist"));
    }
    _M0MPB3Map6removeGsRP211localreview3tcl7CommandE(self.state.commands, command.name);
    command.name = target;
    let definition;
    _L: {
      _L$2: {
        const _bind$3 = command.body;
        if (_bind$3.$tag === 1) {
          const _Script = _bind$3;
          const _definition = _Script._0;
          definition = _definition;
          break _L$2;
        }
        break _L;
      }
      command.body = new _M0DTP211localreview3tcl11CommandBody6Script(new _M0TP211localreview3tcl9Procedure(definition.parameters, definition.body, owner));
    }
    _M0MPB3Map3setGsRP211localreview3tcl7CommandE(self.state.commands, target, command);
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
}
function _M0FP211localreview3tcl15string__boolean(value) {
  const text = _M0MPC16string6String9to__lower(value);
  if (text === "0") {
    return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE2Ok(false);
  }
  if (text === "1") {
    return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE2Ok(true);
  }
  if (_M0MPC16string6String9is__empty(text) || text === "o") {
    return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expected boolean"));
  }
  const _bind$2 = ["true", "yes", "on"];
  const _bind$3 = _bind$2.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$3) {
      const word = _bind$2[_];
      if (_M0MPC16string6String11has__prefix(word, new _M0TPC16string10StringView(text, 0, text.length))) {
        return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE2Ok(true);
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$4 = ["false", "no", "off"];
  const _bind$5 = _bind$4.length;
  let _tmp$2 = 0;
  while (true) {
    const _ = _tmp$2;
    if (_ < _bind$5) {
      const word = _bind$4[_];
      if (_M0MPC16string6String11has__prefix(word, new _M0TPC16string10StringView(text, 0, text.length))) {
        return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE2Ok(false);
      }
      _tmp$2 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGbRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expected boolean"));
}
function _M0MP211localreview3tcl11Interpreter15string__command(_self, args) {
  const n = args.length;
  if (n < 2) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string arity"));
  }
  const op = _M0MPC15array5Array2atGRPB4JsonE(args, 1);
  _L: {
    _L$2: {
      _L$3: {
        _L$4: {
          _L$5: {
            switch (op) {
              case "length": {
                if (n !== 3) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string length arity"));
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC13int3Int18to__string_2einner(_M0MPC15array5Array2atGRPB4JsonE(args, 2).length, 10));
              }
              case "index": {
                break _L$5;
              }
              case "range": {
                break _L$5;
              }
              case "compare": {
                break _L$4;
              }
              case "equal": {
                break _L$4;
              }
              case "first": {
                break _L$3;
              }
              case "last": {
                break _L$3;
              }
              case "tolower": {
                break _L$2;
              }
              case "toupper": {
                break _L$2;
              }
              case "totitle": {
                break _L$2;
              }
              case "trim": {
                break _L;
              }
              case "trimleft": {
                break _L;
              }
              case "trimright": {
                break _L;
              }
              case "repeat": {
                if (n !== 4) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string repeat arity"));
                }
                const _bind$2 = _M0FP211localreview3tcl7integer(_M0MPC15array5Array2atGRPB4JsonE(args, 3));
                let _tmp;
                if (_bind$2.$tag === 1) {
                  const _ok = _bind$2;
                  _tmp = _ok._0;
                } else {
                  return _bind$2;
                }
                const count = _M0MPC13int3Int3max(_tmp, 0);
                let _tmp$2;
                if (!_M0MPC16string6String9is__empty(_M0MPC15array5Array2atGRPB4JsonE(args, 2))) {
                  const _tmp$3 = _M0MPC15array5Array2atGRPB4JsonE(args, 2).length;
                  if (_tmp$3 === 0) {
                    $panic();
                  }
                  _tmp$2 = count > (1000000 / _tmp$3 | 0);
                } else {
                  _tmp$2 = false;
                }
                if (_tmp$2) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string repeat size"));
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC16string6String6repeat(_M0MPC15array5Array2atGRPB4JsonE(args, 2), count));
              }
              case "reverse": {
                if (n !== 3) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string reverse arity"));
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC16string6String3rev(_M0MPC15array5Array2atGRPB4JsonE(args, 2)));
              }
              case "replace": {
                if (n !== 5 && n !== 6) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string replace arity"));
                }
                const text = _M0MPC15array5Array2atGRPB4JsonE(args, 2);
                const _bind$3 = _M0FP211localreview3tcl11list__index(_M0MPC15array5Array2atGRPB4JsonE(args, 3), text.length);
                let _tmp$3;
                if (_bind$3.$tag === 1) {
                  const _ok = _bind$3;
                  _tmp$3 = _ok._0;
                } else {
                  return _bind$3;
                }
                const first = _M0MPC13int3Int3max(_tmp$3, 0);
                const _bind$4 = _M0FP211localreview3tcl11list__index(_M0MPC15array5Array2atGRPB4JsonE(args, 4), text.length);
                let _tmp$4;
                if (_bind$4.$tag === 1) {
                  const _ok = _bind$4;
                  _tmp$4 = _ok._0;
                } else {
                  return _bind$4;
                }
                const last = _M0MPC13int3Int3min(_tmp$4, text.length - 1 | 0);
                if (first >= text.length || last < first) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(text);
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(`${_M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(text, 0, first))}${n === 6 ? _M0MPC15array5Array2atGRPB4JsonE(args, 5) : ""}${_M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(text, last + 1 | 0, undefined))}`);
              }
              case "match": {
                const nocase = n === 5 && _M0MPC15array5Array2atGRPB4JsonE(args, 2) === "-nocase";
                if (n !== (nocase ? 5 : 4)) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string match arity"));
                }
                const _bind$5 = _M0FP211localreview3tcl11glob__match(_M0MPC15array5Array2atGRPB4JsonE(args, n - 2 | 0), _M0MPC15array5Array2atGRPB4JsonE(args, n - 1 | 0), nocase);
                let _tmp$5;
                if (_bind$5.$tag === 1) {
                  const _ok = _bind$5;
                  _tmp$5 = _ok._0;
                } else {
                  return _bind$5;
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(_tmp$5));
              }
              case "map": {
                const nocase$2 = n === 5 && _M0MPC15array5Array2atGRPB4JsonE(args, 2) === "-nocase";
                if (n !== (nocase$2 ? 5 : 4)) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string map arity"));
                }
                const _bind$6 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, n - 2 | 0));
                let mapping;
                if (_bind$6.$tag === 1) {
                  const _ok = _bind$6;
                  mapping = _ok._0;
                } else {
                  return _bind$6;
                }
                if (2 === 0) {
                  $panic();
                }
                if ((mapping.length % 2 | 0) !== 0) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string map expects pairs"));
                }
                const source = _M0MPC15array5Array2atGRPB4JsonE(args, n - 1 | 0);
                const subject = nocase$2 ? _M0MPC16string6String9to__lower(source) : source;
                const out = _M0MPB13StringBuilder21StringBuilder_2einner(0);
                const i = new _M0TPB8MutLocalGiE(0);
                const size = new _M0TPB8MutLocalGiE(0);
                while (true) {
                  if (i.val < source.length) {
                    const matched = new _M0TPB8MutLocalGbE(false);
                    const j = new _M0TPB8MutLocalGiE(0);
                    while (true) {
                      if (j.val < mapping.length) {
                        const key = nocase$2 ? _M0MPC16string6String9to__lower(_M0MPC15array5Array2atGRPB4JsonE(mapping, j.val)) : _M0MPC15array5Array2atGRPB4JsonE(mapping, j.val);
                        if (!_M0MPC16string6String9is__empty(key) && _M0MPC16string10StringView11has__prefix(_M0MPC16string6String11sub_2einner(subject, i.val, undefined), new _M0TPC16string10StringView(key, 0, key.length))) {
                          size.val = size.val + _M0MPC15array5Array2atGRPB4JsonE(mapping, j.val + 1 | 0).length | 0;
                          if (size.val > 1000000) {
                            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string map size limit"));
                          }
                          _M0IPB13StringBuilderPB6Logger13write__string(out, _M0MPC15array5Array2atGRPB4JsonE(mapping, j.val + 1 | 0));
                          i.val = i.val + key.length | 0;
                          matched.val = true;
                          break;
                        }
                        j.val = j.val + 2 | 0;
                        continue;
                      } else {
                        break;
                      }
                    }
                    if (!matched.val) {
                      _M0IPB13StringBuilderPB6Logger13write__string(out, _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(source, i.val, i.val + 1 | 0)));
                      i.val = i.val + 1 | 0;
                      size.val = size.val + 1 | 0;
                    }
                    continue;
                  } else {
                    break;
                  }
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPB13StringBuilder10to__string(out));
              }
              case "is": {
                if (n < 4) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string is arity"));
                }
                const strict = n === 5 && _M0MPC15array5Array2atGRPB4JsonE(args, 3) === "-strict";
                if (n !== (strict ? 5 : 4)) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string is options"));
                }
                const value = _M0MPC15array5Array2atGRPB4JsonE(args, n - 1 | 0);
                const kind = _M0MPC15array5Array2atGRPB4JsonE(args, 2);
                let valid;
                if (_M0MPC16string6String9is__empty(value)) {
                  valid = !strict || kind === "list";
                } else {
                  switch (kind) {
                    case "integer": {
                      let _try_err;
                      _L$6: {
                        _L$7: {
                          const _bind$7 = _M0FP211localreview3tcl5whole(value);
                          let v;
                          if (_bind$7.$tag === 1) {
                            const _ok = _bind$7;
                            v = _ok._0;
                          } else {
                            const _err = _bind$7;
                            _try_err = _err._0;
                            break _L$7;
                          }
                          valid = _M0IP016_24default__implPB7Compare6op__geGRPC16bigint6BigIntE(v, _M0IPC16bigint6BigIntPB3Neg3neg(2147483648n)) && _M0IP016_24default__implPB7Compare6op__leGRPC16bigint6BigIntE(v, 4294967295n);
                          break _L$6;
                        }
                        valid = false;
                      }
                      break;
                    }
                    case "wideinteger": {
                      let _try_err$2;
                      _L$7: {
                        _L$8: {
                          const _bind$7 = _M0FP211localreview3tcl5whole(value);
                          let v;
                          if (_bind$7.$tag === 1) {
                            const _ok = _bind$7;
                            v = _ok._0;
                          } else {
                            const _err = _bind$7;
                            _try_err$2 = _err._0;
                            break _L$8;
                          }
                          valid = _M0IP016_24default__implPB7Compare6op__geGRPC16bigint6BigIntE(v, _M0IPC16bigint6BigIntPB3Neg3neg(9223372036854775808n)) && _M0IP016_24default__implPB7Compare6op__leGRPC16bigint6BigIntE(v, 18446744073709551615n);
                          break _L$7;
                        }
                        valid = false;
                      }
                      break;
                    }
                    case "entier": {
                      let _try_err$3;
                      _L$8: {
                        _L$9: {
                          const _bind$7 = _M0FP211localreview3tcl5whole(value);
                          if (_bind$7.$tag === 1) {
                            const _ok = _bind$7;
                            _ok._0;
                          } else {
                            const _err = _bind$7;
                            _try_err$3 = _err._0;
                            break _L$9;
                          }
                          valid = true;
                          break _L$8;
                        }
                        valid = false;
                      }
                      break;
                    }
                    case "double": {
                      const _bind$7 = _M0FP211localreview3tcl6number(value);
                      valid = !(_bind$7 === undefined);
                      break;
                    }
                    case "boolean": {
                      let _try_err$4;
                      _L$9: {
                        _L$10: {
                          const _bind$8 = _M0FP211localreview3tcl15string__boolean(value);
                          if (_bind$8.$tag === 1) {
                            const _ok = _bind$8;
                            _ok._0;
                          } else {
                            const _err = _bind$8;
                            _try_err$4 = _err._0;
                            break _L$10;
                          }
                          valid = true;
                          break _L$9;
                        }
                        valid = false;
                      }
                      break;
                    }
                    case "true": {
                      let _try_err$5;
                      _L$10: {
                        _L$11: {
                          const _bind$8 = _M0FP211localreview3tcl15string__boolean(value);
                          if (_bind$8.$tag === 1) {
                            const _ok = _bind$8;
                            valid = _ok._0;
                          } else {
                            const _err = _bind$8;
                            _try_err$5 = _err._0;
                            break _L$11;
                          }
                          break _L$10;
                        }
                        valid = false;
                      }
                      break;
                    }
                    case "false": {
                      let _try_err$6;
                      _L$11: {
                        _L$12: {
                          const _bind$8 = _M0FP211localreview3tcl15string__boolean(value);
                          let _tmp$6;
                          if (_bind$8.$tag === 1) {
                            const _ok = _bind$8;
                            _tmp$6 = _ok._0;
                          } else {
                            const _err = _bind$8;
                            _try_err$6 = _err._0;
                            break _L$12;
                          }
                          valid = !_tmp$6;
                          break _L$11;
                        }
                        valid = false;
                      }
                      break;
                    }
                    case "list": {
                      let _try_err$7;
                      _L$12: {
                        _L$13: {
                          const _bind$8 = _M0FP211localreview3tcl11parse__list(value);
                          if (_bind$8.$tag === 1) {
                            const _ok = _bind$8;
                            _ok._0;
                          } else {
                            const _err = _bind$8;
                            _try_err$7 = _err._0;
                            break _L$13;
                          }
                          valid = true;
                          break _L$12;
                        }
                        valid = false;
                      }
                      break;
                    }
                    case "digit": {
                      valid = _M0MPB4Iter3allGcE(_M0MPC15array5Array4iterGcE(_M0MPC16string6String9to__array(value)), (c) => c >= 48 && c <= 57);
                      break;
                    }
                    case "xdigit": {
                      valid = _M0MPB4Iter3allGcE(_M0MPC15array5Array4iterGcE(_M0MPC16string6String9to__array(value)), (c) => _M0FP211localreview3tcl10hex__digit(c) >= 0);
                      break;
                    }
                    case "space": {
                      valid = _M0MPB4Iter3allGcE(_M0MPC15array5Array4iterGcE(_M0MPC16string6String9to__array(value)), _M0FP211localreview3tcl11list__space);
                      break;
                    }
                    case "ascii": {
                      valid = _M0MPB4Iter3allGcE(_M0MPC15array5Array4iterGcE(_M0MPC16string6String9to__array(value)), (c) => c < 128);
                      break;
                    }
                    case "alpha": {
                      valid = _M0MPB4Iter3allGcE(_M0MPC15array5Array4iterGcE(_M0MPC16string6String9to__array(value)), (c) => c >= 97 && c <= 122 || c >= 65 && c <= 90);
                      break;
                    }
                    case "alnum": {
                      valid = _M0MPB4Iter3allGcE(_M0MPC15array5Array4iterGcE(_M0MPC16string6String9to__array(value)), (c) => c >= 97 && c <= 122 || (c >= 65 && c <= 90 || c >= 48 && c <= 57));
                      break;
                    }
                    default: {
                      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported string class"));
                    }
                  }
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(valid));
              }
              default: {
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid(`unsupported string subcommand ${op}`));
              }
            }
          }
          if (n !== (op === "index" ? 4 : 5)) {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string index/range arity"));
          }
          const text = _M0MPC15array5Array2atGRPB4JsonE(args, 2);
          const _bind$2 = _M0FP211localreview3tcl11list__index(_M0MPC15array5Array2atGRPB4JsonE(args, 3), text.length);
          let first;
          if (_bind$2.$tag === 1) {
            const _ok = _bind$2;
            first = _ok._0;
          } else {
            return _bind$2;
          }
          let last;
          if (op === "index") {
            last = first;
          } else {
            const _bind$3 = _M0FP211localreview3tcl11list__index(_M0MPC15array5Array2atGRPB4JsonE(args, 4), text.length);
            if (_bind$3.$tag === 1) {
              const _ok = _bind$3;
              last = _ok._0;
            } else {
              return _bind$3;
            }
          }
          return op === "index" && first < 0 || (first >= text.length || (last < first || last < 0)) ? new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("") : new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(text, _M0MPC13int3Int3max(first, 0), _M0MPC13int3Int3min(last + 1 | 0, text.length))));
        }
        const i = new _M0TPB8MutLocalGiE(2);
        const nocase = new _M0TPB8MutLocalGbE(false);
        const limit = new _M0TPB8MutLocalGOiE(undefined);
        while (true) {
          if (i.val < (n - 2 | 0)) {
            if (_M0MPC15array5Array2atGRPB4JsonE(args, i.val) === "-nocase") {
              nocase.val = true;
              i.val = i.val + 1 | 0;
            } else {
              if (_M0MPC15array5Array2atGRPB4JsonE(args, i.val) === "-length" && (i.val + 1 | 0) < (n - 2 | 0)) {
                const _bind$2 = _M0FP211localreview3tcl7integer(_M0MPC15array5Array2atGRPB4JsonE(args, i.val + 1 | 0));
                let _tmp;
                if (_bind$2.$tag === 1) {
                  const _ok = _bind$2;
                  _tmp = _ok._0;
                } else {
                  return _bind$2;
                }
                limit.val = _tmp;
                i.val = i.val + 2 | 0;
              } else {
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string compare option"));
              }
            }
            continue;
          } else {
            break;
          }
        }
        if (i.val !== (n - 2 | 0)) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string compare arity"));
        }
        const a = nocase.val ? _M0MPC16string6String9to__lower(_M0MPC15array5Array2atGRPB4JsonE(args, i.val)) : _M0MPC15array5Array2atGRPB4JsonE(args, i.val);
        const b = nocase.val ? _M0MPC16string6String9to__lower(_M0MPC15array5Array2atGRPB4JsonE(args, i.val + 1 | 0)) : _M0MPC15array5Array2atGRPB4JsonE(args, i.val + 1 | 0);
        let a$2;
        _L$5: {
          _L$6: {
            let v;
            _L$7: {
              const _bind$2 = limit.val;
              if (_bind$2 === undefined) {
                break _L$6;
              } else {
                const _Some = _bind$2;
                const _v = _Some;
                if (_v >= 0) {
                  v = _v;
                  break _L$7;
                } else {
                  break _L$6;
                }
              }
            }
            a$2 = _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(a, 0, _M0MPC13int3Int3min(v, a.length)));
            break _L$5;
          }
          a$2 = a;
        }
        let b$2;
        _L$6: {
          _L$7: {
            let v;
            _L$8: {
              const _bind$2 = limit.val;
              if (_bind$2 === undefined) {
                break _L$7;
              } else {
                const _Some = _bind$2;
                const _v = _Some;
                if (_v >= 0) {
                  v = _v;
                  break _L$8;
                } else {
                  break _L$7;
                }
              }
            }
            b$2 = _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(b, 0, _M0MPC13int3Int3min(v, b.length)));
            break _L$6;
          }
          b$2 = b;
        }
        const cmp = _M0FP211localreview3tcl20tcl__string__compare(a$2, b$2);
        return op === "equal" ? new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(cmp === 0)) : cmp < 0 ? new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("-1") : cmp > 0 ? new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("1") : new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("0");
      }
      if (n !== 4 && n !== 5) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string search arity"));
      }
      const needle = _M0MPC15array5Array2atGRPB4JsonE(args, 2);
      const text = _M0MPC15array5Array2atGRPB4JsonE(args, 3);
      if (_M0MPC16string6String9is__empty(needle)) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("-1");
      }
      if (op === "first") {
        let start;
        if (n === 5) {
          const _bind$2 = _M0FP211localreview3tcl7integer(_M0MPC15array5Array2atGRPB4JsonE(args, 4));
          let _tmp;
          if (_bind$2.$tag === 1) {
            const _ok = _bind$2;
            _tmp = _ok._0;
          } else {
            return _bind$2;
          }
          start = _M0MPC13int3Int3max(_tmp, 0);
        } else {
          start = 0;
        }
        if (start > text.length) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("-1");
        }
        let i;
        _L$4: {
          const _bind$2 = _M0MPC16string6String4find(_M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(text, start, undefined)), new _M0TPC16string10StringView(needle, 0, needle.length));
          if (_bind$2 === undefined) {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("-1");
          } else {
            const _Some = _bind$2;
            const _i = _Some;
            i = _i;
            break _L$4;
          }
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC13int3Int18to__string_2einner(i + start | 0, 10));
      } else {
        let last;
        if (n === 5) {
          const _bind$2 = _M0FP211localreview3tcl11list__index(_M0MPC15array5Array2atGRPB4JsonE(args, 4), text.length);
          let _tmp;
          if (_bind$2.$tag === 1) {
            const _ok = _bind$2;
            _tmp = _ok._0;
          } else {
            return _bind$2;
          }
          last = _M0MPC13int3Int3min(_tmp, text.length - 1 | 0);
        } else {
          last = text.length - 1 | 0;
        }
        if (last < 0) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("-1");
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC13int3Int18to__string_2einner(_M0MPC16option6Option10unwrap__orGiE(_M0MPC16string6String9rev__find(_M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(text, 0, last + 1 | 0)), new _M0TPC16string10StringView(needle, 0, needle.length)), -1), 10));
      }
    }
    if (n < 3 || n > 5) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string case arity"));
    }
    const text = _M0MPC15array5Array2atGRPB4JsonE(args, 2);
    let first;
    if (n >= 4) {
      const _bind$2 = _M0FP211localreview3tcl11list__index(_M0MPC15array5Array2atGRPB4JsonE(args, 3), text.length);
      let _tmp;
      if (_bind$2.$tag === 1) {
        const _ok = _bind$2;
        _tmp = _ok._0;
      } else {
        return _bind$2;
      }
      first = _M0MPC13int3Int3min(_M0MPC13int3Int3max(_tmp, 0), text.length);
    } else {
      first = 0;
    }
    let last;
    if (n === 5) {
      const _bind$2 = _M0FP211localreview3tcl11list__index(_M0MPC15array5Array2atGRPB4JsonE(args, 4), text.length);
      let _tmp;
      if (_bind$2.$tag === 1) {
        const _ok = _bind$2;
        _tmp = _ok._0;
      } else {
        return _bind$2;
      }
      last = _M0MPC13int3Int3min(_tmp, text.length - 1 | 0);
    } else {
      last = n === 4 ? first : text.length - 1 | 0;
    }
    if (last < first) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(text);
    }
    const part = _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(text, first, last + 1 | 0));
    let converted;
    if (op === "tolower") {
      converted = _M0MPC16string6String9to__lower(part);
    } else {
      if (op === "toupper") {
        converted = _M0MPC16string6String9to__upper(part);
      } else {
        const cs = _M0MPC16string6String9to__array(part);
        converted = _M0MPC15array5Array9is__emptyGcE(cs) ? "" : `${_M0MPC16string6String9to__upper(_M0IPC14char4CharPB4Show10to__string(_M0MPC15array5Array2atGcE(cs, 0)))}${_M0MPC16string6String9to__lower(_M0MPC16string6String11from__array(_M0MPC15array5Array12view_2einnerGcE(cs, 1, undefined)))}`;
      }
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(`${_M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(text, 0, first))}${converted}${_M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(text, last + 1 | 0, undefined))}`);
  }
  if (n !== 3 && n !== 4) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("string trim arity"));
  }
  const text = _M0MPC16string6String9to__array(_M0MPC15array5Array2atGRPB4JsonE(args, 2));
  const chars = n === 4 ? _M0MPC16string6String9to__array(_M0MPC15array5Array2atGRPB4JsonE(args, 3)) : _M0MPC16string6String9to__array(" \t\r\n\u000b\f ");
  const first = new _M0TPB8MutLocalGiE(0);
  const last = new _M0TPB8MutLocalGiE(text.length);
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(op, "trimright")) {
    while (true) {
      if (first.val < last.val && _M0MPC15array5Array8containsGcE(chars, _M0MPC15array5Array2atGcE(text, first.val))) {
        first.val = first.val + 1 | 0;
        continue;
      } else {
        break;
      }
    }
  }
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(op, "trimleft")) {
    while (true) {
      if (last.val > first.val && _M0MPC15array5Array8containsGcE(chars, _M0MPC15array5Array2atGcE(text, last.val - 1 | 0))) {
        last.val = last.val - 1 | 0;
        continue;
      } else {
        break;
      }
    }
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC16string6String11from__array(_M0MPC15array5Array12view_2einnerGcE(text, first.val, last.val)));
}
function _M0MP211localreview3tcl11Interpreter16command__pattern(self, pattern) {
  const full = _M0FP211localreview3tcl13command__name(self.frame.namespace_name, pattern);
  const space = _M0FP211localreview3tcl15command__parent(full);
  if (!_M0MPB3Map8containsGsbE(self.state.namespaces, space)) {
    return new _M0DTPC16result6ResultGUssERP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unknown namespace in command pattern"));
  }
  return new _M0DTPC16result6ResultGUssERP211localreview3tcl8TclErrorE2Ok({ _0: space, _1: _M0FP211localreview3tcl15namespace__tail(full) });
}
function _M0MP211localreview3tcl11Interpreter17namespace__forget(self, args) {
  const _bind$2 = _M0MPC15array5Array12view_2einnerGsE(args, 2, undefined);
  const _bind$3 = _bind$2.end - _bind$2.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$3) {
      const pattern = _bind$2.buf[_bind$2.start + _ | 0];
      const _bind$4 = "::";
      const qualified = _M0MPC16string6String8contains(pattern, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
      let space;
      let tail;
      _L: {
        let _bind$5;
        if (qualified) {
          const _bind$6 = _M0MP211localreview3tcl11Interpreter16command__pattern(self, pattern);
          if (_bind$6.$tag === 1) {
            const _ok = _bind$6;
            _bind$5 = _ok._0;
          } else {
            return _bind$6;
          }
        } else {
          _bind$5 = { _0: "", _1: pattern };
        }
        const _space = _bind$5._0;
        const _tail = _bind$5._1;
        space = _space;
        tail = _tail;
        break _L;
      }
      const _bind$5 = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB3Map6valuesGsRP211localreview3tcl7CommandE(self.state.commands));
      const _bind$6 = _bind$5.length;
      let _tmp$2 = 0;
      while (true) {
        const _$2 = _tmp$2;
        if (_$2 < _bind$6) {
          const command = _bind$5[_$2];
          _L$2: {
            if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0FP211localreview3tcl15command__parent(command.name), self.frame.namespace_name)) {
              break _L$2;
            }
            let parent;
            _L$3: {
              _L$4: {
                const _bind$7 = command.body;
                if (_bind$7.$tag === 2) {
                  const _Imported = _bind$7;
                  const _parent = _Imported._0;
                  parent = _parent;
                  break _L$4;
                }
                break _L$3;
              }
              let _tmp$3;
              if (!qualified) {
                const _bind$7 = _M0FP211localreview3tcl11glob__match(tail, _M0FP211localreview3tcl15namespace__tail(command.name), false);
                let _tmp$4;
                if (_bind$7.$tag === 1) {
                  const _ok = _bind$7;
                  _tmp$4 = _ok._0;
                } else {
                  return _bind$7;
                }
                _tmp$3 = _tmp$4;
              } else {
                _tmp$3 = false;
              }
              const matched = new _M0TPB8MutLocalGbE(_tmp$3);
              const cursor = new _M0TPB8MutLocalGRP211localreview3tcl7CommandE(parent);
              while (true) {
                if (qualified) {
                  let _tmp$4;
                  if (_M0FP211localreview3tcl15command__parent(cursor.val.name) === space) {
                    const _bind$7 = _M0FP211localreview3tcl11glob__match(tail, _M0FP211localreview3tcl15namespace__tail(cursor.val.name), false);
                    let _tmp$5;
                    if (_bind$7.$tag === 1) {
                      const _ok = _bind$7;
                      _tmp$5 = _ok._0;
                    } else {
                      return _bind$7;
                    }
                    _tmp$4 = _tmp$5;
                  } else {
                    _tmp$4 = false;
                  }
                  if (_tmp$4) {
                    matched.val = true;
                    break;
                  }
                  let next;
                  _L$5: {
                    const _bind$7 = cursor.val.body;
                    if (_bind$7.$tag === 2) {
                      const _Imported = _bind$7;
                      const _next = _Imported._0;
                      next = _next;
                      break _L$5;
                    } else {
                      break;
                    }
                  }
                  cursor.val = next;
                  continue;
                } else {
                  break;
                }
              }
              if (matched.val) {
                _M0MP211localreview3tcl11Interpreter15delete__command(self, command);
              }
            }
            break _L$2;
          }
          _tmp$2 = _$2 + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
}
function _M0MP211localreview3tcl11Interpreter17namespace__target(self, name) {
  if (_M0MPC16string6String9is__empty(name) && _M0IP016_24default__implPB2Eq10not__equalGsE(self.frame.namespace_name, "::")) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("empty namespace name"));
  }
  const target = _M0FP211localreview3tcl15qualified__name(self.frame.namespace_name, name);
  if (!_M0MPB3Map8containsGsbE(self.state.namespaces, target)) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unknown namespace"));
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(target);
}
function _M0MP211localreview3tcl11Interpreter18namespace__command(self, args, depth) {
  if (args.length < 2) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace arity"));
  }
  const args$2 = _M0MPC15array5Array4copyGUssEE(args);
  const _bind$2 = _M0FP211localreview3tcl15select__keyword(_M0MPC15array5Array2atGRPB4JsonE(args$2, 1), ["children", "code", "current", "delete", "ensemble", "eval", "exists", "export", "forget", "import", "inscope", "origin", "parent", "path", "qualifiers", "tail", "unknown", "upvar", "which"]);
  let _tmp;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    _tmp = _ok._0;
  } else {
    return _bind$2;
  }
  _M0MPC15array5Array3setGUssEE(args$2, 1, _tmp);
  const n = args$2.length;
  _L: {
    const _bind$3 = _M0MPC15array5Array2atGRPB4JsonE(args$2, 1);
    switch (_bind$3) {
      case "export": {
        const clear = n > 2 && _M0MPC15array5Array2atGRPB4JsonE(args$2, 2) === "-clear";
        const patterns = clear ? [] : _M0MPC16option6Option10unwrap__orGRPB5ArrayGsEE(_M0MPB3Map3getGsRPB5ArrayGsEE(self.state.exports, self.frame.namespace_name), []);
        _M0MPB3Map3setGsRPB5ArrayGsEE(self.state.exports, self.frame.namespace_name, patterns);
        const start = clear ? 3 : 2;
        if (n === 2) {
          const _bind$4 = _M0FP211localreview3tcl12format__list(patterns);
          let _tmp$2;
          if (_bind$4.$tag === 1) {
            const _ok = _bind$4;
            _tmp$2 = _ok._0;
          } else {
            return _bind$4;
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp$2);
        }
        const _bind$4 = _M0MPC15array5Array12view_2einnerGsE(args$2, start, undefined);
        const _bind$5 = _bind$4.end - _bind$4.start | 0;
        let _tmp$2 = 0;
        while (true) {
          const _ = _tmp$2;
          if (_ < _bind$5) {
            const pattern = _bind$4.buf[_bind$4.start + _ | 0];
            const _bind$6 = "::";
            if (_M0MPC16string6String8contains(pattern, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length))) {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("export pattern must not contain namespace"));
            }
            if (!_M0MPC15array5Array8containsGsE(patterns, pattern)) {
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(patterns, pattern);
            }
            _tmp$2 = _ + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
      }
      case "import": {
        return _M0MP211localreview3tcl11Interpreter17namespace__import(self, args$2, depth);
      }
      case "forget": {
        return _M0MP211localreview3tcl11Interpreter17namespace__forget(self, args$2);
      }
      case "origin": {
        if (n !== 3) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace origin arity"));
        }
        let command;
        _L$2: {
          const _bind$6 = _M0MP211localreview3tcl11Interpreter13find__command(self, _M0MPC15array5Array2atGRPB4JsonE(args$2, 2));
          if (_bind$6 === undefined) {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unknown command"));
          } else {
            const _Some = _bind$6;
            const _command = _Some;
            command = _command;
            break _L$2;
          }
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MP211localreview3tcl7Command6origin(command).name);
      }
      case "path": {
        if (n > 3) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace path arity"));
        }
        if (n === 2) {
          const _bind$6 = _M0FP211localreview3tcl12format__list(_M0MPC16option6Option10unwrap__orGRPB5ArrayGsEE(_M0MPB3Map3getGsRPB5ArrayGsEE(self.state.namespace_paths, self.frame.namespace_name), []));
          let _tmp$3;
          if (_bind$6.$tag === 1) {
            const _ok = _bind$6;
            _tmp$3 = _ok._0;
          } else {
            return _bind$6;
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp$3);
        }
        const path = [];
        const _bind$6 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args$2, 2));
        let _bind$7;
        if (_bind$6.$tag === 1) {
          const _ok = _bind$6;
          _bind$7 = _ok._0;
        } else {
          return _bind$6;
        }
        const _bind$8 = _bind$7.length;
        let _tmp$3 = 0;
        while (true) {
          const _ = _tmp$3;
          if (_ < _bind$8) {
            const name = _bind$7[_];
            const _bind$9 = _M0MP211localreview3tcl11Interpreter17namespace__target(self, name);
            let space;
            if (_bind$9.$tag === 1) {
              const _ok = _bind$9;
              space = _ok._0;
            } else {
              return _bind$9;
            }
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(path, space);
            _tmp$3 = _ + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        _M0MPB3Map3setGsRPB5ArrayGsEE(self.state.namespace_paths, self.frame.namespace_name, path);
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
      }
      case "unknown": {
        if (n > 3) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace unknown arity"));
        }
        if (n === 3) {
          _M0MPB3Map3setGssE(self.state.unknown_handlers, self.frame.namespace_name, _M0MPC15array5Array2atGRPB4JsonE(args$2, 2));
        }
        const handler = _M0MPC16option6Option10unwrap__orGsE(_M0MPB3Map3getGssE(self.state.unknown_handlers, self.frame.namespace_name), "");
        return _M0MPC16string6String9is__empty(handler) && self.frame.namespace_name === "::" ? new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("::unknown") : new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(handler);
      }
      case "upvar": {
        let _tmp$4;
        if (n < 3) {
          _tmp$4 = true;
        } else {
          if (2 === 0) {
            $panic();
          }
          _tmp$4 = (n % 2 | 0) !== 1;
        }
        if (_tmp$4) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace upvar arity"));
        }
        const _bind$9 = _M0MP211localreview3tcl11Interpreter17namespace__target(self, _M0MPC15array5Array2atGRPB4JsonE(args$2, 2));
        let space;
        if (_bind$9.$tag === 1) {
          const _ok = _bind$9;
          space = _ok._0;
        } else {
          return _bind$9;
        }
        let _tmp$5 = 3;
        while (true) {
          const i = _tmp$5;
          if (i < n) {
            const _bind$10 = _M0MP211localreview3tcl11Interpreter7binding(self, _M0FP211localreview3tcl13command__name(space, _M0MPC15array5Array2atGRPB4JsonE(args$2, i)), true);
            let _tmp$6;
            if (_bind$10.$tag === 1) {
              const _ok = _bind$10;
              _tmp$6 = _ok._0;
            } else {
              return _bind$10;
            }
            const binding = _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_tmp$6);
            const _bind$11 = _M0MP211localreview3tcl11Interpreter14link__variable(self, _M0MPC15array5Array2atGRPB4JsonE(args$2, i + 1 | 0), binding);
            if (_bind$11.$tag === 1) {
              const _ok = _bind$11;
              _ok._0;
            } else {
              return _bind$11;
            }
            _tmp$5 = i + 2 | 0;
            continue;
          } else {
            break;
          }
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
      }
      case "ensemble": {
        return _M0MP211localreview3tcl11Interpreter17ensemble__command(self, args$2);
      }
      case "current": {
        if (n !== 2) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace current arity"));
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(self.frame.namespace_name);
      }
      case "eval": {
        break _L;
      }
      case "inscope": {
        break _L;
      }
      case "exists": {
        if (n !== 3) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace exists arity"));
        }
        if (_M0MPC16string6String9is__empty(_M0MPC15array5Array2atGRPB4JsonE(args$2, 2)) && _M0IP016_24default__implPB2Eq10not__equalGsE(self.frame.namespace_name, "::")) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("0");
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(_M0MPB3Map8containsGsbE(self.state.namespaces, _M0FP211localreview3tcl15qualified__name(self.frame.namespace_name, _M0MPC15array5Array2atGRPB4JsonE(args$2, 2)))));
      }
      case "parent": {
        if (n > 3) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace parent arity"));
        }
        let target;
        if (n === 3) {
          const _bind$10 = _M0MP211localreview3tcl11Interpreter17namespace__target(self, _M0MPC15array5Array2atGRPB4JsonE(args$2, 2));
          if (_bind$10.$tag === 1) {
            const _ok = _bind$10;
            target = _ok._0;
          } else {
            return _bind$10;
          }
        } else {
          target = self.frame.namespace_name;
        }
        return target === "::" ? new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("") : new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl17namespace__parent(target));
      }
      case "tail": {
        if (n !== 3) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace tail arity"));
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl15namespace__tail(_M0MPC15array5Array2atGRPB4JsonE(args$2, 2)));
      }
      case "qualifiers": {
        if (n !== 3) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace qualifiers arity"));
        }
        const _tmp$6 = _M0MPC15array5Array2atGRPB4JsonE(args$2, 2);
        const _bind$10 = "::";
        const parts = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPC16string6String5split(_tmp$6, new _M0TPC16string10StringView(_bind$10, 0, _bind$10.length)));
        if (parts.length < 2) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
        } else {
          const _tmp$7 = _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(parts, 0, parts.length - 1 | 0));
          const _bind$11 = "::";
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC15array5Array4joinGRPC16string10StringViewE(_tmp$7, new _M0TPC16string10StringView(_bind$11, 0, _bind$11.length)));
        }
      }
      case "children": {
        if (n > 4) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace children arity"));
        }
        let target$2;
        if (n >= 3) {
          const _bind$11 = _M0MP211localreview3tcl11Interpreter17namespace__target(self, _M0MPC15array5Array2atGRPB4JsonE(args$2, 2));
          if (_bind$11.$tag === 1) {
            const _ok = _bind$11;
            target$2 = _ok._0;
          } else {
            return _bind$11;
          }
        } else {
          target$2 = self.frame.namespace_name;
        }
        const names = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB4Iter6filterGRPC16string10StringViewE(_M0MPB3Map4keysGsbE(self.state.namespaces), (name) => _M0IP016_24default__implPB2Eq10not__equalGsE(name, target$2) && _M0FP211localreview3tcl17namespace__parent(name) === target$2));
        _M0MPC15array5Array4sortGsE(names);
        let _tmp$7;
        if (n === 4) {
          const _bind$11 = _M0MPC15array5Array6filterGsEHRP211localreview3tcl8TclError(names, (name) => {
            let _tmp$8;
            const _tmp$9 = _M0MPC15array5Array2atGRPB4JsonE(args$2, 3);
            const _bind$12 = "::";
            if (_M0MPC16string6String11has__prefix(_tmp$9, new _M0TPC16string10StringView(_bind$12, 0, _bind$12.length))) {
              _tmp$8 = _M0MPC15array5Array2atGRPB4JsonE(args$2, 3);
            } else {
              _tmp$8 = _M0FP211localreview3tcl15qualified__name(target$2, _M0MPC15array5Array2atGRPB4JsonE(args$2, 3));
            }
            return _M0FP211localreview3tcl11glob__match(_tmp$8, name, false);
          });
          if (_bind$11.$tag === 1) {
            const _ok = _bind$11;
            _tmp$7 = _ok._0;
          } else {
            return _bind$11;
          }
        } else {
          _tmp$7 = names;
        }
        return _M0FP211localreview3tcl12format__list(_tmp$7);
      }
      case "which": {
        const variable = n === 4 && _M0MPC15array5Array2atGRPB4JsonE(args$2, 2) === "-variable";
        let name;
        if (n === 3) {
          name = _M0MPC15array5Array2atGRPB4JsonE(args$2, 2);
        } else {
          if (n === 4 && (variable || _M0MPC15array5Array2atGRPB4JsonE(args$2, 2) === "-command")) {
            name = _M0MPC15array5Array2atGRPB4JsonE(args$2, 3);
          } else {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace which arity"));
          }
        }
        if (variable) {
          const key = new _M0TPB8MutLocalGsE(_M0FP211localreview3tcl15qualified__name(self.frame.namespace_name, name));
          let _tmp$8;
          const _bind$11 = "::";
          if (!_M0MPC16string6String8contains(name, new _M0TPC16string10StringView(_bind$11, 0, _bind$11.length))) {
            _tmp$8 = !_M0MP211localreview3tcl11Interpreter15global__defined(self, key.val) && _M0MP211localreview3tcl11Interpreter15global__defined(self, `::${name}`);
          } else {
            _tmp$8 = false;
          }
          if (_tmp$8) {
            key.val = `::${name}`;
          }
          return _M0MP211localreview3tcl11Interpreter15global__defined(self, key.val) ? new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(key.val) : new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
        } else {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC16option6Option10unwrap__orGsE(_M0MPC16option6Option3mapGRP211localreview3tcl7CommandsE(_M0MP211localreview3tcl11Interpreter13find__command(self, name), (c) => c.name), ""));
        }
      }
      case "delete": {
        const _bind$11 = _M0MPC15array5Array12view_2einnerGsE(args$2, 2, undefined);
        const _bind$12 = _bind$11.end - _bind$11.start | 0;
        let _tmp$8 = 0;
        while (true) {
          const _ = _tmp$8;
          if (_ < _bind$12) {
            const name$2 = _bind$11.buf[_bind$11.start + _ | 0];
            const _bind$13 = _M0MP211localreview3tcl11Interpreter17namespace__target(self, name$2);
            let target$3;
            if (_bind$13.$tag === 1) {
              const _ok = _bind$13;
              target$3 = _ok._0;
            } else {
              return _bind$13;
            }
            if (target$3 === "::") {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("root namespace deletion not supported"));
            }
            if (!_M0MPB3Map8containsGsbE(self.state.namespaces, target$3)) {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unknown namespace"));
            }
            const _bind$14 = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB3Map4keysGsbE(self.state.namespaces));
            const _bind$15 = _bind$14.length;
            let _tmp$9 = 0;
            while (true) {
              const _$2 = _tmp$9;
              if (_$2 < _bind$15) {
                const key = _bind$14[_$2];
                let _tmp$10;
                if (key === target$3) {
                  _tmp$10 = true;
                } else {
                  const _bind$16 = `${target$3}::`;
                  _tmp$10 = _M0MPC16string6String11has__prefix(key, new _M0TPC16string10StringView(_bind$16, 0, _bind$16.length));
                }
                if (_tmp$10) {
                  _M0MPB3Map6removeGsbE(self.state.namespaces, key);
                }
                _tmp$9 = _$2 + 1 | 0;
                continue;
              } else {
                break;
              }
            }
            const _bind$16 = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB3Map4keysGsRP211localreview3tcl4CellE(self.state.globals));
            const _bind$17 = _bind$16.length;
            let _tmp$10 = 0;
            while (true) {
              const _$2 = _tmp$10;
              if (_$2 < _bind$17) {
                const key = _bind$16[_$2];
                const _bind$18 = `${target$3}::`;
                if (_M0MPC16string6String11has__prefix(key, new _M0TPC16string10StringView(_bind$18, 0, _bind$18.length))) {
                  let cell;
                  _L$3: {
                    _L$4: {
                      const _bind$19 = _M0MPB3Map3getGsRP211localreview3tcl4CellE(self.state.globals, key);
                      if (_bind$19 === undefined) {
                      } else {
                        const _Some = _bind$19;
                        const _cell = _Some;
                        cell = _cell;
                        break _L$4;
                      }
                      break _L$3;
                    }
                    cell.value = undefined;
                  }
                  _M0MPB3Map6removeGsRP211localreview3tcl4CellE(self.state.globals, key);
                }
                _tmp$10 = _$2 + 1 | 0;
                continue;
              } else {
                break;
              }
            }
            const _bind$18 = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB3Map6valuesGsRP211localreview3tcl7CommandE(self.state.commands));
            const _bind$19 = _bind$18.length;
            let _tmp$11 = 0;
            while (true) {
              const _$2 = _tmp$11;
              if (_$2 < _bind$19) {
                const command$2 = _bind$18[_$2];
                let linked;
                let ensemble;
                _L$3: {
                  _L$4: {
                    const _bind$20 = command$2.body;
                    if (_bind$20.$tag === 3) {
                      const _EnsembleCommand = _bind$20;
                      const _ensemble = _EnsembleCommand._0;
                      ensemble = _ensemble;
                      break _L$4;
                    } else {
                      linked = false;
                    }
                    break _L$3;
                  }
                  if (ensemble.namespace_name === target$3) {
                    linked = true;
                  } else {
                    const _tmp$12 = ensemble.namespace_name;
                    const _bind$20 = `${target$3}::`;
                    linked = _M0MPC16string6String11has__prefix(_tmp$12, new _M0TPC16string10StringView(_bind$20, 0, _bind$20.length));
                  }
                }
                let _tmp$12;
                if (linked) {
                  _tmp$12 = true;
                } else {
                  const _tmp$13 = command$2.name;
                  const _bind$20 = `${target$3}::`;
                  _tmp$12 = _M0MPC16string6String11has__prefix(_tmp$13, new _M0TPC16string10StringView(_bind$20, 0, _bind$20.length));
                }
                if (_tmp$12) {
                  _M0MP211localreview3tcl11Interpreter15delete__command(self, command$2);
                }
                _tmp$11 = _$2 + 1 | 0;
                continue;
              } else {
                break;
              }
            }
            const _bind$20 = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB3Map4keysGsRPB5ArrayGsEE(self.state.exports));
            const _bind$21 = _bind$20.length;
            let _tmp$12 = 0;
            while (true) {
              const _$2 = _tmp$12;
              if (_$2 < _bind$21) {
                const key = _bind$20[_$2];
                let _tmp$13;
                if (key === target$3) {
                  _tmp$13 = true;
                } else {
                  const _bind$22 = `${target$3}::`;
                  _tmp$13 = _M0MPC16string6String11has__prefix(key, new _M0TPC16string10StringView(_bind$22, 0, _bind$22.length));
                }
                if (_tmp$13) {
                  _M0MPB3Map6removeGsRPB5ArrayGsEE(self.state.exports, key);
                }
                _tmp$12 = _$2 + 1 | 0;
                continue;
              } else {
                break;
              }
            }
            const _bind$22 = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB3Map4keysGsRP211localreview3tcl4CellE(self.state.unknown_handlers));
            const _bind$23 = _bind$22.length;
            let _tmp$13 = 0;
            while (true) {
              const _$2 = _tmp$13;
              if (_$2 < _bind$23) {
                const key = _bind$22[_$2];
                let _tmp$14;
                if (key === target$3) {
                  _tmp$14 = true;
                } else {
                  const _bind$24 = `${target$3}::`;
                  _tmp$14 = _M0MPC16string6String11has__prefix(key, new _M0TPC16string10StringView(_bind$24, 0, _bind$24.length));
                }
                if (_tmp$14) {
                  _M0MPB3Map6removeGssE(self.state.unknown_handlers, key);
                }
                _tmp$13 = _$2 + 1 | 0;
                continue;
              } else {
                break;
              }
            }
            const _bind$24 = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB3Map4keysGsRPB5ArrayGsEE(self.state.namespace_paths));
            const _bind$25 = _bind$24.length;
            let _tmp$14 = 0;
            while (true) {
              const _$2 = _tmp$14;
              if (_$2 < _bind$25) {
                const key = _bind$24[_$2];
                let _tmp$15;
                if (key === target$3) {
                  _tmp$15 = true;
                } else {
                  const _bind$26 = `${target$3}::`;
                  _tmp$15 = _M0MPC16string6String11has__prefix(key, new _M0TPC16string10StringView(_bind$26, 0, _bind$26.length));
                }
                if (_tmp$15) {
                  _M0MPB3Map6removeGsRPB5ArrayGsEE(self.state.namespace_paths, key);
                } else {
                  _M0MPB3Map3setGsRPB5ArrayGsEE(self.state.namespace_paths, key, _M0MPC15array5Array6filterGsE(_M0MPB3Map2atGsRPB5ArrayGsEE(self.state.namespace_paths, key), (s) => {
                    if (_M0IP016_24default__implPB2Eq10not__equalGsE(s, target$3)) {
                      const _bind$26 = `${target$3}::`;
                      return !_M0MPC16string6String11has__prefix(s, new _M0TPC16string10StringView(_bind$26, 0, _bind$26.length));
                    } else {
                      return false;
                    }
                  }));
                }
                _tmp$14 = _$2 + 1 | 0;
                continue;
              } else {
                break;
              }
            }
            const _bind$26 = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB3Map4keysGsRP211localreview3tcl4CellE(self.state.aliases));
            const _bind$27 = _bind$26.length;
            let _tmp$15 = 0;
            while (true) {
              const _$2 = _tmp$15;
              if (_$2 < _bind$27) {
                const key = _bind$26[_$2];
                const _bind$28 = `${target$3}::`;
                if (_M0MPC16string6String11has__prefix(key, new _M0TPC16string10StringView(_bind$28, 0, _bind$28.length))) {
                  _M0MPB3Map6removeGsRP211localreview3tcl7BindingE(self.state.aliases, key);
                }
                _tmp$15 = _$2 + 1 | 0;
                continue;
              } else {
                break;
              }
            }
            _tmp$8 = _ + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
      }
      case "code": {
        if (n !== 3) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace code arity"));
        }
        let words;
        let _try_err;
        _L$3: {
          _L$4: {
            const _bind$13 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args$2, 2));
            if (_bind$13.$tag === 1) {
              const _ok = _bind$13;
              words = _ok._0;
            } else {
              const _err = _bind$13;
              _try_err = _err._0;
              break _L$4;
            }
            break _L$3;
          }
          words = [];
        }
        return words.length === 4 && (_M0MPC15array5Array2atGRPB4JsonE(words, 0) === "::namespace" && _M0MPC15array5Array2atGRPB4JsonE(words, 1) === "inscope") ? new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC15array5Array2atGRPB4JsonE(args$2, 2)) : _M0FP211localreview3tcl12format__list(["::namespace", "inscope", self.frame.namespace_name, _M0MPC15array5Array2atGRPB4JsonE(args$2, 2)]);
      }
      default: {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported namespace subcommand"));
      }
    }
  }
  if (n < 4) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("namespace eval arity"));
  }
  if (_M0MPC16string6String9is__empty(_M0MPC15array5Array2atGRPB4JsonE(args$2, 2)) && _M0IP016_24default__implPB2Eq10not__equalGsE(self.frame.namespace_name, "::")) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("empty namespace name"));
  }
  const target = _M0FP211localreview3tcl15qualified__name(self.frame.namespace_name, _M0MPC15array5Array2atGRPB4JsonE(args$2, 2));
  if (_M0MPC15array5Array2atGRPB4JsonE(args$2, 1) === "inscope" && !_M0MPB3Map8containsGsbE(self.state.namespaces, target)) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unknown namespace"));
  }
  const _bind$3 = "::";
  const parts = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB4Iter6filterGRPC16string10StringViewE(_M0MPC16string6String5split(target, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length)), (s) => !_M0MPC16string10StringView9is__empty(s)));
  const prefix = new _M0TPB8MutLocalGsE("::");
  const _bind$4 = parts.length;
  let _tmp$2 = 0;
  while (true) {
    const _ = _tmp$2;
    if (_ < _bind$4) {
      const part = parts[_];
      prefix.val = _M0FP211localreview3tcl15qualified__name(prefix.val, _M0MPC16string10StringView9to__owned(part));
      _M0MPB3Map3setGsbE(self.state.namespaces, prefix.val, true);
      _tmp$2 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$5 = [];
  const frame = new _M0TP211localreview3tcl5Frame(_M0MPB3Map3MapGsRP211localreview3tcl7BindingE(new _M0TPB9ArrayViewGUsRP211localreview3tcl7BindingEE(_bind$5, 0, 0), undefined), target, false, self.frame);
  let script;
  if (_M0MPC15array5Array2atGRPB4JsonE(args$2, 1) === "inscope" && n > 4) {
    const _tmp$3 = _M0MPC15array5Array2atGRPB4JsonE(args$2, 3);
    const _bind$6 = _M0FP211localreview3tcl12format__list(_M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args$2, 4, undefined)));
    let _tmp$4;
    if (_bind$6.$tag === 1) {
      const _ok = _bind$6;
      _tmp$4 = _ok._0;
    } else {
      return _bind$6;
    }
    script = `${_tmp$3} ${_tmp$4}`;
  } else {
    const _tmp$3 = _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args$2, 3, undefined));
    const _bind$6 = " ";
    script = _M0MPC15array5Array4joinGsE(_tmp$3, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length));
  }
  return _M0MP211localreview3tcl11Interpreter15execute_2einner(_M0MP211localreview3tcl11Interpreter11with__frame(self, frame), script, depth + 1 | 0, false);
}
function _M0MP211localreview3tcl11Interpreter15execute_2einner(self, source, depth, discard_result) {
  if (source.length > 100000) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("script size limit"));
  }
  const program = _M0MP211localreview3tcl11Interpreter14cached__script(self, source);
  const result = new _M0TPB8MutLocalGsE("");
  const index = new _M0TPB8MutLocalGiE(0);
  while (true) {
    if (index.val === program.commands.length) {
      let message;
      _L: {
        _L$2: {
          const _bind$2 = program.failure;
          if (_bind$2 === undefined) {
          } else {
            const _Some = _bind$2;
            const _message = _Some;
            message = _message;
            break _L$2;
          }
          break _L;
        }
        const _bind$2 = _M0MP211localreview3tcl11Interpreter15annotate__error(self, _M0FP211localreview3tcl25completion__error_2einner(message, "NONE"), _M0MPC16string6String11from__array(_M0MPC15array5Array12view_2einnerGcE(program.parser.chars, program.parser.command_start, undefined)), program.parser.command_line, []);
        let _tmp;
        if (_bind$2.$tag === 1) {
          const _ok = _bind$2;
          _tmp = _ok._0;
        } else {
          return _bind$2;
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_tmp));
      }
      if (program.parser.pos === program.parser.chars.length) {
        break;
      }
      let _try_err;
      _L$2: {
        _L$3: {
          const _bind$2 = _M0MP211localreview3tcl12ScriptParser14script_2einner(program.parser, false, 0, true);
          let commands;
          if (_bind$2.$tag === 1) {
            const _ok = _bind$2;
            commands = _ok._0;
          } else {
            const _err = _bind$2;
            _try_err = _err._0;
            break _L$3;
          }
          const _bind$3 = commands.length;
          let _tmp = 0;
          while (true) {
            const _ = _tmp;
            if (_ < _bind$3) {
              const command = commands[_];
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(program.commands, command);
              _tmp = _ + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          break _L$2;
        }
        let error;
        _L$4: {
          let message$2;
          _L$5: {
            if (_try_err.$tag === 4) {
              const _Invalid = _try_err;
              const _message = _Invalid._0;
              message$2 = _message;
              break _L$5;
            } else {
              error = _try_err;
              break _L$4;
            }
          }
          program.failure = message$2;
          const _bind$2 = _M0MP211localreview3tcl11Interpreter15annotate__error(self, _M0FP211localreview3tcl25completion__error_2einner(message$2, "NONE"), _M0MPC16string6String11from__array(_M0MPC15array5Array12view_2einnerGcE(program.parser.chars, program.parser.command_start, undefined)), program.parser.command_line, []);
          let _tmp;
          if (_bind$2.$tag === 1) {
            const _ok = _bind$2;
            _tmp = _ok._0;
          } else {
            return _bind$2;
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_tmp));
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(error);
      }
      if (index.val === program.commands.length) {
        continue;
      }
    }
    const _bind$2 = _M0MP211localreview3tcl11Interpreter25execute__commands_2einner(self, [_M0MPC15array5Array2atGRPB4JsonE(program.commands, index.val)], depth, discard_result);
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    result.val = _tmp;
    index.val = index.val + 1 | 0;
    continue;
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(result.val);
}
function _M0MP211localreview3tcl11Interpreter25execute__commands_2einner(self, commands, depth, discard_result) {
  if (depth > 64) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("execution nesting limit"));
  }
  const result = new _M0TPB8MutLocalGsE("");
  const _bind$2 = commands.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const parsed = commands[_];
      const args = [];
      let _try_err;
      _L: {
        _L$2: {
          const _bind$3 = parsed.words;
          const _bind$4 = _bind$3.length;
          let _tmp$2 = 0;
          while (true) {
            const _$2 = _tmp$2;
            if (_$2 < _bind$4) {
              const word = _bind$3[_$2];
              const _bind$5 = _M0MP211localreview3tcl11Interpreter13expand__parts(self, word.parts, depth + 1 | 0);
              let value;
              if (_bind$5.$tag === 1) {
                const _ok = _bind$5;
                value = _ok._0;
              } else {
                const _err = _bind$5;
                _try_err = _err._0;
                break _L$2;
              }
              if (word.expand) {
                const _bind$6 = _M0FP211localreview3tcl11parse__list(value);
                let _bind$7;
                if (_bind$6.$tag === 1) {
                  const _ok = _bind$6;
                  _bind$7 = _ok._0;
                } else {
                  const _err = _bind$6;
                  _try_err = _err._0;
                  break _L$2;
                }
                const _bind$8 = _bind$7.length;
                let _tmp$3 = 0;
                while (true) {
                  const _$3 = _tmp$3;
                  if (_$3 < _bind$8) {
                    const item = _bind$7[_$3];
                    _M0MPC15array5Array4pushGRPC14json10WriteFrameE(args, item);
                    _tmp$3 = _$3 + 1 | 0;
                    continue;
                  } else {
                    break;
                  }
                }
              } else {
                _M0MPC15array5Array4pushGRPC14json10WriteFrameE(args, value);
              }
              if (args.length > 4096) {
                _try_err = new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expanded argument limit");
                break _L$2;
              }
              _tmp$2 = _$2 + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          if (!_M0MPC15array5Array9is__emptyGRPB4JsonE(args)) {
            const _bind$5 = _M0MP211localreview3tcl11Interpreter15command_2einner(self, args, depth, discard_result);
            let _tmp$3;
            if (_bind$5.$tag === 1) {
              const _ok = _bind$5;
              _tmp$3 = _ok._0;
            } else {
              const _err = _bind$5;
              _try_err = _err._0;
              break _L$2;
            }
            result.val = _tmp$3;
          }
          if (result.val.length > 1000000) {
            _try_err = new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("command result size limit");
            break _L$2;
          }
          break _L;
        }
        const error = _try_err;
        const _bind$3 = _M0MP211localreview3tcl11Interpreter15annotate__error(self, _M0FP211localreview3tcl7outcome(error), parsed.source, parsed.line, args);
        let _tmp$2;
        if (_bind$3.$tag === 1) {
          const _ok = _bind$3;
          _tmp$2 = _ok._0;
        } else {
          return _bind$3;
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_tmp$2));
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(result.val);
}
function _M0MP211localreview3tcl11Interpreter15command_2einner(self, input, depth, discard_result) {
  let _tmp = self;
  let _tmp$2 = input;
  let _tmp$3 = depth;
  let _tmp$4 = discard_result;
  _L: while (true) {
    const self$2 = _tmp;
    const input$2 = _tmp$2;
    const depth$2 = _tmp$3;
    const discard_result$2 = _tmp$4;
    const _bind$2 = _M0MP211localreview3tcl11Interpreter4tick(self$2);
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _ok._0;
    } else {
      return _bind$2;
    }
    if (depth$2 > 64) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("command recursion limit"));
    }
    let command;
    let command$2;
    _L$2: {
      const _bind$3 = _M0MP211localreview3tcl11Interpreter13find__command(self$2, _M0MPC15array5Array2atGRPB4JsonE(input$2, 0));
      if (_bind$3 === undefined) {
        const local_handler = _M0MPC16option6Option10unwrap__orGsE(_M0MPB3Map3getGssE(self$2.state.unknown_handlers, self$2.frame.namespace_name), "");
        const global_handler = _M0MPC16option6Option10unwrap__orGsE(_M0MPB3Map3getGssE(self$2.state.unknown_handlers, "::"), "::unknown");
        const handler = !_M0MPC16string6String9is__empty(local_handler) ? local_handler : !_M0MPC16string6String9is__empty(global_handler) ? global_handler : "::unknown";
        const _bind$4 = _M0FP211localreview3tcl11parse__list(handler);
        let words;
        if (_bind$4.$tag === 1) {
          const _ok = _bind$4;
          words = _ok._0;
        } else {
          return _bind$4;
        }
        _L$3: {
          _L$4: {
            if (_M0MPC15array5Array9is__emptyGRPB4JsonE(words)) {
              break _L$4;
            } else {
              if (_M0MPC15array5Array2atGRPB4JsonE(words, 0) === "::unknown") {
                const _bind$5 = _M0MP211localreview3tcl11Interpreter13find__command(self$2, "::unknown");
                if (_bind$5 === undefined) {
                  break _L$4;
                }
              }
            }
            break _L$3;
          }
          const _tmp$5 = `invalid command name \"${_M0MPC15array5Array2atGRPB4JsonE(input$2, 0)}\"`;
          const _bind$5 = _M0FP211localreview3tcl12format__list(["TCL", "LOOKUP", "COMMAND", _M0MPC15array5Array2atGRPB4JsonE(input$2, 0)]);
          let _tmp$6;
          if (_bind$5.$tag === 1) {
            const _ok = _bind$5;
            _tmp$6 = _ok._0;
          } else {
            return _bind$5;
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_M0FP211localreview3tcl25completion__error_2einner(_tmp$5, _tmp$6)));
        }
        _tmp$2 = _M0IPC15array5ArrayPB3Add3addGsE(words, input$2);
        _tmp$3 = depth$2 + 1 | 0;
        continue;
      } else {
        const _Some = _bind$3;
        const _command = _Some;
        command$2 = _command;
        break _L$2;
      }
    }
    command = _M0MP211localreview3tcl7Command6origin(command$2);
    let name;
    let ensemble;
    _L$3: {
      _L$4: {
        let definition;
        _L$5: {
          _L$6: {
            const _bind$3 = command.body;
            switch (_bind$3.$tag) {
              case 1: {
                const _Script = _bind$3;
                const _definition = _Script._0;
                definition = _definition;
                break _L$6;
              }
              case 3: {
                const _EnsembleCommand = _bind$3;
                const _ensemble = _EnsembleCommand._0;
                ensemble = _ensemble;
                break _L$4;
              }
              case 0: {
                const _Native = _bind$3;
                const _name = _Native._0;
                name = _name;
                break;
              }
              default: {
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("invalid command import"));
              }
            }
            break _L$5;
          }
          const _bind$3 = _M0MP211localreview3tcl11Interpreter17invoke__procedure(self$2, definition, input$2, depth$2);
          let _tmp$5;
          if (_bind$3.$tag === 1) {
            const _ok = _bind$3;
            _tmp$5 = _ok._0;
          } else {
            return _bind$3;
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp$5);
        }
        break _L$3;
      }
      const _bind$3 = _M0MP211localreview3tcl11Interpreter24invoke__ensemble_2einner(self$2, command, ensemble, input$2, depth$2, discard_result$2);
      let _tmp$5;
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        _tmp$5 = _ok._0;
      } else {
        return _bind$3;
      }
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp$5);
    }
    let args;
    if (_M0MPC15array5Array2atGRPB4JsonE(input$2, 0) === name) {
      args = input$2;
    } else {
      const args$2 = _M0MPC15array5Array4copyGUssEE(input$2);
      _M0MPC15array5Array3setGUssEE(args$2, 0, name);
      args = args$2;
    }
    const n = args.length;
    _L$4: {
      _L$5: {
        _L$6: {
          _L$7: {
            const _bind$3 = _M0MPC15array5Array2atGRPB4JsonE(args, 0);
            switch (_bind$3) {
              case "list": {
                break _L$7;
              }
              case "llength": {
                break _L$7;
              }
              case "lindex": {
                break _L$7;
              }
              case "lappend": {
                break _L$7;
              }
              case "join": {
                break _L$7;
              }
              case "split": {
                break _L$7;
              }
              case "concat": {
                break _L$7;
              }
              case "lrange": {
                break _L$7;
              }
              case "lreverse": {
                break _L$7;
              }
              case "lrepeat": {
                break _L$7;
              }
              case "lset": {
                break _L$6;
              }
              case "linsert": {
                break _L$6;
              }
              case "lreplace": {
                break _L$6;
              }
              case "lsearch": {
                break _L$6;
              }
              case "lsort": {
                break _L$6;
              }
              case "while": {
                break _L$5;
              }
              case "for": {
                break _L$5;
              }
              case "foreach": {
                break _L$5;
              }
              case "lmap": {
                break _L$5;
              }
              case "break": {
                break _L$5;
              }
              case "continue": {
                break _L$5;
              }
              case "catch": {
                break _L$5;
              }
              case "error": {
                break _L$5;
              }
              case "try": {
                break _L$5;
              }
              case "throw": {
                break _L$5;
              }
              case "namespace": {
                return _M0MP211localreview3tcl11Interpreter18namespace__command(self$2, args, depth$2);
              }
              case "global": {
                break _L$4;
              }
              case "variable": {
                break _L$4;
              }
              case "upvar": {
                break _L$4;
              }
              case "uplevel": {
                break _L$4;
              }
              case "array": {
                return _M0MP211localreview3tcl11Interpreter14array__command(self$2, args);
              }
              case "dict": {
                return _M0MP211localreview3tcl11Interpreter21dict__command_2einner(self$2, args, depth$2, discard_result$2, true);
              }
              case "string": {
                return _M0MP211localreview3tcl11Interpreter15string__command(self$2, args);
              }
              case "info": {
                return _M0MP211localreview3tcl11Interpreter13info__command(self$2, args);
              }
              case "set": {
                if (n === 2) {
                  return _M0MP211localreview3tcl11Interpreter9read__var(self$2, _M0MPC15array5Array2atGRPB4JsonE(args, 1));
                } else {
                  if (n === 3) {
                    const _bind$4 = _M0MP211localreview3tcl11Interpreter8set__var(self$2, _M0MPC15array5Array2atGRPB4JsonE(args, 1), _M0MPC15array5Array2atGRPB4JsonE(args, 2));
                    if (_bind$4.$tag === 1) {
                      const _ok = _bind$4;
                      _ok._0;
                    } else {
                      return _bind$4;
                    }
                    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC15array5Array2atGRPB4JsonE(args, 2));
                  } else {
                    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("set arity"));
                  }
                }
              }
              case "unset": {
                const i = new _M0TPB8MutLocalGiE(1);
                const quiet = new _M0TPB8MutLocalGbE(false);
                if (i.val < n && _M0MPC15array5Array2atGRPB4JsonE(args, i.val) === "-nocomplain") {
                  quiet.val = true;
                  i.val = i.val + 1 | 0;
                }
                if (i.val < n && _M0MPC15array5Array2atGRPB4JsonE(args, i.val) === "--") {
                  i.val = i.val + 1 | 0;
                }
                if (i.val === n && !quiet.val) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unset arity"));
                }
                const _bind$4 = _M0MPC15array5Array12view_2einnerGsE(args, i.val, undefined);
                const _bind$5 = _bind$4.end - _bind$4.start | 0;
                let _tmp$5 = 0;
                while (true) {
                  const _ = _tmp$5;
                  if (_ < _bind$5) {
                    const name$2 = _bind$4.buf[_bind$4.start + _ | 0];
                    const _bind$6 = _M0MP211localreview3tcl11Interpreter10unset__var(self$2, name$2, quiet.val);
                    if (_bind$6.$tag === 1) {
                      const _ok = _bind$6;
                      _ok._0;
                    } else {
                      return _bind$6;
                    }
                    _tmp$5 = _ + 1 | 0;
                    continue;
                  } else {
                    break;
                  }
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
              }
              case "incr": {
                if (n !== 2 && n !== 3) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("incr arity"));
                }
                const _bind$6 = _M0MP211localreview3tcl11Interpreter8get__var(self$2, _M0MPC15array5Array2atGRPB4JsonE(args, 1));
                let _tmp$6;
                if (_bind$6.$tag === 1) {
                  const _ok = _bind$6;
                  _tmp$6 = _ok._0;
                } else {
                  return _bind$6;
                }
                const _bind$7 = _M0FP211localreview3tcl12integer__add(_M0MPC16option6Option10unwrap__orGsE(_tmp$6, "0"), n === 3 ? _M0MPC15array5Array2atGRPB4JsonE(args, 2) : "1");
                let text;
                if (_bind$7.$tag === 1) {
                  const _ok = _bind$7;
                  text = _ok._0;
                } else {
                  return _bind$7;
                }
                const _bind$8 = _M0MP211localreview3tcl11Interpreter8set__var(self$2, _M0MPC15array5Array2atGRPB4JsonE(args, 1), text);
                if (_bind$8.$tag === 1) {
                  const _ok = _bind$8;
                  _ok._0;
                } else {
                  return _bind$8;
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(text);
              }
              case "append": {
                if (n < 2) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("append arity"));
                }
                const _bind$9 = _M0MP211localreview3tcl11Interpreter8get__var(self$2, _M0MPC15array5Array2atGRPB4JsonE(args, 1));
                let _tmp$7;
                if (_bind$9.$tag === 1) {
                  const _ok = _bind$9;
                  _tmp$7 = _ok._0;
                } else {
                  return _bind$9;
                }
                const previous = _M0MPC16option6Option10unwrap__orGsE(_tmp$7, "");
                const values = _M0IPC15array5ArrayPB3Add3addGsE([previous], _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 2, undefined)));
                const size = new _M0TPB8MutLocalGiE(0);
                const _bind$10 = values.length;
                let _tmp$8 = 0;
                while (true) {
                  const _ = _tmp$8;
                  if (_ < _bind$10) {
                    const value = values[_];
                    size.val = size.val + value.length | 0;
                    if (size.val > 1000000) {
                      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("append size limit"));
                    }
                    _tmp$8 = _ + 1 | 0;
                    continue;
                  } else {
                    break;
                  }
                }
                const _bind$11 = "";
                const result = _M0MPC15array5Array4joinGsE(values, new _M0TPC16string10StringView(_bind$11, 0, _bind$11.length));
                const _bind$12 = _M0MP211localreview3tcl11Interpreter8set__var(self$2, _M0MPC15array5Array2atGRPB4JsonE(args, 1), result);
                if (_bind$12.$tag === 1) {
                  const _ok = _bind$12;
                  _ok._0;
                } else {
                  return _bind$12;
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(result);
              }
              case "expr": {
                if (n < 2) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expr arity"));
                }
                const _tmp$9 = _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 1, undefined));
                const _bind$13 = " ";
                return _M0MP211localreview3tcl11Interpreter17expression__value(self$2, _M0MPC15array5Array4joinGsE(_tmp$9, new _M0TPC16string10StringView(_bind$13, 0, _bind$13.length)), depth$2);
              }
              case "puts": {
                const nonewline = n >= 2 && _M0MPC15array5Array2atGRPB4JsonE(args, 1) === "-nonewline";
                const start = nonewline ? 2 : 1;
                let value;
                if (n === (start + 1 | 0)) {
                  value = _M0MPC15array5Array2atGRPB4JsonE(args, start);
                } else {
                  if (n === (start + 2 | 0) && _M0MPC15array5Array2atGRPB4JsonE(args, start) === "stdout") {
                    value = _M0MPC15array5Array2atGRPB4JsonE(args, start + 1 | 0);
                  } else {
                    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("puts arity or unsupported channel"));
                  }
                }
                const text$2 = `${value}${nonewline ? "" : "\n"}`;
                if (text$2.length > (1000000 - _M0MPC15array5Array2atGiE(self$2.output_size, 0) | 0)) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("printed output size limit"));
                }
                const _array_1 = self$2.output_size;
                const _index_2 = 0;
                _M0MPC15array5Array3setGiE(_array_1, _index_2, _M0MPC15array5Array2atGiE(_array_1, _index_2) + text$2.length | 0);
                _M0MPC15array5Array4pushGRPC14json10WriteFrameE(self$2.output, text$2);
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
              }
              case "if": {
                const i$2 = new _M0TPB8MutLocalGiE(1);
                while (true) {
                  if (i$2.val < n) {
                    const expression = _M0MPC15array5Array2atGRPB4JsonE(args, i$2.val);
                    i$2.val = i$2.val + 1 | 0;
                    if (i$2.val < n && _M0MPC15array5Array2atGRPB4JsonE(args, i$2.val) === "then") {
                      i$2.val = i$2.val + 1 | 0;
                    }
                    if (i$2.val >= n) {
                      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("if missing body"));
                    }
                    const body = _M0MPC15array5Array2atGRPB4JsonE(args, i$2.val);
                    i$2.val = i$2.val + 1 | 0;
                    const _bind$14 = _M0MP211localreview3tcl11Interpreter17expression__value(self$2, expression, depth$2);
                    let _tmp$10;
                    if (_bind$14.$tag === 1) {
                      const _ok = _bind$14;
                      _tmp$10 = _ok._0;
                    } else {
                      return _bind$14;
                    }
                    const _bind$15 = _M0FP211localreview3tcl7boolean(_tmp$10);
                    let _tmp$11;
                    if (_bind$15.$tag === 1) {
                      const _ok = _bind$15;
                      _tmp$11 = _ok._0;
                    } else {
                      return _bind$15;
                    }
                    if (_tmp$11) {
                      const _bind$16 = _M0MP211localreview3tcl11Interpreter15execute_2einner(self$2, body, depth$2 + 1 | 0, discard_result$2);
                      let _tmp$12;
                      if (_bind$16.$tag === 1) {
                        const _ok = _bind$16;
                        _tmp$12 = _ok._0;
                      } else {
                        return _bind$16;
                      }
                      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp$12);
                    }
                    if (i$2.val === n) {
                      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
                    }
                    if (_M0MPC15array5Array2atGRPB4JsonE(args, i$2.val) === "elseif") {
                      i$2.val = i$2.val + 1 | 0;
                      continue;
                    }
                    if (_M0MPC15array5Array2atGRPB4JsonE(args, i$2.val) === "else") {
                      i$2.val = i$2.val + 1 | 0;
                    }
                    if (i$2.val !== (n - 1 | 0)) {
                      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("if malformed else"));
                    }
                    const _bind$16 = _M0MP211localreview3tcl11Interpreter15execute_2einner(self$2, _M0MPC15array5Array2atGRPB4JsonE(args, i$2.val), depth$2 + 1 | 0, discard_result$2);
                    let _tmp$12;
                    if (_bind$16.$tag === 1) {
                      const _ok = _bind$16;
                      _tmp$12 = _ok._0;
                    } else {
                      return _bind$16;
                    }
                    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp$12);
                  } else {
                    break;
                  }
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("if arity"));
              }
              case "proc": {
                if (n !== 4) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("proc name parameters body"));
                }
                const key = _M0FP211localreview3tcl13command__name(self$2.frame.namespace_name, _M0MPC15array5Array2atGRPB4JsonE(args, 1));
                const owner = _M0FP211localreview3tcl15command__parent(key);
                if (!_M0MPB3Map8containsGsbE(self$2.state.namespaces, owner)) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("procedure namespace missing"));
                }
                const parameters = [];
                const _bind$14 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, 2));
                let _bind$15;
                if (_bind$14.$tag === 1) {
                  const _ok = _bind$14;
                  _bind$15 = _ok._0;
                } else {
                  return _bind$14;
                }
                const _bind$16 = _bind$15.length;
                let _tmp$10 = 0;
                while (true) {
                  const _ = _tmp$10;
                  if (_ < _bind$16) {
                    const spec = _bind$15[_];
                    const _bind$17 = _M0FP211localreview3tcl11parse__list(spec);
                    let parts;
                    if (_bind$17.$tag === 1) {
                      const _ok = _bind$17;
                      parts = _ok._0;
                    } else {
                      return _bind$17;
                    }
                    if (_M0MPC15array5Array9is__emptyGRPB4JsonE(parts) || parts.length > 2) {
                      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("invalid procedure parameter"));
                    }
                    _M0MPC15array5Array4pushGRPC14json10WriteFrameE(parameters, { _0: _M0MPC15array5Array2atGRPB4JsonE(parts, 0), _1: parts.length === 2 ? _M0MPC15array5Array2atGRPB4JsonE(parts, 1) : undefined });
                    _tmp$10 = _ + 1 | 0;
                    continue;
                  } else {
                    break;
                  }
                }
                const _bind$17 = _M0MP211localreview3tcl11Interpreter15define__command(self$2, key, new _M0DTP211localreview3tcl11CommandBody6Script(new _M0TP211localreview3tcl9Procedure(parameters, _M0MPC15array5Array2atGRPB4JsonE(args, 3), owner)));
                if (_bind$17.$tag === 1) {
                  const _ok = _bind$17;
                  _ok._0;
                } else {
                  return _bind$17;
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
              }
              case "return": {
                return _M0MP211localreview3tcl11Interpreter15return__command(self$2, args);
              }
              case "eval": {
                if (n < 2) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("eval arity"));
                }
                const _tmp$11 = _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 1, undefined));
                const _bind$18 = " ";
                return _M0MP211localreview3tcl11Interpreter15execute_2einner(self$2, _M0MPC15array5Array4joinGsE(_tmp$11, new _M0TPC16string10StringView(_bind$18, 0, _bind$18.length)), depth$2 + 1 | 0, discard_result$2);
              }
              case "subst": {
                if (n !== 2) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("subst options not implemented"));
                }
                const parser = new _M0TP211localreview3tcl12ScriptParser(_M0MPC16string6String9to__array(_M0MPC15array5Array2atGRPB4JsonE(args, 1)), 0, 0, 1, 0, 1);
                const _bind$19 = _M0MP211localreview3tcl12ScriptParser13parts_2einner(parser, 0, false, 0, false);
                let _tmp$12;
                if (_bind$19.$tag === 1) {
                  const _ok = _bind$19;
                  _tmp$12 = _ok._0;
                } else {
                  return _bind$19;
                }
                return _M0MP211localreview3tcl11Interpreter13expand__parts(self$2, _tmp$12, depth$2 + 1 | 0);
              }
              case "rename": {
                if (n !== 3) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("rename arity"));
                }
                return _M0MP211localreview3tcl11Interpreter15rename__command(self$2, _M0MPC15array5Array2atGRPB4JsonE(args, 1), _M0MPC15array5Array2atGRPB4JsonE(args, 2));
              }
              default: {
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid(`unsupported command ${_M0MPC15array5Array2atGRPB4JsonE(args, 0)}`));
              }
            }
          }
          return _M0MP211localreview3tcl11Interpreter21list__command_2einner(self$2, args, discard_result$2);
        }
        return _M0MP211localreview3tcl11Interpreter23extended__list__command(self$2, args, depth$2);
      }
      return _M0MP211localreview3tcl11Interpreter16control__command(self$2, args, depth$2);
    }
    return _M0MP211localreview3tcl11Interpreter14scope__command(self$2, args, depth$2);
  }
}
function _M0MP211localreview3tcl11Interpreter16control__command(self, args, depth) {
  const n = args.length;
  _L: {
    _L$2: {
      const _bind$2 = _M0MPC15array5Array2atGRPB4JsonE(args, 0);
      switch (_bind$2) {
        case "break": {
          if (n !== 1) {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("break arity"));
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(_M0DTPC15error5Error36localreview_2ftcl_2eTclError_2eBreak__);
        }
        case "continue": {
          if (n !== 1) {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("continue arity"));
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(_M0DTPC15error5Error39localreview_2ftcl_2eTclError_2eContinue__);
        }
        case "error": {
          break _L$2;
        }
        case "throw": {
          break _L$2;
        }
        case "return": {
          return _M0MP211localreview3tcl11Interpreter15return__command(self, args);
        }
        case "catch": {
          return _M0MP211localreview3tcl11Interpreter14catch__command(self, args, depth);
        }
        case "try": {
          return _M0MP211localreview3tcl11Interpreter12try__command(self, args, depth);
        }
        case "while": {
          if (n !== 3) {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("while arity"));
          }
          while (true) {
            const _bind$3 = _M0MP211localreview3tcl11Interpreter4math(self, _M0MPC15array5Array2atGRPB4JsonE(args, 1), depth);
            let _tmp;
            if (_bind$3.$tag === 1) {
              const _ok = _bind$3;
              _tmp = _ok._0;
            } else {
              return _bind$3;
            }
            if (_tmp !== 0) {
              const _bind$4 = _M0MP211localreview3tcl11Interpreter4tick(self);
              if (_bind$4.$tag === 1) {
                const _ok = _bind$4;
                _ok._0;
              } else {
                return _bind$4;
              }
              const _bind$5 = _M0MP211localreview3tcl11Interpreter10loop__body(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2), depth);
              let _tmp$2;
              if (_bind$5.$tag === 1) {
                const _ok = _bind$5;
                _tmp$2 = _ok._0;
              } else {
                return _bind$5;
              }
              if (_tmp$2 === 2) {
                break;
              }
              continue;
            } else {
              break;
            }
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
        }
        case "for": {
          if (n !== 5) {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("for arity"));
          }
          const _bind$3 = _M0MP211localreview3tcl11Interpreter15execute_2einner(self, _M0MPC15array5Array2atGRPB4JsonE(args, 1), depth + 1 | 0, true);
          if (_bind$3.$tag === 1) {
            const _ok = _bind$3;
            _ok._0;
          } else {
            return _bind$3;
          }
          while (true) {
            const _bind$4 = _M0MP211localreview3tcl11Interpreter4math(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2), depth);
            let _tmp;
            if (_bind$4.$tag === 1) {
              const _ok = _bind$4;
              _tmp = _ok._0;
            } else {
              return _bind$4;
            }
            if (_tmp !== 0) {
              const _bind$5 = _M0MP211localreview3tcl11Interpreter4tick(self);
              if (_bind$5.$tag === 1) {
                const _ok = _bind$5;
                _ok._0;
              } else {
                return _bind$5;
              }
              const _bind$6 = _M0MP211localreview3tcl11Interpreter10loop__body(self, _M0MPC15array5Array2atGRPB4JsonE(args, 4), depth);
              let _tmp$2;
              if (_bind$6.$tag === 1) {
                const _ok = _bind$6;
                _tmp$2 = _ok._0;
              } else {
                return _bind$6;
              }
              if (_tmp$2 === 2) {
                break;
              }
              const _bind$7 = _M0MP211localreview3tcl11Interpreter10loop__body(self, _M0MPC15array5Array2atGRPB4JsonE(args, 3), depth);
              let code;
              if (_bind$7.$tag === 1) {
                const _ok = _bind$7;
                code = _ok._0;
              } else {
                return _bind$7;
              }
              if (code === 2) {
                break;
              }
              if (code === 1) {
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(_M0DTPC15error5Error39localreview_2ftcl_2eTclError_2eContinue__);
              }
              continue;
            } else {
              break;
            }
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
        }
        case "foreach": {
          break _L;
        }
        case "lmap": {
          break _L;
        }
        default: {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported control command"));
        }
      }
    }
    return _M0MP211localreview3tcl11Interpreter14error__command(self, args);
  }
  const collected = [];
  let _tmp;
  if (n < 4) {
    _tmp = true;
  } else {
    if (2 === 0) {
      $panic();
    }
    _tmp = (n % 2 | 0) !== 0;
  }
  if (_tmp) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("foreach arity"));
  }
  const groups = [];
  const count = new _M0TPB8MutLocalGiE(0);
  const i = new _M0TPB8MutLocalGiE(1);
  while (true) {
    if (i.val < (n - 1 | 0)) {
      const _bind$2 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, i.val));
      let names;
      if (_bind$2.$tag === 1) {
        const _ok = _bind$2;
        names = _ok._0;
      } else {
        return _bind$2;
      }
      const _bind$3 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, i.val + 1 | 0));
      let values;
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        values = _ok._0;
      } else {
        return _bind$3;
      }
      if (_M0MPC15array5Array9is__emptyGRPB4JsonE(names)) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("foreach variable list is empty"));
      }
      const _tmp$2 = count.val;
      const _tmp$3 = names.length;
      if (_tmp$3 === 0) {
        $panic();
      }
      count.val = _M0MPC13int3Int3max(_tmp$2, ((values.length + names.length | 0) - 1 | 0) / _tmp$3 | 0);
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(groups, { _0: names, _1: values });
      i.val = i.val + 2 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$2 = 0;
  const _bind$3 = count.val;
  let _tmp$2 = _bind$2;
  _L$2: while (true) {
    const iteration = _tmp$2;
    if (iteration < _bind$3) {
      _L$3: {
        const _bind$4 = _M0MP211localreview3tcl11Interpreter4tick(self);
        if (_bind$4.$tag === 1) {
          const _ok = _bind$4;
          _ok._0;
        } else {
          return _bind$4;
        }
        const _bind$5 = groups.length;
        let _tmp$3 = 0;
        while (true) {
          const _ = _tmp$3;
          if (_ < _bind$5) {
            const _foreach_element = groups[_];
            let names;
            let values;
            _L$4: {
              const _names = _foreach_element._0;
              const _values = _foreach_element._1;
              names = _names;
              values = _values;
              break _L$4;
            }
            const _bind$6 = 0;
            const _bind$7 = names.length;
            let _tmp$4 = _bind$6;
            while (true) {
              const j = _tmp$4;
              if (j < _bind$7) {
                const at = (Math.imul(iteration, names.length) | 0) + j | 0;
                const _bind$8 = _M0MP211localreview3tcl11Interpreter8set__var(self, _M0MPC15array5Array2atGRPB4JsonE(names, j), at < values.length ? _M0MPC15array5Array2atGRPB4JsonE(values, at) : "");
                if (_bind$8.$tag === 1) {
                  const _ok = _bind$8;
                  _ok._0;
                } else {
                  return _bind$8;
                }
                _tmp$4 = j + 1 | 0;
                continue;
              } else {
                break;
              }
            }
            _tmp$3 = _ + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        if (_M0MPC15array5Array2atGRPB4JsonE(args, 0) === "lmap") {
          let _try_err;
          _L$4: {
            _L$5: {
              const _bind$6 = _M0MP211localreview3tcl11Interpreter15execute_2einner(self, _M0MPC15array5Array2atGRPB4JsonE(args, n - 1 | 0), depth + 1 | 0, false);
              let _tmp$4;
              if (_bind$6.$tag === 1) {
                const _ok = _bind$6;
                _tmp$4 = _ok._0;
              } else {
                const _err = _bind$6;
                _try_err = _err._0;
                break _L$5;
              }
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(collected, _tmp$4);
              break _L$4;
            }
            let error;
            _L$6: {
              let result;
              _L$7: {
                let result$2;
                _L$8: {
                  switch (_try_err.$tag) {
                    case 1: {
                      break _L$3;
                    }
                    case 2: {
                      break _L$2;
                    }
                    case 0: {
                      const _Signal = _try_err;
                      const _result = _Signal._0;
                      if (_M0MP211localreview3tcl10Completion12actual__code(_result) === 4) {
                        result$2 = _result;
                        break _L$8;
                      } else {
                        if (_M0MP211localreview3tcl10Completion12actual__code(_result) === 3) {
                          result = _result;
                          break _L$7;
                        } else {
                          error = _try_err;
                          break _L$6;
                        }
                      }
                    }
                    default: {
                      error = _try_err;
                      break _L$6;
                    }
                  }
                }
                break _L$3;
              }
              break;
            }
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(error);
          }
        } else {
          const _bind$6 = _M0MP211localreview3tcl11Interpreter10loop__body(self, _M0MPC15array5Array2atGRPB4JsonE(args, n - 1 | 0), depth);
          let _tmp$4;
          if (_bind$6.$tag === 1) {
            const _ok = _bind$6;
            _tmp$4 = _ok._0;
          } else {
            return _bind$6;
          }
          if (_tmp$4 === 2) {
            break;
          }
        }
        break _L$3;
      }
      _tmp$2 = iteration + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  if (_M0MPC15array5Array2atGRPB4JsonE(args, 0) === "lmap") {
    return _M0FP211localreview3tcl12format__list(collected);
  } else {
    self.state.return_options.val = [];
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
  }
}
function _M0MP211localreview3tcl11Interpreter14catch__command(self, args, depth) {
  if (args.length < 2 || args.length > 4) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("catch arity"));
  }
  const result = _M0MP211localreview3tcl11Interpreter7capture(self, _M0MPC15array5Array2atGRPB4JsonE(args, 1), depth + 1 | 0);
  if (args.length >= 3) {
    const _bind$2 = _M0MP211localreview3tcl11Interpreter8set__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2), result.value);
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _ok._0;
    } else {
      return _bind$2;
    }
  }
  if (args.length === 4) {
    const _tmp = _M0MPC15array5Array2atGRPB4JsonE(args, 3);
    const _bind$2 = _M0MP211localreview3tcl10Completion12option__text(result);
    let _tmp$2;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp$2 = _ok._0;
    } else {
      return _bind$2;
    }
    const _bind$3 = _M0MP211localreview3tcl11Interpreter8set__var(self, _tmp, _tmp$2);
    if (_bind$3.$tag === 1) {
      const _ok = _bind$3;
      _ok._0;
    } else {
      return _bind$3;
    }
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC13int3Int18to__string_2einner(_M0MP211localreview3tcl10Completion12actual__code(result), 10));
}
function _M0MP211localreview3tcl11Interpreter7capture(self, source, depth) {
  self.state.return_options.val = [];
  let result;
  let _try_err;
  _L: {
    _L$2: {
      const _bind$2 = _M0MP211localreview3tcl11Interpreter15execute_2einner(self, source, depth, false);
      let value;
      if (_bind$2.$tag === 1) {
        const _ok = _bind$2;
        value = _ok._0;
      } else {
        const _err = _bind$2;
        _try_err = _err._0;
        break _L$2;
      }
      result = _M0FP211localreview3tcl18completion_2einner(0, value, 0, self.state.return_options.val, false);
      break _L;
    }
    const error = _try_err;
    result = _M0FP211localreview3tcl7outcome(error);
  }
  self.state.return_options.val = [];
  if (_M0MP211localreview3tcl10Completion12actual__code(result) === 1) {
    const _bind$2 = _M0FP211localreview3tcl11option__get(result.options, "-errorinfo");
    if (_bind$2 === undefined) {
      _M0FP211localreview3tcl11option__set(result.options, "-errorinfo", result.value);
    }
    const _bind$3 = _M0FP211localreview3tcl11option__get(result.options, "-errorline");
    if (_bind$3 === undefined) {
      _M0FP211localreview3tcl11option__set(result.options, "-errorline", "1");
    }
    const _bind$4 = _M0FP211localreview3tcl11option__get(result.options, "-errorstack");
    if (_bind$4 === undefined) {
      _M0FP211localreview3tcl11option__set(result.options, "-errorstack", "");
    }
  }
  _M0MP211localreview3tcl11Interpreter13record__error(self, result);
  return result;
}
function _M0MP211localreview3tcl11Interpreter10loop__body(self, source, depth) {
  let _try_err;
  _L: {
    const _bind$2 = _M0MP211localreview3tcl11Interpreter15execute_2einner(self, source, depth + 1 | 0, true);
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _ok._0;
    } else {
      const _err = _bind$2;
      _try_err = _err._0;
      break _L;
    }
    return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(0);
  }
  let error;
  _L$2: {
    let result;
    _L$3: {
      let result$2;
      _L$4: {
        switch (_try_err.$tag) {
          case 2: {
            return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(2);
          }
          case 1: {
            return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(1);
          }
          case 0: {
            const _Signal = _try_err;
            const _result = _Signal._0;
            if (_M0MP211localreview3tcl10Completion12actual__code(_result) === 3) {
              result$2 = _result;
              break _L$4;
            } else {
              if (_M0MP211localreview3tcl10Completion12actual__code(_result) === 4) {
                result = _result;
                break _L$3;
              } else {
                error = _try_err;
                break _L$2;
              }
            }
          }
          default: {
            error = _try_err;
            break _L$2;
          }
        }
      }
      return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(2);
    }
    return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(1);
  }
  return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE3Err(error);
}
function _M0MP211localreview3tcl11Interpreter4math(self, source, depth) {
  let _tmp;
  const _bind$2 = _M0MP211localreview3tcl11Interpreter17expression__value(self, source, depth);
  let _tmp$2;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    _tmp$2 = _ok._0;
  } else {
    return _bind$2;
  }
  const _bind$3 = _M0FP211localreview3tcl7boolean(_tmp$2);
  let _tmp$3;
  if (_bind$3.$tag === 1) {
    const _ok = _bind$3;
    _tmp$3 = _ok._0;
  } else {
    return _bind$3;
  }
  if (_tmp$3) {
    _tmp = 1;
  } else {
    _tmp = 0;
  }
  return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(_tmp);
}
function _M0MP211localreview3tcl11Interpreter17expression__value(self, source, depth) {
  const _bind$2 = _M0MP211localreview3tcl11Interpreter18cached__expression(self, source);
  let expr;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    expr = _ok._0;
  } else {
    return _bind$2;
  }
  const _bind$3 = _M0MP211localreview3tcl11Interpreter10eval__expr(self, expr, depth + 1 | 0);
  let value;
  if (_bind$3.$tag === 1) {
    const _ok = _bind$3;
    value = _ok._0;
  } else {
    return _bind$3;
  }
  let n;
  _L: {
    const _bind$4 = _M0FP211localreview3tcl6number(value);
    if (_bind$4 === undefined) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(value);
    } else {
      const _Some = _bind$4;
      const _n = _Some;
      n = _n;
      break _L;
    }
  }
  return _M0MP211localreview3tcl6Number4text(n);
}
function _M0MP211localreview3tcl11Interpreter10eval__expr(self, expr, depth) {
  let _tmp = self;
  let _tmp$2 = expr;
  let _tmp$3 = depth;
  _L: while (true) {
    const self$2 = _tmp;
    const expr$2 = _tmp$2;
    const depth$2 = _tmp$3;
    const _bind$2 = _M0MP211localreview3tcl11Interpreter4tick(self$2);
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _ok._0;
    } else {
      return _bind$2;
    }
    if (depth$2 > 64) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expression evaluation depth"));
    }
    let name;
    let args;
    _L$2: {
      let a;
      let op;
      let b;
      _L$3: {
        let op$2;
        let value;
        _L$4: {
          let yes;
          let condition;
          let no;
          _L$5: {
            let parts;
            _L$6: {
              let value$2;
              _L$7: {
                switch (expr$2.$tag) {
                  case 0: {
                    const _Value = expr$2;
                    const _value = _Value._0;
                    value$2 = _value;
                    break _L$7;
                  }
                  case 1: {
                    const _Substitute = expr$2;
                    const _parts = _Substitute._0;
                    parts = _parts;
                    break _L$6;
                  }
                  case 4: {
                    const _Conditional = expr$2;
                    const _condition = _Conditional._0;
                    const _yes = _Conditional._1;
                    const _no = _Conditional._2;
                    yes = _yes;
                    condition = _condition;
                    no = _no;
                    break _L$5;
                  }
                  case 2: {
                    const _Unary = expr$2;
                    const _op = _Unary._0;
                    const _value$2 = _Unary._1;
                    op$2 = _op;
                    value = _value$2;
                    break _L$4;
                  }
                  case 3: {
                    const _Binary = expr$2;
                    const _op$2 = _Binary._0;
                    const _a = _Binary._1;
                    const _b = _Binary._2;
                    a = _a;
                    op = _op$2;
                    b = _b;
                    break _L$3;
                  }
                  default: {
                    const _Function = expr$2;
                    const _name = _Function._0;
                    const _args = _Function._1;
                    name = _name;
                    args = _args;
                    break _L$2;
                  }
                }
              }
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(value$2);
            }
            return _M0MP211localreview3tcl11Interpreter13expand__parts(self$2, parts, depth$2 + 1 | 0);
          }
          const _bind$3 = _M0MP211localreview3tcl11Interpreter10eval__expr(self$2, condition, depth$2 + 1 | 0);
          let _tmp$4;
          if (_bind$3.$tag === 1) {
            const _ok = _bind$3;
            _tmp$4 = _ok._0;
          } else {
            return _bind$3;
          }
          const _bind$4 = _M0FP211localreview3tcl7boolean(_tmp$4);
          let _tmp$5;
          if (_bind$4.$tag === 1) {
            const _ok = _bind$4;
            _tmp$5 = _ok._0;
          } else {
            return _bind$4;
          }
          if (_tmp$5) {
            _tmp$2 = yes;
          } else {
            _tmp$2 = no;
          }
          _tmp$3 = depth$2 + 1 | 0;
          continue;
        }
        const _bind$3 = _M0MP211localreview3tcl11Interpreter10eval__expr(self$2, value, depth$2 + 1 | 0);
        let v;
        if (_bind$3.$tag === 1) {
          const _ok = _bind$3;
          v = _ok._0;
        } else {
          return _bind$3;
        }
        if (op$2 === "!") {
          const _bind$4 = _M0FP211localreview3tcl7boolean(v);
          let _tmp$4;
          if (_bind$4.$tag === 1) {
            const _ok = _bind$4;
            _tmp$4 = _ok._0;
          } else {
            return _bind$4;
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(!_tmp$4));
        }
        if (op$2 === "~") {
          const _bind$4 = _M0FP211localreview3tcl5whole(v);
          let _tmp$4;
          if (_bind$4.$tag === 1) {
            const _ok = _bind$4;
            _tmp$4 = _ok._0;
          } else {
            return _bind$4;
          }
          const _bind$5 = _M0MP211localreview3tcl6Number4text(new _M0DTP211localreview3tcl6Number5Whole(_M0IPC16bigint6BigIntPB3Sub3sub(_M0IPC16bigint6BigIntPB3Neg3neg(_tmp$4), 1n)));
          let _tmp$5;
          if (_bind$5.$tag === 1) {
            const _ok = _bind$5;
            _tmp$5 = _ok._0;
          } else {
            return _bind$5;
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp$5);
        }
        let n;
        const _bind$4 = _M0FP211localreview3tcl6number(v);
        if (_bind$4 === undefined) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expected numeric operand"));
        } else {
          const _Some = _bind$4;
          const _n = _Some;
          n = _n;
        }
        let x;
        _L$5: {
          let x$2;
          _L$6: {
            let x$3;
            _L$7: {
              switch (n.$tag) {
                case 0: {
                  const _Small = n;
                  const _x = _Small._0;
                  x$3 = _x;
                  break _L$7;
                }
                case 1: {
                  const _Whole = n;
                  const _x$2 = _Whole._0;
                  x$2 = _x$2;
                  break _L$6;
                }
                default: {
                  const _Real = n;
                  const _x$3 = _Real._0;
                  x = _x$3;
                  break _L$5;
                }
              }
            }
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC13int3Int18to__string_2einner(op$2 === "-" ? -x$3 | 0 : x$3, 10));
          }
          return _M0MP211localreview3tcl6Number4text(new _M0DTP211localreview3tcl6Number5Whole(op$2 === "-" ? _M0IPC16bigint6BigIntPB3Neg3neg(x$2) : x$2));
        }
        return _M0MP211localreview3tcl6Number4text(new _M0DTP211localreview3tcl6Number4Real(op$2 === "-" ? -x : x));
      }
      const _bind$3 = _M0MP211localreview3tcl11Interpreter10eval__expr(self$2, a, depth$2 + 1 | 0);
      let left;
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        left = _ok._0;
      } else {
        return _bind$3;
      }
      if (op === "&&") {
        let _tmp$4;
        const _bind$4 = _M0FP211localreview3tcl7boolean(left);
        let _tmp$5;
        if (_bind$4.$tag === 1) {
          const _ok = _bind$4;
          _tmp$5 = _ok._0;
        } else {
          return _bind$4;
        }
        if (_tmp$5) {
          const _bind$5 = _M0MP211localreview3tcl11Interpreter10eval__expr(self$2, b, depth$2 + 1 | 0);
          let _tmp$6;
          if (_bind$5.$tag === 1) {
            const _ok = _bind$5;
            _tmp$6 = _ok._0;
          } else {
            return _bind$5;
          }
          const _bind$6 = _M0FP211localreview3tcl7boolean(_tmp$6);
          let _tmp$7;
          if (_bind$6.$tag === 1) {
            const _ok = _bind$6;
            _tmp$7 = _ok._0;
          } else {
            return _bind$6;
          }
          _tmp$4 = _tmp$7;
        } else {
          _tmp$4 = false;
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(_tmp$4));
      }
      if (op === "||") {
        let _tmp$4;
        const _bind$4 = _M0FP211localreview3tcl7boolean(left);
        let _tmp$5;
        if (_bind$4.$tag === 1) {
          const _ok = _bind$4;
          _tmp$5 = _ok._0;
        } else {
          return _bind$4;
        }
        if (_tmp$5) {
          _tmp$4 = true;
        } else {
          const _bind$5 = _M0MP211localreview3tcl11Interpreter10eval__expr(self$2, b, depth$2 + 1 | 0);
          let _tmp$6;
          if (_bind$5.$tag === 1) {
            const _ok = _bind$5;
            _tmp$6 = _ok._0;
          } else {
            return _bind$5;
          }
          const _bind$6 = _M0FP211localreview3tcl7boolean(_tmp$6);
          let _tmp$7;
          if (_bind$6.$tag === 1) {
            const _ok = _bind$6;
            _tmp$7 = _ok._0;
          } else {
            return _bind$6;
          }
          _tmp$4 = _tmp$7;
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(_tmp$4));
      }
      const _bind$4 = _M0MP211localreview3tcl11Interpreter10eval__expr(self$2, b, depth$2 + 1 | 0);
      let right;
      if (_bind$4.$tag === 1) {
        const _ok = _bind$4;
        right = _ok._0;
      } else {
        return _bind$4;
      }
      return op === "/" ? _M0FP211localreview3tcl15numeric__divide(left, right) : _M0FP211localreview3tcl15numeric__binary(op, left, right);
    }
    const _bind$3 = _M0MPC15array5Array3mapGRP211localreview3tcl4ExprsEHRP211localreview3tcl8TclError(args, (arg) => _M0MP211localreview3tcl11Interpreter10eval__expr(self$2, arg, depth$2 + 1 | 0));
    let values;
    if (_bind$3.$tag === 1) {
      const _ok = _bind$3;
      values = _ok._0;
    } else {
      return _bind$3;
    }
    return _M0MP211localreview3tcl11Interpreter14math__function(self$2, name, values, depth$2 + 1 | 0);
  }
}
function _M0MP211localreview3tcl11Interpreter13expand__parts(self, parts, depth) {
  if (depth > 64) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("substitution depth"));
  }
  const first = new _M0TPB8MutLocalGsE("");
  const out = new _M0TPB8MutLocalGORPB13StringBuilderE(undefined);
  const length = new _M0TPB8MutLocalGiE(0);
  const _bind$2 = parts.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const part = parts[_];
      const _bind$3 = _M0MP211localreview3tcl11Interpreter4tick(self);
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        _ok._0;
      } else {
        return _bind$3;
      }
      let value;
      let commands;
      _L: {
        _L$2: {
          let name;
          let index;
          _L$3: {
            _L$4: {
              switch (part.$tag) {
                case 0: {
                  const _Text = part;
                  const _text = _Text._0;
                  value = _text;
                  break;
                }
                case 1: {
                  const _Variable = part;
                  const _name = _Variable._0;
                  const _index = _Variable._1;
                  name = _name;
                  index = _index;
                  break _L$4;
                }
                default: {
                  const _Command = part;
                  const _commands = _Command._0;
                  commands = _commands;
                  break _L$2;
                }
              }
              break _L$3;
            }
            let name$2;
            let parts$2;
            _L$5: {
              _L$6: {
                if (index.$tag === 1) {
                  const _Some = index;
                  const _parts = _Some._0;
                  parts$2 = _parts;
                  break _L$6;
                } else {
                  name$2 = name;
                }
                break _L$5;
              }
              const _bind$4 = _M0MP211localreview3tcl11Interpreter13expand__parts(self, parts$2, depth + 1 | 0);
              let _tmp$2;
              if (_bind$4.$tag === 1) {
                const _ok = _bind$4;
                _tmp$2 = _ok._0;
              } else {
                return _bind$4;
              }
              name$2 = `${name}(${_tmp$2})`;
            }
            const _bind$4 = _M0MP211localreview3tcl11Interpreter9read__var(self, name$2);
            if (_bind$4.$tag === 1) {
              const _ok = _bind$4;
              value = _ok._0;
            } else {
              return _bind$4;
            }
          }
          break _L;
        }
        const _bind$4 = _M0MP211localreview3tcl11Interpreter25execute__commands_2einner(self, commands, depth + 1 | 0, false);
        if (_bind$4.$tag === 1) {
          const _ok = _bind$4;
          value = _ok._0;
        } else {
          return _bind$4;
        }
      }
      const previous = length.val;
      length.val = length.val + value.length | 0;
      if (length.val > 1000000) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("substitution result size limit"));
      }
      if (previous === 0) {
        first.val = value;
      } else {
        if (!_M0MPC16string6String9is__empty(value)) {
          let builder;
          _L$2: {
            _L$3: {
              const _bind$4 = out.val;
              if (_bind$4 === undefined) {
                const builder$2 = _M0MPB13StringBuilder21StringBuilder_2einner(0);
                _M0IPB13StringBuilderPB6Logger13write__string(builder$2, first.val);
                _M0IPB13StringBuilderPB6Logger13write__string(builder$2, value);
                out.val = builder$2;
              } else {
                const _Some = _bind$4;
                const _builder = _Some;
                builder = _builder;
                break _L$3;
              }
              break _L$2;
            }
            _M0IPB13StringBuilderPB6Logger13write__string(builder, value);
          }
        }
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  let builder;
  _L: {
    const _bind$3 = out.val;
    if (_bind$3 === undefined) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(first.val);
    } else {
      const _Some = _bind$3;
      const _builder = _Some;
      builder = _builder;
      break _L;
    }
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPB13StringBuilder10to__string(builder));
}
function _M0MP211localreview3tcl11Interpreter14math__function(self, name, args, depth) {
  let command;
  _L: {
    _L$2: {
      const _bind$2 = _M0MP211localreview3tcl11Interpreter13find__command(self, `tcl::mathfunc::${name}`);
      if (_bind$2 === undefined) {
      } else {
        const _Some = _bind$2;
        const _command = _Some;
        command = _command;
        break _L$2;
      }
      break _L;
    }
    const _bind$2 = _M0MP211localreview3tcl11Interpreter15command_2einner(self, _M0IPC15array5ArrayPB3Add3addGsE([command.name], args), depth, false);
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp);
  }
  if (name === "bool") {
    if (args.length !== 1) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("math function arity"));
    }
    const _bind$2 = _M0FP211localreview3tcl7boolean(_M0MPC15array5Array2atGRPB4JsonE(args, 0));
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(_tmp));
  }
  const _bind$2 = _M0MPC15array5Array3mapGsRP211localreview3tcl6NumberEHRP211localreview3tcl8TclError(args, (v) => {
    let n;
    _L$2: {
      const _bind$3 = _M0FP211localreview3tcl6number(v);
      if (_bind$3 === undefined) {
        return new _M0DTPC16result6ResultGRP211localreview3tcl6NumberRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("math function requires number"));
      } else {
        const _Some = _bind$3;
        const _n = _Some;
        n = _n;
        break _L$2;
      }
    }
    return new _M0DTPC16result6ResultGRP211localreview3tcl6NumberRP211localreview3tcl8TclErrorE2Ok(n);
  });
  let values;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    values = _ok._0;
  } else {
    return _bind$2;
  }
  if (name === "min" || name === "max") {
    if (_M0MPC15array5Array9is__emptyGRPB4JsonE(values)) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("math function arity"));
    }
    const best = new _M0TPB8MutLocalGsE(_M0MPC15array5Array2atGRPB4JsonE(args, 0));
    const _bind$3 = _M0MPC15array5Array12view_2einnerGsE(args, 1, undefined);
    const _bind$4 = _bind$3.end - _bind$3.start | 0;
    let _tmp = 0;
    while (true) {
      const _ = _tmp;
      if (_ < _bind$4) {
        const value = _bind$3.buf[_bind$3.start + _ | 0];
        const _bind$5 = _M0FP211localreview3tcl15numeric__binary(name === "min" ? "<" : ">", value, best.val);
        let _tmp$2;
        if (_bind$5.$tag === 1) {
          const _ok = _bind$5;
          _tmp$2 = _ok._0;
        } else {
          return _bind$5;
        }
        if (_tmp$2 === "1") {
          best.val = value;
        }
        _tmp = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    let _tmp$2;
    let n;
    _L$2: {
      _L$3: {
        const _bind$5 = _M0FP211localreview3tcl6number(best.val);
        if (_bind$5 === undefined) {
          _tmp$2 = best.val;
        } else {
          const _Some = _bind$5;
          const _n = _Some;
          n = _n;
          break _L$3;
        }
        break _L$2;
      }
      const _bind$5 = _M0MP211localreview3tcl6Number4text(n);
      if (_bind$5.$tag === 1) {
        const _ok = _bind$5;
        _tmp$2 = _ok._0;
      } else {
        return _bind$5;
      }
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp$2);
  }
  const two = _M0MPC15array5Array8containsGsE(["pow", "atan2", "hypot", "fmod"], name);
  if (values.length !== (two ? 2 : 1)) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("math function arity"));
  }
  const x = _M0MP211localreview3tcl6Number6double(_M0MPC15array5Array2atGRPB4JsonE(values, 0));
  const y = two ? _M0MP211localreview3tcl6Number6double(_M0MPC15array5Array2atGRPB4JsonE(values, 1)) : 0;
  if (name === "abs") {
    let _tmp;
    let n;
    _L$2: {
      _L$3: {
        let n$2;
        _L$4: {
          _L$5: {
            let n$3;
            _L$6: {
              const _bind$3 = _M0MPC15array5Array2atGRPB4JsonE(values, 0);
              switch (_bind$3.$tag) {
                case 0: {
                  const _Small = _bind$3;
                  const _n = _Small._0;
                  n$3 = _n;
                  break _L$6;
                }
                case 1: {
                  const _Whole = _bind$3;
                  const _n$2 = _Whole._0;
                  n$2 = _n$2;
                  break _L$5;
                }
                default: {
                  const _Real = _bind$3;
                  const _n$3 = _Real._0;
                  n = _n$3;
                  break _L$3;
                }
              }
            }
            _tmp = _M0MPC13int3Int18to__string_2einner(_M0MPC13int3Int3abs(n$3), 10);
            break _L$4;
          }
          const _bind$3 = _M0MP211localreview3tcl6Number4text(new _M0DTP211localreview3tcl6Number5Whole(_M0IP016_24default__implPB7Compare6op__ltGRPC16bigint6BigIntE(n$2, 0n) ? _M0IPC16bigint6BigIntPB3Neg3neg(n$2) : n$2));
          if (_bind$3.$tag === 1) {
            const _ok = _bind$3;
            _tmp = _ok._0;
          } else {
            return _bind$3;
          }
        }
        break _L$2;
      }
      const _bind$3 = _M0MP211localreview3tcl6Number4text(new _M0DTP211localreview3tcl6Number4Real(Math.abs(n)));
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        _tmp = _ok._0;
      } else {
        return _bind$3;
      }
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp);
  }
  if (_M0MPC15array5Array8containsGsE(["int", "wide", "entier", "round"], name)) {
    let n;
    let n$2;
    _L$2: {
      _L$3: {
        const _bind$3 = _M0MPC15array5Array2atGRPB4JsonE(values, 0);
        switch (_bind$3.$tag) {
          case 0: {
            const _Small = _bind$3;
            const _n = _Small._0;
            n$2 = _n;
            break _L$3;
          }
          case 1: {
            const _Whole = _bind$3;
            const _n$2 = _Whole._0;
            n = _n$2;
            break;
          }
          default: {
            if (_M0MPC16double6Double7is__inf(x) || _M0MPC16double6Double7is__nan(x)) {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("cannot convert non-finite integer"));
            }
            const value = name === "round" ? (x < 0 ? -_M0MPC16double6Double5floor(Math.abs(x) + 0.5) : _M0MPC16double6Double5floor(x + 0.5)) : x < 0 ? _M0MPC16double6Double4ceil(x) : _M0MPC16double6Double5floor(x);
            const _bind$4 = _M0FP211localreview3tcl15double__integer(value);
            if (_bind$4.$tag === 1) {
              const _ok = _bind$4;
              n = _ok._0;
            } else {
              return _bind$4;
            }
          }
        }
        break _L$2;
      }
      n = _M0MPC16bigint6BigInt9from__int(n$2);
    }
    if (name === "int" || name === "wide") {
      const modulus = _M0IPC16bigint6BigIntPB3Shl3shl(1n, 64);
      const masked = _M0IPC16bigint6BigIntPB6BitAnd4land(n, _M0IPC16bigint6BigIntPB3Sub3sub(modulus, 1n));
      const _bind$3 = _M0MP211localreview3tcl6Number4text(new _M0DTP211localreview3tcl6Number5Whole(_M0IP016_24default__implPB7Compare6op__geGRPC16bigint6BigIntE(masked, _M0IPC16bigint6BigIntPB3Shl3shl(1n, 63)) ? _M0IPC16bigint6BigIntPB3Sub3sub(masked, modulus) : masked));
      let _tmp;
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        _tmp = _ok._0;
      } else {
        return _bind$3;
      }
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp);
    }
    const _bind$3 = _M0MP211localreview3tcl6Number4text(new _M0DTP211localreview3tcl6Number5Whole(n));
    let _tmp;
    if (_bind$3.$tag === 1) {
      const _ok = _bind$3;
      _tmp = _ok._0;
    } else {
      return _bind$3;
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp);
  }
  let value;
  switch (name) {
    case "double": {
      value = x;
      break;
    }
    case "ceil": {
      value = _M0MPC16double6Double4ceil(x);
      break;
    }
    case "floor": {
      value = _M0MPC16double6Double5floor(x);
      break;
    }
    case "sqrt": {
      value = Math.sqrt(x);
      break;
    }
    case "sin": {
      value = _M0FPC14math3sin(x);
      break;
    }
    case "cos": {
      value = _M0FPC14math3cos(x);
      break;
    }
    case "tan": {
      value = _M0FPC14math3tan(x);
      break;
    }
    case "asin": {
      value = _M0FPC14math4asin(x);
      break;
    }
    case "acos": {
      value = _M0FPC14math4acos(x);
      break;
    }
    case "atan": {
      value = _M0FPC14math4atan(x);
      break;
    }
    case "sinh": {
      value = _M0FPC14math4sinh(x);
      break;
    }
    case "cosh": {
      value = _M0FPC14math4cosh(x);
      break;
    }
    case "tanh": {
      value = _M0FPC14math4tanh(x);
      break;
    }
    case "exp": {
      value = _M0FPC14math3exp(x);
      break;
    }
    case "log": {
      value = _M0FPC14math2ln(x);
      break;
    }
    case "log10": {
      value = _M0FPC14math5log10(x);
      break;
    }
    case "pow": {
      value = _M0FPC14math3pow(x, y);
      break;
    }
    case "atan2": {
      value = _M0FPC14math5atan2(x, y);
      break;
    }
    case "hypot": {
      value = _M0FPC14math5hypot(x, y);
      break;
    }
    case "fmod": {
      value = x - y * (x / y < 0 ? _M0MPC16double6Double4ceil(x / y) : _M0MPC16double6Double5floor(x / y));
      break;
    }
    default: {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid(`unknown math function ${name}`));
    }
  }
  return _M0MP211localreview3tcl6Number4text(new _M0DTP211localreview3tcl6Number4Real(value));
}
function _M0MP211localreview3tcl11Interpreter12try__command(self, args, depth) {
  if (args.length < 2) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("try body required"));
  }
  const handlers = [];
  const finalizer = new _M0TPB8MutLocalGOsE(undefined);
  const index = new _M0TPB8MutLocalGiE(2);
  while (true) {
    if (index.val < args.length) {
      const kind = _M0MPC15array5Array2atGRPB4JsonE(args, index.val);
      if (kind === "finally") {
        if (index.val !== (args.length - 2 | 0)) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("finally must be last with one script"));
        }
        finalizer.val = _M0MPC15array5Array2atGRPB4JsonE(args, index.val + 1 | 0);
        break;
      }
      if (_M0IP016_24default__implPB2Eq10not__equalGsE(kind, "on") && _M0IP016_24default__implPB2Eq10not__equalGsE(kind, "trap") || (index.val + 3 | 0) >= args.length) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("invalid try handler"));
      }
      let code;
      if (kind === "on") {
        const _bind$2 = _M0FP211localreview3tcl16completion__code(_M0MPC15array5Array2atGRPB4JsonE(args, index.val + 1 | 0));
        if (_bind$2.$tag === 1) {
          const _ok = _bind$2;
          code = _ok._0;
        } else {
          return _bind$2;
        }
      } else {
        code = 1;
      }
      let pattern;
      if (kind === "trap") {
        const _bind$2 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, index.val + 1 | 0));
        let _tmp;
        if (_bind$2.$tag === 1) {
          const _ok = _bind$2;
          _tmp = _ok._0;
        } else {
          return _bind$2;
        }
        pattern = new _M0DTPC16option6OptionGRPB5ArrayGsEE4Some(_tmp);
      } else {
        pattern = _M0DTPC16option6OptionGRPB5ArrayGsEE4None__;
      }
      const _bind$2 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, index.val + 2 | 0));
      let variables;
      if (_bind$2.$tag === 1) {
        const _ok = _bind$2;
        variables = _ok._0;
      } else {
        return _bind$2;
      }
      _M0MPC15array5Array4pushGRPC14json10WriteFrameE(handlers, new _M0TP211localreview3tcl7Handler(code, pattern, variables, _M0MPC15array5Array2atGRPB4JsonE(args, index.val + 3 | 0)));
      index.val = index.val + 4 | 0;
      continue;
    } else {
      break;
    }
  }
  let handler;
  _L: {
    _L$2: {
      const _bind$2 = _M0MPC15array5Array4lastGRPC16string10StringViewE(handlers);
      if (_bind$2 === undefined) {
      } else {
        const _Some = _bind$2;
        const _handler = _Some;
        handler = _handler;
        break _L$2;
      }
      break _L;
    }
    if (handler.script === "-") {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("last try handler has no script"));
    }
  }
  const original = _M0MP211localreview3tcl11Interpreter7capture(self, _M0MPC15array5Array2atGRPB4JsonE(args, 1), depth + 1 | 0);
  const result = new _M0TPB8MutLocalGRP211localreview3tcl10CompletionE(original);
  let _try_err;
  _L$2: {
    _L$3: {
      const selected = new _M0TPB8MutLocalGiE(-1);
      const _bind$2 = 0;
      const _bind$3 = handlers.length;
      let _tmp = _bind$2;
      while (true) {
        const i = _tmp;
        if (i < _bind$3) {
          _L$4: {
            const handler$2 = _M0MPC15array5Array2atGRPB4JsonE(handlers, i);
            if (handler$2.code !== _M0MP211localreview3tcl10Completion12actual__code(original)) {
              break _L$4;
            }
            let matched;
            let pattern;
            _L$5: {
              _L$6: {
                const _bind$4 = handler$2.pattern;
                if (_bind$4.$tag === 0) {
                  matched = true;
                } else {
                  const _Some = _bind$4;
                  const _pattern = _Some._0;
                  pattern = _pattern;
                  break _L$6;
                }
                break _L$5;
              }
              const _bind$4 = _M0FP211localreview3tcl11parse__list(_M0MPC16option6Option10unwrap__orGsE(_M0FP211localreview3tcl11option__get(original.options, "-errorcode"), "NONE"));
              let code;
              if (_bind$4.$tag === 1) {
                const _ok = _bind$4;
                code = _ok._0;
              } else {
                const _err = _bind$4;
                _try_err = _err._0;
                break _L$3;
              }
              const matched$2 = new _M0TPB8MutLocalGbE(pattern.length <= code.length);
              if (matched$2.val) {
                const _bind$5 = 0;
                const _bind$6 = pattern.length;
                let _tmp$2 = _bind$5;
                while (true) {
                  const j = _tmp$2;
                  if (j < _bind$6) {
                    if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0MPC15array5Array2atGRPB4JsonE(pattern, j), _M0MPC15array5Array2atGRPB4JsonE(code, j))) {
                      matched$2.val = false;
                      break;
                    }
                    _tmp$2 = j + 1 | 0;
                    continue;
                  } else {
                    break;
                  }
                }
              }
              matched = matched$2.val;
            }
            if (matched) {
              selected.val = i;
              break;
            }
            break _L$4;
          }
          _tmp = i + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      if (selected.val >= 0) {
        while (true) {
          if (_M0MPC15array5Array2atGRPB4JsonE(handlers, selected.val).script === "-") {
            selected.val = selected.val + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        const handler$2 = _M0MPC15array5Array2atGRPB4JsonE(handlers, selected.val);
        if (handler$2.variables.length >= 1 && !_M0MPC16string6String9is__empty(_M0MPC15array5Array2atGRPB4JsonE(handler$2.variables, 0))) {
          const _bind$4 = _M0MP211localreview3tcl11Interpreter8set__var(self, _M0MPC15array5Array2atGRPB4JsonE(handler$2.variables, 0), original.value);
          if (_bind$4.$tag === 1) {
            const _ok = _bind$4;
            _ok._0;
          } else {
            const _err = _bind$4;
            _try_err = _err._0;
            break _L$3;
          }
        }
        if (handler$2.variables.length >= 2 && !_M0MPC16string6String9is__empty(_M0MPC15array5Array2atGRPB4JsonE(handler$2.variables, 1))) {
          const _tmp$2 = _M0MPC15array5Array2atGRPB4JsonE(handler$2.variables, 1);
          const _bind$4 = _M0MP211localreview3tcl10Completion12option__text(original);
          let _tmp$3;
          if (_bind$4.$tag === 1) {
            const _ok = _bind$4;
            _tmp$3 = _ok._0;
          } else {
            const _err = _bind$4;
            _try_err = _err._0;
            break _L$3;
          }
          const _bind$5 = _M0MP211localreview3tcl11Interpreter8set__var(self, _tmp$2, _tmp$3);
          if (_bind$5.$tag === 1) {
            const _ok = _bind$5;
            _ok._0;
          } else {
            const _err = _bind$5;
            _try_err = _err._0;
            break _L$3;
          }
        }
        result.val = _M0MP211localreview3tcl11Interpreter7capture(self, handler$2.script, depth + 1 | 0);
        if (_M0MP211localreview3tcl10Completion12actual__code(result.val) === 1) {
          const options = _M0MPC15array5Array4copyGUssEE(result.val.options);
          const _bind$4 = _M0MP211localreview3tcl10Completion12option__text(original);
          let _tmp$2;
          if (_bind$4.$tag === 1) {
            const _ok = _bind$4;
            _tmp$2 = _ok._0;
          } else {
            const _err = _bind$4;
            _try_err = _err._0;
            break _L$3;
          }
          _M0FP211localreview3tcl11option__set(options, "-during", _tmp$2);
          const _bind$5 = result.val;
          result.val = new _M0TP211localreview3tcl10Completion(_bind$5.code, _bind$5.level, _bind$5.value, options, _bind$5.skip_trace);
        }
      }
      break _L$2;
    }
    const error = _try_err;
    result.val = _M0FP211localreview3tcl7outcome(error);
    if (_M0MP211localreview3tcl10Completion12actual__code(result.val) === 1) {
      const options = _M0MPC15array5Array4copyGUssEE(result.val.options);
      const _bind$2 = _M0MP211localreview3tcl10Completion12option__text(original);
      let _tmp;
      if (_bind$2.$tag === 1) {
        const _ok = _bind$2;
        _tmp = _ok._0;
      } else {
        return _bind$2;
      }
      _M0FP211localreview3tcl11option__set(options, "-during", _tmp);
      const _bind$3 = result.val;
      result.val = new _M0TP211localreview3tcl10Completion(_bind$3.code, _bind$3.level, _bind$3.value, options, _bind$3.skip_trace);
    }
  }
  let script;
  _L$3: {
    _L$4: {
      const _bind$2 = finalizer.val;
      if (_bind$2 === undefined) {
      } else {
        const _Some = _bind$2;
        const _script = _Some;
        script = _script;
        break _L$4;
      }
      break _L$3;
    }
    const finished = _M0MP211localreview3tcl11Interpreter7capture(self, script, depth + 1 | 0);
    if (_M0MP211localreview3tcl10Completion12actual__code(finished) !== 0) {
      if (_M0MP211localreview3tcl10Completion12actual__code(finished) === 1) {
        const options = _M0MPC15array5Array4copyGUssEE(finished.options);
        const _bind$2 = _M0MP211localreview3tcl10Completion12option__text(result.val);
        let _tmp;
        if (_bind$2.$tag === 1) {
          const _ok = _bind$2;
          _tmp = _ok._0;
        } else {
          return _bind$2;
        }
        _M0FP211localreview3tcl11option__set(options, "-during", _tmp);
        result.val = new _M0TP211localreview3tcl10Completion(finished.code, finished.level, finished.value, options, finished.skip_trace);
      } else {
        result.val = finished;
      }
    }
  }
  return _M0MP211localreview3tcl11Interpreter9propagate(self, result.val);
}
function _M0MP211localreview3tcl11Interpreter21dict__command_2einner(self, args, depth, discard_result, object_path) {
  const n = args.length;
  if (n < 2) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict arity"));
  }
  if (object_path && (_M0MPC15array5Array2atGRPB4JsonE(args, 1) === "set" && n === 5 || (_M0MPC15array5Array2atGRPB4JsonE(args, 1) === "incr" && (n === 4 || n === 5) || _M0MPC15array5Array8containsGsE(["append", "lappend"], _M0MPC15array5Array2atGRPB4JsonE(args, 1)) && n >= 4))) {
    const _bind$2 = _M0MP211localreview3tcl11Interpreter18update__dictionary(self, args, depth, discard_result);
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp);
  }
  _L: {
    _L$2: {
      _L$3: {
        _L$4: {
          _L$5: {
            const _bind$2 = _M0MPC15array5Array2atGRPB4JsonE(args, 1);
            switch (_bind$2) {
              case "create": {
                const _bind$3 = _M0FP211localreview3tcl12format__list(_M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 2, undefined)));
                let _tmp;
                if (_bind$3.$tag === 1) {
                  const _ok = _bind$3;
                  _tmp = _ok._0;
                } else {
                  return _bind$3;
                }
                const _bind$4 = _M0FP211localreview3tcl10dictionary(_tmp);
                let _tmp$2;
                if (_bind$4.$tag === 1) {
                  const _ok = _bind$4;
                  _tmp$2 = _ok._0;
                } else {
                  return _bind$4;
                }
                return _M0FP211localreview3tcl16dictionary__text(_tmp$2);
              }
              case "get": {
                if (n < 3) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict get arity"));
                }
                if (n === 3) {
                  const _bind$5 = _M0FP211localreview3tcl10dictionary(_M0MPC15array5Array2atGRPB4JsonE(args, 2));
                  let _tmp$3;
                  if (_bind$5.$tag === 1) {
                    const _ok = _bind$5;
                    _tmp$3 = _ok._0;
                  } else {
                    return _bind$5;
                  }
                  return _M0FP211localreview3tcl16dictionary__text(_tmp$3);
                } else {
                  return _M0FP211localreview3tcl15dictionary__get(_M0MPC15array5Array2atGRPB4JsonE(args, 2), _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 3, undefined)));
                }
              }
              case "exists": {
                if (n < 4) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict exists arity"));
                }
                const _bind$5 = _M0FP211localreview3tcl10dictionary(_M0MPC15array5Array2atGRPB4JsonE(args, 2));
                if (_bind$5.$tag === 1) {
                  const _ok = _bind$5;
                  _ok._0;
                } else {
                  return _bind$5;
                }
                let _tmp$3;
                let _try_err;
                _L$6: {
                  _L$7: {
                    const _bind$6 = _M0FP211localreview3tcl15dictionary__get(_M0MPC15array5Array2atGRPB4JsonE(args, 2), _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 3, undefined)));
                    if (_bind$6.$tag === 1) {
                      const _ok = _bind$6;
                      _ok._0;
                    } else {
                      const _err = _bind$6;
                      _try_err = _err._0;
                      break _L$7;
                    }
                    _tmp$3 = true;
                    break _L$6;
                  }
                  _tmp$3 = false;
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0FP211localreview3tcl13boolean__text(_tmp$3));
              }
              case "size": {
                if (n !== 3) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict size arity"));
                }
                const _bind$6 = _M0FP211localreview3tcl10dictionary(_M0MPC15array5Array2atGRPB4JsonE(args, 2));
                let _tmp$4;
                if (_bind$6.$tag === 1) {
                  const _ok = _bind$6;
                  _tmp$4 = _ok._0;
                } else {
                  return _bind$6;
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_M0MPC13int3Int18to__string_2einner(_tmp$4.length, 10));
              }
              case "keys": {
                break _L$5;
              }
              case "values": {
                break _L$5;
              }
              case "merge": {
                const result = new _M0TPB8MutLocalGsE("");
                const _bind$7 = _M0MPC15array5Array12view_2einnerGsE(args, 2, undefined);
                const _bind$8 = _bind$7.end - _bind$7.start | 0;
                let _tmp$5 = 0;
                while (true) {
                  const _ = _tmp$5;
                  if (_ < _bind$8) {
                    const value = _bind$7.buf[_bind$7.start + _ | 0];
                    const _bind$9 = _M0FP211localreview3tcl10dictionary(value);
                    let _bind$10;
                    if (_bind$9.$tag === 1) {
                      const _ok = _bind$9;
                      _bind$10 = _ok._0;
                    } else {
                      return _bind$9;
                    }
                    const _bind$11 = _bind$10.length;
                    let _tmp$6 = 0;
                    while (true) {
                      const _$2 = _tmp$6;
                      if (_$2 < _bind$11) {
                        const _foreach_element = _bind$10[_$2];
                        let key;
                        let value$2;
                        _L$7: {
                          const _key = _foreach_element._0;
                          const _value = _foreach_element._1;
                          key = _key;
                          value$2 = _value;
                          break _L$7;
                        }
                        const _bind$12 = _M0FP211localreview3tcl16dictionary__edit(result.val, [key], value$2, 0);
                        let _tmp$7;
                        if (_bind$12.$tag === 1) {
                          const _ok = _bind$12;
                          _tmp$7 = _ok._0;
                        } else {
                          return _bind$12;
                        }
                        result.val = _tmp$7;
                        _tmp$6 = _$2 + 1 | 0;
                        continue;
                      } else {
                        break;
                      }
                    }
                    _tmp$5 = _ + 1 | 0;
                    continue;
                  } else {
                    break;
                  }
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(result.val);
              }
              case "replace": {
                break _L$4;
              }
              case "remove": {
                break _L$4;
              }
              case "set": {
                break _L$3;
              }
              case "unset": {
                break _L$3;
              }
              case "incr": {
                break _L$2;
              }
              case "append": {
                break _L$2;
              }
              case "lappend": {
                break _L$2;
              }
              case "for": {
                break _L;
              }
              case "map": {
                break _L;
              }
              case "filter": {
                if (n < 5) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict filter arity"));
                }
                const result$2 = [];
                const _bind$9 = _M0FP211localreview3tcl10dictionary(_M0MPC15array5Array2atGRPB4JsonE(args, 2));
                let _bind$10;
                if (_bind$9.$tag === 1) {
                  const _ok = _bind$9;
                  _bind$10 = _ok._0;
                } else {
                  return _bind$9;
                }
                const _bind$11 = _bind$10.length;
                let _tmp$6 = 0;
                _L$7: while (true) {
                  const _ = _tmp$6;
                  if (_ < _bind$11) {
                    const _foreach_element = _bind$10[_];
                    let key;
                    let value;
                    _L$8: {
                      const _key = _foreach_element._0;
                      const _value = _foreach_element._1;
                      key = _key;
                      value = _value;
                      break _L$8;
                    }
                    _L$9: {
                      const _bind$12 = _M0MP211localreview3tcl11Interpreter4tick(self);
                      if (_bind$12.$tag === 1) {
                        const _ok = _bind$12;
                        _ok._0;
                      } else {
                        return _bind$12;
                      }
                      let keep;
                      if (_M0MPC15array5Array2atGRPB4JsonE(args, 3) === "key" || _M0MPC15array5Array2atGRPB4JsonE(args, 3) === "value") {
                        const item = _M0MPC15array5Array2atGRPB4JsonE(args, 3) === "key" ? key : value;
                        const matched = new _M0TPB8MutLocalGbE(false);
                        const _bind$13 = _M0MPC15array5Array12view_2einnerGsE(args, 4, undefined);
                        const _bind$14 = _bind$13.end - _bind$13.start | 0;
                        let _tmp$7 = 0;
                        while (true) {
                          const _$2 = _tmp$7;
                          if (_$2 < _bind$14) {
                            const pattern = _bind$13.buf[_bind$13.start + _$2 | 0];
                            const _bind$15 = _M0FP211localreview3tcl11glob__match(pattern, item, false);
                            let _tmp$8;
                            if (_bind$15.$tag === 1) {
                              const _ok = _bind$15;
                              _tmp$8 = _ok._0;
                            } else {
                              return _bind$15;
                            }
                            if (_tmp$8) {
                              matched.val = true;
                              break;
                            }
                            _tmp$7 = _$2 + 1 | 0;
                            continue;
                          } else {
                            break;
                          }
                        }
                        keep = matched.val;
                      } else {
                        if (_M0MPC15array5Array2atGRPB4JsonE(args, 3) === "script" && n === 6) {
                          const _bind$13 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, 4));
                          let names;
                          if (_bind$13.$tag === 1) {
                            const _ok = _bind$13;
                            names = _ok._0;
                          } else {
                            return _bind$13;
                          }
                          if (names.length !== 2) {
                            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict filter variable list"));
                          }
                          const _bind$14 = _M0MP211localreview3tcl11Interpreter8set__var(self, _M0MPC15array5Array2atGRPB4JsonE(names, 0), key);
                          if (_bind$14.$tag === 1) {
                            const _ok = _bind$14;
                            _ok._0;
                          } else {
                            return _bind$14;
                          }
                          const _bind$15 = _M0MP211localreview3tcl11Interpreter8set__var(self, _M0MPC15array5Array2atGRPB4JsonE(names, 1), value);
                          if (_bind$15.$tag === 1) {
                            const _ok = _bind$15;
                            _ok._0;
                          } else {
                            return _bind$15;
                          }
                          let _try_err$2;
                          _L$10: {
                            _L$11: {
                              const _bind$16 = _M0MP211localreview3tcl11Interpreter15execute_2einner(self, _M0MPC15array5Array2atGRPB4JsonE(args, 5), depth + 1 | 0, false);
                              let _tmp$7;
                              if (_bind$16.$tag === 1) {
                                const _ok = _bind$16;
                                _tmp$7 = _ok._0;
                              } else {
                                const _err = _bind$16;
                                _try_err$2 = _err._0;
                                break _L$11;
                              }
                              const _bind$17 = _M0FP211localreview3tcl7boolean(_tmp$7);
                              if (_bind$17.$tag === 1) {
                                const _ok = _bind$17;
                                keep = _ok._0;
                              } else {
                                const _err = _bind$17;
                                _try_err$2 = _err._0;
                                break _L$11;
                              }
                              break _L$10;
                            }
                            let error;
                            _L$12: {
                              let result$3;
                              _L$13: {
                                let result$4;
                                _L$14: {
                                  switch (_try_err$2.$tag) {
                                    case 1: {
                                      break _L$9;
                                    }
                                    case 2: {
                                      break _L$7;
                                    }
                                    case 0: {
                                      const _Signal = _try_err$2;
                                      const _result = _Signal._0;
                                      if (_M0MP211localreview3tcl10Completion12actual__code(_result) === 4) {
                                        result$4 = _result;
                                        break _L$14;
                                      } else {
                                        if (_M0MP211localreview3tcl10Completion12actual__code(_result) === 3) {
                                          result$3 = _result;
                                          break _L$13;
                                        } else {
                                          error = _try_err$2;
                                          break _L$12;
                                        }
                                      }
                                    }
                                    default: {
                                      error = _try_err$2;
                                      break _L$12;
                                    }
                                  }
                                }
                                break _L$9;
                              }
                              break;
                            }
                            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(error);
                          }
                        } else {
                          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict filter mode"));
                        }
                      }
                      if (keep) {
                        _M0MPC15array5Array4pushGRPC14json10WriteFrameE(result$2, { _0: key, _1: value });
                      }
                      break _L$9;
                    }
                    _tmp$6 = _ + 1 | 0;
                    continue;
                  } else {
                    break;
                  }
                }
                return _M0FP211localreview3tcl16dictionary__text(result$2);
              }
              case "update": {
                let _tmp$7;
                if (n < 6) {
                  _tmp$7 = true;
                } else {
                  if (2 === 0) {
                    $panic();
                  }
                  _tmp$7 = (n % 2 | 0) !== 0;
                }
                if (_tmp$7) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict update arity"));
                }
                const _bind$12 = _M0MP211localreview3tcl11Interpreter9read__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2));
                let original;
                if (_bind$12.$tag === 1) {
                  const _ok = _bind$12;
                  original = _ok._0;
                } else {
                  return _bind$12;
                }
                const _bind$13 = _M0FP211localreview3tcl10dictionary(original);
                if (_bind$13.$tag === 1) {
                  const _ok = _bind$13;
                  _ok._0;
                } else {
                  return _bind$13;
                }
                const i = new _M0TPB8MutLocalGiE(3);
                while (true) {
                  if (i.val < (n - 1 | 0)) {
                    let value;
                    _L$8: {
                      _L$9: {
                        let _bind$14;
                        let _try_err$2;
                        _L$10: {
                          _L$11: {
                            const _bind$15 = _M0FP211localreview3tcl15dictionary__get(original, [_M0MPC15array5Array2atGRPB4JsonE(args, i.val)]);
                            if (_bind$15.$tag === 1) {
                              const _ok = _bind$15;
                              _bind$14 = _ok._0;
                            } else {
                              const _err = _bind$15;
                              _try_err$2 = _err._0;
                              break _L$11;
                            }
                            break _L$10;
                          }
                          _bind$14 = undefined;
                        }
                        if (_bind$14 === undefined) {
                          const _bind$15 = _M0MP211localreview3tcl11Interpreter10unset__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, i.val + 1 | 0), true);
                          if (_bind$15.$tag === 1) {
                            const _ok = _bind$15;
                            _ok._0;
                          } else {
                            return _bind$15;
                          }
                        } else {
                          const _Some = _bind$14;
                          const _value = _Some;
                          value = _value;
                          break _L$9;
                        }
                        break _L$8;
                      }
                      const _bind$14 = _M0MP211localreview3tcl11Interpreter8set__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, i.val + 1 | 0), value);
                      if (_bind$14.$tag === 1) {
                        const _ok = _bind$14;
                        _ok._0;
                      } else {
                        return _bind$14;
                      }
                    }
                    i.val = i.val + 2 | 0;
                    continue;
                  } else {
                    break;
                  }
                }
                const _defer = () => {
                  let current;
                  _L$8: {
                    const _bind$14 = _M0MP211localreview3tcl11Interpreter8get__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2));
                    let _bind$15;
                    if (_bind$14.$tag === 1) {
                      const _ok = _bind$14;
                      _bind$15 = _ok._0;
                    } else {
                      return _bind$14;
                    }
                    if (_bind$15 === undefined) {
                      return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
                    } else {
                      const _Some = _bind$15;
                      const _current = _Some;
                      current = _current;
                      break _L$8;
                    }
                  }
                  const updated = new _M0TPB8MutLocalGsE(current);
                  const i$2 = new _M0TPB8MutLocalGiE(3);
                  while (true) {
                    if (i$2.val < (n - 1 | 0)) {
                      const _tmp$8 = updated.val;
                      const _tmp$9 = [_M0MPC15array5Array2atGRPB4JsonE(args, i$2.val)];
                      const _bind$14 = _M0MP211localreview3tcl11Interpreter8get__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, i$2.val + 1 | 0));
                      let _tmp$10;
                      if (_bind$14.$tag === 1) {
                        const _ok = _bind$14;
                        _tmp$10 = _ok._0;
                      } else {
                        return _bind$14;
                      }
                      const _bind$15 = _M0FP211localreview3tcl16dictionary__edit(_tmp$8, _tmp$9, _tmp$10, 0);
                      let _tmp$11;
                      if (_bind$15.$tag === 1) {
                        const _ok = _bind$15;
                        _tmp$11 = _ok._0;
                      } else {
                        return _bind$15;
                      }
                      updated.val = _tmp$11;
                      i$2.val = i$2.val + 2 | 0;
                      continue;
                    } else {
                      break;
                    }
                  }
                  return _M0MP211localreview3tcl11Interpreter8set__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2), updated.val);
                };
                let _err;
                _L$8: {
                  const _bind$14 = _M0MP211localreview3tcl11Interpreter15execute_2einner(self, _M0MPC15array5Array2atGRPB4JsonE(args, n - 1 | 0), depth + 1 | 0, false);
                  let _defer_result;
                  if (_bind$14.$tag === 1) {
                    const _ok = _bind$14;
                    _defer_result = _ok._0;
                  } else {
                    const _err$2 = _bind$14;
                    _err = _err$2._0;
                    break _L$8;
                  }
                  const _bind$15 = _defer();
                  if (_bind$15.$tag === 1) {
                    const _ok = _bind$15;
                    _ok._0;
                  } else {
                    return _bind$15;
                  }
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_defer_result);
                }
                const _bind$14 = _defer();
                if (_bind$14.$tag === 1) {
                  const _ok = _bind$14;
                  _ok._0;
                } else {
                  return _bind$14;
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(_err);
              }
              case "with": {
                if (n < 4) {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict with arity"));
                }
                const _bind$15 = _M0MP211localreview3tcl11Interpreter9read__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2));
                let original$2;
                if (_bind$15.$tag === 1) {
                  const _ok = _bind$15;
                  original$2 = _ok._0;
                } else {
                  return _bind$15;
                }
                const keys = _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 3, n - 1 | 0));
                const _bind$16 = _M0FP211localreview3tcl15dictionary__get(original$2, keys);
                let selected;
                if (_bind$16.$tag === 1) {
                  const _ok = _bind$16;
                  selected = _ok._0;
                } else {
                  return _bind$16;
                }
                const _bind$17 = _M0FP211localreview3tcl10dictionary(selected);
                let pairs;
                if (_bind$17.$tag === 1) {
                  const _ok = _bind$17;
                  pairs = _ok._0;
                } else {
                  return _bind$17;
                }
                const _bind$18 = pairs.length;
                let _tmp$8 = 0;
                while (true) {
                  const _ = _tmp$8;
                  if (_ < _bind$18) {
                    const _foreach_element = pairs[_];
                    let key;
                    let value;
                    _L$9: {
                      const _key = _foreach_element._0;
                      const _value = _foreach_element._1;
                      key = _key;
                      value = _value;
                      break _L$9;
                    }
                    const _bind$19 = _M0MP211localreview3tcl11Interpreter8set__var(self, key, value);
                    if (_bind$19.$tag === 1) {
                      const _ok = _bind$19;
                      _ok._0;
                    } else {
                      return _bind$19;
                    }
                    _tmp$8 = _ + 1 | 0;
                    continue;
                  } else {
                    break;
                  }
                }
                const _defer$2 = () => {
                  let current;
                  _L$9: {
                    const _bind$19 = _M0MP211localreview3tcl11Interpreter8get__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2));
                    let _bind$20;
                    if (_bind$19.$tag === 1) {
                      const _ok = _bind$19;
                      _bind$20 = _ok._0;
                    } else {
                      return _bind$19;
                    }
                    if (_bind$20 === undefined) {
                      return new _M0DTPC16result6ResultGuRP211localreview3tcl8TclErrorE2Ok(undefined);
                    } else {
                      const _Some = _bind$20;
                      const _current = _Some;
                      current = _current;
                      break _L$9;
                    }
                  }
                  const _bind$19 = _M0FP211localreview3tcl15dictionary__get(current, keys);
                  let _tmp$9;
                  if (_bind$19.$tag === 1) {
                    const _ok = _bind$19;
                    _tmp$9 = _ok._0;
                  } else {
                    return _bind$19;
                  }
                  const updated = new _M0TPB8MutLocalGsE(_tmp$9);
                  const _bind$20 = pairs.length;
                  let _tmp$10 = 0;
                  while (true) {
                    const _ = _tmp$10;
                    if (_ < _bind$20) {
                      const _foreach_element = pairs[_];
                      let key;
                      _L$10: {
                        const _key = _foreach_element._0;
                        key = _key;
                        break _L$10;
                      }
                      const _tmp$11 = updated.val;
                      const _tmp$12 = [key];
                      const _bind$21 = _M0MP211localreview3tcl11Interpreter8get__var(self, key);
                      let _tmp$13;
                      if (_bind$21.$tag === 1) {
                        const _ok = _bind$21;
                        _tmp$13 = _ok._0;
                      } else {
                        return _bind$21;
                      }
                      const _bind$22 = _M0FP211localreview3tcl16dictionary__edit(_tmp$11, _tmp$12, _tmp$13, 0);
                      let _tmp$14;
                      if (_bind$22.$tag === 1) {
                        const _ok = _bind$22;
                        _tmp$14 = _ok._0;
                      } else {
                        return _bind$22;
                      }
                      updated.val = _tmp$14;
                      _tmp$10 = _ + 1 | 0;
                      continue;
                    } else {
                      break;
                    }
                  }
                  const _tmp$11 = _M0MPC15array5Array2atGRPB4JsonE(args, 2);
                  let _tmp$12;
                  if (_M0MPC15array5Array9is__emptyGRPB4JsonE(keys)) {
                    _tmp$12 = updated.val;
                  } else {
                    const _bind$21 = _M0FP211localreview3tcl16dictionary__edit(current, keys, updated.val, 0);
                    if (_bind$21.$tag === 1) {
                      const _ok = _bind$21;
                      _tmp$12 = _ok._0;
                    } else {
                      return _bind$21;
                    }
                  }
                  return _M0MP211localreview3tcl11Interpreter8set__var(self, _tmp$11, _tmp$12);
                };
                let _err$2;
                _L$9: {
                  const _bind$19 = _M0MP211localreview3tcl11Interpreter15execute_2einner(self, _M0MPC15array5Array2atGRPB4JsonE(args, n - 1 | 0), depth + 1 | 0, false);
                  let _defer_result;
                  if (_bind$19.$tag === 1) {
                    const _ok = _bind$19;
                    _defer_result = _ok._0;
                  } else {
                    const _err$3 = _bind$19;
                    _err$2 = _err$3._0;
                    break _L$9;
                  }
                  const _bind$20 = _defer$2();
                  if (_bind$20.$tag === 1) {
                    const _ok = _bind$20;
                    _ok._0;
                  } else {
                    return _bind$20;
                  }
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_defer_result);
                }
                const _bind$19 = _defer$2();
                if (_bind$19.$tag === 1) {
                  const _ok = _bind$19;
                  _ok._0;
                } else {
                  return _bind$19;
                }
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(_err$2);
              }
              default: {
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported dict subcommand"));
              }
            }
          }
          if (n !== 3 && n !== 4) {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict keys/values arity"));
          }
          const result = [];
          const _bind$2 = _M0FP211localreview3tcl10dictionary(_M0MPC15array5Array2atGRPB4JsonE(args, 2));
          let _bind$3;
          if (_bind$2.$tag === 1) {
            const _ok = _bind$2;
            _bind$3 = _ok._0;
          } else {
            return _bind$2;
          }
          const _bind$4 = _bind$3.length;
          let _tmp = 0;
          while (true) {
            const _ = _tmp;
            if (_ < _bind$4) {
              const _foreach_element = _bind$3[_];
              let key;
              let value;
              _L$6: {
                const _key = _foreach_element._0;
                const _value = _foreach_element._1;
                key = _key;
                value = _value;
                break _L$6;
              }
              const item = _M0MPC15array5Array2atGRPB4JsonE(args, 1) === "keys" ? key : value;
              let _tmp$2;
              if (n === 3) {
                _tmp$2 = true;
              } else {
                const _bind$5 = _M0FP211localreview3tcl11glob__match(_M0MPC15array5Array2atGRPB4JsonE(args, 3), item, false);
                let _tmp$3;
                if (_bind$5.$tag === 1) {
                  const _ok = _bind$5;
                  _tmp$3 = _ok._0;
                } else {
                  return _bind$5;
                }
                _tmp$2 = _tmp$3;
              }
              if (_tmp$2) {
                _M0MPC15array5Array4pushGRPC14json10WriteFrameE(result, item);
              }
              _tmp = _ + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          return _M0FP211localreview3tcl12format__list(result);
        }
        if (n < 3) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict replace/remove arity"));
        }
        const _bind$2 = _M0FP211localreview3tcl10dictionary(_M0MPC15array5Array2atGRPB4JsonE(args, 2));
        let _tmp;
        if (_bind$2.$tag === 1) {
          const _ok = _bind$2;
          _tmp = _ok._0;
        } else {
          return _bind$2;
        }
        const _bind$3 = _M0FP211localreview3tcl16dictionary__text(_tmp);
        let _tmp$2;
        if (_bind$3.$tag === 1) {
          const _ok = _bind$3;
          _tmp$2 = _ok._0;
        } else {
          return _bind$3;
        }
        const result = new _M0TPB8MutLocalGsE(_tmp$2);
        if (_M0MPC15array5Array2atGRPB4JsonE(args, 1) === "replace") {
          if (2 === 0) {
            $panic();
          }
          if (((n - 3 | 0) % 2 | 0) !== 0) {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict replace expects pairs"));
          }
          const i = new _M0TPB8MutLocalGiE(3);
          while (true) {
            if (i.val < n) {
              const _bind$4 = _M0FP211localreview3tcl16dictionary__edit(result.val, [_M0MPC15array5Array2atGRPB4JsonE(args, i.val)], _M0MPC15array5Array2atGRPB4JsonE(args, i.val + 1 | 0), 0);
              let _tmp$3;
              if (_bind$4.$tag === 1) {
                const _ok = _bind$4;
                _tmp$3 = _ok._0;
              } else {
                return _bind$4;
              }
              result.val = _tmp$3;
              i.val = i.val + 2 | 0;
              continue;
            } else {
              break;
            }
          }
        } else {
          const _bind$4 = _M0MPC15array5Array12view_2einnerGsE(args, 3, undefined);
          const _bind$5 = _bind$4.end - _bind$4.start | 0;
          let _tmp$3 = 0;
          while (true) {
            const _ = _tmp$3;
            if (_ < _bind$5) {
              const key = _bind$4.buf[_bind$4.start + _ | 0];
              const _bind$6 = _M0FP211localreview3tcl16dictionary__edit(result.val, [key], undefined, 0);
              let _tmp$4;
              if (_bind$6.$tag === 1) {
                const _ok = _bind$6;
                _tmp$4 = _ok._0;
              } else {
                return _bind$6;
              }
              result.val = _tmp$4;
              _tmp$3 = _ + 1 | 0;
              continue;
            } else {
              break;
            }
          }
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(result.val);
      }
      if (n < (_M0MPC15array5Array2atGRPB4JsonE(args, 1) === "set" ? 5 : 4)) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict set/unset arity"));
      }
      const last = _M0MPC15array5Array2atGRPB4JsonE(args, 1) === "set" ? n - 1 | 0 : n;
      let previous;
      if (_M0MPC15array5Array2atGRPB4JsonE(args, 1) === "set") {
        const _bind$2 = _M0MP211localreview3tcl11Interpreter8get__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2));
        let _tmp;
        if (_bind$2.$tag === 1) {
          const _ok = _bind$2;
          _tmp = _ok._0;
        } else {
          return _bind$2;
        }
        previous = _M0MPC16option6Option10unwrap__orGsE(_tmp, "");
      } else {
        const _bind$2 = _M0MP211localreview3tcl11Interpreter9read__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2));
        if (_bind$2.$tag === 1) {
          const _ok = _bind$2;
          previous = _ok._0;
        } else {
          return _bind$2;
        }
      }
      const _bind$2 = _M0FP211localreview3tcl16dictionary__edit(previous, _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 3, last)), _M0MPC15array5Array2atGRPB4JsonE(args, 1) === "set" ? _M0MPC15array5Array2atGRPB4JsonE(args, n - 1 | 0) : undefined, 0);
      let result;
      if (_bind$2.$tag === 1) {
        const _ok = _bind$2;
        result = _ok._0;
      } else {
        return _bind$2;
      }
      const _bind$3 = _M0MP211localreview3tcl11Interpreter8set__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2), result);
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        _ok._0;
      } else {
        return _bind$3;
      }
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(result);
    }
    if (n < 4 || _M0MPC15array5Array2atGRPB4JsonE(args, 1) === "incr" && n > 5) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict update arity"));
    }
    const _bind$2 = _M0MP211localreview3tcl11Interpreter8get__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2));
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    const previous = _M0MPC16option6Option10unwrap__orGsE(_tmp, "");
    const _bind$3 = _M0FP211localreview3tcl10dictionary(previous);
    if (_bind$3.$tag === 1) {
      const _ok = _bind$3;
      _ok._0;
    } else {
      return _bind$3;
    }
    let current;
    let _try_err;
    _L$3: {
      _L$4: {
        const _bind$4 = _M0FP211localreview3tcl15dictionary__get(previous, [_M0MPC15array5Array2atGRPB4JsonE(args, 3)]);
        if (_bind$4.$tag === 1) {
          const _ok = _bind$4;
          current = _ok._0;
        } else {
          const _err = _bind$4;
          _try_err = _err._0;
          break _L$4;
        }
        break _L$3;
      }
      current = "";
    }
    let value;
    if (_M0MPC15array5Array2atGRPB4JsonE(args, 1) === "incr") {
      const _bind$4 = _M0FP211localreview3tcl10dictionary(previous);
      let _tmp$2;
      if (_bind$4.$tag === 1) {
        const _ok = _bind$4;
        _tmp$2 = _ok._0;
      } else {
        return _bind$4;
      }
      const exists = _M0MPB4Iter3anyGUssEE(_M0MPC15array5Array4iterGUssEE(_tmp$2), (p) => p._0 === _M0MPC15array5Array2atGRPB4JsonE(args, 3));
      const _bind$5 = _M0FP211localreview3tcl12integer__add(exists ? current : "0", n === 5 ? _M0MPC15array5Array2atGRPB4JsonE(args, 4) : "1");
      if (_bind$5.$tag === 1) {
        const _ok = _bind$5;
        value = _ok._0;
      } else {
        return _bind$5;
      }
    } else {
      if (_M0MPC15array5Array2atGRPB4JsonE(args, 1) === "append") {
        const _tmp$2 = _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 4, undefined));
        const _bind$4 = "";
        value = `${current}${_M0MPC15array5Array4joinGsE(_tmp$2, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length))}`;
      } else {
        const _bind$4 = _M0FP211localreview3tcl11parse__list(current);
        let _tmp$2;
        if (_bind$4.$tag === 1) {
          const _ok = _bind$4;
          _tmp$2 = _ok._0;
        } else {
          return _bind$4;
        }
        const _bind$5 = _M0FP211localreview3tcl12format__list(_M0IPC15array5ArrayPB3Add3addGsE(_tmp$2, _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 4, undefined))));
        if (_bind$5.$tag === 1) {
          const _ok = _bind$5;
          value = _ok._0;
        } else {
          return _bind$5;
        }
      }
    }
    if (value.length > 1000000) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dictionary value size"));
    }
    const _bind$4 = _M0FP211localreview3tcl16dictionary__edit(previous, [_M0MPC15array5Array2atGRPB4JsonE(args, 3)], value, 0);
    let result;
    if (_bind$4.$tag === 1) {
      const _ok = _bind$4;
      result = _ok._0;
    } else {
      return _bind$4;
    }
    const _bind$5 = _M0MP211localreview3tcl11Interpreter8set__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 2), result);
    if (_bind$5.$tag === 1) {
      const _ok = _bind$5;
      _ok._0;
    } else {
      return _bind$5;
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(result);
  }
  if (n !== 5) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict for/map arity"));
  }
  const _bind$2 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, 2));
  let names;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    names = _ok._0;
  } else {
    return _bind$2;
  }
  if (names.length !== 2) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dict loop requires two variables"));
  }
  const result = [];
  const _bind$3 = _M0FP211localreview3tcl10dictionary(_M0MPC15array5Array2atGRPB4JsonE(args, 3));
  let _bind$4;
  if (_bind$3.$tag === 1) {
    const _ok = _bind$3;
    _bind$4 = _ok._0;
  } else {
    return _bind$3;
  }
  const _bind$5 = _bind$4.length;
  let _tmp = 0;
  _L$2: while (true) {
    const _ = _tmp;
    if (_ < _bind$5) {
      const _foreach_element = _bind$4[_];
      let key;
      let value;
      _L$3: {
        const _key = _foreach_element._0;
        const _value = _foreach_element._1;
        key = _key;
        value = _value;
        break _L$3;
      }
      _L$4: {
        const _bind$6 = _M0MP211localreview3tcl11Interpreter4tick(self);
        if (_bind$6.$tag === 1) {
          const _ok = _bind$6;
          _ok._0;
        } else {
          return _bind$6;
        }
        const _bind$7 = _M0MP211localreview3tcl11Interpreter8set__var(self, _M0MPC15array5Array2atGRPB4JsonE(names, 0), key);
        if (_bind$7.$tag === 1) {
          const _ok = _bind$7;
          _ok._0;
        } else {
          return _bind$7;
        }
        const _bind$8 = _M0MP211localreview3tcl11Interpreter8set__var(self, _M0MPC15array5Array2atGRPB4JsonE(names, 1), value);
        if (_bind$8.$tag === 1) {
          const _ok = _bind$8;
          _ok._0;
        } else {
          return _bind$8;
        }
        let _try_err;
        _L$5: {
          _L$6: {
            const _bind$9 = _M0MP211localreview3tcl11Interpreter15execute_2einner(self, _M0MPC15array5Array2atGRPB4JsonE(args, 4), depth + 1 | 0, false);
            let computed;
            if (_bind$9.$tag === 1) {
              const _ok = _bind$9;
              computed = _ok._0;
            } else {
              const _err = _bind$9;
              _try_err = _err._0;
              break _L$6;
            }
            if (_M0MPC15array5Array2atGRPB4JsonE(args, 1) === "map") {
              const _bind$10 = _M0MP211localreview3tcl11Interpreter9read__var(self, _M0MPC15array5Array2atGRPB4JsonE(names, 0));
              let _tmp$2;
              if (_bind$10.$tag === 1) {
                const _ok = _bind$10;
                _tmp$2 = _ok._0;
              } else {
                const _err = _bind$10;
                _try_err = _err._0;
                break _L$6;
              }
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(result, { _0: _tmp$2, _1: computed });
            }
            break _L$5;
          }
          let error;
          _L$7: {
            let result$2;
            _L$8: {
              let result$3;
              _L$9: {
                switch (_try_err.$tag) {
                  case 1: {
                    break _L$4;
                  }
                  case 2: {
                    break _L$2;
                  }
                  case 0: {
                    const _Signal = _try_err;
                    const _result = _Signal._0;
                    if (_M0MP211localreview3tcl10Completion12actual__code(_result) === 4) {
                      result$3 = _result;
                      break _L$9;
                    } else {
                      if (_M0MP211localreview3tcl10Completion12actual__code(_result) === 3) {
                        result$2 = _result;
                        break _L$8;
                      } else {
                        error = _try_err;
                        break _L$7;
                      }
                    }
                  }
                  default: {
                    error = _try_err;
                    break _L$7;
                  }
                }
              }
              break _L$4;
            }
            break;
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(error);
        }
        break _L$4;
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  if (_M0MPC15array5Array2atGRPB4JsonE(args, 1) === "map") {
    const _bind$6 = _M0FP211localreview3tcl16dictionary__text(result);
    let _tmp$2;
    if (_bind$6.$tag === 1) {
      const _ok = _bind$6;
      _tmp$2 = _ok._0;
    } else {
      return _bind$6;
    }
    const _bind$7 = _M0FP211localreview3tcl10dictionary(_tmp$2);
    let _tmp$3;
    if (_bind$7.$tag === 1) {
      const _ok = _bind$7;
      _tmp$3 = _ok._0;
    } else {
      return _bind$7;
    }
    return _M0FP211localreview3tcl16dictionary__text(_tmp$3);
  } else {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
  }
}
function _M0MP211localreview3tcl11Interpreter18update__dictionary(self, args, depth, discard_result) {
  const name = _M0MPC15array5Array2atGRPB4JsonE(args, 2);
  const key = _M0MPC15array5Array2atGRPB4JsonE(args, 3);
  const _bind$2 = _M0MP211localreview3tcl11Interpreter7binding(self, name, true);
  let _tmp;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    _tmp = _ok._0;
  } else {
    return _bind$2;
  }
  const binding = _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_tmp);
  const _bind$3 = binding.index;
  if (_bind$3 === undefined) {
  } else {
    const _bind$4 = _M0MP211localreview3tcl11Interpreter21dict__command_2einner(self, args, depth, false, false);
    let _tmp$2;
    if (_bind$4.$tag === 1) {
      const _ok = _bind$4;
      _tmp$2 = _ok._0;
    } else {
      return _bind$4;
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp$2);
  }
  let object;
  _L: {
    _L$2: {
      const _bind$4 = binding.cell.value;
      if (_bind$4 === undefined) {
        break _L$2;
      } else {
        const _Some = _bind$4;
        const _x = _Some;
        switch (_x.$tag) {
          case 2: {
            const _Mapping = _x;
            const _object = _Mapping._0;
            object = _object;
            break;
          }
          case 3: {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("variable is array"));
          }
          default: {
            break _L$2;
          }
        }
      }
      break _L;
    }
    const _bind$4 = _M0MP211localreview3tcl7Binding4read(binding);
    let _tmp$2;
    if (_bind$4.$tag === 1) {
      const _ok = _bind$4;
      _tmp$2 = _ok._0;
    } else {
      return _bind$4;
    }
    const _bind$5 = _M0MP211localreview3tcl10DictObject10from__text(_M0MPC16option6Option10unwrap__orGsE(_tmp$2, ""));
    if (_bind$5.$tag === 1) {
      const _ok = _bind$5;
      object = _ok._0;
    } else {
      return _bind$5;
    }
  }
  const previous = _M0MP211localreview3tcl10DictObject3get(object, key);
  const _bind$4 = _M0MPC15array5Array2atGRPB4JsonE(args, 1);
  let value;
  switch (_bind$4) {
    case "set": {
      value = _M0MPC15array5Array2atGRPB4JsonE(args, 4);
      break;
    }
    case "incr": {
      const _bind$5 = _M0FP211localreview3tcl12integer__add(_M0MPC16option6Option10unwrap__orGsE(previous, "0"), args.length === 5 ? _M0MPC15array5Array2atGRPB4JsonE(args, 4) : "1");
      if (_bind$5.$tag === 1) {
        const _ok = _bind$5;
        value = _ok._0;
      } else {
        return _bind$5;
      }
      break;
    }
    case "append": {
      const _tmp$2 = _M0MPC16option6Option10unwrap__orGsE(previous, "");
      const _tmp$3 = _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 4, undefined));
      const _bind$6 = "";
      value = `${_tmp$2}${_M0MPC15array5Array4joinGsE(_tmp$3, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length))}`;
      break;
    }
    case "lappend": {
      const _bind$7 = _M0FP211localreview3tcl11parse__list(_M0MPC16option6Option10unwrap__orGsE(previous, ""));
      let _tmp$4;
      if (_bind$7.$tag === 1) {
        const _ok = _bind$7;
        _tmp$4 = _ok._0;
      } else {
        return _bind$7;
      }
      const _bind$8 = _M0FP211localreview3tcl12format__list(_M0IPC15array5ArrayPB3Add3addGsE(_tmp$4, _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 4, undefined))));
      if (_bind$8.$tag === 1) {
        const _ok = _bind$8;
        value = _ok._0;
      } else {
        return _bind$8;
      }
      break;
    }
    default: {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("dictionary update operation"));
    }
  }
  const _bind$9 = _M0MP211localreview3tcl10DictObject3put(object, key, value);
  if (_bind$9.$tag === 1) {
    const _ok = _bind$9;
    _ok._0;
  } else {
    return _bind$9;
  }
  binding.cell.value = new _M0DTP211localreview3tcl13VariableValue7Mapping(object);
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(discard_result ? "" : _M0MP211localreview3tcl10DictObject4text(object));
}
function _M0MP211localreview3tcl11Interpreter23extended__list__command(self, args, depth) {
  const n = args.length;
  const _bind$2 = _M0MPC15array5Array2atGRPB4JsonE(args, 0);
  switch (_bind$2) {
    case "lset": {
      if (n < 3) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("lset arity"));
      }
      let indices;
      if (n === 4) {
        const _bind$3 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, 2));
        if (_bind$3.$tag === 1) {
          const _ok = _bind$3;
          indices = _ok._0;
        } else {
          return _bind$3;
        }
      } else {
        indices = _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 2, n - 1 | 0));
      }
      const _bind$3 = _M0MP211localreview3tcl11Interpreter9read__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 1));
      let _tmp;
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        _tmp = _ok._0;
      } else {
        return _bind$3;
      }
      const _bind$4 = _M0FP211localreview3tcl10list__edit(_tmp, indices, _M0MPC15array5Array2atGRPB4JsonE(args, n - 1 | 0), 0);
      let result;
      if (_bind$4.$tag === 1) {
        const _ok = _bind$4;
        result = _ok._0;
      } else {
        return _bind$4;
      }
      const _bind$5 = _M0MP211localreview3tcl11Interpreter8set__var(self, _M0MPC15array5Array2atGRPB4JsonE(args, 1), result);
      if (_bind$5.$tag === 1) {
        const _ok = _bind$5;
        _ok._0;
      } else {
        return _bind$5;
      }
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(result);
    }
    case "linsert": {
      if (n < 3) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("linsert arity"));
      }
      const _bind$6 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, 1));
      let values;
      if (_bind$6.$tag === 1) {
        const _ok = _bind$6;
        values = _ok._0;
      } else {
        return _bind$6;
      }
      const _bind$7 = _M0FP211localreview3tcl11list__index(_M0MPC15array5Array2atGRPB4JsonE(args, 2), values.length + 1 | 0);
      let _tmp$2;
      if (_bind$7.$tag === 1) {
        const _ok = _bind$7;
        _tmp$2 = _ok._0;
      } else {
        return _bind$7;
      }
      const index = _M0MPC13int3Int3min(_M0MPC13int3Int3max(_tmp$2, 0), values.length);
      return _M0FP211localreview3tcl12format__list(_M0IPC15array5ArrayPB3Add3addGsE(_M0IPC15array5ArrayPB3Add3addGsE(_M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(values, 0, index)), _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 3, undefined))), _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(values, index, undefined))));
    }
    case "lreplace": {
      if (n < 4) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("lreplace arity"));
      }
      const _bind$8 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, 1));
      let values$2;
      if (_bind$8.$tag === 1) {
        const _ok = _bind$8;
        values$2 = _ok._0;
      } else {
        return _bind$8;
      }
      const _bind$9 = _M0FP211localreview3tcl11list__index(_M0MPC15array5Array2atGRPB4JsonE(args, 2), values$2.length);
      let _tmp$3;
      if (_bind$9.$tag === 1) {
        const _ok = _bind$9;
        _tmp$3 = _ok._0;
      } else {
        return _bind$9;
      }
      const first = _M0MPC13int3Int3min(_M0MPC13int3Int3max(_tmp$3, 0), values$2.length);
      const _bind$10 = _M0FP211localreview3tcl11list__index(_M0MPC15array5Array2atGRPB4JsonE(args, 3), values$2.length);
      let _tmp$4;
      if (_bind$10.$tag === 1) {
        const _ok = _bind$10;
        _tmp$4 = _ok._0;
      } else {
        return _bind$10;
      }
      const last = _M0MPC13int3Int3min(_M0MPC13int3Int3max(_tmp$4, first - 1 | 0), values$2.length - 1 | 0);
      return _M0FP211localreview3tcl12format__list(_M0IPC15array5ArrayPB3Add3addGsE(_M0IPC15array5ArrayPB3Add3addGsE(_M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(values$2, 0, first)), _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, 4, undefined))), _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(values$2, last + 1 | 0, undefined))));
    }
    case "lsearch": {
      const i = new _M0TPB8MutLocalGiE(1);
      const exact = new _M0TPB8MutLocalGbE(false);
      const nocase = new _M0TPB8MutLocalGbE(false);
      const all = new _M0TPB8MutLocalGbE(false);
      const inline = new _M0TPB8MutLocalGbE(false);
      const negate = new _M0TPB8MutLocalGbE(false);
      const start = new _M0TPB8MutLocalGiE(0);
      while (true) {
        if (i.val < (n - 2 | 0)) {
          const _bind$11 = _M0MPC15array5Array2atGRPB4JsonE(args, i.val);
          switch (_bind$11) {
            case "-exact": {
              exact.val = true;
              break;
            }
            case "-glob": {
              exact.val = false;
              break;
            }
            case "-nocase": {
              nocase.val = true;
              break;
            }
            case "-all": {
              all.val = true;
              break;
            }
            case "-inline": {
              inline.val = true;
              break;
            }
            case "-not": {
              negate.val = true;
              break;
            }
            case "-start": {
              i.val = i.val + 1 | 0;
              if (i.val >= (n - 2 | 0)) {
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("lsearch start"));
              }
              const _bind$12 = _M0FP211localreview3tcl7integer(_M0MPC15array5Array2atGRPB4JsonE(args, i.val));
              let _tmp$5;
              if (_bind$12.$tag === 1) {
                const _ok = _bind$12;
                _tmp$5 = _ok._0;
              } else {
                return _bind$12;
              }
              start.val = _M0MPC13int3Int3max(_tmp$5, 0);
              break;
            }
            default: {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported lsearch option"));
            }
          }
          i.val = i.val + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      if (i.val !== (n - 2 | 0)) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("lsearch arity"));
      }
      const _bind$11 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, i.val));
      let values$3;
      if (_bind$11.$tag === 1) {
        const _ok = _bind$11;
        values$3 = _ok._0;
      } else {
        return _bind$11;
      }
      const pattern = nocase.val ? _M0MPC16string6String9to__lower(_M0MPC15array5Array2atGRPB4JsonE(args, i.val + 1 | 0)) : _M0MPC15array5Array2atGRPB4JsonE(args, i.val + 1 | 0);
      const result$2 = [];
      const _bind$12 = start.val;
      const _bind$13 = values$3.length;
      let _tmp$5 = _bind$12;
      while (true) {
        const j = _tmp$5;
        if (j < _bind$13) {
          const value = nocase.val ? _M0MPC16string6String9to__lower(_M0MPC15array5Array2atGRPB4JsonE(values$3, j)) : _M0MPC15array5Array2atGRPB4JsonE(values$3, j);
          let matched;
          if (exact.val) {
            matched = value === pattern;
          } else {
            const _bind$14 = _M0FP211localreview3tcl11glob__match(pattern, value, false);
            if (_bind$14.$tag === 1) {
              const _ok = _bind$14;
              matched = _ok._0;
            } else {
              return _bind$14;
            }
          }
          if (_M0IP016_24default__implPB2Eq10not__equalGbE(matched, negate.val)) {
            const item = inline.val ? _M0MPC15array5Array2atGRPB4JsonE(values$3, j) : _M0MPC13int3Int18to__string_2einner(j, 10);
            if (!all.val) {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(item);
            }
            _M0MPC15array5Array4pushGRPC14json10WriteFrameE(result$2, item);
          }
          _tmp$5 = j + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      return all.val ? _M0FP211localreview3tcl12format__list(result$2) : inline.val ? new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("") : new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("-1");
    }
    case "lsort": {
      if (n < 2) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("lsort arity"));
      }
      const i$2 = new _M0TPB8MutLocalGiE(1);
      const mode = new _M0TPB8MutLocalGsE("-ascii");
      const reverse = new _M0TPB8MutLocalGbE(false);
      const nocase$2 = new _M0TPB8MutLocalGbE(false);
      const unique = new _M0TPB8MutLocalGbE(false);
      const index$2 = new _M0TPB8MutLocalGOsE(undefined);
      const command = new _M0TPB8MutLocalGOsE(undefined);
      while (true) {
        if (i$2.val < (n - 1 | 0)) {
          _L: {
            _L$2: {
              const _bind$14 = _M0MPC15array5Array2atGRPB4JsonE(args, i$2.val);
              switch (_bind$14) {
                case "-ascii": {
                  break _L$2;
                }
                case "-integer": {
                  break _L$2;
                }
                case "-real": {
                  break _L$2;
                }
                case "-decreasing": {
                  reverse.val = true;
                  break;
                }
                case "-increasing": {
                  reverse.val = false;
                  break;
                }
                case "-nocase": {
                  nocase$2.val = true;
                  break;
                }
                case "-unique": {
                  unique.val = true;
                  break;
                }
                case "-index": {
                  i$2.val = i$2.val + 1 | 0;
                  if (i$2.val >= (n - 1 | 0)) {
                    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("lsort index"));
                  }
                  index$2.val = _M0MPC15array5Array2atGRPB4JsonE(args, i$2.val);
                  break;
                }
                case "-command": {
                  i$2.val = i$2.val + 1 | 0;
                  if (i$2.val >= (n - 1 | 0)) {
                    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("lsort command"));
                  }
                  command.val = _M0MPC15array5Array2atGRPB4JsonE(args, i$2.val);
                  break;
                }
                default: {
                  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported lsort option"));
                }
              }
              break _L;
            }
            mode.val = _M0MPC15array5Array2atGRPB4JsonE(args, i$2.val);
          }
          i$2.val = i$2.val + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      const _bind$14 = _M0FP211localreview3tcl11parse__list(_M0MPC15array5Array2atGRPB4JsonE(args, n - 1 | 0));
      let values$4;
      if (_bind$14.$tag === 1) {
        const _ok = _bind$14;
        values$4 = _ok._0;
      } else {
        return _bind$14;
      }
      const key = (value) => {
        let raw;
        let index$3;
        _L: {
          _L$2: {
            const _bind$15 = index$2.val;
            if (_bind$15 === undefined) {
              raw = value;
            } else {
              const _Some = _bind$15;
              const _index = _Some;
              index$3 = _index;
              break _L$2;
            }
            break _L;
          }
          const _bind$15 = _M0FP211localreview3tcl11parse__list(value);
          let values$5;
          if (_bind$15.$tag === 1) {
            const _ok = _bind$15;
            values$5 = _ok._0;
          } else {
            return _bind$15;
          }
          const _bind$16 = _M0FP211localreview3tcl11list__index(index$3, values$5.length);
          let at;
          if (_bind$16.$tag === 1) {
            const _ok = _bind$16;
            at = _ok._0;
          } else {
            return _bind$16;
          }
          if (at < 0 || at >= values$5.length) {
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("lsort index range"));
          }
          raw = _M0MPC15array5Array2atGRPB4JsonE(values$5, at);
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(nocase$2.val ? _M0MPC16string6String9to__lower(raw) : raw);
      };
      const compare = (a, b) => {
        const _bind$15 = _M0MP211localreview3tcl11Interpreter4tick(self);
        if (_bind$15.$tag === 1) {
          const _ok = _bind$15;
          _ok._0;
        } else {
          return _bind$15;
        }
        const _bind$16 = key(a);
        let a$2;
        if (_bind$16.$tag === 1) {
          const _ok = _bind$16;
          a$2 = _ok._0;
        } else {
          return _bind$16;
        }
        const _bind$17 = key(b);
        let b$2;
        if (_bind$17.$tag === 1) {
          const _ok = _bind$17;
          b$2 = _ok._0;
        } else {
          return _bind$17;
        }
        let result$3;
        let script;
        _L: {
          _L$2: {
            const _bind$18 = command.val;
            if (_bind$18 === undefined) {
              if (mode.val === "-integer") {
                const _bind$19 = _M0FP211localreview3tcl16integer__compare(a$2, b$2);
                if (_bind$19.$tag === 1) {
                  const _ok = _bind$19;
                  result$3 = _ok._0;
                } else {
                  return _bind$19;
                }
              } else {
                if (mode.val === "-real") {
                  let a$3;
                  let n$2;
                  _L$3: {
                    const _bind$19 = _M0FP211localreview3tcl6number(a$2);
                    if (_bind$19 === undefined) {
                      return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expected real"));
                    } else {
                      const _Some = _bind$19;
                      const _n = _Some;
                      n$2 = _n;
                      break _L$3;
                    }
                  }
                  a$3 = _M0MP211localreview3tcl6Number6double(n$2);
                  let b$3;
                  let n$3;
                  _L$4: {
                    const _bind$19 = _M0FP211localreview3tcl6number(b$2);
                    if (_bind$19 === undefined) {
                      return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("expected real"));
                    } else {
                      const _Some = _bind$19;
                      const _n = _Some;
                      n$3 = _n;
                      break _L$4;
                    }
                  }
                  b$3 = _M0MP211localreview3tcl6Number6double(n$3);
                  if (_M0MPC16double6Double7is__nan(a$3) || _M0MPC16double6Double7is__nan(b$3)) {
                    return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("cannot sort NaN"));
                  }
                  result$3 = a$3 < b$3 ? -1 : a$3 > b$3 ? 1 : 0;
                } else {
                  result$3 = _M0FP211localreview3tcl20tcl__string__compare(a$2, b$2);
                }
              }
            } else {
              const _Some = _bind$18;
              const _script = _Some;
              script = _script;
              break _L$2;
            }
            break _L;
          }
          const _bind$18 = _M0FP211localreview3tcl11parse__list(script);
          let _tmp$6;
          if (_bind$18.$tag === 1) {
            const _ok = _bind$18;
            _tmp$6 = _ok._0;
          } else {
            return _bind$18;
          }
          const _bind$19 = _M0MP211localreview3tcl11Interpreter15command_2einner(self, _M0IPC15array5ArrayPB3Add3addGsE(_tmp$6, [a$2, b$2]), depth + 1 | 0, false);
          let _tmp$7;
          if (_bind$19.$tag === 1) {
            const _ok = _bind$19;
            _tmp$7 = _ok._0;
          } else {
            return _bind$19;
          }
          const _bind$20 = _M0FP211localreview3tcl7integer(_tmp$7);
          if (_bind$20.$tag === 1) {
            const _ok = _bind$20;
            result$3 = _ok._0;
          } else {
            return _bind$20;
          }
        }
        const sign = result$3 < 0 ? -1 : result$3 > 0 ? 1 : 0;
        return new _M0DTPC16result6ResultGiRP211localreview3tcl8TclErrorE2Ok(reverse.val ? -sign | 0 : sign);
      };
      const _bind$15 = _M0FP211localreview3tcl13sort__strings(values$4, compare);
      if (_bind$15.$tag === 1) {
        const _ok = _bind$15;
        _ok._0;
      } else {
        return _bind$15;
      }
      if (unique.val) {
        const result$3 = [];
        const _bind$16 = values$4.length;
        let _tmp$6 = 0;
        while (true) {
          const _ = _tmp$6;
          if (_ < _bind$16) {
            const value = values$4[_];
            let _tmp$7;
            if (!_M0MPC15array5Array9is__emptyGRPB4JsonE(result$3)) {
              const _bind$17 = compare(_M0MPC15array5Array2atGRPB4JsonE(result$3, result$3.length - 1 | 0), value);
              let _tmp$8;
              if (_bind$17.$tag === 1) {
                const _ok = _bind$17;
                _tmp$8 = _ok._0;
              } else {
                return _bind$17;
              }
              _tmp$7 = _tmp$8 === 0;
            } else {
              _tmp$7 = false;
            }
            if (_tmp$7) {
              _M0MPC15array5Array3setGUssEE(result$3, result$3.length - 1 | 0, value);
            } else {
              _M0MPC15array5Array4pushGRPC14json10WriteFrameE(result$3, value);
            }
            _tmp$6 = _ + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        return _M0FP211localreview3tcl12format__list(result$3);
      } else {
        return _M0FP211localreview3tcl12format__list(values$4);
      }
    }
    default: {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported list command"));
    }
  }
}
function _M0MP211localreview3tcl11Interpreter24invoke__ensemble_2einner(self, command, ensemble, input, depth, discard_result) {
  const index = new _M0TPB8MutLocalGiE(1 + ensemble.parameters.length | 0);
  if (input.length <= index.val) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("ensemble subcommand required"));
  }
  const _bind$2 = _M0MP211localreview3tcl11Interpreter16ensemble__prefix(self, ensemble, _M0MPC15array5Array2atGRPB4JsonE(input, index.val));
  let _tmp;
  if (_bind$2.$tag === 1) {
    const _ok = _bind$2;
    _tmp = _ok._0;
  } else {
    return _bind$2;
  }
  const prefix = new _M0TPB8MutLocalGORPB5ArrayGsEE(_tmp);
  const _bind$3 = prefix.val;
  if (_bind$3.$tag === 0) {
    if (!_M0MPC15array5Array9is__emptyGRPB4JsonE(ensemble.unknown)) {
      let value;
      let _try_err;
      _L: {
        _L$2: {
          const _bind$4 = _M0MP211localreview3tcl11Interpreter15command_2einner(self, _M0IPC15array5ArrayPB3Add3addGsE(_M0IPC15array5ArrayPB3Add3addGsE(ensemble.unknown, [command.name]), _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(input, 1, undefined))), depth + 1 | 0, false);
          if (_bind$4.$tag === 1) {
            const _ok = _bind$4;
            value = _ok._0;
          } else {
            const _err = _bind$4;
            _try_err = _err._0;
            break _L$2;
          }
          break _L;
        }
        _L$3: {
          let result;
          _L$4: {
            let message;
            _L$5: {
              switch (_try_err.$tag) {
                case 4: {
                  const _Invalid = _try_err;
                  const _message = _Invalid._0;
                  message = _message;
                  break _L$5;
                }
                case 0: {
                  const _Signal = _try_err;
                  const _result = _Signal._0;
                  if (_M0MP211localreview3tcl10Completion12actual__code(_result) === 1) {
                    result = _result;
                    break _L$4;
                  } else {
                    break _L$3;
                  }
                }
                default: {
                  break _L$3;
                }
              }
            }
            return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid(message));
          }
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(result));
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("invalid completion from ensemble unknown handler"));
      }
      let still_live;
      let current;
      _L$2: {
        _L$3: {
          const _bind$4 = _M0MPB3Map3getGsRP211localreview3tcl7CommandE(self.state.commands, command.name);
          if (_bind$4 === undefined) {
            still_live = false;
          } else {
            const _Some = _bind$4;
            const _current = _Some;
            current = _current;
            break _L$3;
          }
          break _L$2;
        }
        if (current === command) {
          let _tmp$2;
          let active;
          _L$4: {
            _L$5: {
              const _bind$4 = current.body;
              if (_bind$4.$tag === 3) {
                const _EnsembleCommand = _bind$4;
                const _active = _EnsembleCommand._0;
                active = _active;
                break _L$5;
              } else {
                _tmp$2 = false;
              }
              break _L$4;
            }
            _tmp$2 = active === ensemble;
          }
          still_live = _tmp$2;
        } else {
          still_live = false;
        }
      }
      if (!still_live) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unknown handler deleted its ensemble"));
      }
      index.val = 1 + ensemble.parameters.length | 0;
      const _bind$4 = _M0FP211localreview3tcl11parse__list(value);
      let words;
      if (_bind$4.$tag === 1) {
        const _ok = _bind$4;
        words = _ok._0;
      } else {
        return _bind$4;
      }
      if (!_M0MPC15array5Array9is__emptyGRPB4JsonE(words)) {
        if (index.val >= input.length) {
          index.val = input.length - 1 | 0;
        }
        prefix.val = new _M0DTPC16option6OptionGRPB5ArrayGsEE4Some(words);
      } else {
        if (input.length <= index.val) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("ensemble subcommand required"));
        }
        const _bind$5 = _M0MP211localreview3tcl11Interpreter16ensemble__prefix(self, ensemble, _M0MPC15array5Array2atGRPB4JsonE(input, index.val));
        let _tmp$2;
        if (_bind$5.$tag === 1) {
          const _ok = _bind$5;
          _tmp$2 = _ok._0;
        } else {
          return _bind$5;
        }
        prefix.val = _tmp$2;
      }
    }
  }
  let words;
  const _bind$4 = prefix.val;
  if (_bind$4.$tag === 1) {
    const _Some = _bind$4;
    const _words = _Some._0;
    words = _words;
  } else {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unknown or ambiguous ensemble subcommand"));
  }
  return _M0MP211localreview3tcl11Interpreter15command_2einner(self, _M0IPC15array5ArrayPB3Add3addGsE(_M0IPC15array5ArrayPB3Add3addGsE(words, _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(input, 1, index.val))), _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(input, index.val + 1 | 0, undefined))), depth + 1 | 0, discard_result);
}
function _M0MP211localreview3tcl11Interpreter17invoke__procedure(self, definition, args, depth) {
  const parameters = definition.parameters;
  const body = definition.body;
  const variadic = !_M0MPC15array5Array9is__emptyGRPB4JsonE(parameters) && _M0MPC15array5Array2atGRPB4JsonE(parameters, parameters.length - 1 | 0)._0 === "args";
  const fixed = parameters.length - (variadic ? 1 : 0) | 0;
  const supplied = args.length - 1 | 0;
  if (!variadic && supplied > fixed) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("procedure arity"));
  }
  const required = new _M0TPB8MutLocalGiE(0);
  const _bind$2 = 0;
  let _tmp = _bind$2;
  while (true) {
    const i = _tmp;
    if (i < fixed) {
      const _bind$3 = _M0MPC15array5Array2atGRPB4JsonE(parameters, i)._1;
      if (_bind$3 === undefined) {
        required.val = i + 1 | 0;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  if (supplied < required.val) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("procedure arity"));
  }
  const _bind$3 = [];
  const vars = _M0MPB3Map3MapGssE(new _M0TPB9ArrayViewGUssEE(_bind$3, 0, 0), undefined);
  const _bind$4 = 0;
  let _tmp$2 = _bind$4;
  while (true) {
    const i = _tmp$2;
    if (i < fixed) {
      let name;
      let default_;
      _L: {
        const _bind$5 = _M0MPC15array5Array2atGRPB4JsonE(parameters, i);
        const _name = _bind$5._0;
        const _default = _bind$5._1;
        name = _name;
        default_ = _default;
        break _L;
      }
      let value;
      if (i < supplied) {
        value = _M0MPC15array5Array2atGRPB4JsonE(args, i + 1 | 0);
      } else {
        if (default_ === undefined) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("procedure arity"));
        } else {
          const _Some = default_;
          const _v = _Some;
          value = _v;
        }
      }
      if (!_M0MPB3Map8containsGssE(vars, name)) {
        _M0MPB3Map3setGssE(vars, name, value);
      }
      _tmp$2 = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  if (variadic && !_M0MPB3Map8containsGssE(vars, "args")) {
    const _bind$5 = _M0FP211localreview3tcl12format__list(supplied > fixed ? _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, fixed + 1 | 0, undefined)) : []);
    let _tmp$3;
    if (_bind$5.$tag === 1) {
      const _ok = _bind$5;
      _tmp$3 = _ok._0;
    } else {
      return _bind$5;
    }
    _M0MPB3Map3setGssE(vars, "args", _tmp$3);
  }
  const _bind$5 = [];
  const bindings = _M0MPB3Map3MapGsRP211localreview3tcl7BindingE(new _M0TPB9ArrayViewGUsRP211localreview3tcl7BindingEE(_bind$5, 0, 0), undefined);
  const _it = _M0MPB3Map5iter2GsRPC15debug4ReprE(vars);
  while (true) {
    let name;
    let value;
    _L: {
      const _bind$6 = _M0MPB5Iter24nextGsRPC15debug4ReprE(_it);
      if (_bind$6 === undefined) {
        break;
      } else {
        const _Some = _bind$6;
        const _x = _Some;
        const _name = _x._0;
        const _value = _x._1;
        name = _name;
        value = _value;
        break _L;
      }
    }
    _M0MPB3Map3setGsRP211localreview3tcl7BindingE(bindings, name, new _M0TP211localreview3tcl7Binding(new _M0TP211localreview3tcl4Cell(new _M0DTP211localreview3tcl13VariableValue6Scalar(value), false), undefined, false));
    continue;
  }
  const child = _M0MP211localreview3tcl11Interpreter11with__frame(self, new _M0TP211localreview3tcl5Frame(bindings, definition.namespace_name, true, self.frame));
  let _try_err;
  _L: {
    const _bind$6 = _M0MP211localreview3tcl11Interpreter15execute_2einner(child, body, depth + 1 | 0, false);
    let _tmp$3;
    if (_bind$6.$tag === 1) {
      const _ok = _bind$6;
      _tmp$3 = _ok._0;
    } else {
      const _err = _bind$6;
      _try_err = _err._0;
      break _L;
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp$3);
  }
  const error = _try_err;
  const result = _M0FP211localreview3tcl7outcome(error);
  if (result.level !== 0) {
    return _M0MP211localreview3tcl11Interpreter9propagate(self, new _M0TP211localreview3tcl10Completion(result.code, result.level - 1 | 0, result.value, result.options, result.skip_trace));
  } else {
    if (result.code === 3 || result.code === 4) {
      const options = _M0MPC15array5Array4copyGUssEE(result.options);
      _M0FP211localreview3tcl11option__set(options, "-errorcode", "TCL RESULT UNEXPECTED");
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(_M0FP211localreview3tcl18completion_2einner(1, `invoked ${result.code === 3 ? "break" : "continue"} outside of a loop`, 0, options, false)));
    } else {
      if (result.code === 1) {
        const options = _M0MPC15array5Array4copyGUssEE(result.options);
        const line = _M0MPC16option6Option10unwrap__orGsE(_M0FP211localreview3tcl11option__get(options, "-errorline"), "1");
        const info = _M0MPC16option6Option10unwrap__orGsE(_M0FP211localreview3tcl11option__get(options, "-errorinfo"), result.value);
        _M0FP211localreview3tcl11option__set(options, "-errorinfo", `${info}\n    (procedure \"${_M0MPC15array5Array2atGRPB4JsonE(args, 0)}\" line ${line})`);
        const stack = _M0MPC16option6Option10unwrap__orGsE(_M0FP211localreview3tcl11option__get(options, "-errorstack"), "");
        const _tmp$3 = _M0MPC16string6String9is__empty(stack) ? "" : " ";
        const _bind$6 = _M0FP211localreview3tcl12format__list(args);
        let _tmp$4;
        if (_bind$6.$tag === 1) {
          const _ok = _bind$6;
          _tmp$4 = _ok._0;
        } else {
          return _bind$6;
        }
        const _bind$7 = _M0FP211localreview3tcl12format__list(["CALL", _tmp$4]);
        let _tmp$5;
        if (_bind$7.$tag === 1) {
          const _ok = _bind$7;
          _tmp$5 = _ok._0;
        } else {
          return _bind$7;
        }
        _M0FP211localreview3tcl11option__set(options, "-errorstack", `${stack}${_tmp$3}${_tmp$5}`);
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(new _M0TP211localreview3tcl10Completion(result.code, result.level, result.value, options, result.skip_trace)));
      } else {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error37localreview_2ftcl_2eTclError_2eSignal(result));
      }
    }
  }
}
function _M0MP211localreview3tcl11Interpreter14scope__command(self, args, depth) {
  const n = args.length;
  _L: {
    const _bind$2 = _M0MPC15array5Array2atGRPB4JsonE(args, 0);
    switch (_bind$2) {
      case "global": {
        break _L;
      }
      case "variable": {
        break _L;
      }
      case "upvar": {
        let explicit;
        if (n >= 2) {
          let _tmp;
          const _tmp$2 = _M0MPC15array5Array2atGRPB4JsonE(args, 1);
          const _bind$3 = "#";
          if (_M0MPC16string6String11has__prefix(_tmp$2, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
            _tmp = true;
          } else {
            let _tmp$3;
            let _try_err;
            _L$2: {
              _L$3: {
                const _bind$4 = _M0FP211localreview3tcl7integer(_M0MPC15array5Array2atGRPB4JsonE(args, 1));
                if (_bind$4.$tag === 1) {
                  const _ok = _bind$4;
                  _ok._0;
                } else {
                  const _err = _bind$4;
                  _try_err = _err._0;
                  break _L$3;
                }
                _tmp$3 = true;
                break _L$2;
              }
              _tmp$3 = false;
            }
            _tmp = _tmp$3;
          }
          explicit = _tmp;
        } else {
          explicit = false;
        }
        const start = explicit ? 2 : 1;
        let _tmp;
        if (n <= start) {
          _tmp = true;
        } else {
          if (2 === 0) {
            $panic();
          }
          _tmp = ((n - start | 0) % 2 | 0) !== 0;
        }
        if (_tmp) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("upvar arity"));
        }
        const _bind$3 = _M0MP211localreview3tcl11Interpreter12level__frame(self, explicit ? _M0MPC15array5Array2atGRPB4JsonE(args, 1) : "1");
        let _tmp$2;
        if (_bind$3.$tag === 1) {
          const _ok = _bind$3;
          _tmp$2 = _ok._0;
        } else {
          return _bind$3;
        }
        const target = _M0MP211localreview3tcl11Interpreter11with__frame(self, _tmp$2);
        const i = new _M0TPB8MutLocalGiE(start);
        while (true) {
          if (i.val < n) {
            let _tmp$3;
            const _tmp$4 = _M0MPC15array5Array2atGRPB4JsonE(args, i.val + 1 | 0);
            const _bind$4 = "::";
            if (_M0MPC16string6String8contains(_tmp$4, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length))) {
              _tmp$3 = true;
            } else {
              const _tmp$5 = _M0MPC15array5Array2atGRPB4JsonE(args, i.val + 1 | 0);
              const _bind$5 = "(";
              _tmp$3 = _M0MPC16string6String8contains(_tmp$5, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length));
            }
            if (_tmp$3) {
              return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported upvar local name"));
            }
            const _bind$5 = _M0MP211localreview3tcl11Interpreter7binding(target, _M0MPC15array5Array2atGRPB4JsonE(args, i.val), true);
            let _tmp$5;
            if (_bind$5.$tag === 1) {
              const _ok = _bind$5;
              _tmp$5 = _ok._0;
            } else {
              return _bind$5;
            }
            const binding = _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_tmp$5);
            const _bind$6 = _M0MP211localreview3tcl11Interpreter14link__variable(self, _M0MPC15array5Array2atGRPB4JsonE(args, i.val + 1 | 0), binding);
            if (_bind$6.$tag === 1) {
              const _ok = _bind$6;
              _ok._0;
            } else {
              return _bind$6;
            }
            i.val = i.val + 2 | 0;
            continue;
          } else {
            break;
          }
        }
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
      }
      case "uplevel": {
        if (n < 2) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("uplevel arity"));
        }
        let explicit$2;
        const _tmp$3 = _M0MPC15array5Array2atGRPB4JsonE(args, 1);
        const _bind$4 = "#";
        if (_M0MPC16string6String11has__prefix(_tmp$3, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length))) {
          explicit$2 = true;
        } else {
          let _tmp$4;
          let _try_err;
          _L$2: {
            _L$3: {
              const _bind$5 = _M0FP211localreview3tcl7integer(_M0MPC15array5Array2atGRPB4JsonE(args, 1));
              if (_bind$5.$tag === 1) {
                const _ok = _bind$5;
                _ok._0;
              } else {
                const _err = _bind$5;
                _try_err = _err._0;
                break _L$3;
              }
              _tmp$4 = true;
              break _L$2;
            }
            _tmp$4 = false;
          }
          explicit$2 = _tmp$4;
        }
        const start$2 = explicit$2 ? 2 : 1;
        if (n <= start$2) {
          return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("uplevel script required"));
        }
        const _bind$5 = _M0MP211localreview3tcl11Interpreter12level__frame(self, explicit$2 ? _M0MPC15array5Array2atGRPB4JsonE(args, 1) : "1");
        let _tmp$4;
        if (_bind$5.$tag === 1) {
          const _ok = _bind$5;
          _tmp$4 = _ok._0;
        } else {
          return _bind$5;
        }
        const _tmp$5 = _M0MP211localreview3tcl11Interpreter11with__frame(self, _tmp$4);
        const _tmp$6 = _M0MPC15array9ArrayView9to__ownedGsE(_M0MPC15array5Array12view_2einnerGsE(args, start$2, undefined));
        const _bind$6 = " ";
        return _M0MP211localreview3tcl11Interpreter15execute_2einner(_tmp$5, _M0MPC15array5Array4joinGsE(_tmp$6, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length)), depth + 1 | 0, false);
      }
      default: {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("unsupported scope command"));
      }
    }
  }
  const i = new _M0TPB8MutLocalGiE(1);
  while (true) {
    if (i.val < n) {
      const name = _M0MPC15array5Array2atGRPB4JsonE(args, i.val);
      i.val = i.val + 1 | 0;
      const target = _M0FP211localreview3tcl15qualified__name(_M0MPC15array5Array2atGRPB4JsonE(args, 0) === "global" ? "::" : self.frame.namespace_name, name);
      const _bind$2 = self.frame;
      const _bind$3 = _M0MP211localreview3tcl11Interpreter7binding(_M0MP211localreview3tcl11Interpreter11with__frame(self, new _M0TP211localreview3tcl5Frame(_bind$2.vars, _bind$2.namespace_name, false, _bind$2.parent)), target, true);
      let _tmp;
      if (_bind$3.$tag === 1) {
        const _ok = _bind$3;
        _tmp = _ok._0;
      } else {
        return _bind$3;
      }
      const binding = _M0MPC16option6Option6unwrapGRPB5EntryGiRP211localreview3tcl11InterpreterEE(_tmp);
      if (_M0MPC15array5Array2atGRPB4JsonE(args, 0) === "variable") {
        binding.cell.declared = true;
      }
      if (self.frame.procedure) {
        const _bind$4 = _M0MP211localreview3tcl11Interpreter14link__variable(self, _M0FP211localreview3tcl15namespace__tail(name), binding);
        if (_bind$4.$tag === 1) {
          const _ok = _bind$4;
          _ok._0;
        } else {
          return _bind$4;
        }
      }
      if (_M0MPC15array5Array2atGRPB4JsonE(args, 0) === "variable" && i.val < n) {
        const _bind$4 = self.frame;
        const _bind$5 = _M0MP211localreview3tcl11Interpreter8set__var(_M0MP211localreview3tcl11Interpreter11with__frame(self, new _M0TP211localreview3tcl5Frame(_bind$4.vars, _bind$4.namespace_name, false, _bind$4.parent)), target, _M0MPC15array5Array2atGRPB4JsonE(args, i.val));
        if (_bind$5.$tag === 1) {
          const _ok = _bind$5;
          _ok._0;
        } else {
          return _bind$5;
        }
        i.val = i.val + 1 | 0;
      }
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
}
function _M0MP211localreview3tcl11Interpreter17namespace__import(self, args, depth) {
  const force = args.length > 2 && _M0MPC15array5Array2atGRPB4JsonE(args, 2) === "-force";
  const start = force ? 3 : 2;
  if (args.length === start) {
    if (force) {
      return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
    }
    const names = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPB4Iter3mapGRP211localreview3tcl7CommandsE(_M0MPB4Iter6filterGRPC16string10StringViewE(_M0MPB3Map6valuesGsRP211localreview3tcl7CommandE(self.state.commands), (c) => {
      if (_M0FP211localreview3tcl15command__parent(c.name) === self.frame.namespace_name) {
        const _bind$2 = c.body;
        let _tmp;
        if (_bind$2.$tag === 2) {
          _tmp = true;
        } else {
          _tmp = false;
        }
        return _tmp;
      } else {
        return false;
      }
    }), (c) => _M0FP211localreview3tcl15namespace__tail(c.name)));
    _M0MPC15array5Array4sortGsE(names);
    const _bind$2 = _M0FP211localreview3tcl12format__list(names);
    let _tmp;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _tmp = _ok._0;
    } else {
      return _bind$2;
    }
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(_tmp);
  }
  const _bind$2 = _M0MPC15array5Array12view_2einnerGsE(args, start, undefined);
  const _bind$3 = _bind$2.end - _bind$2.start | 0;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$3) {
      const pattern = _bind$2.buf[_bind$2.start + _ | 0];
      if (_M0MPB3Map8containsGsRP211localreview3tcl7CommandE(self.state.commands, "::auto_import")) {
        const _bind$4 = _M0MP211localreview3tcl11Interpreter15command_2einner(self, ["::auto_import", pattern], depth + 1 | 0, false);
        if (_bind$4.$tag === 1) {
          const _ok = _bind$4;
          _ok._0;
        } else {
          return _bind$4;
        }
      }
      const _bind$4 = "::";
      if (!_M0MPC16string6String8contains(pattern, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length))) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("import pattern requires namespace"));
      }
      let space;
      let tail;
      _L: {
        const _bind$5 = _M0MP211localreview3tcl11Interpreter16command__pattern(self, pattern);
        let _bind$6;
        if (_bind$5.$tag === 1) {
          const _ok = _bind$5;
          _bind$6 = _ok._0;
        } else {
          return _bind$5;
        }
        const _space = _bind$6._0;
        const _tail = _bind$6._1;
        space = _space;
        tail = _tail;
        break _L;
      }
      if (space === self.frame.namespace_name) {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("cannot import from own namespace"));
      }
      const _bind$5 = _M0MP211localreview3tcl11Interpreter18exported__commands(self, space);
      let _bind$6;
      if (_bind$5.$tag === 1) {
        const _ok = _bind$5;
        _bind$6 = _ok._0;
      } else {
        return _bind$5;
      }
      const _bind$7 = _bind$6.length;
      let _tmp$2 = 0;
      while (true) {
        const _$2 = _tmp$2;
        if (_$2 < _bind$7) {
          const command = _bind$6[_$2];
          _L$2: {
            const _bind$8 = _M0MP211localreview3tcl11Interpreter4tick(self);
            if (_bind$8.$tag === 1) {
              const _ok = _bind$8;
              _ok._0;
            } else {
              return _bind$8;
            }
            const _bind$9 = _M0FP211localreview3tcl11glob__match(tail, _M0FP211localreview3tcl15namespace__tail(command.name), false);
            let _tmp$3;
            if (_bind$9.$tag === 1) {
              const _ok = _bind$9;
              _tmp$3 = _ok._0;
            } else {
              return _bind$9;
            }
            if (!_tmp$3) {
              break _L$2;
            }
            const target = _M0FP211localreview3tcl13command__name(self.frame.namespace_name, _M0FP211localreview3tcl15namespace__tail(command.name));
            let existing;
            _L$3: {
              _L$4: {
                const _bind$10 = _M0MPB3Map3getGsRP211localreview3tcl7CommandE(self.state.commands, target);
                if (_bind$10 === undefined) {
                } else {
                  const _Some = _bind$10;
                  const _existing = _Some;
                  existing = _existing;
                  break _L$4;
                }
                break _L$3;
              }
              let previous;
              _L$5: {
                _L$6: {
                  const _bind$10 = existing.body;
                  if (_bind$10.$tag === 2) {
                    const _Imported = _bind$10;
                    const _previous = _Imported._0;
                    previous = _previous;
                    break _L$6;
                  }
                  break _L$5;
                }
                if (previous === command) {
                  break _L$2;
                }
              }
              if (!force) {
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("import command conflict"));
              }
              if (_M0MP211localreview3tcl7Command11depends__on(command, existing)) {
                return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("import cycle"));
              }
            }
            const _bind$10 = _M0MP211localreview3tcl11Interpreter15define__command(self, target, new _M0DTP211localreview3tcl11CommandBody8Imported(command));
            if (_bind$10.$tag === 1) {
              const _ok = _bind$10;
              _ok._0;
            } else {
              return _bind$10;
            }
            break _L$2;
          }
          _tmp$2 = _$2 + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok("");
}
function _M0FP211localreview3tcl14builtin__names() {
  return ["set", "unset", "incr", "append", "expr", "puts", "if", "proc", "return", "list", "llength", "lindex", "lappend", "join", "split", "concat", "lrange", "lreverse", "lrepeat", "lset", "linsert", "lreplace", "lsearch", "lsort", "while", "for", "foreach", "lmap", "break", "continue", "catch", "error", "namespace", "global", "variable", "upvar", "uplevel", "array", "dict", "string", "info", "eval", "subst", "rename", "try", "throw"];
}
function _M0MP211localreview3tcl10ParseCache3new() {
  const _bind$2 = [];
  const _tmp = _M0MPB3Map3MapGsRP211localreview3tcl13ScriptProgramE(new _M0TPB9ArrayViewGUsRP211localreview3tcl13ScriptProgramEE(_bind$2, 0, 0), undefined);
  const _bind$3 = [];
  return new _M0TP211localreview3tcl10ParseCache(_tmp, _M0MPB3Map3MapGsRP211localreview3tcl4ExprE(new _M0TPB9ArrayViewGUsRP211localreview3tcl4ExprEE(_bind$3, 0, 0), undefined), 0, 0, 0, 0);
}
function _M0MP211localreview3tcl11Interpreter3new() {
  const _bind$2 = [];
  const commands = _M0MPB3Map3MapGsRP211localreview3tcl7CommandE(new _M0TPB9ArrayViewGUsRP211localreview3tcl7CommandEE(_bind$2, 0, 0), undefined);
  const _bind$3 = _M0FP211localreview3tcl14builtin__names();
  const _bind$4 = _bind$3.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$4) {
      const name = _bind$3[_];
      const key = `::${name}`;
      _M0MPB3Map3setGsRP211localreview3tcl7CommandE(commands, key, new _M0TP211localreview3tcl7Command(key, new _M0DTP211localreview3tcl11CommandBody6Native(name)));
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$5 = [];
  const _bind$6 = _M0MPB3Map3MapGsRP211localreview3tcl4CellE(new _M0TPB9ArrayViewGUsRP211localreview3tcl4CellEE(_bind$5, 0, 0), undefined);
  const _bind$7 = [];
  const _bind$8 = _M0MPB3Map3MapGsRP211localreview3tcl7BindingE(new _M0TPB9ArrayViewGUsRP211localreview3tcl7BindingEE(_bind$7, 0, 0), undefined);
  const _bind$9 = [];
  const _bind$10 = _M0MPB3Map3MapGsRPB5ArrayGsEE(new _M0TPB9ArrayViewGUsRPB5ArrayGsEEE(_bind$9, 0, 0), undefined);
  const _bind$11 = [];
  const _bind$12 = _M0MPB3Map3MapGsRPB5ArrayGsEE(new _M0TPB9ArrayViewGUsRPB5ArrayGsEEE(_bind$11, 0, 0), undefined);
  const _bind$13 = [];
  const _bind$14 = _M0MPB3Map3MapGssE(new _M0TPB9ArrayViewGUssEE(_bind$13, 0, 0), undefined);
  const _bind$15 = [{ _0: "::", _1: true }];
  const _bind$16 = _M0MPB3Map3MapGsbE(new _M0TPB9ArrayViewGUsbEE(_bind$15, 0, 1), undefined);
  const _bind$17 = _M0MP211localreview3tcl10ParseCache3new();
  const _bind$18 = _M0MPC13ref3Ref3RefGRPB5ArrayGUssEEE([]);
  const _bind$19 = _M0MPC13ref3Ref3RefGsE("");
  const _tmp$2 = new _M0TP211localreview3tcl5State(_bind$6, _bind$8, commands, _bind$10, _bind$12, _bind$14, _bind$16, _bind$18, _bind$19, _bind$17);
  const _bind$20 = [];
  return new _M0TP211localreview3tcl11Interpreter(_tmp$2, new _M0TP211localreview3tcl5Frame(_M0MPB3Map3MapGsRP211localreview3tcl7BindingE(new _M0TPB9ArrayViewGUsRP211localreview3tcl7BindingEE(_bind$20, 0, 0), undefined), "::", false, undefined), [], [0], _M0MPC13ref3Ref3RefGiE(10000));
}
function _M0MP211localreview3tcl11Interpreter7printed(self) {
  const _tmp = self.output;
  const _bind$2 = "";
  const value = _M0MPC15array5Array4joinGsE(_tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _bind$3 = "\n";
  if (_M0MPC16string6String11has__suffix(value, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
    return _M0MPC16string10StringView9to__owned(_M0MPC16string6String11sub_2einner(value, 0, value.length - 1 | 0));
  } else {
    return value;
  }
}
function _M0MP211localreview3tcl11Interpreter12output__text(self) {
  const _tmp = self.output;
  const _bind$2 = "";
  return _M0MPC15array5Array4joinGsE(_tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
}
function _M0MP211localreview3tcl11Interpreter13clear__output(self) {
  _M0MPC15array5Array5clearGsE(self.output);
  _M0MPC15array5Array3setGiE(self.output_size, 0, 0);
}
function _M0MP211localreview3tcl11Interpreter12eval_2einner(self, source, budget) {
  if (budget < 1 || budget > 1000000) {
    return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("budget range"));
  }
  self.budget.val = budget;
  const result = _M0MP211localreview3tcl11Interpreter7capture(self, source, 0);
  const result$2 = result.level !== 0 ? new _M0TP211localreview3tcl10Completion(result.code, result.level - 1 | 0, result.value, result.options, result.skip_trace) : result;
  let code;
  _L: {
    const _bind$2 = _M0MP211localreview3tcl10Completion12actual__code(result$2);
    switch (_bind$2) {
      case 0: {
        self.state.return_options.val = result$2.options;
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE2Ok(result$2.value);
      }
      case 1: {
        _M0MP211localreview3tcl11Interpreter13record__error(self, result$2);
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid(result$2.value));
      }
      case 3: {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("invoked break outside of a loop"));
      }
      case 4: {
        return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid("invoked continue outside of a loop"));
      }
      default: {
        code = _bind$2;
        break _L;
      }
    }
  }
  return new _M0DTPC16result6ResultGsRP211localreview3tcl8TclErrorE3Err(new _M0DTPC15error5Error38localreview_2ftcl_2eTclError_2eInvalid(`command returned bad code: ${_M0MPC13int3Int18to__string_2einner(code, 10)}`));
}
function _M0FP411localreview3tcl3cmd3web11host__error(error) {
  let other;
  _L: {
    let message;
    _L$2: {
      if (error.$tag === 4) {
        const _Invalid = error;
        const _message = _Invalid._0;
        message = _message;
        break _L$2;
      } else {
        other = error;
        break _L;
      }
    }
    return `Invalid(${_M0MPC14json4Json17stringify_2einner(_M0MPC14json4Json6string(message), false, 0, undefined)})`;
  }
  return _M0IP016_24default__implPB4Show10to__stringGRPC15debug4ReprE(_M0MPC15debug4Repr4ReprGRP211localreview3tcl8TclErrorE(other));
}
function _M0FP411localreview3tcl3cmd3web3run(input) {
  let _try_err;
  _L: {
    const t = _M0MP211localreview3tcl11Interpreter3new();
    const _bind$2 = _M0MP211localreview3tcl11Interpreter12eval_2einner(t, input, 10000);
    let result;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      result = _ok._0;
    } else {
      const _err = _bind$2;
      _try_err = _err._0;
      break _L;
    }
    return `Result: ${result}\nOutput:\n${_M0MP211localreview3tcl11Interpreter7printed(t)}`;
  }
  const e = _try_err;
  return `ERROR: ${_M0FP411localreview3tcl3cmd3web11host__error(e)}`;
}
function _M0FP411localreview3tcl3cmd3web21evaluate__interpreter(t, input) {
  _M0MP211localreview3tcl11Interpreter13clear__output(t);
  let _try_err;
  _L: {
    const _bind$2 = _M0MP211localreview3tcl11Interpreter12eval_2einner(t, input, 100000);
    let result;
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      result = _ok._0;
    } else {
      const _err = _bind$2;
      _try_err = _err._0;
      break _L;
    }
    const _bind$3 = [{ _0: "ok", _1: _M0MPC14json4Json7boolean(true) }, { _0: "result", _1: _M0MPC14json4Json6string(result) }, { _0: "output", _1: _M0MPC14json4Json6string(_M0MP211localreview3tcl11Interpreter12output__text(t)) }];
    return _M0MPC14json4Json17stringify_2einner(_M0MPC14json4Json6object(_M0MPB3Map3MapGsRPB4JsonE(new _M0TPB9ArrayViewGUsRPB4JsonEE(_bind$3, 0, 3), undefined)), false, 0, undefined);
  }
  const error = _try_err;
  const _bind$2 = [{ _0: "ok", _1: _M0MPC14json4Json7boolean(false) }, { _0: "error", _1: _M0MPC14json4Json6string(_M0FP411localreview3tcl3cmd3web11host__error(error)) }, { _0: "output", _1: _M0MPC14json4Json6string(_M0MP211localreview3tcl11Interpreter12output__text(t)) }];
  return _M0MPC14json4Json17stringify_2einner(_M0MPC14json4Json6object(_M0MPB3Map3MapGsRPB4JsonE(new _M0TPB9ArrayViewGUsRPB4JsonEE(_bind$2, 0, 3), undefined)), false, 0, undefined);
}
function _M0FP411localreview3tcl3cmd3web8evaluate(input) {
  const t = _M0MP211localreview3tcl11Interpreter3new();
  return _M0FP411localreview3tcl3cmd3web21evaluate__interpreter(t, input);
}
function _M0FP411localreview3tcl3cmd3web12new__session() {
  if (_M0MPB3Map6lengthGiRP211localreview3tcl11InterpreterE(_M0FP411localreview3tcl3cmd3web8sessions) >= 32) {
    return -1;
  }
  _M0FP411localreview3tcl3cmd3web13next__session.val = _M0FP411localreview3tcl3cmd3web13next__session.val + 1 | 0;
  _M0MPB3Map3setGiRP211localreview3tcl11InterpreterE(_M0FP411localreview3tcl3cmd3web8sessions, _M0FP411localreview3tcl3cmd3web13next__session.val, _M0MP211localreview3tcl11Interpreter3new());
  return _M0FP411localreview3tcl3cmd3web13next__session.val;
}
function _M0FP411localreview3tcl3cmd3web13session__eval(id, input) {
  let t;
  _L: {
    const _bind$2 = _M0MPB3Map3getGiRP211localreview3tcl11InterpreterE(_M0FP411localreview3tcl3cmd3web8sessions, id);
    if (_bind$2 === undefined) {
      return "{\"ok\":false,\"error\":\"Unknown or closed session\",\"output\":\"\"}";
    } else {
      const _Some = _bind$2;
      const _t = _Some;
      t = _t;
      break _L;
    }
  }
  return _M0FP411localreview3tcl3cmd3web21evaluate__interpreter(t, input);
}
function _M0FP411localreview3tcl3cmd3web14reset__session(id) {
  if (!_M0MPB3Map8containsGiRP211localreview3tcl11InterpreterE(_M0FP411localreview3tcl3cmd3web8sessions, id)) {
    return false;
  }
  _M0MPB3Map3setGiRP211localreview3tcl11InterpreterE(_M0FP411localreview3tcl3cmd3web8sessions, id, _M0MP211localreview3tcl11Interpreter3new());
  return true;
}
function _M0FP411localreview3tcl3cmd3web14close__session(id) {
  _M0MPB3Map6removeGiRP211localreview3tcl11InterpreterE(_M0FP411localreview3tcl3cmd3web8sessions, id);
}
(() => {
})();
export { _M0FP411localreview3tcl3cmd3web3run as run, _M0FP411localreview3tcl3cmd3web8evaluate as evaluate, _M0FP411localreview3tcl3cmd3web12new__session as new_session, _M0FP411localreview3tcl3cmd3web13session__eval as session_eval, _M0FP411localreview3tcl3cmd3web14reset__session as reset_session, _M0FP411localreview3tcl3cmd3web14close__session as close_session }
//# sourceMappingURL=web.js.map

declare void @printInt(i32)
declare void @printString(i8*)
declare void @error()
declare i32 @readInt()
declare i8* @readString()
declare i8* @concat(i8*, i8*)
declare i8* @malloc(i32)
declare void @llvm.memset.p0i8.i32(i8*, i8, i32, i1)



define i32 @main() {
  call void @p()
  call void @printInt(i32 1)
  ret i32 0
}

define void @p() {
  ret void
}

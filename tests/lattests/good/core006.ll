declare void @printInt(i32)
declare void @printString(i8*)
declare void @error()
declare i32 @readInt()
declare i8* @readString()
declare i8* @concat(i8*, i8*)
declare i8* @malloc(i32)
declare void @llvm.memset.p0i8.i32(i8*, i8, i32, i1)



define i32 @main() {
  %x = alloca i32
  %y = alloca i32
  store i32 0, i32* %x
  store i32 0, i32* %y
  store i32 45, i32* %x
  store i32 -36, i32* %y
  %1 = load i32, i32* %x
  call void @printInt(i32 %1)
  %2 = load i32, i32* %y
  call void @printInt(i32 %2)
  ret i32 0
}

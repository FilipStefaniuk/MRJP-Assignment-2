declare void @printInt(i32)
declare void @printString(i8*)
declare void @error()
declare i32 @readInt()
declare i8* @readString()
declare i8* @concat(i8*, i8*)
declare i8* @malloc(i32)
@.str = constant [4 x i8] c"foo\00"

define i32 @main() {
	call void @foo()
	ret i32 0
}

define void @foo() {
	%1 = getelementptr inbounds [4 x i8], [4 x i8]* @.str, i32 0, i32 0
	call void @printString(i8* %1)
	ret void
}

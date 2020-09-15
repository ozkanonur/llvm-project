; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -verify -iroutliner < %s | FileCheck %s

; This test makes sure we are extracting the found similarity sections
; correctly at the call site.

define void @extract1() {
; CHECK-LABEL: @extract1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @extract1.outlined(i32* [[A]], i32* [[B]], i32* [[C]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 2, i32* %a, align 4
  store i32 3, i32* %b, align 4
  store i32 4, i32* %c, align 4
  %al = load i32, i32* %a
  %bl = load i32, i32* %b
  %cl = load i32, i32* %c
  ret void
}

define void @extract2() {
; CHECK-LABEL: @extract2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @extract2.outlined(i32* [[A]], i32* [[B]], i32* [[C]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 2, i32* %a, align 4
  store i32 3, i32* %b, align 4
  store i32 4, i32* %c, align 4
  %al = load i32, i32* %a
  %bl = load i32, i32* %b
  %cl = load i32, i32* %c
  ret void
}

define void @extract_outs1() #0 {
; CHECK-LABEL: @extract_outs1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTLOC:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[ADD_LOC:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[OUTPUT:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[RESULT:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[LT_CAST:%.*]] = bitcast i32* [[ADD_LOC]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 -1, i8* [[LT_CAST]])
; CHECK-NEXT:    [[LT_CAST1:%.*]] = bitcast i32* [[DOTLOC]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 -1, i8* [[LT_CAST1]])
; CHECK-NEXT:    call void @extract_outs1.outlined(i32* [[A]], i32* [[B]], i32* [[OUTPUT]], i32* [[ADD_LOC]], i32* [[DOTLOC]])
; CHECK-NEXT:    [[ADD_RELOAD:%.*]] = load i32, i32* [[ADD_LOC]], align 4
; CHECK-NEXT:    [[DOTRELOAD:%.*]] = load i32, i32* [[DOTLOC]], align 4
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 -1, i8* [[LT_CAST]])
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 -1, i8* [[LT_CAST1]])
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* [[OUTPUT]], align 4
; CHECK-NEXT:    call void @extract_outs1.outlined.1(i32 [[DOTRELOAD]], i32 [[ADD_RELOAD]], i32* [[RESULT]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %output = alloca i32, align 4
  %result = alloca i32, align 4
  store i32 2, i32* %a, align 4
  store i32 3, i32* %b, align 4
  %0 = load i32, i32* %a, align 4
  %1 = load i32, i32* %b, align 4
  %add = add i32 %0, %1
  store i32 %add, i32* %output, align 4
  %2 = load i32, i32* %output, align 4
  %3 = load i32, i32* %output, align 4
  %mul = mul i32 %2, %add
  store i32 %mul, i32* %result, align 4
  ret void
}

define void @extract_outs2() #0 {
; CHECK-LABEL: @extract_outs2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTLOC:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[ADD_LOC:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[OUTPUT:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[RESULT:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[LT_CAST:%.*]] = bitcast i32* [[ADD_LOC]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 -1, i8* [[LT_CAST]])
; CHECK-NEXT:    [[LT_CAST1:%.*]] = bitcast i32* [[DOTLOC]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 -1, i8* [[LT_CAST1]])
; CHECK-NEXT:    call void @extract_outs2.outlined(i32* [[A]], i32* [[B]], i32* [[OUTPUT]], i32* [[ADD_LOC]], i32* [[DOTLOC]])
; CHECK-NEXT:    [[ADD_RELOAD:%.*]] = load i32, i32* [[ADD_LOC]], align 4
; CHECK-NEXT:    [[DOTRELOAD:%.*]] = load i32, i32* [[DOTLOC]], align 4
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 -1, i8* [[LT_CAST]])
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 -1, i8* [[LT_CAST1]])
; CHECK-NEXT:    call void @extract_outs2.outlined.2(i32 [[DOTRELOAD]], i32 [[ADD_RELOAD]], i32* [[RESULT]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %output = alloca i32, align 4
  %result = alloca i32, align 4
  store i32 2, i32* %a, align 4
  store i32 3, i32* %b, align 4
  %0 = load i32, i32* %a, align 4
  %1 = load i32, i32* %b, align 4
  %add = add i32 %0, %1
  store i32 %add, i32* %output, align 4
  %2 = load i32, i32* %output, align 4
  %mul = mul i32 %2, %add
  store i32 %mul, i32* %result, align 4
  ret void
}

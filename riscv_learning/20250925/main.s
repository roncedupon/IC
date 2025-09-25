	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	sw	zero,-20(s0)
.L2:
	lw	a5,-20(s0) 	#从 x 的内存位置（-20(s0)）加载值到寄存器 a5。
	addi	a5,a5,1	#将 a5 加 1（即 x++）。
	sw	a5,-20(s0)	#将加 1 后的值写回到 x 的内存位置。
	j	.L2			#无条件跳转到 .L2，形成无限循环。
	.size	main, .-main
	.ident	"GCC: (crosstool-NG 1.26.0_rc1) 10.2.0"

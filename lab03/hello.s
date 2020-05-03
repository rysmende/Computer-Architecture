.section .data
message:
	.string "hello world\n"
	message_size = . - message
.section .text
.global main
main:
	mov $0x1, %rax
	mov $0x1, %rdi
	lea message(%rip), %rsi
	mov $message_size, %rdx
	syscall

	xor %eax, %eax
	ret

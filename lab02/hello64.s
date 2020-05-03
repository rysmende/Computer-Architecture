.section .data
message:
	.string "Hello World!"

.section .text
.global main
main:
	lea message(%rip), %rdi
	call puts@plt
	xor %eax, %eax
	ret

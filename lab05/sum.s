.section .data
input:
	.string "%ld %ld"
number1:
	.int 0, 0
number2:
	.int 0, 0
output:
	.string "%ld + %ld = %ld\n"
.section .text
.global main
main:
	push %rbp
	mov %rsp, %rbp

	lea input(%rip), %rdi
	lea number1(%rip), %rsi
	lea number2(%rip), %rdx
	xor %eax, %eax
	call scanf@plt

	mov number1(%rip), %rsi
	mov number2(%rip), %rdx
	mov %rsi, %rcx
	add %rdx, %rcx
	
	lea output(%rip), %rdi
	xor %eax, %eax
	call printf@plt

	xor %eax, %eax
	pop %rbp
	ret

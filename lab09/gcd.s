.section .data
input: .string "%ld %ld"
output: .string "%ld\n"
 
.section .text
.global main

main:
	sub $24, %rsp

	lea input(%rip), %rdi
	lea 8(%rsp), %rsi
	lea (%rsp), %rdx
	xor %eax, %eax
	call scanf@plt

	mov 8(%rsp), %rsi
	mov (%rsp), %rdi
.gcd:
	test %rdi, %rdi
	jz .end	

	mov %rsi, %rax
	cqo
	mov %rdi, %rsi
	div %rdi
	mov %rdx, %rdi
	jmp .gcd	

.end:
	lea output(%rip), %rdi
	xor %eax, %eax
	call printf@plt

	add $24, %rsp

	xor %eax, %eax
	ret

.section .data
input: .string "%ld %ld"
output: .string "%d\n"

a: .int 0, 0
b: .int 0, 0

.section .text

.global main
main:
	sub $8, %rsp
	lea input(%rip), %rdi
	lea a(%rip), %rsi
	lea b(%rip), %rdx
	xor %eax, %eax
	call scanf@plt

	mov a(%rip), %rdi
	mov b(%rip), %rsi
	mov %rdi, %rdx
.loop:
	cmp %rsi, %rdi
	je .loop.end
	inc %rdi
	add %rdi, %rdx
	jmp .loop

.loop.end:
	lea output(%rip), %rdi
	mov %rdx, %rsi
	xor %eax, %eax
	call printf@plt

	add $8, %rsp
	xor %eax, %eax
	ret

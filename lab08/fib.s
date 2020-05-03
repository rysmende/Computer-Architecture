.section .data
	input: .string "%ld"
	output: .string "%ld\n"
	a: .int 0, 0

.section .text
.global main
main:
	sub $8, %rsp

	lea input(%rip), %rdi
	lea a(%rip), %rsi
	xor %eax, %eax
	call scanf@plt
	
	mov $2, %rcx
	mov $1, %rdi
	mov $1, %rsi
        mov a(%rip), %r8
.sum:
	mov %rsi, %rdx
	add %rdi, %rsi
	mov %rdx, %rdi
	inc %rcx
	cmp %rcx, %r8
	jne .sum

	lea output(%rip), %rdi
	xor %eax, %eax
	call printf@plt
	add $8, %rsp
	xor %eax, %eax
	ret

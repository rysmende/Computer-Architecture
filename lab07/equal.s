.section .data
input: .string "%ld %ld"
output: .string "%ld is greater number.\n"
equal: .string "Both values are equal.\n"

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

	mov a(%rip), %rsi
	mov b(%rip), %rdx
	cmp %rdx, %rsi

	jg .main.ag
	jl .main.bg

	lea equal(%rip), %rdi
	call puts@plt

.main.end:
	add $8, %rsp
	xor %eax, %eax
	ret

.main.ag:
	lea output(%rip), %rdi
	xor %eax, %eax
	call printf@plt
	jmp .main.end	

.main.bg:
	lea output(%rip), %rdi
	mov %rdx, %rsi
	xor %eax, %eax
	call printf@plt
	jmp .main.end


.section .data
	input: .string "%ld"
	output: .string "%ld\n"
	num: .int 0, 0
.section .text

factR:
	test %rdi, %rdi
	jle .factR_end
	imul %rdi, %rsi
	dec %rdi
	call factR
.factR_end:
	mov %rsi, %rax
	ret

.global main
main:
	sub $8, %rsp
	lea input(%rip), %rdi
	lea num(%rip), %rsi
	xor %eax, %eax
	call scanf@plt

	mov num(%rip), %rdi
	mov $1, %rsi
	call factR


	add $8, %rsp
	xor %eax, %eax
	ret

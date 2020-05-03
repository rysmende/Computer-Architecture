.section .data
input: .string "%d"
output: .string "%d\n"
n: .int 0, 0

.section .text
.global main
main:
        sub $8, %rsp
        lea input(%rip), %rdi
        lea n(%rip), %rsi
        xor %eax, %eax
        call scanf@plt

        mov $1, %rdx
        mov $0, %rcx
        mov n(%rip), %rsi
        cmp %rcx, %rsi
        je .end
        inc %rcx
.loop:
        cmp %rcx, %rsi
        je .end
        inc %rcx
        imul %rcx, %rdx
        jmp .loop
.end:
	mov %rdx, %rsi
	lea output(%rip), %rdi
	xor %eax, %eax
	call printf@plt

	add $8, %rsp	
	xor %eax, %eax
	ret

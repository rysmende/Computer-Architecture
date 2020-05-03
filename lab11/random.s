.section .data
	input: .string "%ld %ld %ld %ld"
	output: .string "%ld "
        endl: .string "\n"
		
	max: .string "Max: %ld\n"
	min: .string "Min: %ld\n"
	med: .string "Med: %ld\n"
	mod: .string "Mod: %ld\n"
	avg: .string "Avg: %ld\n"
	sum: .string "Sum: %ld\n"
		
        x: .int 0, 0
        a: .int 0, 0
        b: .int 0, 0
        m: .int 0, 0

.section .text

rnd:
	mov $0, %r12
.rnd_loop:
	cmp $15, %r12
	jge .rnd_end
		
	mov (%rdi, %r12, 8), %rax
	mul %rsi
	add %r8, %rax
	div %rcx
	inc %r12
	mov %rdx, (%rdi, %r12, 8)
		
	jmp .rnd_loop
		
.rnd_end:
	ret


.global main
main:
        sub $8, %rsp
        lea input(%rip), %rdi
        lea x(%rip), %rsi
        lea a(%rip), %rdx
        lea b(%rip), %rcx
        lea m(%rip), %r8
        xor %eax, %eax
        call scanf@plt

        sub $128, %rsp
	push %rbp
	mov %rsp, %rbp
        
	mov x(%rip), %rdi
	mov %rdi, (%rbp)
	lea (%rbp), %rdi
	mov a(%rip), %rsi
	mov b(%rip), %r8
	mov m(%rip), %rcx
	call rnd
		
        mov $0, %r12
		
.loop_pr:
        mov (%rbp, %r12, 8), %rsi
        lea output(%rip), %rdi
        xor %eax, %eax
        call printf@plt
		
        inc %r12
		
	cmp $16, %r12
	je .finish
		
        jmp .loop_pr
		
.finish:
	lea endl(%rip), %rdi
	xor %eax, %eax
	call printf@plt
		
	leave
        add $136, %rsp
        xor %eax, %eax
        ret


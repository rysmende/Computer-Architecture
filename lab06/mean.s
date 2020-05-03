.section .data
output_format: .string "%ld\n"

.section .text
add2:
	mov %edi, %eax
	cltq
	mov %rax, %rdi

	mov %esi, %eax
	cltq
	
	add %rdi, %rax
	ret

add2m:
	mov %rdi, %rax
	add %rsi, %rax
	ret

add6m:
	mov %rdi, %rax
	add %rsi, %rax
	add %rdx, %rax
	add %rcx, %rax
	add %r8, %rax
	add %r9, %rax
	ret

add7m:
        mov %rdi, %rax
        add %rsi, %rax
        add %rdx, %rax
        add %rcx, %rax
        add %r8, %rax
        add %r9, %rax
        pop %rdi
	pop %rsi
	add %rsi, %rax
	push %rdi
	ret
add8m:
        mov %rdi, %rax
        add %rsi, %rax
        add %rdx, %rax
        add %rcx, %rax
        add %r8, %rax
        add %r9, %rax
        pop %rdi
        pop %rsi
        add %rsi, %rax
        pop %rsi
        add %rsi, %rax
	push %rdi
        ret
add9m:
        mov %rdi, %rax
        add %rsi, %rax
        add %rdx, %rax
        add %rcx, %rax
        add %r8, %rax
        add %r9, %rax
        pop %rdi
        pop %rsi
        add %rsi, %rax
	pop %rsi
        add %rsi, %rax
	pop %rsi
        add %rsi, %rax
	push %rdi
        ret
add10m:
        mov %rdi, %rax
        add %rsi, %rax
        add %rdx, %rax
        add %rcx, %rax
        add %r8, %rax
        add %r9, %rax
        pop %rdi
        pop %rsi
        add %rsi, %rax
        pop %rsi
        add %rsi, %rax
        pop %rsi
        add %rsi, %rax
        pop %rsi
        add %rsi, %rax
	push %rdi
        ret
add7:
	mov %edi, %eax
	cltq
	mov %rax, %rdi

        mov %esi, %eax
        cltq
        mov %rax, %rsi

        mov %edx, %eax
        cltq
        mov %rax, %rdx

        mov %ecx, %eax
        cltq
        mov %rax, %rcx

        mov %edi, %eax
        cltq
        mov %rax, %rdi

        mov %r8d, %eax
        cltq
        mov %rax, %r8
	
	mov %r9d, %eax
	cltq

	pop %r9
	add %rdi, %rax
	pop %rdi
	add %rdi, %rax
	push %r9
	
	add %rsi, %rax
	add %rdx, %rax
	add %rcx, %rax
	add %r8, %rax
	ret
add8:
        mov %edi, %eax
        cltq
        mov %rax, %rdi

        mov %esi, %eax
        cltq
        mov %rax, %rsi

        mov %edx, %eax
        cltq
        mov %rax, %rdx

        mov %ecx, %eax
        cltq
        mov %rax, %rcx

        mov %edi, %eax
        cltq
        mov %rax, %rdi

        mov %r8d, %eax
        cltq
        mov %rax, %r8

        mov %r9d, %eax
        cltq

        pop %r9
        add %rdi, %rax
        pop %rdi
        add %rdi, %rax
        pop %rdi
        add %rdi, %rax
        push %r9

        add %rsi, %rax
        add %rdx, %rax
        add %rcx, %rax
        add %r8, %rax
        ret

add9:
        mov %edi, %eax
        cltq
        mov %rax, %rdi

        mov %esi, %eax
        cltq
        mov %rax, %rsi

        mov %edx, %eax
        cltq
        mov %rax, %rdx

        mov %ecx, %eax
        cltq
        mov %rax, %rcx

        mov %edi, %eax
        cltq
        mov %rax, %rdi

        mov %r8d, %eax
        cltq
        mov %rax, %r8

        mov %r9d, %eax
        cltq

        pop %r9
        add %rdi, %rax
        pop %rdi
        add %rdi, %rax
        pop %rdi
       	add %rdi, %rax
        pop %rdi
        add %rdi, %rax
	push %r9

        add %rsi, %rax
        add %rdx, %rax
        add %rcx, %rax
        add %r8, %rax
        ret

add10:
        mov %edi, %eax
        cltq
        mov %rax, %rdi

        mov %esi, %eax
        cltq
        mov %rax, %rsi

        mov %edx, %eax
        cltq
        mov %rax, %rdx

        mov %ecx, %eax
        cltq
        mov %rax, %rcx

        mov %edi, %eax
        cltq
        mov %rax, %rdi

        mov %r8d, %eax
        cltq
        mov %rax, %r8

        mov %r9d, %eax
        cltq

        pop %r9
        add %rdi, %rax
        pop %rdi
        add %rdi, %rax
        pop %rdi
        add %rdi, %rax
        pop %rdi
        add %rdi, %rax
        pop %rdi
        add %rdi, %rax
        push %r9

        add %rsi, %rax
        add %rdx, %rax
        add %rcx, %rax
        add %r8, %rax
        ret

.global main
main:
	mov $1, %edi
	mov $2, %esi
	call add2

	mov %rax, %rsi

	lea output_format(%rip), %rdi	
	xor %eax, %eax
	call printf@plt
	
	mov $1, %rdi
	mov $2, %rsi
	call add2m

	mov %rax, %rsi

	lea output_format(%rip), %rdi
	xor %eax, %eax
	call printf@plt
	
	mov $1, %rdi
	mov $2, %rsi
	mov $3, %rdx
	mov $4, %rcx
	mov $5, %r8
	mov $6, %r9
	call add6m

	mov %rax, %rsi

        lea output_format(%rip), %rdi
        xor %eax, %eax
        call printf@plt

	mov $1, %rdi
        mov $2, %rsi
        mov $3, %rdx
        mov $4, %rcx
        mov $5, %r8
        mov $6, %r9
	push $7        
	call add7m

        mov %rax, %rsi

        lea output_format(%rip), %rdi
        xor %eax, %eax
        call printf@plt


        mov $1, %edi
        mov $2, %esi
        mov $3, %edx
        mov $4, %ecx
        mov $5, %r8d
        mov $6, %r9d
        push $7
        call add7

        mov %rax, %rsi

        lea output_format(%rip), %rdi
        xor %eax, %eax
        call printf@plt

        mov $1, %edi
        mov $2, %esi
        mov $3, %edx
        mov $4, %ecx
        mov $5, %r8d
        mov $6, %r9d
        push $7
	push $8
        call add8

        mov %rax, %rsi

        lea output_format(%rip), %rdi
        xor %eax, %eax
        call printf@plt
	
        mov $1, %edi
        mov $2, %esi
        mov $3, %edx
        mov $4, %ecx
        mov $5, %r8d
        mov $6, %r9d
        push $7
        push $8
	push $9
        call add9

        mov %rax, %rsi

        lea output_format(%rip), %rdi
        xor %eax, %eax
        call printf@plt


        mov $1, %edi
        mov $2, %esi
        mov $3, %edx
        mov $4, %ecx
        mov $5, %r8d
        mov $6, %r9d
        push $7
        push $8
	push $9
	push $10
        call add10

        mov %rax, %rsi

        lea output_format(%rip), %rdi
        xor %eax, %eax
        call printf@plt

	xor %eax, %eax
	ret

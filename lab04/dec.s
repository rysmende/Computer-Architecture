.section .data
number:
        .int 0, 0
input_format:
        .string "%ld"
output_format:
        .string "%ld\n"
.section .text
.global main
main:
        push %rbp
        xor %eax, %eax
        
	lea input_format(%rip), %rdi
        lea number(%rip), %rsi
        xor %eax, %eax
        call scanf@plt
        
	mov number(%rip), %rsi
        dec %rsi
        
	lea output_format(%rip), %rdi
        xor %eax, %eax
        call printf@plt
        
	xor %eax, %eax
        pop %rbp
        ret


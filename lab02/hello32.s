.section .data

message:
    .string "hello, world"

.section .text

.global main
main:
    call __x86.get_pc_thunk.bx
    add $_GLOBAL_OFFSET_TABLE_, %ebx
    lea message@GOTOFF(%ebx), %eax
    push %eax
    call puts@plt
    add $0x4, %esp
    xor %eax, %eax
    ret

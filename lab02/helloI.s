.intel_syntax noprefix

.section .data

message:
    .string "hello, world"

.section .text

.global main
main:
    lea rdi, [rip+message]
    call puts@plt          
    xor eax, eax
    ret

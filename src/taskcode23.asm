%include "asmc_io.inc"

# task 2.3 goal 
;Write an assembler program that
;defines an array of 100 elements,
; for that ill use loops 
;initialize the array to the numbers 1 to 10
segment .data


segment .bss
    

segment .text
    global asm_main

asm_main:
    pusha

    popa             ; restore registers saved by pusha, must match it before ret
    mov     eax, 0   ; return 0
    ret
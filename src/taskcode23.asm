%include "asm_io.inc"

; task 2.3 goal 
;Write an assembler program that 
;defines an array of 100 elements, initialize the array to the numbers
;1 to 100, and then sums the array, 
;outputting the result.
segment .data
    Elarray     times 100 dd  0  ; define array of 100 elements 


segment .bss
    ;Elarray     resd 100

segment .text
    global asm_main

asm_main:
    pusha
; initialize array 1 to 100  elements define 
    mov         ecx, 100 ; register for loops acts as a counter 
    mov         ebx, 0 
    mov         eax, 1   ; values to store 1 to 100
    fill_loop: ; populate loop with items 1 to 100 each loop icrement by 1
        mov     [Elarray + ebx*4], eax
        inc     eax
        inc     ebx
        loop    fill_loop
    
    mov     ecx, 100
    mov     ebx, 0
    mov     eax, 0 
    sum_loop: ; summ up array using loop 
        add     eax, [Elarray + ebx*4]
        inc     ebx
        loop    sum_loop
    call    print_int   ; print ints in eax aka results 
    call    print_nl 

    popa             ; restore registers saved by pusha, must match it before ret
    mov     eax, 0   ; return 0
    ret
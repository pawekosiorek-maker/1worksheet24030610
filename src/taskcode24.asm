%include "asm_io.inc"

; task 2.4 goal 
; Finally, extend the previous program so that
; it asks the user to enter a range to sum, checking the
; range is valid, and then display the sum of that range.

; for range will need 2 range_int
segment .data
    msg_invalid db "Invalid range: 1 <=  num1 <= num2 <= 100 ", 0
    range_int1   db " num1 for range " , 0 ; prompt to enter second int
    range_int2   db " num2 for  range" , 0
    Elarray     times 100 dd  0  ; define array of 100 elements 
    


segment .bss
    ;Elarray    resd 100
    result      resd 1 
    intager1    resd 1
    intager2    resd 1

segment .text
    global asm_main

asm_main:
    pusha
;; reading inputs of the user and passing them 
    mov     eax, range_int1       ; print the first prompt
    call    print_string        ;
    call    print_nl            ;
    call    read_int            ; read number
    mov     [intager1], eax     ; load int1

    mov     eax, range_int2       ; print the second prompt
    call    print_string        ;
    call    print_nl            ;
    call    read_int            ; read number 
    mov     [intager2], eax     ; load int2
    ; comparig the inputs captured 
    mov     eax, [intager1]
    mov     ebx, [intager2]
    cmp     eax, 1 
    jl      error_num     ; if eax is lower than 1 jump if less prints error message  
    cmp     ebx, 100 
    jg      error_num     ; if number in ebx is greater than 100 jump if bigger prints error message   
    cmp     eax, ebx
    jg      error_num     ; cheks if eax > ebx / start > end of the range prints error message 

; initialize array 1 to 100  elements define 
    mov         ecx, 100 ; register for loops acts as a counter 
    mov         ebx, 0 
    mov         eax, 1   ; values to store 1 to 100

    fill_loop: ; populate loop with items 1 to 100 each loop icrement by 1
        mov     [Elarray + ebx*4], eax
        inc     eax
        inc     ebx
        loop    fill_loop
    
; target section of task24  -
; Elarray start point intager 1 or 2 check 
; 
    mov     ebx, [intager1]   
    dec     ebx  ; start of the index 
    mov     ecx, [intager2]
    sub     ecx, [intager1]
    inc     ecx             ; calculation how many elements are in ecx
    mov     eax, 0 
    sum_loop: ; summ up array using loop 
        add     eax, [Elarray + ebx*4]
        inc     ebx
        loop    sum_loop
    call    print_int   ; print ints in eax aka results 
    call    print_nl 
    jmp    finish_summing

    error_num: 
        mov     eax, msg_invalid
        call    print_string 
        call    print_nl
    finish_summing:
        popa             ; restore registers saved by pusha, must match it before ret
        mov     eax, 0   ; return 0
        ret
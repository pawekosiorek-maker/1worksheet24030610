%include "asm_io.inc"

segment .data
    giveint1        db "Enter 1 number" , 0 ; prompt to enter first int
    giveint2        db "Enter 2 number" , 0 ; prompt to enter second int
    outsm            db " sum is =  ", 0 ; egxample , 0s end strings and
                                         ; brake give-int1 from give-int2
segment .bss
    intager1        resd 1 ; definition of  resd 1:  res- reserve the memory
    intager2        resd 1 ; with no value assigned,
    result          resd 1 ;  d-4 bytes of memory assigned, 1 - times x 1  results

segment .text
        global asm_main
asm_main:
    pusha

    ; first input int 1 and 2 capturing and saving to eax

    mov     eax, giveint1       ; print the first prompt
    call    print_string        ;
    call    read_int            ; read num in eax
    mov     [intager1], eax     ; save int to eax

    ; second int capture and saving code to eax

    mov     eax, giveint2       ; print the first prompt
    call    print_string        ;
    call    read_int            ; read number to eax
    mov     [intager2], eax     ; save int 2 to eax

    ; add int1 and int2  save results to eax

    mov     eax, [intager1]     ; eax = int1
    add     eax, [intager2]     ; eax = int1 + int2
    mov     [result], eax       ; result = int1 + int2

    ; print output with results
    mov     eax, outsm       ; print output massage
    call    print_string        ;
    mov     eax, [result]       ; print_int contents in eax
    call    print_int
    call    print_nl            ; newline

    ; mov     eax, [integer1]     ; eax = int1
    ; add     eax, [intager2]     ; eax = int1 + int2
    ; mov     [result], eax       ; result = int1 + int2
    ; call    print_int           ; print result

    popa
    mov     eax, 0   ; return 0
    ret

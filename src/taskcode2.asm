%include "asm_io.inc"


; i recycled some of the code from task1 
segment .data
; giveint1        db "Enter 1 number" , 0 ; prompt to enter first int
;loopLimitInt  db "set limit for loop", 0 ; prompt the user to set the loop limit
giveint1        db "starting number for loop" , 0 ; prompt to enter second int
outsm            db " comparison of result  ", 0

msg_zero      db "The number is zero", 0
msg_negative  db "The number is negative", 0
msg_positive  db "The number is positive", 0

segment .bss
    ;loopLimitInt    resd 1
    ; intager1        resd 1 ; definition of  resd 1:  res- reserve the memory
    intager2        resd 1 ; with no value assigned,
    result          resd 1 ;  d-4 bytes of memory assigned, 1 - times x 1  for results
segment .text
    global asm_main

asm_main:
    pusha
; gather ints for loop's  limit
    ; mov     eax, loopLimitInt       ; print the first prompt
    ; call    print_string        ;
    ; call    read_int            ; read num in eax
    ; mov     eax, [loopLimitInt] ; save int to eax
;gather ints for loop starting num (be it positive 0 negative compared to limiting int )
    mov     eax, giveint1       ; print the first prompt
    call    print_string        ;
    call    print_nl            ;
    call    read_int            ; read number to eax
    mov     [intager2], eax     ; save int 2 to eax
; acctual looping and coditionals in assembly  if, if/else, while and do…while into compare-and-jump code.
; consider mov byte [intager2](can do it to loopLimitInt), 5- or whatever 
   ;  mov     eax, [loopLimitInt] dont think i need that 
    mov     eax, [intager2]     ; dont know if i need that move into registery from memory
    cmp     eax, 0 
    je      flag_zero           ; if equal to 0, jump to flag_zero
    jl      flag_negative       ; if less than 0, jump to flag_negative
    jg      flag_positive       ; if grater tahn 0, jump to flag_positive

        flag_zero:
            mov eax, msg_zero   ;  EDX data	used for I/O operations.
            call print_string   ;  ECX automatically used as a loop and shift counter.
            call print_nl
            jmp resolution

        flag_negative:
        mov eax, msg_negative
        call print_string 
        call print_nl
        jmp resolution

        flag_positive:
        mov eax, msg_positive
        call print_string
        call print_nl
        jmp resolution

        resolution:
        mov eax, outsm
        call    print_string
        mov     eax, [intager2]
        call print_int
        call print_nl
    popa             ; restore registers saved by pusha, must match it before ret
    mov     eax, 0   ; return 0
    ret
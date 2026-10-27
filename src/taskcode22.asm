%include "asm_io.inc"

;Once you have spent a bit of time understanding how loops and conditionals can be implemented in
;assembler, write an assembler program that asks the user for their name and the number of times to
;print a welcome message. Test that the value is less than 100 and greater than 50 and then finally print
;out a welcome string that many times. Print an error message if the number is two large or small
;materials accesed to complete task 2 :

segment .data

get_name        db "enter your name: ", 0
get_intloop     db "how many times print welcome message ( 50 < n < 100)", 0
msg_welcome     db "Welcome, ", 0
er_small        db "Error number to low", 0
er_large        db "Error number to high", 0

NAMEMAX         equ 31 ; max char for names 

segment .bss
    captured_name       resb NAMEMAX + 1  ; byte reserved 
    count               resd 1 ; reserv just 4 bytes

segment .text
    global asm_main

asm_main:
    pusha

    ;get name 
    mov     eax, get_name
    call    print_string
    mov     ebx, 0

    read_loop_name:
        call    read_char       ; chars captured in eax
        cmp     eax, 10         ; new line
        je      read_name_done  ; conditional jump 
        cmp     ebx, NAMEMAX    ; 
        jae     read_loop_name  ; jumpe above if equal
        mov     [captured_name + ebx], eax  
        inc     ebx             ; increment by one
        jmp    read_loop_name

    read_name_done:
        mov     byte [captured_name + ebx], 0   ; 

; gather the count ask > capture input > save in register eax 
    mov     eax, get_intloop
    call    print_string
    call    read_int
    mov     [count], eax     

; check range 50 < n < 100 

    cmp     eax, 50 
    jle     too_small       ; if smaller <= 50 jump 
    cmp     eax, 100        
    jge     too_large       ; if bigger >= 100 jump

; valid - print the welcome message  x times 
    mov     ecx, [count]        ; ECX is the loop counter
    welcome_loop:
        mov     eax, [count]
        sub     eax, ecx
        inc     eax 
        call    print_int
        mov     eax, ' '
        call    print_char
        mov     eax, msg_welcome
        call    print_string
        mov     eax, captured_name
        call    print_string
        call    print_nl
        loop   welcome_loop ; loop = de
    jmp     finish

    too_small:
        mov     eax, er_small
        call    print_string
        call    print_nl
        jmp     finish

    too_large:
        mov     eax, er_large
        call    print_string
        call    print_nl

    finish:
    popa
    mov         eax, 0 
    ret                     ; return 0


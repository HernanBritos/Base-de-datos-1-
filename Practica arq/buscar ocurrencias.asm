.model small
.stack
.data 
    cartel1 db "Presione una tecla para buscar: $"
    cartel2 db "Apariciones :$"
    cadena db "qwettyuiopasdffgjls1234567890$"
    
.code
mov ax, @data
mov ds, ax 

xor si, si;Indice
xor ax, ax
xor bx, bx

mov ah, 09h
mov bx, offset cartel1
int 21h
mov ah, 01h
int 21h
inicio:
cmp cadena[si],'$'
je fin
cmp cadena[si],al
jne otro
inc bl
otro:
inc si
jmp inicio
fin:
call nueva_linea
add bl, 30h
mov ah, 09h
mov dx, offset cartel2
int 21h
mov dl, bl
mov ah, 02h
int 21h
mov ah, 4ch
int 21h

nueva_linea proc
    mov ah, 02h
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    ret
nueva_linea endp 
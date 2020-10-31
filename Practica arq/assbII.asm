.model small
.stack 
.data
.code
 
 mov ax,@data 
 mov ds,ax
 
 xor si,si
 xor ax,ax                                                                       
 
 inicio:
    mov al,[SI]
    mov ah,al 
    and ah,42h
    cmp ah,00h
    je cumple
    cmp ah,42h
    jne otro
 cumple:
    or al,10h
    mov al,[SI]
 otro:
    inc si
    cmp si,0011h
    jne inicio
     
    mov ah,4ch
    int 21h         
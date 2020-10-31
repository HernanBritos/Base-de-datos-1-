.model small
.stack 
.data 
    vector db ?
.code 

mov ax,@data
mov ds,ax

xor ax,ax
xor si,si
xor di,di
xor bx,bx
xor dx,dx

inicio:
    call ingreso
    call contar_unos
mov ah,4ch
int 21h 
;----------------------------------------
ingreso proc 

mov ah,01h
leo:
    int 21h
    cmp al,13h
    jng sigo
    ret
sigo:
    cmp al,30h
    jl leo
    cmp al,39h
    jg leo
    mov vector[si],al
    inc si 
    jmp leo
ingreso endp
;----------------------------------------

contar_unos proc
mov ah,02h
contar:
    mov bl,vector[di]
    mov dl,bl
    int 21h
    xor dx,dx 
    sub bl,30h 
    mov cx,0008
recorrer: 
    rcl bl,01
    adc dl,00h
    loop recorrer
add dl,30h
int 21h 
xor dx,dx
inc di
cmp di,si
jng contar
ret
contar_unos endp

.model small
.stack
.data
    tabla db ?
.code 

mov ax,@data
mov ds,ax

xor si,si
xor ax,ax
xor bx,bx
xor cx,cx
xor dx,dx

mov cx,0020
inicio:
    mov ah,tabla[si]
    add al,ah ; acumulo y sumo en al
    inc si
    loop inicio  ; termina la sumatoria
xor cx,cx
xor ah,ah
 ;  promedio 
mov cl,0020
div cl           ; ah resto--al resultado, div cl hace ax/cl
xor cx,cx   ; inicializo 

mov ah,02h     ; mostrar por pantalla lo que esta en dl
mov cl,20
xor si,si
mayor:
    mov bl,tabla[si]
    cmp al,bl
    jng otro
    mov dl,bl
    int 21h
otro:
    inc si
    loop mayor     

mov ah,4ch
int 21h 
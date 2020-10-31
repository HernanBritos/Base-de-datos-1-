.model small 
.stack
.data   
        cartel db 'ingrese 10 numeros $'
       vector db 10 
.code                 

mov ax,@data
mov ds,ax

xor si,si
xor cx,cx
xor ax,ax



       
mov dx,offset cartel
mov ah,09h
int 21h       
       
       
mov ah,01h
mov cx,0010
leo:
int 21h
cmp al,30h
jl leo
cmp al,39h
jg leo 
mov vector[si],al 
inc si
loop leo
call cuenta_impar
mov ah,4ch
int 21h                    
cuenta_impar proc
    mov cx,10
    xor si,si
    xor bx,bx
    inicio:
    mov al,vector[si]
    and al,01h
    cmp al,00h
    je sigo
    inc bl
    sigo:
    inc si
    loop inicio
    ret 
    cuenta_impar endp
mov ax,bx ;cantidad de impares en bx,se pasa a ax
mov cl,10
div cl
mov bx,ax ;bh resto bl resultado
xor dx,dx
add dl,bl  ;sumo el resulado
add dl,30h
mov ah,02
int 21h
add bl,dh ;sumo el resto
add bl,30h
int 21h
       
       
mov ah,4ch
int 21h     
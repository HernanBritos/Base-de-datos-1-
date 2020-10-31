.model small
.stack
.data
       cartel db 'Ingrese numeros..$'
       vector db 10
.code  


mov ax,@data
mov ds,ax

xor ax,ax
xor bx,bx
xor dx,dx
xor si,si


mov dx,offset cartel 
mov ah,09h
int 21h

mov ah,01h

leo:
    int 21h 
    cmp al,13
    jnz controlo
    jmp sigo
controlo:
    cmp al,30h
    jl leo 
    cmp al,39h
    jg leo 
    mov vector[si],al
    inc si 
    jmp leo 
sigo:
    mov ax,cx
    mov cl,10    ; 0-99
    div cl
    mov bx,ax
    xor dx,dx
    mov cx,ax
    mov ah,02h
    add dl,bl
    add dl,30h
    int 21h
    mov dl,bh 
    add dl,30h
    int 21h    
    mov bx,cx
    xor cx,cx
    mov cl,8     ; inicio contador de loop
    mov ah,02h
binario:
    mov dl,30h   ;inicializo dl con 30h (0)
    rcl bl,1     ; pasa al carry el bit mas sig, el carry lo pone el bit menos sig
    adc dl,00h   ;dl:=dl+0h+carry
    int 21h 
    loop binario 
    
 mov ah,4ch
 int 21h   
           
       
       
       
       
       
       
       
       
       
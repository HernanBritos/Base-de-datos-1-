.model small
.stack
.data       
        
 ;variable db a,b,c,d
  
.code

mov ax,@data
mov ds,ax 

xor ax,ax
xor cx,cx
xor si,si
xor cx,cx

inicio: 
    mov al,[si]
    and al,14h
    cmp al,00h
    jne otro
    inc cl  
    jmp sigo
otro:
    cmp al,14h
    jne sigo
    inc cl
sigo:
    inc cl 
    cmp si,0021h  
    jne inicio
    mov [0150h],cl
    mov ah,4ch
    int 21h




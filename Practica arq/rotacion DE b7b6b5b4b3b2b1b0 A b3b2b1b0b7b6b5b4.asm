.MODEL SMALL 
.STACK 
.DATA 
    dato db 45h ;
    
.CODE
    
    mov ax,@data
    mov ds,ax 
    
    xor ax,ax
    xor bx,bx
    
    mov ah,02h
    mov bl,45h
    mov dl,bl
    int 21h 
    mov bh,bl
    rol bl,4
    xor cx,cx
    mov ah,02h
    mov cl,8
    binario:
    xor dl,dl
    rcl bl,1
    adc dl,30h
    int 21h
    loop binario
  
 
    mov ah,4ch
    int 21h 
 
.MODEL SMALL 
.STACK 
.DATA 
    cartel db 'ingrese numeros$'
    cartel2 db 'el promedio es:$'
    cont db ?
    
.CODE
    
    mov ax,@data
    mov ds,ax 
    
    xor ax,ax
    mov ah,09h
    mov dx, offset cartel 
    int 21h  
    call nuevaL
    call ingresoV 
    call nuevaL
    mov ah,09h
    mov dx,offset cartel2
    int 21h
    xor ax,ax
    mov ax,bx
    xor cx,cx 
    mov cl,cont
    div cl 
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h 
 
    mov ah,4ch
    int 21h 
   
 ingresoV proc
    xor ax,ax                                 
    xor bx,bx
    xor cx,cx
    xor dx,dx 
    
    ingreso:
        mov ah,01h 
        int 21h 
        cmp al,13
        je  fin 
        sub al,30h
        add bl,al 
        inc cont
        jmp ingreso 
    fin:
        
        ret
 ingresoV endp  
 
 pedir_otro proc
     mov ah,02h
     mov dl,08
     int 21h
     ret
 pedir_otro endp
 
 nuevaL proc 
    mov ah,02h
    mov dl,10
    int 21h
    mov dl,13 
    int 21h
    ret
 nuevaL endp   
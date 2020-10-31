.model small
.stack
.data 
    tabla db '123$'
.code 

    mov ax,@data 
    mov ds,ax
      
    xor si,si
    xor ax,ax
    xor bx,bx  
      
    mov si,offset tabla   
    push si
    call sumar_contar
    xor cx,cx 
    xor bx,bx 
    
    pop cx     ; cantidad
    pop bx     ; suma 
    
    mov ax,bx
    div cx         ;tengo en  al el resultado
    
    
    mov ah,02h
    mov dl,al 
    int 21h
     
    mov ah,4ch
    int 21h 
    
    sumar_contar proc
        xor si,si
        xor di,di
        xor ax,ax
        xor bx,bx
        xor cx,cx 
        pop di   ;mando ip a pila 
        pop si   ;mando ip de tabla a pila
        sumar: 
        mov al,[si] ;sumo 
        cmp al,'$'
        je fin
        add bl,al
        inc si
        inc cx
        jmp sumar   
        fin: 
        push bx
        push cx 
        push di 
        ret              
     sumar_contar endp    



              
.model small
.stack 
.data
    vector_impares db 10 dup (0) 
    cartel db 'Ingrese  numeros $'
.code                               
 
 mov ax,@data
 mov ds,ax
 
 xor ax,ax
 xor cx,cx
 xor si,si    
 
 inicio:
    mov dx, offset cartel 
    mov ah,09h
    int 21h
    mov ah,01h
    mov cx,10 
 leer:
    int 21h 
    mov ch,al 
    and ch, 01h
    cmp ch,00h
    jne   otro
    mov vector_impares[SI],al 
    inc si
    dec cx
 otro:   
  xor ch,ch 
  loop inicio
  
  mov ah,02h
 mostrar:
    mov dl,[SI]
    int 21h 
    dec si
    dec cl  
    cmp si,00h
    jnl mostrar
    
    mov ah,4ch
    int 21h                               ; no es menor 
   
     
  
 
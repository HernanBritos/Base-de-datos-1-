.model small
.stack
.data
    cIngreso db 'Ingresar numero: $' 
    vector db ?
.code 

mov ax,@data
mov ds,ax 

xor ax,ax
xor cx,cx
xor bx,bx
xor si,si 


mov si,01  
mov ah,09h
mov dx,offset cIngreso
int 21h

leer: 
mov ah,01h 
int 21h
cmp al,13
je mostrar 
cmp al,30h 
jb  leer
cmp al,39h 
ja leer
mov bl,al 
mov vector[si],al  
loop leer 

comparar:
xor si,si 
mov si,01 
cmp bl,Vector[si]
jb guardar
inc si
guardar: 
mov bl,vector[si]

mostrar:
mov ah,02h
mov dl,bl
int 21h
 

mov ah,4ch
int 21h 


         
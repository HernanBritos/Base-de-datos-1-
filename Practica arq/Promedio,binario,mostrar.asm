.Model Small
.Stack
.Data
        Cartel db 'Ingrese 20 numeros:  $'
        Cartel2 db 'El Numero ingresado esta mal $'
        Cartel3 db 'El promedio es: $'
        Cartel4 db 'Numeros mayores al promedio: $'
        Cartel5 db 'El promedio en binario es: $'
        Cartel6 db 'El promedio en binario pero inverso es: $' 
        Vector db ?
.Code                                    

    Mov Ax,@Data
    Mov Ds,Ax
 
 Xor Ax,Ax            
 Xor Si,Si
 xor bx,bx
 Mov si,01                              
 call Ingresa_Valores
 call promedio                           
 call mostrar_decimal
 call mostra_promedio_binario
 Mov ah, 4ch
 Int 21h   
                  
                
mostra_promedio_binario proc         ;saco el numero binario de del promedio que esta el bl
                        xor cx,cx
                        xor dx,dx
                        mov cx,8 
                        xor di,di
                        sub bl,30h
                        mov di,bx
                        call nueva_linea
                        mov dx,offset cartel5
                        mov ah,09h          
                        int 21h 
                        mov ah,02h
                        derecho:
                        mov dx,30h
                        rcl bl,1
                        adc dx,00h
                        int 21h
                        loop derecho
                        xor cx,cx
                        xor dx,dx
                        mov bx,di
                        mov cx,8 
                        call nueva_linea
                        mov dx,offset cartel6
                        mov ah,09h          
                        int 21h 
                        mov ah,02h
                        izquierdo:
                        mov dx,30h
                        rcr bl,1
                        adc dx,00h
                        int 21h
                        loop izquierdo    
                        ret
                        
mostra_promedio_binario endp



promedio proc          ;saco el promedio  que esta en bl
    Xor Cx,Cx
    xor dx,dx 
    mov cx,20
    mov ax,bx                         
    div cx
    mov bx,ax
    call nueva_linea
    mov dx,offset cartel3
    mov ah,09h          
    int 21h 
    mov ah,02h        
    mov dx,bx        
    int 21h    
    ret
promedio endp 


Mostrar_decimal Proc       ;muestra un vector en formato decimal 
         xor cx,cx
         xor si,si
         mov si,01
         mov cx,20         
         call nueva_linea          ;hago nueva linea
         Mov dx, Offset Cartel4    ;llamo a un cartel
         Mov Ah,09H
         Int 21H 
         mov ah,02h                
         Inici:            
         mov dl,Vector[si]     
         cmp dx,bx
         jbe no_es 
         int 21h
         No_es:
         inc si            ;incremento si para seguir recorriendo el vector y que no escriba lo mismo          
         loop inici           ;loop    
         ret                  ;salgo del procedimiento 
Mostrar_decimal endp  

         
cargar proc  ;cargo en un vector
     xor ah,ah
     Add bx,ax          ;sumo en bl los valores que ingrese por teclado            
     Mov Vector[SI],Al               
     inc si                     
     ret                     ;termina 
cargar endp   
 
 
Nueva_linea proc        ;hace una nueva linea    
     mov ah,02h 
     mov dl,10
     int 21h 
     mov dl,13
     int 21h 
     ret      
Nueva_linea endp    
 
 
 
ingresa_valores proc  
   Xor Cx,Cx 
   Mov cx,20
   mov dx,offset cartel
   mov ah,09h
   int 21h
   jmp otra_tecla 
   otra_tecla1:
   call nueva_linea
   mov dx,offset cartel2
   mov ah,09h
   int 21h
   Call nueva_linea
   mov dx,offset cartel
   mov ah,09h
   int 21h
   otra_tecla:        ;Ingreso por teclado valores y lo valida
   mov ah,01h
   int 21h             ;comparo el valor ingresado para ver si es correcto 
   cmp al, 30h
   jb otra_tecla1      ;salta si no es un valor dentro del rango
   cmp al, 39h
   ja otra_tecla1      ;salta si no es un valor dentro del rango
   call cargar        ;llama funcion 
   xor ch,ch
   Loop Otra_tecla  
   ret 
ingresa_valores endp 
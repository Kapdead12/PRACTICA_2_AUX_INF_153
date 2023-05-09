data segment
    x db 10 dp(0)  
    numero dw  0       
    enter db 10,13,'$'
    intro db "Introduzca un numero: $"
    contador dw 0  
    contador2 dw 0 
    aux1 dw 0
    aux2 dw 0 
    aux dw 0
ends

code segment
start:
    ; Cargar la dirección del primer elemento del vector en bx
    mov ax, data
    mov ds, ax
    
    ; Pedimos el tamaño del vector
    
    lea dx,intro
    mov ah,9
    int 21h
    call pideNumero 
    call return
    mov ax,numero
    
    call imprime
    call return
    mov ah, 1
    int 21h
    
    mov ax, 4c00h
    int 21h
    
    pideNumeroEsp:
        mov numero,0
        mov bx,10
    leerNumeroEsp:
        mov ah,1
        int 21h
        cmp al,32
        jnz p1  
        jz finLecturaEsp
        p1:    
            sub al,48
            mov cx,0
            mov cl,al
            mov ax,numero
            mul bx
            add al,cl
            mov numero, ax
            jnz leerNumeroEsp
    finLecturaEsp:
        ret    
     
    pideNumero:
        mov numero,0
        mov bx,10
    leerNumero:
        mov ah,1
        int 21h
        cmp al,13     
        jz finLectura
        sub al,48
        mov cx,0
        mov cl,al
        mov ax,numero
        mul bx
        add al,cl
        mov numero, ax
        jnz leerNumero
     finLectura:
        ret    
     
     
     imprime:
        mov bx,10
        mov cx,0
        reducir:
            mov dx,0
            div bx
            push dx
            inc cx
            cmp ax,0
            jz mostrar
            jmp reducir 
        mostrar: 
            mov dx,0
            pop dx
            add dl, 48
            mov ah,2
            int 21h 
            loop mostrar      
        ret       
    
     return:
        lea dx, enter
        mov ah, 9
        int 21h    
        ret
              
                
end start

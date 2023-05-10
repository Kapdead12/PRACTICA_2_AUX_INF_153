; multi-segment executable file template.

data segment  
    v db 10 dup(0)
    numero dw  0
    enter db 10,13,'$'
    len dw 0
    contador dw 0
    salida db "Numero: $"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    call pideNumero
    call return  
    mov ax,numero
    mov len, ax
            
    lea si,v 
    
    mov cx,0
    ciclo:
        cmp cx, len ; comparar cx con 11
        jz fin ; si cx >= 11, salir del loop
        inc cx
        mov contador, cx
        
        call pideNumeroEsp
        mov bx,numero
        mov [si], bx
        inc si
        
        mov cx, contador
        jmp ciclo ; volver al inicio del loop
    
    fin:
    dec si
    mov cx,0
    call return    
    lea dx,salida
    mov ah,9
    int 21h
    AlReves:
        cmp cx,len
        jz fin1
        inc cx
        mov dx,[si] 
        add dx,48
        mov ah,2
        int 21h
        
        mov dx,' '
        int 21h
            
        dec si
        jmp AlReves
    fin1:    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h  
    
    
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
    
     return:
        lea dx, enter
        mov ah, 9
        int 21h    
        ret
        
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
                 
ends

end start ; set entry point and stop the assembler.
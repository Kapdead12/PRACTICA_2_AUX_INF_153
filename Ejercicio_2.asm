; multi-segment executable file template.

data segment  
    v db 1,2,3,4,4
    numero dw  0
    enter db 10,13,'$' 
    may db "Mayor: $"
    apa db "Apariciones: $"
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
            
    lea si,v 
    mov cx,1 
    mov ax,0   
    mov al,[si]  
    inc si
    Mayor:
        cmp cx,5
        jz Repetir
        buscar:
            cmp [si],al
            jnl actualizar
            jmp continua
            actualizar:
                mov al,[si]
            continua:
                inc si        
                inc cx
                jmp Mayor
    
    Repetir:
        lea si,v
        mov cx,0
        mov bx,0
        ciclo:
            cmp cx,5
            jz pantalla
            cmp al,[si]
            jz incrementar
            jmp continuar
            incrementar:
                inc bx  
            continuar:
                inc si
                inc cx
                jmp ciclo
    pantalla:
        mov cx,ax
        lea dx,may
        mov ah,9
        int 21h
        
        mov dx,cx
        add dx,48
        mov ah,2
        int 21h
        
        mov dx,' '
        int 21h
        
        lea dx,apa
        mov ah,9
        int 21h
        
        mov dx,bx
        add dx,48
        mov ah,2
        int 21h
            
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h         
                 
ends

end start ; set entry point and stop the assembler.

; multi-segment executable file template.

data segment  
    numero dw  0   
    enter db 10,13,'$' 
    intro db "Introduzca un numero: $"
    dig db "Introduzca el digito: $"
    salida db "si existe$"     
    nosalida db "no existe$" 
    p1 dw 0
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
              
    introducir:
        lea dx,intro
        mov ah,9
        int 21h
        call pideNumero
        call return    
        mov ax,numero
        mov p1,ax
        
        lea dx,dig
        mov ah,9
        int 21h
        call pideNumero
        call return
    
    buscar:
        mov ax,p1
        mov bx,10
        reducir:
            mov dx,0
            div bx
            cmp numero,dx
            jz pantalla
            cmp ax,0
            jz nopantalla
            jmp reducir 
    pantalla:  
        lea dx,salida
        mov ah,9
        int 21h
        jmp fin
    nopantalla:
        lea dx,nosalida
        mov ah,9
        int 21h
    fin:        
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
        lea dx,enter
        mov ah,9
        int 21h
        ret          
ends

end start ; set entry point and stop the assembler.

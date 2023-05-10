; multi-segment executable file template.

data segment
    x db 8 dp(0)  
    numero dw  0       
    enter db 10,13,'$'
    intro db "Introduzca un numero: $"
    salida db "Numero: $"
    cont dw 0  
    aux1 dw 0
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
    
    clasificar:
        mov bx,10
        mov cx,0    
        lea si,x
        reducir:
            mov dx,0
            div bx
            mov [si],dl
            inc cx
            inc si
            cmp ax,0
            jz ciclo
            jmp reducir
    ciclo:
        mov bx,0
        mov aux,cx
        lea dx,salida
        mov ah,9
        int 21h
        iterar: 
            lea si,x
            mov cx,aux
            cmp bx,10
            jz fin
            iterar2:
                cmp cx,0
                jz continuar
                cmp [si],bl
                jz pantalla
                jmp continuar2
                pantalla:
                    mov dx,bx
                    add dx,48
                    mov ah,2
                    int 21h
                    inc cont
                    mov dx,cont
                    cmp dx,aux
                    jz fin
                continuar2:
                    dec cx
                    inc si
                    jmp iterar2
            continuar:
                inc bx
                jmp iterar
    fin:
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
     
    
     return:
        lea dx, enter
        mov ah, 9
        int 21h    
        ret
              
                
end start
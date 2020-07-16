; to check if a no is >,< or = to 3
data segment      
	msg db "Enter a no: $"
    msg_g db 13,10,"Greater$"
    msg_e db 13,10,"Equal$"
    msg_l db 13,10,"Lesser$"
data ends

code segment
    assume cs:code ds:data

start:
    mov ax,@data
    mov ds,ax 
    mov ah,9
    lea dx,msg
    int 21h
    
    mov ah,01h
    int 21h   
    
    and al,0fh
    
    cmp al,03h
    jg greater
    jl lesser
    lea dx,msg_e
    jmp endprog
    
    greater:
        lea dx,msg_g
        jmp endprog
    
    lesser:
        lea dx,msg_l
        jmp endprog
        
    endprog:
        mov ah,09h
        int 21h
    code ends
end start
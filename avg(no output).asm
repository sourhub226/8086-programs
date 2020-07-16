;to find avg of 2 nos
data segment
    n1 db 21h
    n2 db 27h
    avg db ?
data ends

code segment
    assume cs:code ds:data

start:
    mov ax,@data
    mov ds,ax
    mov ax,0
    mov al,n1
    add al,n2
    mov bl,02
    div bl
    mov avg,al
    code ends
end start
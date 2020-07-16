;to convert hex to dec using a stack
data segment
	n dw 23abh
ends data

code segment
	assume cs:code ds:data
	
start:
	mov ax,@data
	mov ds,ax
	mov ax,n
	mov cx,0
	loop1:
		cmp ax,0
		je print1
		
		mov bx,10
		div bx
		push dx
		inc cx
		mov dx,00
		jmp loop1
	
	
	print1:
        cmp cx,0 
        je exit
        
        pop dx
        add dx,30h 
        mov ah,02h 
        int 21h 
        dec cx 
        jmp print1 
        
    exit:
        mov ah,4ch
        int 21h
	ends code
end start












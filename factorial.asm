;to find factorial
data segment
	ans dw ?
	msg1 db "Enter a no: $"
	msg2 db 13,10,"Factorial ans = $"
ends data

printstr macro msg
	mov ah,09h
	lea dx,msg
	int 21h  
endm

printans macro x
	mov ax,x
	mov cx,0
	mov dx,0
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
endm

code segment
	assume cs:code ds:data
	
start:
	mov ax,@data
	mov ds,ax
	
	printstr msg1
	mov ah,01h
	int 21h
	sub al,30h
	mov ah,0 
	mov cx,ax
	sub cl,01
	
	fact:
		mul cx
		loop fact
	mov ans,ax
	
	printstr msg2
	printans ans		

	ends code
end start












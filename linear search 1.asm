data segment
	msg1 db "Found at position: $"
	msg2 db "Element not found$"
	array db 1,6,2,8,4
ends data

code segment
	assume cs:code ds:data
	
start:
	mov ax,@data
	mov ds,ax
	mov cl,5
	
	search:
		mov bl,array[si]
		cmp bl,8
		je found
		inc si
		loop search
		
	not_found:
		lea dx,msg2
		mov ah,09h
		int 21h
		jmp endprog
		
	found:
		lea dx,msg1
		mov ah,09h
		int 21h
		mov dl,6
		sub dl,cl
		add dl,30h
		mov ah,02h
		int 21h 
		
	endprog:
		mov ah,4ch
		int 21h
	
ends code
end start
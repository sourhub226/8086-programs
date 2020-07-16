;array user input and display
data segment
	n db ?
	arr db n dup(?)
	msg1 db "Enter n: $"
	msg2 db 13,10,"Enter no: $"
	msg3 db 13,10,"Entered nos are: $"
ends data

code segment
	assume cs:code ds:data
	
start:
	mov ax,@data
	mov ds,ax 
	
	mov ah,9h
	lea dx,msg1
	int 21h 
	mov ah,01h
	int 21h
	sub al,30h
	mov n,al
	mov cl,n    
	l1:
		lea dx,msg2
		mov ah,9h
		int 21h
		mov ah,01h
		int 21h
		;sub al,30h
		mov arr[si],al
		inc si
		loop l1 
	
	mov si,0
	mov cl,n
	lea dx,msg3
	mov ah,9h
	int 21h	
	l2:
		mov ah,02h     
		mov dl,arr[si]
		int 21h
		inc si
		loop l2
			
	mov ah,4ch
	int 21h	
	
ends code
end start
	
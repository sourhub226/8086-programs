;Addition of 1 digit  dec no. (user input)
data segment
	message1 db "Enter 1st no: $"
	message2 db 13,10,"Enter 2nd no: $"
	message3 db 13,10,"Sum = $" 
	newline db 13,10,"$"
	
data ends

code segment
	assume cs:code ds:data
	
start:

	mov ax,@data
	mov ds,ax
	mov ax,0
	mov ah,9 
	lea dx, message1 
	int 21h
	mov ah,1
	int 21h
	aaa 
	mov bl,al
	mov ah,9
	lea dx,message2
	int 21h
	mov ah,1
	int 21h
	aaa 
	add al,bl
	daa
	mov bl,al
	mov ah,9
	lea dx,message3
	int 21h
	mov al,bl
	mov bl,10h
	mov ah,0
	mov dx,0
	div bl 
	add ax,3030h
	mov dx,ax
	mov ah,2
	int 21h
	xchg dl,dh
	mov ah,2
	int 21h      
	mov ah,4ch
	int 21h
	
	code ends
end start
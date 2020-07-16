;to reverse a string (user input)
data segment
	strlen dw ?
	str db 10 dup(0)
	str_rev 10 dup(0)
	msg1 db "Enter a string (Press enter to continue): $"
	msg2 db 13,10,"Reversed string: $"
data ends 

printStr macro str
	lea dx,str
	mov ah,09h
	int 21h
endm

code segment
	assume cs:code ds:data
	
start:
	mov ax,@data
	mov ds,ax
	printStr msg1
	mov si,00
	mov strlen,0
	input:
		mov ah,01h
		int 21h
		cmp al,0dh
		je reverse
		mov str[si],al
		inc si
		inc strlen
	jmp input
	
	reverse:
		mov cx,strlen 
		mov si,00
		mov di,strlen
		copy:
			mov al,str[si]
			mov str_rev[di-1],al
			inc si
			dec di
		loop copy
	
	output:
		printStr msg2
		mov di,00
		mov cx,strlen
		print:
			mov	dl,str_rev[di]
			mov ah,02h
			int 21h
			inc di
		loop print
		
	mov ah,4ch
	int 21h
	
	code ends
end start
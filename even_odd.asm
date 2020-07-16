;to find if a no is even or odd 

data segment
	msg1 db "Enter a no: $"
	even_no db 13,10,"The no. is even.$"
	odd_no db 13,10,"The no. is odd.$"
ends data

code segment
	assume cs:code ds:data
	
start:
	mov ax,@data
	mov ds,ax
	lea dx,msg1
	mov ah,09h
	int 21h
	mov ah,01h
	int 21h
	sub al,30h
	mov ah,0
	mov bl,2
	div bl 
	
	cmp ah,1               ;compares value in ah with 1
	je odd                 ;if the above instruction is true then jump to label odd 
	even:                  ;else continue as label even
		lea dx,even_no
		mov ah,09h
		int 21h
		jmp endprog        ;jumps to endprog label to end the program
	odd:
		lea dx,odd_no
		mov ah,09h
		int 21h
		jmp endprog	
	endprog:
		mov ah,4ch
		int 21h	
	ends code
end start
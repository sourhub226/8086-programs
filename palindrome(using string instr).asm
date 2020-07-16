;palindrome using string instrn
data segment        
	msg1 db "Enter a string: $"
	msg2 db 10,13,"String is a palindrome$"
	msg3 db 10,13,"String is not palindrome$"
	str db 10h dup('$')
	data ends

extra segment
	revstr db 10h
	extra ends

printstr macro msg
	mov ah,09h
	lea dx,msg
	int 21h
	endm


code segment
	assume cs:code ds:data es:extra
	start:
		mov ax,data
		mov ds,ax
		mov ax,extra
		mov es,ax     
		printstr msg1        
		mov ah,0ah  
		lea dx,str
		int 21h
		           
		lea si,str
		inc si
		mov cl,[si]
		mov bl,cl
		mov ch,0
		inc si      
		
		lea di,revstr
		add di,cx
		dec di   
		
		back: 
			cld
			lodsb  
			std
			stosb
			loop back
			
		lea si,str
		inc si 
		inc si
		lea di,revstr
		mov cl,bl
		mov ch,0
		cld
		
		repe cmpsb
		jnz notpal
		
		printstr msg2   
		jmp quit
		
		notpal:
			printstr msg3
			
		quit:
			mov ah,4ch
			int 21h
		
		code ends
end start
	
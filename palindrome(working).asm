;to check if a string is a palindrome

data segment
	str1 db 10 dup('$')		;intializing an empty array of strings
	len db ?
	msg1 db "Enter the string: $"
	notpal db 10,13,"String is not Palindrome$"
	pal db 10,13,"String is Palindrome$"
data ends

printStr macro msg			;macro to display a string
	mov ah,09h
	lea dx,msg
	int 21h
endm 

code segment
	assume cs:code ds:data
	
	accept_str proc near	;procedure to input a string from user
		mov ah,0ah          ;accept string from user function
		lea dx,str1  		;store the string in memory pointed by "DX"
		int 21h
		ret
	endp 
	
start:
	mov ax,@data
	mov ds,ax
	printStr msg1			;calling string display macro
    call accept_str         ;calling string input procedure

    lea si,str1
	mov cl,str1+1			;CL stores the length od str1
	mov len,cl
	inc si
	add si,cx				;si points to last element      
	lea di,str1				;di points to size of string str1
	add di,2h            	;di points to actual start of string str1
	
	;string 0th byte->size
	;string 1st byte->length of string
    ;string 2nd byte->actual string 		
     
	mov cl,len				;load counter
	compare: 
		mov al,[si]
		mov ah,[di]
		inc di
		dec si
		cmp al,ah           ;comparing elements pointed by SI and DI
		jne notpalindrome	;if not equal,jump to notpalindrome label 	
		loop compare
	   
    palindrome:  	
		printStr pal
		jmp endprog
	notpalindrome:
		printStr notpal
	
	endprog:
		mov ah,4ch			;exit the program
		int 21h
	code ends
end start
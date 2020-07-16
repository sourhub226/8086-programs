;subtraction (with negative result)
data segment
	msg1 db "Enter 1st no: $"
	msg2 db 13,10,"Enter 2nd no: $"
	msg3 db 13,10,"Diff = $"
	diff db ? 
	n1 db ?
	n2 db ?
ends data
 
printstr macro msg
	mov ah,09h
	lea dx,msg
	int 21h
endm printstr 

input macro x
	mov ah,01h
	int 21h
	sub al,30h
	mov x,al
endm input
 
 
code segment
	assume cs:code ds:data
	
start:  
	mov ax,@data
	mov ds,ax
	
	printstr msg1
	input n1
	printstr msg2
	input n2
	printstr msg3
	mov bl,n1
	cmp bl,n2
	jl negative
	
	positive:
		mov al,n1
		sub al,n2
		mov dl,al
		add dl,30h
		mov ah,02h
		int 21h
		jmp endprog
		
	negative:
		mov al,n2
		sub al,n1
		mov diff,al
		mov ah,02h
		mov dl,"-"
		int 21h
		mov dl,diff
		add dl,30h
		int 21h
	    jmp endprog
	    
    endprog:
    	mov ah,4ch
    	int 21h
	
ends code
end start
	
	

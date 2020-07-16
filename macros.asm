;to implement use of macros
data segment
	msg1 db "Hello$"
	msg2 db "World$"
	msg3 db "Print$"
	msg4 db "Macro$"    
	newline db 13,10,"$"
	n1 db ?
	n2 db ?
	n3 db ?
ends data

printstr macro msg
	mov ah,09h
	lea dx,msg
	int 21h
endm printstr 

printnum macro num
	mov ah,02h
	mov dl,num
	add dl,30h
	int 21h 
endm printnum 

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
	
	printnum 2
	printnum 8
	printnum 3    
	
	printstr newline
	printstr msg1
	printstr msg2
	printstr msg3
	printstr msg4 
	
	printstr newline
	input n1
	input n2
	input n3
	
	printstr newline
	printnum n1
	printnum n2
	printnum n3
	
	mov ah,4ch
	int 21h
	
ends code
end start
	
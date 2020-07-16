;addition using macros
data segment
	msg1 db "Enter 1st no: $"
	msg2 db 13,10,"Enter 2nd no: $"
	msg3 db 13,10,"Sum = $"
	sum db ? 
	n1 db ?
	n2 db ?
ends data

addnos macro a,b
	mov al,a
	add al,b
	mov sum,al
endm

input macro x
	mov ah,01h
	int 21h
	sub al,30h
	mov x,al
endm

printsum macro y
	mov al,y
	aam
	add ax,3030h
	mov dx,ax
	xchg dh,dl
	mov ah,02h
	int 21h
	xchg dh,dl
	int 21h
endm 

printstr macro s
	mov ah,09h
	lea dx,s
	int 21h 
endm 

code segment
	assume cs:code ds:data
	
start:  
	mov ax,@data
	mov ds,ax
	
	printstr msg1
	input n1
	printstr msg2
	input n2
	addnos n1,n2
	printstr msg3
	printsum sum 
	
	mov ah,4ch
	int 21h
	
ends code
end start
	
	

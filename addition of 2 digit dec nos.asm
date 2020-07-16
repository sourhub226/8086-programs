;addition of 2 digit dec nos
data segment
	n1 db 52h
	n2 db 17h
	ans db ?
	
data ends

code segment
	assume cs:code ds:data
	
	
start:

	mov ax,@data
	mov ds,ax
	mov ax,0
	mov al,n1
	add al,n2
	mov bl,10h
	div bl 
	add ax,3030h
	mov dx,ax
	mov ah,2
	int 21h
	xchg dl,dh
	mov ah,2
	int 21h
	
	code ends
end start
;sum of elements in an array
data segment
	arr db 02h,04h,07h
	sum db ?
data ends

code segment
	assume cs:code ds:data
	
start:
	mov ax,@data
	mov ds,ax
	mov ax,0  
	mov cx,03h
	mov di,offset arr
	
	l1:
		add al,arr[di]
		inc di
		loop l1
		
	mov sum,al 
	code ends
end start
	
	

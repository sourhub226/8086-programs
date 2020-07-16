;to implement bubble sort

data segment
	n db ?
	ctrl db ?
	arr db 10 dup(?)			;declaring empty array of size 10
	msg1 db "Enter no of elements: $"
	msg2 db 13,10,"Enter no: $"
	msg3 db 13,10,"Sorted array: $"
	space db "  $"
data ends

printStr macro str				;macro to display a string
	lea dx,str
	mov ah,09h
	int 21h
endm

code segment
	assume cs:code ds:data
	
start:
	mov ax,@data
	mov ds,ax 
	
	printStr msg1				;calling string display macro
	mov ah,01h
	int 21h
	sub al,30h
	mov n,al
	mov cl,n
	mov si,00
	
	input:						;taking user input and storing elements in array
		printStr msg2
		mov ah,01h
		int 21h
		mov arr[si],al
		inc si
	loop input
	 
	 sub n,1
	 mov cl,n
	 mov si,00
	 mov ctrl,cl 
	 
	 bsort:						;sorting begins
	 	mov cl,ctrl
	 	mov si,00
	 	pass:					;loop for each pass 
		 	mov ax,00
		 	mov bx,00
		 	mov al,arr[si]
		 	mov bl,arr[si+1]
		 	 
		 	cmp bl,al           ;compares 2 consecutive elements (*swap al and bl for descending order sort)
		 	jg noswap
		 	swap:               ;if 1st element > 2nd element (in order) 
		 		xchg al,bl		;then swap both elements
		 		mov arr[si],al
		 		mov arr[si+1],bl
		 		
		 	noswap:
		 		inc si
		loop pass
		 
		dec ctrl
		cmp ctrl,0
		je printSort	
	 jmp bsort
	
	printSort:
		mov si,00
		add n,1
		mov cl,n 
		printStr msg3 
		output:					;displays sorted array elements
			mov ah,02h
			mov dl,arr[si]
			int 21h
			printStr space
			inc si
		loop output
		
	mov ah,4ch
	int 21h
	 
	code ends
end start
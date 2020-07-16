;to find largest element in an array
data segment 
 	n db ?
    arr db 10 dup(?)			;declaring empty array of size 10
    msg1 db "Enter no. of elements: $"
    msg2 db 10,13,"Enter no:  $"
	msg3 db 13,10,"Largest element = $"
data ends

print macro msg					;macro to display a string
    mov ah,09h
    lea dx,msg
    int 21h
endm

code segment
    assume cs:code, ds:data
start:
	mov ax,@data
    mov ds,ax
    mov cx,00
    print msg1
    mov ah,01
    int 21h
    sub al,48  
    mov n,al
    mov cl,n
    mov si,00
    l1:							;loop to input n elements and store in array
	    print msg2
	    mov ah,01
	    int 21h
	    mov arr[si],al          ;array elements are pointed by SI
	    inc si                  ;increments SI to point to next location
    loop l1
    
    print msg3
    mov si,00
    mov al,arr[si]
    inc si
    mov cl,n
    dec cl
    
    find:
    	mov bl,arr[si]
    	cmp bl,al				;swap bl and al to find smallest element
    	jg greater
    	jmp not_greater          
    	greater:
    		mov al,bl
    	not_greater:
    		inc si
    loop find
     
    output:
    	mov dl,al
    	mov ah,2
    	int 21h
	    mov ah,4ch
	    int 21h
	code ends
end start    
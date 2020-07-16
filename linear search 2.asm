;to search an element
data segment
	n db ?
    e db ?
    arr db 10 dup(?)			;declaring empty array of size 10
    msg1 db "Enter no. of elements: $"
    msg2 db 10,13,"Enter no:  $"
    msg3 db 10,13,"Enter the no. to be searched: $"
    msg4 db 10,13,"Element found at position $"
    msg5 db 10,13,"Element not found$"
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
    mov ah,01
    int 21h
    mov e,al
    mov si,00
    mov cl,n
    search:						;loop to compare every array element with the element to be searched 
	    mov al,arr[si] 
	    mov bl,e
	    cmp bl,al
	    je found                ;if the element is found,jump to found label
	    inc si
    loop search
    
    notfound:					;indicates element is not found in array
	    print msg5              
	    jmp endprog
         
    found:						;indicates element is found and prints element location
	    print msg4
	    mov dx,si
	    add dx,1
	    add dx,30h
	    mov ah,02
	    int 21h
    
    endprog:
	    mov ah,4ch
	    int 21h
	code ends
end start    
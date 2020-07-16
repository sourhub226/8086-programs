;to find sum and avg of n numbers 

data segment
	sum db ?
	msg1 db 'Enter n: $'
	msg2 db 13,10,'Enter no: $'
	msg3 db 13,10,"Sum = $"
	msg4 db 13,10,'Avg = $'
ends data

code segment
	assume cs:code ds:data
	
start:
	mov ax,@data
	mov ds,ax

	lea dx,msg1			;loads effective address of msg1 for printing
	mov ah,09h          ;invokes printing a string command
	int 21h

	mov ah,01h
	int 21h
	sub al,30h          ;converts ascii to decimal in AL

	mov cl,al
	mov bl,al
	mov al,00
	mov sum,al

	l1:
        lea dx,msg2
        mov ah,09h
        int 21h

        mov ah,01h
        int 21h
        sub al,30h
        add sum,al
        loop l1          ;loops all instructions inside l1 untill CX=0

    lea dx,msg3
	mov ah,09h
	int 21h     
            
	mov ax,00 
	mov al,sum
	aam                  ;splits the no.in AL into 2 unpacked BCD and stores in AH and AL
	add ax,3030h         ;converts decimal to ascii in AX
	mov dx,ax            
	xchg dh,dl           ;exchanges data in DH and DL
	mov ah,02h
	int 21h
	xchg dh,dl
	int 21h
	
	lea dx,msg4
	mov ah,09h
	int 21h
	
	mov ax,00
	mov al,sum
	div bl              ;divides AX by BL and stores quotient in AL and remainder in AH
	mov dl,al
	add dl,30h          ;converts decimal to ascii in AL
	mov ah,02h
	int 21h  
        
	mov ah,4ch          ;invokes program termination command
	int 21h
	ends code
end start
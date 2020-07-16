;to evaluate a linear expression

data segment                 ;data segment begins
	n1 db 02h                ;initialize n1 variable to 2
	n2 db 03h                ;initialize n2 variable to 3
	n3 db 02h                ;initialize n3 variable to 2
	n4 db 05h                ;initialize n4 variable to 5
	ans db ?                 ;declare empty variable to store answer
ends data                    ;data segment ends

code segment                 ;code segment begins
	assume cs:code ds:data   ;assembler directive instructing assembler
			
start:                       ;start label
	mov ax,@data             ;moves memory location of data segment to AX
	mov ds,ax                ;moves data from AX to DS register
	mov ax,0                 ;initialize AX to 0
	mov ah,02h               ;invokes display of a single char
	mov dl,n1                ;moves n1 to DL
	add dl,48                ;converts hex to dec
	int 21h                  ;invokes DOS prompt
	mov dl,'*'               ;moves * char to DL
	int 21h                  ;invokes DOS prompt
	mov dl,n2                ;moves n2 to DL
	add dl,48                ;converts hex to dec
	int 21h                  ;invokes DOS prompt
	mov dl,'+'               ;moves + char to DL
	int 21h                  ;invokes DOS prompt
	mov dl,n3                ;moves n3 to DL
	add dl,48                ;converts hex to dec
	int 21h                  ;invokes DOS prompt
	mov dl,'-'               ;moves - char to DL
	int 21h                  ;invokes DOS prompt
	mov dl,n4                ;moves n4 to DL
	add dl,48                ;converts hex to dec
	int 21h                  ;invokes DOS prompt
	mov dl,'='               ;moves = char to DL
	int 21h                  ;invokes DOS prompt
	
	mov al,n1                ;moves n1 to AL
	mov bl,n2                ;moves n2 to BL
	mul bl                   ;multiply n2 with n1 and stores ans in AL
	add al,n3                ;adds n3 to AL
	sub al,n4                ;subtracts n4 from AL
	mov ans,al               ;moves answer from AL to ans variable
	mov ah,02h               ;invokes display of a single char
	mov dl,ans               ;moves data in ans to DL for printing
	add dl,48                ;converts hex to dec
	int 21h                  ;invokes DOS prompt
	
	mov ah,4ch               ;terminates program returns control to OS
	int 21h                  ;invokes DOS prompt
		 
ends code                    ;code segment ends
end start                    ;program ends

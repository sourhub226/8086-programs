;string reverse using array
data segment
String1 db "Hello World$" 
Length dw $-String1        
revstr db 20h dup('$')
data ends

code segment
	assume cs:code ds:data
	start:  
		MOV AX, @data  
		MOV DS, AX  
		MOV SI, offset String1
		dec si
		MOV CX, Length-1 
		ADD SI, CX 
		mov di,0 
		Back: MOV DL, [SI]  
			mov revstr[di],dl 
			DEC SI 
			inc di 
			LOOP Back 
		
		MOV CX, Length-1
		mov si,0	
		printrev:
			mov dl,revstr[si]
			mov ah,02h
			int 21h
			inc si
			loop printrev
			     
			     
		MOV AH, 4CH  
		INT 21H    
code ends
End start
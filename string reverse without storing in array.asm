;string reverse without array
data segment
String1 db "Hello World$" 
Length dw $-String1  
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
		Back: MOV DL, [SI]  
			MOV AH, 02H  
			INT 21H  
			DEC SI  
			LOOP Back  
		MOV AH, 4CH  
		INT 21H    
code ends
End start
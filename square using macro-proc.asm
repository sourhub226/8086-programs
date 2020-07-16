;to find square of a number using macro and procedure
data segment
    msg1 db "Enter a no: $"  
    msg2 db 13,10,"Ans(using macro) = $"
    msg3 db 13,10,"Ans(using procedure) = $"
    n db ?
    sq db ?
data ends

calc_mac macro num		;macro to calc square
    mov al,num
    mov bl,al
    mul bl				;Al getting multiplied by AL to find square
    mov sq,al
endm                    ;end of macro

printNos macro x		;macro to print 2 digit nos
    mov al,x
    aam
    add ax,3030h
    mov dx,ax
    xchg dh,dl
    mov ah,02h
    int 21h
    xchg dh,dl
    int 21h  
endm					;end of macro  

printStr macro str		;macro to display a string  
    lea dx,str
    mov ah,09h
    int 21h
endm					;end of macro
    
code segment
    assume cs:code ds:data
    calc_proc proc		;procedure to calc square 
        mov al,n
        mov bl,al
        mul bl
        mov sq,al
        ret				;return instruction transfers execution to caller program
    endp                ;end of procedure
  
start:
    mov ax,@data
    mov ds,ax
    printStr msg1       ;calling string display macro
    mov ah,01h
    int 21h
    sub al,48
    mov n,al
    calc_mac n          ;calling square calculation macro
    printStr msg2
    printNos sq         ;displays ans for calculation by macro
    printStr msg3   
    call calc_proc      ;calling square calculation procedure
    printNos sq			;displays ans for calculation by procedure

    mov ah,4ch
    int 21h
	code ends
end start    
;to evaluate a linear expression (user ip)
data segment
    n1 db ?
    n2 db ?
    n3 db ?
    n4 db ?
    msg1 db "To evaluate a*b+c-d$"
    msg2 db 13,10,"Enter values of a,b,c,d: $"
    newline db 13,10,"$"
data ends

code segment
    assume cs:code,ds:data
    
    start:
    	mov ax,@data
        mov ds,ax
        mov ax,0 
		mov ah,09h
        lea dx,msg1
        int 21h
        lea dx,msg2
        int 21h
          
        mov ah,01h
        int 21h
        aaa
        mov n1,al
        int 21h
        aaa
        mov n2,al
        int 21h
        aaa
        mov n3,al    
        int 21h
        aaa
        mov n4,al	
                        
        mov ah,09h              
        lea dx,newline
        int 21h         
        mov ah,02h         
        mov dl,n1
        add dl,48
        int 21h
        mov dl,"*"
        int 21h          
        mov dl,n2
        add dl,48
        int 21h
        mov dl,"+"
        int 21h 
        mov dl,n3
        add dl,48
        int 21h
        mov dl,"-"
        int 21h
        mov dl,n4
        add dl,48
        int 21h
        mov dl,"="
        int 21h
                     
        mov al,n1
        mul n2
        add al,n3
        sub al,n4
        aam
        add ax,3030h
        xchg al,ah 
        mov dx,ax 
        mov ah,2
		int 21h
		xchg dl,dh
        mov ah,2
        int 21h
          
        mov ah,4ch
        int 21h  
        code ends	  
end start
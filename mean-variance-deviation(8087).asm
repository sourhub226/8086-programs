;8087 ALP
;to obtain: Mean, Variance and Standard Deviation
data segment
	num1 dt ?       ;5 no.s accept ,size is define ten bytes
	num2 dt ?
	num3 dt ?
	num4 dt ?
	num5 dt ?

	num dt 100

	b dt 100.00     ;mul by 100 to 2 digits after decimal
	cnt dt 5.0
	count db 5

	mean dt ?		;store mean
	var dt ?        ;store variance
	store dt ?      

	stdev dt ?		;store stdev
    a dw ?          ;temporary variable
        
	dot db ".$"     ;to display dot

	msg db 10d,13d,"Enter 5 numbers: $"
	msg1 db "Mean = $"
	msg2 db "Variance = $"
	msg3 db "Standard Deviation= $"
	msg4 db 10d,13d,"$"
data ends	

scall macro xx,yy       ;macro to display
    lea dx,xx
    mov ah,yy
    int 21h
endm

sdcalc macro zz     ;macro to calculate difference & sqr
    fld zz          ;load passed parameter
	fld  store      ;load mean       
	fsubp st[1],st	;subtract first number from mean
	fmul st,st      ;make square of subtracted resulted
endm

displayreal macro xx,yy
    fld xx
	scall msg4,09h  
	scall yy,09h

	fld b             ;load 100.00
	fmulp st[1],st    ;multiply by 100.00
	fbstp xx	      ;convert to BCD

	mov ax,word ptr xx
	call display4digit      ;display ax contents
endm


code segment
    assume cs:code, ds:data   
accept2digit proc       ;accept 2 digit and store in bl
    mov bl,00
	mov ch,02       	;count of digits
	loop1:    
	    mov ah,01h		;Accept Function
		int 21h
	
		sub al,30h      ;convert to hex eqivalent
		add bl,al
		rol bl,04
		dec ch
		jnz loop1
	
	    rol bl,04
ret
endp

display4digit proc
    mov a,ax        ;ax has 4 digits to diaplay
	mov dl,ah       ;to display ah first

	mov ch,02h      ;count of digits
	rol dl,04
	loop3:	
		and dl,0fh
		add dl,30h
	
		mov ah,02h
		int 21h
	
		mov ax,a        ;restore ax
		mov dl,ah
	
		dec ch
		jnz loop3
	
		scall dot,09h   ;display dot
	
		mov ax,a
		mov dl,al       ;to display al
		
		mov ch,02h      ;count of digits
		rol dl,04

	loop4:  
		and dl,0fh      ;anding to extract last digit
		add dl,30h      ;convert to ascii-hex
	
		mov ah,02h      ;display dl contents
		int 21h
	
		mov ax,a
		mov dl,al
	
		dec ch
		jnz loop4
ret
endp

start:
	mov ax,@data
	mov ds,ax

	scall msg,09h

	finit	;to initalise 8087     
	
;Accept Integer Part
loop2:
	call accept2digit
	mov byte ptr num1,bl  ;Integer Part(for eg :12)

;display dot
	scall dot,09h
;accept fractional part
	call accept2digit
	mov byte ptr num2,bl	;second 2 digit no.(for eg :20)

	fbld num2          		;convert to bcd & load

	fbld num           		;num =100

	fdivp st[1],st     		;convert to fractional part(20/100=0.20)
			   				;Divide destination real by source real
			   				;result goes in destination,also increments
			   				;stack pointer by 1 after DIV.P means POP.

	fbld num1          		;num1 1st two digit no.
						    ;Packed Decimal(BCD) load
						    ;Convert number from memory to temporary -real format
						    ;and push on top of stack.

	faddp st[1],st     		;add both no. to get final floating point no.(for eg 12.20)
			   				;Add ST to specified stack element
			  				;and increment stack pointer by 1.

	scall msg4,09h

	dec count
	jnz loop2

	fstp num1			;No. Stored in variable
						;Copies ST to a specified stack element
						;or memory location and increment satck pointerby 1.

	fstp num2	;No. Stored in variable
	fstp num3	;No. Stored in variable
	fstp num4	;No. Stored in variable
	fstp num5	;No. Stored in variable
;find the Mean
	fld num1
	fld num2
	fld num3
	fld num4
	fld num5

	faddp st[1],st      ;Add ST to specified stack element
			    		;& increment Stack pointer by 1
	faddp st[1],st
	faddp st[1],st
	faddp st[1],st

	fld cnt
	fdivp st[1],st       ;calculate mean

	fstp mean	     	 ;Stores Mean
	fld mean

	fstp store           ;mean's dupicate value in store variable

    sdcalc num1      	 ;macro call to calculate difference and take square
    sdcalc num2
    sdcalc num3
    sdcalc num4
    sdcalc num5
       
	faddp st[1],st	     ;square's addition
	faddp st[1],st
	faddp st[1],st
	faddp st[1],st  
	
;find variance and std deviation
	fld cnt          ;load count
	fdivp st[1],st   ;to calculate variance divide by cnt

	fld st

	fstp var         ;store variance
	fld var          ;load variance on top of stack

	fsqrt			 ;to find the square root of variance to get std deviation

	fstp stdev       ;Stores Standard Deviation

;Code to Display Mean,Variance and Std Deviation
	displayreal mean,msg1   ;macro calls
	displayreal var,msg2
	displayreal stdev,msg3

	mov ah,4ch              ;Exit Function
	int 21h
	
code ends
end start
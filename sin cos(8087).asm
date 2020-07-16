;8087 ALP
;to verify the equation [sin^2 X+ cos^2 X = 1] for given value of X
data segment
oneighty dd 180
theta dd 30.156
x dd ?
y dd ?
h dd ?
result dd ?
data ends

code segment

assume cs:code,ds:data

  start:mov ax,data
        mov ds,ax
        finit

		fld oneighty
		fld theta
		fldpi
		fmul
		fdiv

        fptan 
		fstp x
		fst y
		fmul st(0),st(0)
		fld x
		fmul st(0),st(0)
		fadd
		fsqrt

		fld x
		fdiv st(0), st(1)
		fmul st(0), st(0)
		fld y
		fdiv st(0), st(2)
		fmul st(0), st(0)

		fadd

        fstp result

        mov ah,4ch
        int 21h
code ends
end start
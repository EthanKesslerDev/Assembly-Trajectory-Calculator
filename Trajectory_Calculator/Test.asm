INCLUDE Irvine32.inc
; Assembly language for x86 processors, Irvine

.data
	val1	DWORD	10000h
	val2	DWORD	40000h
	val3	DWORD	20000h
	finalVal	DWORD	?
	
.code
main PROC
	mov	eax,val1
	add	eax,val2
	sub	eax,val3
	mov finalVal,eax
	call writeint
	call DumpRegs
	exit
main ENDP

END main
INCLUDE Irvine32.inc
INCLUDE macros.inc
; Assembly language for x86 processors, Irvine

.data
	G	real8	9.81f	;	Gravitational Constant
	fp_Two	real8	2.0f
	
	ux		real8	?
	uy		real8	?

	sx		real8	?
	sy		real8	?

	t	real8	0.0f
	t_total	real8	?
	t_step	real8	?
	n	DWORD	20

	ut		real8	?	;	used in calculations
	half_a_t2	real8	?	;	used in calculations
	
.code
main PROC

	finit

	;	Get Inputs
	mWrite	"Enter inital horizontal velocity [FLOAT]: "
	call	ReadFloat
	fst	ux

	mWrite	"Enter initial vertical velocity [FLOAT]: "
	call	ReadFloat
	fst	uy

	mWrite	"Enter total tracking time [FLOAT]: "
	call	ReadFloat
	fst	t_total

	mWrite	"Enter start time [FLOAT]: "
	call	ReadFloat
	fst	t

	call Crlf

	mov ecx,n ;define loop length
	fld	t_total
	fidiv n
	fst t_step

	call Crlf

;_____________________________START MAIN LOOP_____________________________

Loop_Main:
	cmp	ecx,0
	je	EndLoop_Main

	call Crlf
	call Crlf

	mWrite	"__________________________________________"
	call Crlf

	finit ;	clean up FPU (This is probably not a great idea)
	;	call DumpRegs


	;	display time (t)
	fld	t
	mWrite	"Displacement at time (seconds): "
	call writefloat

	call Crlf

	;	calculate x displacement over time (t)
	fld	 ux
	fmul t
	fst	sx
	; call DumpRegs
	mWrite	"Horizontal Displacement: "
	call writefloat

	call Crlf

	;	calculate y displacement over time (t)
	fld	uy
	fmul	t
	fst	ut	;	ut calculated

	fld	t
	fmul t
	fmul G
	fdiv	fp_Two
	fst	half_a_t2

	fld	ut
	;	call showfpustack
	fsub half_a_t2
	fst	sy	;	This all works!
	mWrite	"Vertical Displacement: "
	call writefloat

	fld	t
	fadd t_step
	fst	t

	dec	ecx
	jmp	Loop_Main

;_____________________________END MAIN LOOP_____________________________
EndLoop_Main:
	call Crlf
	mWrite	"Loop Over"


	exit
main ENDP

END main
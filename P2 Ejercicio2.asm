.MODEL SMALL
.STACK 
	;PDB TYPEDEF PTR BYTE		;VARIABLE TIPO APUNTADOR 
.DATA

	STRING DB 5 DUP(?)			;set string of 5
	;pArreglo PDB OFFSET STRING			;SE INICIALIZA EL APNTADOR A STRING
	;input prompts
	MSG1 DB 10,13,"INSERTA VALOR 0-9: ","$"
	MSG2 DB 10,13,"ERROR... INSERTA SOLO VALORES 0-9","$"
	;output prompts
	V1 DB 10,13,36
	MSG3 DB 10,13,"EL STRING LLENO ES: ",36
	MSG4 DB 10,13,"STRING ORDENADO: ",36
	MSG5 DB 10,13,"VALOR MAS GRANDE:  ",36
	
.CODE
	MOV AX,@DATA
	MOV DS,AX
	MOV CX,5			;initialize the count with 5  
	MOV SI,0			;initialize SI with 0
	INPUTSTRING:	;input value of the character  
		;show message prompts input 
		INICIO:
		MOV AH,09H
		MOV DX,OFFSET MSG1
		INT 21H
		;read key, return AL 
		MOV AH,01H				
		INT 21H
		
		;se inserto una opcion invalida (caracter)
		CMP AL,2FH			;si es menor 
			JLE DEFAULT
		CMP AL,40H			;si es mayor 
			JGE DEFAULT
		JMP N1
			DEFAULT:			;cls screen y muestra error
			MOV AH,00H			;modo de video 
			MOV AL,3
			INT 10H
			MOV AH,09H
			MOV DX,OFFSET MSG2
			INT 21H
			JMP INICIO
		N1:
		;insert the value in the string 
		MOV STRING[SI],AL			
		MOV AH,09H				;se muestra el mensaje 
		MOV DX,OFFSET V1
		INT 21H
		;indecrease the count 
		INC SI

	LOOP INPUTSTRING	;end INPUTSTRING
	
	;show message 
	MOV AH,09H
	MOV DX,OFFSET MSG3
	INT 21H
	;initialize CX and SI, because the value change before
	MOV CX,5
	MOV SI,0
	
	PRINTSTRING:	;print the string 
		MOV AH,02H
		MOV DL,STRING[SI]
		INT 21H
		MOV AH,02H
		MOV DL,' '
		INT 21H
		INC SI
	LOOP PRINTSTRING	;END PRINTSTRING
	
	;***************INICIA ORDENAMIENTO BURBUJA***************************
	
	MOV CX,5
	DEC CX					;DECREMENTA CUENTA
	CICLO1:	
		PUSH CX				;GUARDA CUENTA DEL CICLO EXTERNO 
		MOV SI,0			;APUNTA AL PRIMER VALOR 
			
	CICLO2:	
		MOV AL,STRING[SI]	;OBTIENE EL VALOR DEL ARREGLO
		CMP STRING[SI+1],AL	;COMPARA PAR DE VALORES 
			JLE CICLO3		;SI [SI] <= [DI], NO INTERCAMBIA
		XCHG AL,STRING[SI+1]	;XCHG INTERCAMBIA EL PAR 
		MOV STRING[SI],AL
		
	CICLO3:	
		INC SI			;MUEVE APUNTADORES HACIA ADELANTE 
		LOOP CICLO2			;CICLO INTERNO
		
		POP CX				;OBTIENE LA CUENTA DEL CICLO EXTERNO
		LOOP CICLO1			;EN CUALQUIER OTRO CASO REPITE EL CICLO EXTERNO
		
	;*****************TERMINA ORDENAMIENTO BURBUJA**************************
	;show message 
	MOV AH,09H
	MOV DX,OFFSET MSG4
	INT 21H
	;initialize value for the print 
	MOV SI,0
	MOV CX,5
	PRINTSTRINGINORDER:	;print the string 
		MOV AH,02H
		MOV DL,STRING[SI]
		INT 21H
		MOV AH,02H
		MOV DL,' '
		INT 21H
		INC SI
	LOOP PRINTSTRINGINORDER	;END PRINTSTRING
	;show message bigger value
	MOV AH,09H
	MOV DX,OFFSET MSG5
	INT 21H
	;initialize the value 
	MOV SI,0	;INDICE
	MOV CX,5	;
	MOV AL,0	;VALOR MAS GRANDE 
	PLUSVALUE:
		CMP AL,STRING[SI]
			JGE NOTSWAP
		XCHG AL,STRING[SI]
	NOTSWAP:
		INC SI
		LOOP PLUSVALUE
	;show the value bigger
	MOV DL,AL
	MOV AH,02H
	INT 21H
	
	;return the control of the system 
	MOV AH,4CH
	INT 21H
	
END
.MODEL SMALL
.STACK
.DATA				;SEGMENTO DE DATOS VARIABLES
	MSG1 DB 10,13,"INSERTE EL NUMERO DE CICLOS: ","$"
	MSG2 DB 10,13,"ERROR.... INSERTE CARACTER VALIDO",10,13,"$"
	MSG3 DB 10,13,"HOLA MUNDO","$"
.CODE 
	
	MOV AX,@DATA
	MOV DS,AX
	JMP CLS
	NEXTCLS:
INICIO:
	;se muestra el primer mensaje 
	MOV AH,09H
	MOV DX,OFFSET MSG1
	INT 21H

	;se inserta el caracter 
	MOV AH,01h			;lee una tecla 
	INT 21H
	
	;se inserto una opcion invalida (caracter)
	CMP AL,30H			 
		JLE DEFAULT		;si es menor o igual 
	CMP AL,40H			 
		JGE DEFAULT		;si es mayor o igual 
		
	
MUESTRAMSG:
	MOV AH,09H
	MOV DX,OFFSET MSG3
	INT 21H
	CMP AL,31H
		JE SALIR		;si es igual 
	DEC AL
	LOOP MUESTRAMSG			;ciclo LOOP, contador CX
		
SALIR:
	;se devuelve el control al sistema
	MOV AH,4CH
	INT 21H
	
DEFAULT:			;cls screen y muestra error
	MOV AH,00H		;establece modo de video, texto o graficos 
	MOV AL,3		;modo de video 3 texto a color 
	INT 10H			;interrupcion, 
	MOV AH,09H
	MOV DX,OFFSET MSG2
	INT 21H
	JMP INICIO
CLS:				;se borra la pantalla 
	MOV AH,00H		;modo de video 
	MOV AL,3		;modo de video 3
	INT 10H
	JMP NEXTCLS
	
END
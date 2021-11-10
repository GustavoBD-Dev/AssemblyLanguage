.MODEL SMALL
.STACK
.DATA
	matrix DB 46 DUP (" ","A","B","C","D","E","0","F","G","H","I","J","K","L","%","M","N","O","P","Q","R","S","T","U","1","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9","0","@","?","!","#","*")
	matrix4 DB 46 DUP (" ","A","B","C","D","E"," ","F","G","H","I","J","K","L"," ","M","N","O","P","Q","R","S","T","U"," ","V","W","X","Y","Z"," ","1","2","3","4","5","6","7","8","9"," ","@","?","!","#","*")
	matrix2 DB 45 DUP ("10100110")
	matrix3 DB 45 DUP (03H)
	endl DB 10,13,36
.CODE
	MOV AX,@DATA
	MOV DS,AX
	MOV SI,0
	MOV CX,35
	JMP L1
	L1:
		INC DH					;fila siguiente
		L2:
			;color de fuente
			MOV AH,9			;funcion 
			MOV AL,matrix4[SI]		;carcater a mostrar
			MOV BH,0			;pagina de video 
			MOV BL,0AH			;atributos fondo/frente
			MOV CX,2			;repeticiones del caracter
			INT 10H
			INC SI				
			PUSH CX
			MOV AH,02H			
			INT 10H			
			CMP SI,46			;si llega el final de la pantalla
				JE REINICIAR
			CONTINUAR:
			;posicion del cursor 
			INC DL				;siguiente columna			
			MOV AH,02H			
			INT 10H
			POP CX
			CMP DL,35
				JE L1
			JMP L2
	JMP L1
	REINICIAR:
		MOV SI,1
	JMP CONTINUAR
END
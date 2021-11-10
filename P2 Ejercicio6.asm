.model small
.stack
.data
	msgMenu db 10,10,13,"Menu",10,13,"1.- LIMPIAR PANTALLA",10,13,"2.- IMPRIMIR UN MENSAJE",10,13,"3.- DECREMENTAR UN NUMERO INGRESADO",10,13,"4.- INCREMENTAR UN NUMERO INGRESADO",10,13,"5.- Salir",10,13,"inserte opcion: ",10,10,"$"
	msgCLSScreen db 10,13,"se ha borrado la pantalla ",36
	msgPrint db 10,13,"este es el mensaje",36
	
	msgNDec db 10,13,"DECREMENTAR UN NUMERO",10,13,"inserta un numero 1-9: 	    ",36
	msgNDec1 db 10,13,"el numero ingresado es:     ",36
	msgNDec2 db 10,13,"el numero decrementado es:  ",36
	
	msgNInc db 10,13,"INCREMENTAR UN NUMERO",10,13,"inserta un numero 0-8:      ",36
	msgNInc1 db 10,13,"el numero ingresado es:     ",36
	msgNInc2 db 10,13,"el numero ncrementados es:  ",36
	
	msgDefault db 10,13,"Inserta caracter valido",10,13,36
	
.code
	mov ax,@data
	mov ds,ax
	menu:
	mov ah,09h			;despliega una cadena de caracteres
	mov dx,offset msgMenu	;la cadena entra a dx
	int 21h				;interrupcion
	mov ah,01h			;funcion para leer el teclado
	int 21h				;interrupcion
	cmp al,31h			;compara al con 1
		je first 		;realiza el salto
	cmp al,32h			;compara al con 2
		je second		;realiza el salto
	cmp al,33h			;compara al con 3
		je third		;realiza el salto
	cmp al,34h			;compara al con 4
		je fourth		;realiza el salto 
	cmp al,35h
		je fifth
	jmp L1
		fifth:
			mov ah,4ch			;se solicita la opcion FINALIZAR UN PROCESO de 21h
			int 21h				;se devuelve el control al sistema
	L1:		
	cmp al,36h
		jge default
	cmp al,30h
		jle default
		
	
		first:
			mov ah,00h			;(00h) modo de video 3
			mov al,3			;modo de video 3 (texto a color)
			int 10h				;interrupcion de serivioios de video
								;una vez borrada la patalla se muestra el mensaje
			mov Ah,09h			;09h despliega una cadena de caracteres
			mov Dx,offset msgCLSScreen	;la cadena v1 entra a Dx
			int 21h
		jmp menu
		
		saltoMenu:
			jmp menu
			
		second:
			mov Ah,09h			;09h despliega una cadena de caracteres
			mov Dx,offset msgPrint	;la cadena v1 entra a Dx
			int 21h				;llamara a la interrupcion 21h con la funcion 09h
		jmp menu

		third:
			MOV AH,00H
			MOV AL,3
			INT 10H
			mov Ah,09h			;09h despliega una cadena de caracteres
			mov Dx,offset msgNDec	;la cadena v1 entra a Dx
			int 21h				;llamara a la interrupcion 21h con la funcion 09h
			mov ah,01h
			int 21h
			cmp al,40h
				jge third
			cmp al,30h
				jle third
			
			decrementarNumero:
				dec al
				mov ah,09h			;09h despliega una cadena de caracteres
				mov dx,offset msgNDec2	;la cadena v1 entra a Dx
				int 21h				;llamara a la interrupcion 21h con la funcion 09h
				mov ah,02h
				mov dl,al
				int 21h
				cmp al,30h
					je menu
			loop decrementarNumero
		jmp menu

		fourth:
			MOV AH,00H
			MOV AL,3
			INT 10H
			mov Ah,09h			;09h despliega una cadena de caracteres
			mov Dx,offset msgNInc	;la cadena v1 entra a Dx
			int 21h				;llamara a la interrupcion 21h con la funcion 09h
			;el usuario inserta el numero 
			mov ah,01h
			int 21h
			cmp al,39h
				jge fourth
			cmp al,2Fh
				jle fourth
			
			incrementarNumero:
				inc al
				mov ah,09h			;09h despliega una cadena de caracteres
				mov dx,offset msgNInc2	;la cadena v1 entra a Dx
				int 21h				;llamara a la interrupcion 21h con la funcion 09h
				mov ah,02h
				mov dl,al
				int 21h
				cmp al,39h
					je saltoMenu 
			loop incrementarNumero
		jmp menu
	
		
		default:
			mov ah,00h			;(00h) modo de video 3
			mov al,3			;modo de video 3 (texto a color)
			int 10h				;interrupcion de serivioios de video
								;una vez borrada la patalla se muestra el mensaje
			mov Ah,09h			;09h despliega una cadena de caracteres
			mov Dx,offset msgDefault	;la cadena v1 entra a Dx
		jmp menu			
end

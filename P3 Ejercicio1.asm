.model small
JUMPS
.stack 
.data
	  
	datosMenu db 10,13,"	MENU",10,13,"1.-Suma",10,13,"2.-Resta",10,13,"3.-Multiplicacion",10,13,"4.-Division",10,13,"5.-Salir",10,13,"Inserte opcion: $"
	msgDefault db 10,13,"Error... no has insertado un caracter invalido. intenta de nuevo ",10,13,36
	msgTresDigitos db 10,13,"Resultado >= 100. No podemos imprimir",36
	msgNumNeg db 10,13,"El segundo numero es mayor al primero, el resultado es negativo",36
	instruccion db 10,13,"inserta operacion:   ",36
	sleep db 10,13,10,13,10,13,"Presiona cualquier tecla para continuar...$"
	residuoDiv db 10,10,"Residuo: $"
	salto db 10,13,36
	n1 db 0
	n2 db 0
	n1aux db 0
	n2aux db 0
	pot db 10
	;variables para formato de impresion 
	c1 db 0
	c2 db 0
	c3 db 0
	c4 db 0
	r db 0
.code 
	mov ax,@data 
	mov ds,ax
	;cls screen
	mov ax,0600h
    	mov bl,0ah
    	mov cx,0000h
	mov dx,184fh
    int 10h
inicio:
	mov ah,00h
	mov ax,3
	int 10h
	;se muestra el menu 
	mov ah,09h
	mov dx,offset datosMenu
	int 21h 
	mov ah,01h	;se inserta caracter 
	int 21h
	cmp al,31h	;comparacion de la variable con opciones 
		je suma
	cmp al,32h
		je resta
	cmp al,33h
		je multiplicacion
	cmp al,34h
		je division
	cmp al,35h
		je salir
	cmp al,36h
		jge default
	cmp al,30h
		jle default
	;inician las funciones 
	suma:
		;muestra mensaje
		mov ah,09h
		mov dx,offset instruccion
		int 21h
		mov ah,01h	;decena primer numero 
		int 21h
		mov c1,al										;*****c1	
		sub al,30h
		mul pot		;se multiplica por la variable por == 10
		mov n1,al	;el valor se guarda en AL, se hace un respaldo en la variable n1
		mov ah,01h	;unidades de primer digito
		int 21h
		mov c2,al										;*****c2	
		sub al,30h	;se restan 30 al valor insertado 
		add al,n1	;se suman las decenas que se guardan en la variable n1 a AL 
		mov n1,al	;Al contiene el valor completo, se respalad en N1
		;n1 contiene el valor del primer numero
		
		mov ah,02h
		mov dl,'+'
		int 21h
		mov ah,01h	;decenas segundo digito
		int 21h
		mov c3,al										;*****c3	
		sub al,30h	;se restan 30h al registro AL 
		mul pot		;se multiplica AL x pot, el resultado se guarad en AL 
		mov n2,al	;se respalda Al,en las n2
		mov ah,01h	;unidades segundo digito 
		int 21h
		mov c4,al										;*****c4
		sub al,30h	;restamos 30h al valor insertado, valor original 
		add al,n2	;se suman las decenas guardadas en las variables, con las unidades 
		mov n2,al	;n2 contiene el valor del segundo numero 

		;hacer  suma de n1,n2
		mov al,n1
		add al,n2
		aam		;ajustes ASCII despues de la mutiplicacion
		;tambien podria usarse AAA pero solo para suma de unidades  
		mov n1aux,ah
		mov n2aux,al
		mov ah,09h	;se imprime valores con formato 
		mov dx,offset salto
		int 21h
		int 21h
		int 21h
		mov ah,02h
		mov	dl,c1
		int 21h
		mov dl,c2
		int 21h
		mov dl,'+'
		int 21h
		mov dl,c3
		int 21h
		mov dl,c4
		int 21h
		mov dl,'='
		int 21h
		mov ah,02h	;imprimir el numero
		mov dl,n1aux;parte alta del resultado 
		add dl,30h
		int 21h
		mov ah,02h
		mov dl,n2aux;parte baja del resultado 
		add dl,30h
		int 21h
		mov ah,09h	;se espera hasta insertar tecla 
		mov dx,offset sleep
		int 21h
		mov ah,01h
		int 21h
		jmp inicio	;regresa a inicio 
		
		
	resta:
		;muestra mensaje
		mov ah,09h
		mov dx,offset instruccion
		int 21h
		mov ah,01h	;decena primer numero 
		int 21h
		mov c1,al										;*****c1	
		sub al,30h
		mul pot
		mov n1,al
		mov ah,01h	;unidades de primer digito
		int 21h
		mov c2,al										;*****c2	
		sub al,30h
		add al,n1
		mov n1,al	;n1 contiene el valor del primer numero
		mov ah,02h
		mov dl,'-'
		int 21h
		mov ah,01h	;decenas segundo digito
		int 21h
		mov c3,al										;*****c3	
		sub al,30h
		mul pot
		mov n2,al	
		mov ah,01h	;unidades segundo digito 
		int 21h
		mov c4,al										;*****c4
		sub al,30h
		add al,n2
		mov n2,al	;n2 contiene el valor del segundo numero
		;compara valor de digitos 
		mov al,n1
		cmp n2,al
			jg numNeg
		;hacer  resta de n1,n2
		mov al,n1
		sub al,n2
		aam
		mov n1aux,ah
		mov n2aux,al
		mov ah,09h
		mov dx,offset salto
		int 21h
		int 21h
		int 21h
		mov ah,02h	;s imprime en formato 
		mov	dl,c1
		int 21h
		mov dl,c2
		int 21h
		mov dl,'-'
		int 21h
		mov dl,c3
		int 21h
		mov dl,c4
		int 21h
		mov dl,'='
		int 21h
		;imprimir el numero
		mov ah,02h
		mov dl,n1aux
		add dl,30h
		int 21h
		mov ah,02h
		mov dl,n2aux
		add dl,30h
		int 21h
		mov ah,09h
		mov dx,offset sleep
		int 21h
		mov ah,01h
		int 21h
		jmp inicio	;regresa a inicio
		numNeg:		;si el resultado es un numero negativo 
			mov ah,09h
			mov dx,offset msgNumNeg
			int 21h
			mov ah,09h
			mov dx,offset sleep
			int 21h
			mov ah,01h
			int 21h
			jmp inicio
		
	multiplicacion:
		;muestra mensaje
		mov ah,09h
		mov dx,offset instruccion
		int 21h
		mov ah,01h	;decena primer numero 
		int 21h
		mov c1,al										;*****c1	
		sub al,30h
		mul pot
		mov n1,al
		mov ah,01h	;unidades de primer digito
		int 21h
		mov c2,al										;*****c2	
		sub al,30h
		add al,n1
		mov n1,al	;n1 contiene el valor del primer numero
		mov ah,02h
		mov dl,'*'
		int 21h
		mov ah,01h	;decenas segundo digito
		int 21h
		mov c3,al										;*****c3	
		sub al,30h
		mul pot
		mov n2,al	
		mov ah,01h	;unidades segundo digito 
		int 21h
		mov c4,al										;*****c4
		sub al,30h
		add al,n2
		mov n2,al	;n2 contiene el valor del segundo numero 
		;hacer  multiplicacion de n1,n2
		mov al,n1
		mov cl,n2
		mul cl
		aam	
		mov n1aux,ah
		
		mov n2aux,al
		mov ah,09h
		mov dx,offset salto
		int 21h
		int 21h
		int 21h
		mov ah,02h
		mov	dl,c1
		int 21h
		mov dl,c2
		int 21h
		mov dl,'*'
		int 21h
		mov dl,c3
		int 21h
		mov dl,c4
		int 21h
		mov dl,'='
		int 21h
		;imprimir el numero
		mov ah,02h
		mov dl,n1aux
		add dl,30h
		int 21h
		mov ah,02h
		mov dl,n2aux
		add dl,30h
		int 21h
		mov ah,09h
		mov dx,offset sleep
		int 21h
		mov ah,01h
		int 21h
		jmp inicio	;regresa a inicio
		
	division:
		;muestra mensaje
		mov ah,09h
		mov dx,offset instruccion
		int 21h
		mov ah,01h	;decena primer numero 
		int 21h
		mov c1,al										;*****c1	
		sub al,30h
		mul pot
		mov n1,al
		mov ah,01h	;unidades de primer digito
		int 21h
		mov c2,al										;*****c2	
		sub al,30h
		add al,n1
		mov n1,al	;n1 contiene el valor del primer numero
		mov ah,02h
		mov dl,246
		int 21h
		mov ah,01h	;decenas segundo digito
		int 21h
		mov c3,al										;*****c3	
		sub al,30h
		mul pot
		mov n2,al	
		mov ah,01h	;unidades segundo digito 
		int 21h
		mov c4,al										;*****c4
		sub al,30h
		add al,n2
		mov n2,al	;n2 contiene el valor del segundo numero 
		;hacer  division de n1,n2
		xor ax,ax
		mov cl,n1		;dividendo
		add ax,cx
		mov bl,n2		;divisor 
		div n2
		aam
		mov n1aux,ah	;residuo
		mov n2aux,al	;cociente
		aad
		mov ah,09h
		mov dx,offset salto
		int 21h
		int 21h
		int 21h
		mov ah,02h
		mov	dl,c1
		int 21h
		mov dl,c2
		int 21h
		mov dl,246
		int 21h
		mov dl,c3
		int 21h
		mov dl,c4
		int 21h
		mov dl,'='
		int 21h
		;imprimir el numero
		mov al,n1aux
		aam
		mov bx,ax
		mov ah,02h
		mov dl,bl
		add dl,30h
		int 21h
		mov al,n2aux
		aam
		mov bx,ax
		mov ah,02h
		mov dl,bl
		add dl,30h
		int 21h 
		
		mov ah,09h
		mov dx,offset sleep
		int 21h
		mov ah,01h
		int 21h
		jmp inicio	;regresa a inicio
		
	mayor100:
		mov ah,09h
		mov dx,offset msgTresDigitos
		int 21h
		mov ah,09h
		mov dx,offset sleep
		int 21h 
		mov ah,01h
		int 21h 
		jmp inicio
		
	default:
		mov ah,00h
		mov ax,3
		int 10h
		jmp inicio
		
	salir:			;devuelve el control al DOS
		mov ah,4ch
		int 21h
	
end 
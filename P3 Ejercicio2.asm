.model small 
.stack 
.data 
	jumps
	msgInicio db 10,13,"Factorial de un numero , solo hasta el numero 4", 36
	msgInsertar db 10,13,"Inserta 1-2-3-4:  ",36
	msgResultado db 10,13,"Resultado Final: ", 36  
	msgValidarNumero db 10,13,"Solo numeros del 1-4...",36
	saltodelinea db 10,13,36
	res db 1
	factorial db 0
.code 
	mov ax,@data 
	mov ds,ax
	;se limpia la pantalla 
	mov ah,00h
	mov ax,3
	int 10h
	mov ah,09h
	mov dx,offset msgInicio
	int 21h
	insertar:
	mov ah,09h
	mov dx,offset saltodelinea
	int 21h
	int 21h
	mov al,0
	mov dx,offset msgInsertar
	int 21h 
	mov ah,01h	;se pide el numero al usuario 
	int 21h
	
	cmp al,30h
		jl 	validarNumeros;menor 
	cmp al,34h
		jg 	validarNumeros;mayor 
		
	sub al,30h
	mov cl,al
	mov factorial,al 
	mov ah,02h 
	mov dl,'!'
	int 21h
	mov ah,09h
	mov dx,offset saltodelinea
	int 21h
	int 21h
	
	ciclo:
		mov al,res 	;operador a multiplicar 
		mov bl,cl
		mul bl		;se realiza la multiplicacion
		mov res,al	;se respalda el resultado en res
		mov al,res 
		aam 		;ajuste ASCII despues de la multiplicacion 
		mov bx,ax	
		mov ah,02h
		mov dl,bh	;parte alta del resultado  
		add dl,30h
		int 21h
		mov ah,02h
		mov dl,bl	;parte baja del resultado 
		add dl,30h
		int 21h
		mov ah,02h
		mov dl,' '
		int 21h
	loop ciclo
	;se imprimen en formato 
	mov ah,09h
	mov dx,offset saltodelinea
	int 21h
	mov dx,offset msgResultado
	int 21h 
	mov ah,02h
	mov dl,factorial
	add dl,30h
	int 21h 
	mov ah,02h 
	mov dl,'!'
	int 21h 
	mov dl,'='
	int 21h
	mov al,res 
	aam 	;ajuste ASCII para multiplicacion
	mov bx,ax
	mov ah,02h
	mov dl,bh	;parte alta 
	add dl,30h
	int 21h
	mov ah,02h
	mov dl,bl	;parte baja
	add dl,30h
	int 21h
	mov ah,09h
	mov dx,offset saltodelinea
	int 21h
	int 21h 
	;devuelve el control al DOS
	mov ah,4ch
	int 21h
	
	validarNumeros:
		mov ah,00h
		mov ax,3
		int 10h
		mov ah,09h
		mov dx,offset msgValidarNumero
		int 21h
		jmp insertar
	
	
	
end
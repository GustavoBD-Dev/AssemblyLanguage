.model small
.stack 
.data 
	msg1 db 10,13,"inserte numero de ciclos:   ",36
	msg2 db 10,13,"Error ... solo numeros del 1-9",10,13,36
	msg3 db 10,13,"inserte variable en figura: ",36
	jumpLine db 10,13,36
	maxima db 0,36
	segmentoEspacio db 0,36
	num db 0,36
	var db 0,36
.code 
	mov ax,@data 
	mov ds,ax
	mov ah,09h			;mensaje de entrada de variable a imprimir
	mov dx,offset msg3
	int 21h
	mov ah,01h			;se inserta el caracter 
	int 21h
	mov var,al			;se guarda en num la variable de entrada al
	mov segmentoEspacio,al
	mov dl,var
	add dl,30h
	mov si,0
inicio:
	mov ah,09h			;mensaje de entrada de numero de ciclos 
	mov dx,offset msg1
	int 21h
	mov ah,01h			;se inserta el caracter 
	int 21h	
	
	cmp al,39h			;compara el valor de al con el caracter ASCII
		jg inicio		;si es mayor 
	cmp al,32h
		jl inicio		;si es menor 
				
	cmp al,30h
		jle default		;menor o igual 
	cmp al,40h
		jg default		;si es mayor al con 40h mayor 
	jmp correcto
	default:			;forma de limpiar pantalla 
		mov ax,0600h		;funcion 600h
		mov bl,0ah
		mov cx,0000h
		mov dx,184fh
		int 10h			;interrupcion de video 
		mov ah,09h
		mov dx,offset msg2
		int 21h
	jmp inicio
	correcto:
	sub al,30h			;se restan 30h a el registro AL 
	mov num,al
	mov ah,09h			;salto de linea
	mov dx,offset jumpLine
	int 21h
;parte alta 
	mov al,num
	mov cl,al
	add cl,al
	mov al,0
	max:
		inc al
	loop max
	dec al
	mov bl,al
	mov maxima,al
	;bl contienen el numero maximo de caracteres
	mov si,1	;iniciamos indice 

figuraPA:
	;inicia impresion de espacios 
	dec segmentoEspacio		;decrementa la variable en 1
	mov cl,segmentoEspacio
	espacios:
		mov ah,02h
		mov dl,' '
		int 21h
	loop espacios
	;termina impresion de espacios
	; se le asigna el al el total de caracteres a imprimir 
	mov cx,si
	mov al,0
	maxC:
		inc al
	loop maxC
	mov cl,al
	sub cl,30h			;se resta al registro CL 30h
	cmp cl,maxima
		je seguir		;CL == maxima ?
	cmp cl,1
		je cls			;CL == 1 ?
 	nextCls:
		figuraPA1:			;este ciclo imprime los caracteres
			mov ah,02h
			mov dl,var		;var guarda el carcater a imprimir 
			int 21h
		loop figuraPA1
	mov ah,09h		
	mov dx,offset jumpLine
	int 21h 
	
	add si,02d 
jmp figuraPA
	
	cls:			;limpia pantalla para imprimir solo la firgura 
		mov cl,25
		saltoCLS:
			mov ah,09h
			mov dx,offset jumpLine
			int 21h
		loop saltoCLS		
		;inicia impresion de espacios 
		dec segmentoEspacio
		mov cl,segmentoEspacio
		espaciosCLS:
			mov ah,02h
			mov dl,' '
			int 21h
		loop espaciosCLS
	;termina impresion de espacios
		mov cl,1
	jmp nextCls
		
	
seguir:
;parte maxima de caracteres y parte baja 
	mov cl,02h
	mov al,num
	mul cl
	mov bx,ax
	mov cl,00h
	mov cl,bh
	add cl,bl
	mov cl,bl
figura:
	dec cl
	figura2:			;este ciclo imprime la variable 
		mov ah,02h
		mov dl,var	
		int 21h
	loop figura2
	mov ah,09h
	mov dx,offset jumpLine
	int 21h
	;inicia impresion de espacios 
	inc segmentoEspacio
	mov cl,segmentoEspacio
	espacios2:
		mov ah,02h
		mov dl,' '
		int 21h
	loop espacios2
	;termina impresion de espacios
	dec bl
	dec bl
	mov cl,bl
	cmp cl,0
		je salir 
jmp figura
;--------------------------------------------
salir:
	mov ah,4ch
	int 21h

end
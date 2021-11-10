.model small 
.stack 
.data 
	v1 db 10,10,13,"inserte numero de tabla a mostrar: ",36
	v2 db 10,13,"error... solo numeros del 1-9","$"
	num db 0,36
	saltodelinea db 10,13,36
	espacio db 09,36
.code 
	mov ax,@data 
	mov ds,ax
	mov cx,30
	mov ah,09h
	mov dx,offset saltodelinea
	cls:
		int 21h
	loop cls
		
inicio:
	;mostramos mensaje para introducir numero 
	mov ah,09h
	mov dx,offset v1
	int 21h
	;lee el teclado 
	mov ah,01h
	int 21h
	
	cmp al,30h
		jle default
	cmp al,40h
		jge default
	
	sub al,30h
	mov num,al 
	mov cl,00h
	;salto de linea
	mov ah,09h
	mov dx,offset saltodelinea
	int 21h
	int 21h
tabla:

	mov ah,09h
	mov dx,offset espacio
	int 21h

	mov al,num
	add al,30h
	mov ah,02h
	mov dl,al
	int 21h
	
	mov ah,02h
	mov dl,'x'
	int 21h
	
	add cl,30h
	cmp cl,39h
		jg diex
	
	mov ah,02h
	mov dl,'0'
	int 21h
	mov dl,cl
	int 21h	
	
	afterdiex:
	sub cl,30h
	
	mov ah,02h
	mov dl,'='
	int 21h
	
	mov al,num  
    	mul cl 		;se multiplica CL x Al, el resultado se guarda en AX
    	aam  		;ajuste ASCII para multiplicación
    	mov bx,ax  	;Se respalda la multiplicación el BX
    	mov ah,02h
    	mov dl,bh  	;parte alta del resultado DECENAS 
    	add dl,30h 
    	int 21h
    	mov dl,bl 
    	add dl,30h	;parte baja del resultado UNIDADES 	
    	int 21h
		mov ah,09h
		mov dx,offset saltodelinea
		int 21h
   	inc cx  
  	cmp cx,11
  	ja salir  	;salir
 	jb tabla 	;repetir

salir:
	mov ah,4ch
	int 21h
default:
	mov ax,0600h	;limpiar pantalla 
	mov bl,0ah
	mov cx,0000h
	mov dx,184fh
	int 10h
	
	mov ah,09h
	mov dx,offset v2
	int 21h
	jmp inicio	
diex:
	mov ah,02h
	mov dl,'1'
	int 21h
	mov ah,02h
	mov dl,'0'
	int 21h
	jmp afterdiex
	

end

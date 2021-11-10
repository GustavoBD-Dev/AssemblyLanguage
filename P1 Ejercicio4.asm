.model small            ; tamanio del modelo 
.stack                  ; tamanio de la pila predeterminado  
.data                   ; area de las variables  
       
	v1 db 9,"carcater insertado:$"  
       
.code                   ; area de instrucciones  
  
	mov Ah,01h          ;01h lee el teclado 
	int 21h             ;llamara a la interrupcion 21h con la funcion 01h 
	mov dl,al           ;guarda en: (al)caracter ASCII y (dl)caracter ASCII a desplegar 
	int 21h              
	mov ah,02h          ;escribe a dispositivo estandar de salida 
	int 21h             ; 
	mov ah,4ch          ;se solicita la opcion FINALIZAR UN PROCESO de 21h 
	int 21h             ;se devuelve el control al sistema 
       
 end
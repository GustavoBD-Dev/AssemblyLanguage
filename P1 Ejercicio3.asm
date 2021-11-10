.model small            ; tamanio del modelo  
.stack                  ; tamanio de la pila predeterminado  
.data                   ; area de las variables  
	v1 db 9,"Se ha borrado la pantalla...$"  
.code                   ;area de instrucciones  
	mov ah,00h          ;(00h) modo de video 3 
	mov al,3            ;modo de video 3 (texto a color) 
	int 10h             ;interrupcion de serivioios de video 
        	            ;una vez borrada la patalla se muestra el mensaje 
	mov Ax,@data        ;se guarda el contenido en Ax 
	mov Ds,Ax           ;el contenido de Ax se guarda en Ds 
	mov Ah,09h          ;09h despliega una cadena de caracteres 
	mov Dx,offset v1    ;la cadena v1 entra a Dx 
	int 21h             ;llamara a la interrupcion 21h con la funcion 09h    
	mov ah,4ch          ;se solicita la opcion FINALIZAR UN PROCESO de 21h 
	int 21h             ;se devuelve el control al sistema 
end
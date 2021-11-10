.model small            ; tamanio del modelo  
.stack                  ; tamanio de la pila predeterminado  
.data                   ; area de las variables  
   
	array db 9,71,85,83,84,65,86,79,"$"  
       
 .code                   ;area de isntrucciones  
   
	mov Ax,@data        ;se guarda el contenido en Ax 
      	mov Ds,Ax           ;el contenido de Ax se guarda en Ds 
     	mov Ah,09h          ;09h despliega una cadena de caracteres 
     	mov Dx,offset array ;la cadena v1 entra a Dx 
      	int 21h             ;llamara a la interrupcion 21h con la funcion 09h    
      	mov ah,4ch          ;se solicita la opcion FINALIZAR UN PROCESO de 21h 
      	int 21h             ;se devuelve el control al sistema 
       
end
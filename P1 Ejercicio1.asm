.model small            ; tamanio del modelo  
.stack                  ; tamanio de la pila predeterminado  
.data                   ; area de las variables  
   
     v1 db 0Ah,0Dh,09h,"Primer mensaje$"  
     v2 db 0Ah,0Dh,09h,09h,"Segundo mensaje$"  
     v3 db 0Ah,0Dh,09h,09h,09h,"Tercer mensaje$"  
      
.code                   ;area de isntrucciones 
   
      mov Ax,@data        ;se guarda el contenido en Ax 
      mov Ds,Ax           ;el contenido de Ax se guarda en Ds 
      mov Ah,09h          ;09h despliega una cadena de caracteres 
      mov Dx,offset v1    ;la cadena v1 entra a Dx 
      int 21h             ;llamara a la interrupcion 21h con la funcion 09h    
      mov Dx,offset v2    ;la cadena v2 entra a Dx 
      int 21h             ;interrupcion con la funcion 09h 
      mov Dx,offset v3    ;la cadena v2 entra a Dx 
      int 21h             ;interrupcion con la funcion 09h 
      mov ah,4ch          ;se solicita la opcion FINALIZAR UN PROCESO de 21h 
      int 21h             ;se devuelve el control al sistema 
       
  end 
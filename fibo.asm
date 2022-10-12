
;Debido a que en ensamblador no se puede simplemente dar el numero e imprimirlos
;sino que se debe tener su valor en hexagonal decimal
;definimos un arreglo de 13 espacios para que contenga los primeros dígitos de la sucesión
.model small ;modelo de datos
.stack ;segmento de pila
.data ;segmento de datos
    contador dw 2 ;contador de la sucesión, se inicia en dos porque el primer y segundo número ya están dados
    arreglo db 13 dup (0) ;este es el arreglo que contiene los 13 espacios
    n3 db 0 ;este es el tercer numero de la sucesión
    
.code
    main proc far ;procedimiento principal, que lo llamamos main por convención 
        mov ax,@data ;movemos el segmento de datos a ax
        mov ds,ax ;movemos ax a ds

        mov ah,0
        mov al,1

        mov arreglo[0],ah ;movemos el primer numero de la sucesión al arreglo en la posición 0
        mov arreglo[1],al ;movemos el segundo numero de la sucesión al arreglo en la posición 1

        ;definimos los valores de los registros si y di

        mov si,0 ; si sera el siguiente indice del arreglo
        mov di,1 ;di sera el indice anterior del arreglo

        mov cx,13d
        ciclo: ;etiqueta del ciclo
            mov al,arreglo[si] ;movemos el valor del arreglo en la posición si a el registro al
            mov bl,arreglo[di] ;movemos el valor del arreglo en la posición di a el registro bl
            add al,bl ;sumamos los valores de al y bl
            mov bx,contador ;movemos el valor del contador a bx
            mov arreglo[bx],al ;movemos el valor de al al arreglo en la posición del contador
            ;es decir movemos el valor de la suma al arreglo en la posición del contador
            ;esto es para que el arreglo contenga los primeros 13 números de la sucesión
            inc si ;incrementamos si es decir avanzamos al siguiente indice del arreglo
            inc di ;incrementamos di es decir avanzamos al siguiente indice del arreglo
            inc contador ;incrementamos el contador
        loop ciclo ;hacemos el ciclo hasta que el contador sea igual a 13

        mov si,0 ;movemos el valor de 0 a si
        ;es decir volvemos a empezar desde el primer indice del arreglo
        mov cx,13d ;movemos el valor de 13 a cx
        ;es decir el contador es igual a 13

        ciclo_imprime:
            mov ax,0 ;movemos el valor de 0 a ax
            mov al,arreglo[si] ;movemos el valor del arreglo en la posición si a al
            cmp ax,144d ;comparamos el valor de ax con 144 
            jge ajusta_3_digitos ;si el valor de ax es mayor o igual a 144 entonces vamos a la etiqueta ajusta_3_digitos

            ajustar_2_digitos: ;si el numero tiene dos digitos entramos aqui
            aam ;dividimos el valor de al entre 10 y movemos el resultado a ah y el residuo a al
            mov bx,ax ;movemos el valor de ax a bx
            add bx,3030h ;sumamos 3030h a bx

            mov ah,02h ;movemos el valor de 02h a ah
            mov dl,bh ;movemos el valor de bh a dl
            int 21h ;llamamos a la interrupción 21h para imprimir el valor de dl

            mov ah,02h ;movemos el valor de 02h a ah
            mov dl,bl ;movemos el valor de bl a dl
            int 21h ;llamamos a la interrupción 21h para imprimir el valor de dl

            mov ah,02h ;movemos el valor de 02h a ah
            mov dl,' ' ;movemos el valor de ' ' a dl
            int 21h ;llamamos a la interrupción 21h para imprimir el valor de dl
            jmp avanza ;saltamos a la etiqueta avanza

            ajusta_3_digitos: ;si el numero tiene tres digitos entramos aqui
                aam ;dividimos el valor de al entre 10 y movemos el resultado a ah y el residuo a al
                add al,30h ;sumamos 30h a al
                mov n3,al ;movemos el valor de al a n3

                mov al,ah ;movemos el valor de ah a al
                mov ah,0 ;movemos el valor de 0 a ah
                aam ;dividimos el valor de al entre 10 y movemos el resultado a ah y el residuo a al
                mov bx,ax ;movemos el valor de ax a bx
                add bx,3030h ;sumamos 3030h a bx

                mov ah,02h ;movemos el valor de 02h a ah
                mov dl,bh ;movemos el valor de bh a dl
                int 21h ;llamamos a la interrupción 21h para imprimir el valor de dl

                mov ah,02h ;movemos el valor de 02h a ah
                mov dl,bl ;movemos el valor de bl a dl
                int 21h ;llamamos a la interrupción 21h para imprimir el valor de dl

                mov ah,02h ;movemos el valor de 02h a ah
                mov dl,n3 ;movemos el valor de n3 a dl
                int 21h ;llamamos a la interrupción 21h para imprimir el valor de dl

                mov al,02h ;movemos el valor de 02h a al
                mov dl,' ' ;movemos el valor de ' ' a dl
                int 21h ;llamamos a la interrupción 21h para imprimir el valor de dl

        avanza: ;etiqueta avanza
            inc si ;incrementamos si es decir avanzamos al siguiente indice del arreglo
    loop ciclo_imprime ;hacemos el ciclo hasta que el contador sea igual a 13

        mov ah,4ch ;movemos el valor de 4ch a ah
        int 21h ;llamamos a la interrupción 21h para terminar el programa
 
    main endp ;fin del procedimiento principal o main
eßnd main
     
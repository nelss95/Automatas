with Text_IO,Sequential_IO,Direct_IO;
use Text_IO;
with paquete;

package body paquete is
procedure automata (Ancho:Integer;Numero:Integer) is ---Ancho es el ancho que tendrá el bitmap(Tiempo*2),Numero es el numero ingresado por el usuario
Num : Integer:=Numero;--variable donde se guarda el número
Indice : Integer:= 8; --Indice para la convercion a binario 
Tiempo : Integer; --El tiempo ingresado por el usuario que lo sacaremos con Ancho/2
type Estado is array(1..3) of Integer; --Array para crear los posibles 8 estados binarios
Cero:Estado:=(0,0,0); ---Estado 0 en binario
Uno:Estado:=(0,0,1); ---Estado 1 en binario
Dos:Estado:=(0,1,0); --Estado 2 en binario
Tres:Estado:=(0,1,1); --Estado 3 en binario
Cuatro:Estado:=(1,0,0); --Estado 4 en binario
Cinco:Estado:=(1,0,1); --Estado 5 en binario
Seis:Estado:=(1,1,0); --Estado 6 en binario
Siete:Estado:=(1,1,1); --Estado 7 en binario
segmento:Estado:=(0,0,0); --Segemento será un estado cambiante
type mapa is array (1..Ancho) of Integer; --El tipo mapa es un array, que es donde escribiremos los 1 y 0
listaActual:mapa; --listaActual es la lista que se recorre para leer y sacar los tercios
listaSecundaria:mapa; --listaSecundaria es la lista en donde se escribira el resultado de las comparaciones
Bin:array(1..8) of Integer:=(0,0,0,0,0,0,0,0); --donde se guardara el numero itroducido por el usuario en binario

--- creamos la imagen---
Imagen:File_Type;
Guardar:String:=Integer'Image(0);
---------Función para comparar las tripletas---------------
function compararVecinos(A:Estado) return Integer is
   begin

      if (A=Cero) then
         if (Bin(8) = 1) then
         return 1;
         end if;
      end if;
      if (A=Uno) then
         if (Bin(7) = 1) then
         return 1;
         end if;
      end if;
      if (A=Dos) then
         if (Bin(6) = 1) then
         return 1;
         end if;
      end if;
      if (A=Tres) then
         if (Bin(5) = 1) then
         return 1;
         end if;
      end if;
      if (A=Cuatro) then
         if (Bin(4) = 1) then
         return 1;
         end if;
      end if;
      if (A=Cinco) then
         if (Bin(3) = 1) then
         return 1;
         end if;
      end if;
      if (A=Seis) then
         if (Bin(2) = 1) then
         return 1;
         end if;
      end if;
      if (A=Siete) then
         if (Bin(1) = 1) then
         return 1;
         end if;
      end if;
   return 0;

   end compararVecinos;





begin
---Convertimos el numero que nos dio el usuario a binario
    while Num>1 loop
    	bin(Indice):= Num mod 2;
    	Num:= Num/2;
    	Indice:=Indice-1;
    end loop;
    bin(Indice):=Num;
----Creamos el tiempo---------------
     Tiempo:= Ancho/2;
--Cremos el archivo----
      Create (Imagen,out_File,"Automata.pnm");
      Put(Imagen,"P1");
      Put(Imagen,ASCII.LF);
      Put(Imagen,"# feep.pbm");
      Put(Imagen,ASCII.LF);
      Put(Imagen,Integer'Image(Ancho) & Integer'Image(Tiempo));
      Put(Imagen,ASCII.LF);




 --Inicializa los ciclos de 1 a T con 0.
    for P in 1..Ancho loop
        listaActual(P):=0;
        listaSecundaria(P):=0;
    end loop;
--- Colocamos un 1 en la mitad de la lista          
    listaActual(Tiempo):=1;
--- Escribimos la primera linea         
    for I in 1..Ancho loop
      Guardar:=Integer'Image(listaActual(I));
      Put(Imagen,Guardar);
   end loop;

    for varTiempo in 1..Tiempo loop --ciclo que recorrer los tiempos que dio el usuario
        for varAncho in 1..Ancho loop -- ciclo para recorrer el ancho de cada lista
	 --Eleccion del tercio al lado izquierdo--
	     if (varAncho > 2 ) then 
	         segmento(1) := listaActual(varAncho-2);
	         segmento(2) := listaActual(varAncho-1); 
	         segmento(3) := listaActual(varAncho);
	         listaSecundaria(varAncho-1) := compararVecinos(segmento);
	     elsif (varAncho = 2) then
	         segmento(1) := listaActual(Ancho);
                 segmento(2) := listaActual(1);
                 segmento(3) := listaActual(2);
                 listaSecundaria(1) := compararVecinos(segmento);
             elsif (varAncho = 1) then
	         segmento(1) := listaActual(Ancho-1);
                 segmento(2) := listaActual(Ancho);
                 segmento(3) := listaActual(1);
                 listaSecundaria(Ancho) := compararVecinos(segmento);
	     end if;
        --Eleccion del tercio central---
	     if (varAncho > 1 and varAncho < Ancho) then
	         segmento(1) := listaActual(varAncho-1);
	         segmento(2) := listaActual(varAncho); 
	         segmento(3) := listaActual(varAncho+1);
	         listaSecundaria(varAncho) := compararVecinos(segmento);
	    elsif (varAncho = 1) then
	         segmento(1) := listaActual(Ancho);
	         segmento(2) := listaActual(varAncho); 
	         segmento(3) := listaActual(varAncho+1);
	         listaSecundaria(varAncho) := compararVecinos(segmento);
            elsif (varAncho = Ancho) then
	         segmento(1) := listaActual(varAncho-1);
	         segmento(2) := listaActual(varAncho); 
	         segmento(3) := listaActual(1);
	         listaSecundaria(varAncho) := compararVecinos(segmento);
	    end if;
	--Eleccion del tercio al lado derecho--
	     if (varAncho < Ancho-1) then
	         segmento(1) := listaActual(varAncho);
	         segmento(2) := listaActual(varAncho+1); 
	         segmento(3) := listaActual(varAncho+2);
	         listaSecundaria(varAncho+1) := compararVecinos(segmento);
             elsif (varAncho = Ancho-1) then
	         segmento(1) := listaActual(varAncho);
	         segmento(2) := listaActual(varAncho+1); 
	         segmento(3) := listaActual(1);
	         listaSecundaria(varAncho+1) := compararVecinos(segmento);
	     elsif (varAncho = Ancho) then  
		 segmento(1) := listaActual(varAncho);
	         segmento(2) := listaActual(1); 
	         segmento(3) := listaActual(2);
	         listaSecundaria(1) := compararVecinos(segmento);
 	    
	     end if;
	end loop;
	--Escribimos el nuevo array
	 Put(Imagen,ASCII.LF);
	for I in 1..Ancho loop
	   Put(Imagen,Integer'Image(listaSecundaria(I)));
	end loop;
	---Asigmaos la nueva lista actual y ponemos en 0 la secundaria
	listaActual:=listaSecundaria;
               For I in 1..Ancho loop
                 listaSecundaria(I):=0;
               end loop;    

     end loop;

	

null;
end automata;
end paquete;

with Gnat.IO;use GNAT.IO;

--package body paquete is
procedure consola is
Num : Integer;
Indice : Integer:= 8;
Tiempo : Integer;
Ancho : Integer;
--P:Integer;
type Estado is array(1..3) of Integer;
Cero:Estado:=(0,0,0);
Uno:Estado:=(0,0,1);
Dos:Estado:=(0,1,0);
Tres:Estado:=(0,1,1);
Cuatro:Estado:=(1,0,0);
Cinco:Estado:=(1,0,1);
Seis:Estado:=(1,1,0);
Siete:Estado:=(1,1,1);
segmento:Estado:=(0,0,0);
type mapa is array (1..2048) of Integer;
listaActual:mapa;
listaSecundaria:mapa;
Bin:array(1..8) of Integer:=(0,0,0,0,0,0,0,0);

      --Imagen-
--Imagen:File_Type;
--Guardar:String:=Integer'Image(0);

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

    Put("Digite un numero entero del 0 al 255: ");
    Get(Num);
   
    
    while Num>1 loop
    	bin(Indice):= Num mod 2;
    	Num:= Num/2;
    	Indice:=Indice-1;
    end loop;
    bin(Indice):=Num;

   Put("Digite el tiempo del automata: ");
   Get(Tiempo);
   Ancho := Tiempo*2;
 --Inicializa los ciclos de 1 a T con 0.
    for P in 1..Ancho loop
        listaActual(P):=0;
        listaSecundaria(P):=0;
    end loop;
          
    listaActual(Tiempo):=1;
          
    for I in 1..Ancho loop
      Put(listaActual(I));
   end loop;

    for varTiempo in 1..Tiempo loop
        for varAncho in 1..Ancho loop
	-- if (listaActual(varAncho)= 1 ) then
	 --Eleccion del tercio al lado izquierdo del 1--
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
	-- end if;       
	end loop;
	--Muestra el nuevo array
	 New_Line;
	for I in 1..Ancho loop
	   Put((listaSecundaria(I)));
	end loop;
	
	listaActual:=listaSecundaria;
               For I in 1..Ancho loop
                 listaSecundaria(I):=0;
               end loop;    

     end loop;

	

null;
end consola;


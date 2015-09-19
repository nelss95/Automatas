with Gnat.IO;use GNAT.IO;
with paquete;use paquete;

procedure main is

   Numero:Integer:=257;
   Tiempo:Integer;

begin
    Put("Bienvenido a su automata celular");
    New_Line;
     
    while Numero>255 loop
    	Put("Digite un número del 0 al 255: ");
   	 Get(Numero);
     end loop;
    
      Put("Ingrese el tiempo que desea que tenga el automata: ");
      Get(Tiempo);
      
      Tiempo:=(Tiempo*2)+1;
   
      automata(Tiempo,Numero);
     
      New_Line;
end main;


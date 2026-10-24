with Ada.Real_Time; use Ada.Real_Time;
with Log;
with Magazyn;

package body Monitor is

   task body Kontroler is
      LF        : constant Character := ASCII.LF;
      Stany     : array (Robot_Id) of Stan_Robota := (others => Wolny);
      Obsluzone : Natural := 0;
      Okres     : constant Time_Span := To_Time_Span (5.0);
      Raport_O  : Time := Clock + Okres;

      procedure Drukuj_Raport (Tytul : String) is
         Towary  : Stany_Towarow;
         Wyslane : Natural;
         Suma    : Natural := 0;
         Tekst   : String (1 .. 1000);
         Dl      : Natural := 0;

         procedure Dodaj (S : String) is
         begin
            Tekst (Dl + 1 .. Dl + S'Length) := S;
            Dl := Dl + S'Length;
         end Dodaj;
      begin
         Magazyn.Sejf.Sprawdz (Towary, Wyslane);
         for T in Towar loop
            Suma := Suma + Towary (T);
         end loop;

         Dodaj ("--------- " & Tytul & " ---------" & LF);
         Dodaj ("Sejf: " & Img (Suma) & " / " & Img (Pojemnosc_Sejfu) & LF);
         Dodaj ("  Zegarki     : " & Img (Towary (Zegarki)) & LF);
         Dodaj ("  Pierscionki : " & Img (Towary (Pierscionki)) & LF);
         Dodaj ("  Naszyjniki  : " & Img (Towary (Naszyjniki)) & LF);
         for I in Robot_Id loop
            Dodaj ("Robot R" & Img (I) & ": " & Nazwa (Stany (I)) & LF);
         end loop;
         Dodaj ("Dostawy obsluzone: " & Img (Obsluzone) & " / " & Img (Liczba_Dostaw) & LF);
         Dodaj ("Wyslano do salonow: " & Img (Wyslane) & " szt." & LF);
         Dodaj ("-----------------------------------");

         Log.Pisz_Blok (Tekst (1 .. Dl));
      end Drukuj_Raport;
   begin
      loop
         select
            accept Aktualizuj_Robota (Id : Robot_Id; Stan : Stan_Robota) do
               Stany (Id) := Stan;
            end Aktualizuj_Robota;
         or
            accept Dostawa_Obsluzona;
            Obsluzone := Obsluzone + 1;
         or
            accept Zakoncz do
               Drukuj_Raport ("RAPORT KONCOWY");
            end Zakoncz;
            exit;
         or
            delay until Raport_O;
            Drukuj_Raport ("CENTRUM");
            Raport_O := Raport_O + Okres;
         end select;
      end loop;
   end Kontroler;

end Monitor;

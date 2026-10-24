with Ada.Text_IO;   use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Typy;          use Typy;

package body Log is

   Start : constant Time := Clock;

   function Znacznik_Czasu return String is
      Dziesiate : constant Integer := Integer (To_Duration (Clock - Start) * 10);
      Sekundy   : constant Integer := Dziesiate / 10;
   begin
      if Sekundy < 10 then
         return "[0" & Img (Sekundy) & "." & Img (Dziesiate mod 10) & "] ";
      else
         return "[" & Img (Sekundy) & "." & Img (Dziesiate mod 10) & "] ";
      end if;
   end Znacznik_Czasu;

   task Ekran is
      entry Wypisz (Tekst : String);
      entry Wypisz_Blok (Tekst : String);
   end Ekran;

   task body Ekran is
   begin
      loop
         select
            accept Wypisz (Tekst : String) do
               Put_Line (Znacznik_Czasu & Tekst);
            end Wypisz;
         or
            accept Wypisz_Blok (Tekst : String) do
               Put_Line (Tekst);
            end Wypisz_Blok;
         or
            terminate;
         end select;
      end loop;
   end Ekran;

   procedure Pisz (Tekst : String) is
   begin
      Ekran.Wypisz (Tekst);
   end Pisz;

   procedure Pisz_Blok (Tekst : String) is
   begin
      Ekran.Wypisz_Blok (Tekst);
   end Pisz_Blok;

end Log;

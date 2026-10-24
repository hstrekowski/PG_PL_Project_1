with Typy; use Typy;
with Log;
with Konwoje;
with Stanowisko;
with Roboty;
with Magazyn;
with Serwis;
with Monitor;

procedure Main is
   Na_Rampie   : Natural;
   Rozladowane : Natural;
begin
   Log.Pisz ("Start symulacji - centrum logistyczne bizuterii i zegarkow");

   for I in Robot_Id loop
      Roboty.Robot (I).Start (I);
   end loop;
   for I in Konwoj_Id loop
      Konwoje.Konwoj (I).Start (I);
   end loop;

   loop
      Stanowisko.Rampa.Stan (Na_Rampie, Rozladowane);
      exit when Rozladowane = Liczba_Dostaw and Na_Rampie = 0;
      delay 1.0;
   end loop;
   Log.Pisz ("Wszystkie dostawy rozladowane i zabrane z rampy");

   for I in Robot_Id loop
      Roboty.Robot (I).Zakoncz;
   end loop;
   Serwis.Serwisant.Zakoncz;
   Stanowisko.Rampa.Zakoncz;
   Monitor.Kontroler.Zakoncz;
   Magazyn.Sejf.Zakoncz;

   Log.Pisz ("Koniec symulacji");
end Main;

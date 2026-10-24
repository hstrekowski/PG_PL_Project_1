with Log;
with Losowanie;
with Stanowisko;
with Magazyn;
with Serwis;
with Monitor;

package body Roboty is

   task body Robot_Type is
      Id : Robot_Id;
      G  : Losowanie.Generator;
      P  : Partia;

      function Nazwa_R return String is
      begin
         return "Robot R" & Img (Id);
      end Nazwa_R;

      procedure Zmien_Stan (S : Stan_Robota) is
      begin
         Monitor.Kontroler.Aktualizuj_Robota (Id, S);
      end Zmien_Stan;
   begin
      accept Start (Numer : Robot_Id) do
         Id := Numer;
      end Start;
      Losowanie.Inicjuj (G, Id);

      loop
         select
            accept Zakoncz do
               Zmien_Stan (Wylaczony);
               Log.Pisz (Nazwa_R & " zakonczyl prace");
            end Zakoncz;
            exit;
         else
            null;
         end select;

         select
            Stanowisko.Rampa.Pobierz (P);

            Log.Pisz (Nazwa_R & " otrzymal " & Img (P.Ilosc) & " szt. "
                      & Nazwa (P.Rodzaj) & " (D" & Img (P.Id) & ")");
            Zmien_Stan (Transport);
            Log.Pisz (Nazwa_R & " jedzie do sejfu");
            delay Losowanie.Czas (G, 0.8, 1.8);

            if Losowanie.Szansa (G, Szansa_Awarii) then
               Log.Pisz (Nazwa_R & ": AWARIA! Staje i zglasza usterke serwisantowi");
               Zmien_Stan (Awaria);
               Serwis.Serwisant.Zglos_Awarie (Id);
               Serwis.Serwisant.Odbierz_Robota;
               Log.Pisz (Nazwa_R & " naprawiony, wraca do transportu");
               Zmien_Stan (Transport);
            end if;

            delay Losowanie.Czas (G, 0.8, 1.8);

            loop
               select
                  Magazyn.Sejf.Przyjmij (P.Rodzaj, P.Ilosc);
                  exit;
               or
                  delay 2.0;
                  Log.Pisz (Nazwa_R & ": sejf pelny, czeka z ladunkiem");
               end select;
            end loop;

            Log.Pisz (Nazwa_R & " dostarczyl towar do sejfu");
            Log.Pisz (Nazwa_R & " jest ponownie wolny");
            Zmien_Stan (Wolny);
         or
            delay 1.0;
         end select;
      end loop;
   end Robot_Type;

end Roboty;

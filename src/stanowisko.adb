with Log;
with Losowanie;
with Monitor;

package body Stanowisko is

   task body Rampa is
      Miejsca     : array (1 .. Rozmiar_Rampy) of Partia;
      Glowa       : Positive := 1;
      Liczba      : Natural  := 0;
      Rozladowano : Natural  := 0;
      G           : Losowanie.Generator;
      Nowa        : Partia;
   begin
      Losowanie.Inicjuj (G, 100);

      loop
         select
            when Liczba > 0 =>
               accept Pobierz (P : out Partia) do
                  P := Miejsca (Glowa);
               end Pobierz;
               Glowa  := Glowa mod Rozmiar_Rampy + 1;
               Liczba := Liczba - 1;
         or
            when Liczba < Rozmiar_Rampy =>
               accept Zglos (P : Partia) do
                  Nowa := P;
                  Log.Pisz ("Rozpoczeto rozladunek D" & Img (Nowa.Id));
                  delay Losowanie.Czas (G, 1.5, 3.0);
                  Log.Pisz ("Zakonczono rozladunek D" & Img (Nowa.Id));
               end Zglos;

               Miejsca ((Glowa + Liczba - 1) mod Rozmiar_Rampy + 1) := Nowa;
               Liczba := Liczba + 1;
               Rozladowano := Rozladowano + 1;
               Log.Pisz ("Partia D" & Img (Nowa.Id) & " czeka na robota (na rampie: "
                         & Img (Liczba) & "/" & Img (Rozmiar_Rampy) & ")");
               Monitor.Kontroler.Dostawa_Obsluzona;
         or
            accept Stan (Na_Rampie : out Natural; Rozladowane : out Natural) do
               Na_Rampie   := Liczba;
               Rozladowane := Rozladowano;
            end Stan;
         or
            accept Zakoncz do
               Log.Pisz ("Stanowisko rozladunkowe zamkniete");
            end Zakoncz;
            exit;
         or
            delay 6.0;
            Log.Pisz ("Stanowisko: brak konwojow, ekipa rozladunkowa czeka");
         end select;
      end loop;
   end Rampa;

end Stanowisko;

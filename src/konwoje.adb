with Log;
with Losowanie;
with Stanowisko;

package body Konwoje is

   task body Konwoj_Type is
      Id : Konwoj_Id;
      G  : Losowanie.Generator;
      P  : Partia;
   begin
      accept Start (Numer : Konwoj_Id) do
         Id := Numer;
      end Start;
      Losowanie.Inicjuj (G, 1000 + Id);
      delay Losowanie.Czas (G, 0.5, 8.0);

      for Kurs in 1 .. Kursy_Konwoju loop
         P := (Id     => (Id - 1) * Kursy_Konwoju + Kurs,
               Rodzaj => Towar'Val (Losowanie.Liczba (G, 0, Towar'Pos (Towar'Last))),
               Ilosc  => Losowanie.Liczba (G, Min_Partia, Max_Partia));

         Log.Pisz ("Przyjazd: Konwoj K" & Img (Id) & " z dostawa D" & Img (P.Id) & " ("
                   & Img (P.Ilosc) & " szt. " & Nazwa (P.Rodzaj) & ")");
         Log.Pisz ("D" & Img (P.Id) & " oczekuje na rozladunek");

         Stanowisko.Rampa.Zglos (P);

         Log.Pisz ("Konwoj K" & Img (Id) & " odjezdza po rozladunku D" & Img (P.Id));

         if Kurs < Kursy_Konwoju then
            delay Losowanie.Czas (G, 8.0, 16.0);
         end if;
      end loop;
   end Konwoj_Type;

end Konwoje;

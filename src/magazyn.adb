with Ada.Real_Time; use Ada.Real_Time;
with Log;
with Losowanie;

package body Magazyn is

   task body Sejf is
      Stan    : Stany_Towarow := (others => 0);
      Wyslano : Natural := 0;
      G       : Losowanie.Generator;
      Wysylka : Time;

      function Suma return Natural is
         Wynik : Natural := 0;
      begin
         for T in Towar loop
            Wynik := Wynik + Stan (T);
         end loop;
         return Wynik;
      end Suma;

      function Zapelnienie return String is
      begin
         return "zapelnienie " & Img (Suma) & "/" & Img (Pojemnosc_Sejfu);
      end Zapelnienie;

      procedure Wyslij_Do_Salonu is
         Najwiecej : Towar := Towar'First;
         Ile       : Natural;
      begin
         for T in Towar loop
            if Stan (T) > Stan (Najwiecej) then
               Najwiecej := T;
            end if;
         end loop;

         if Stan (Najwiecej) > 0 then
            Ile := Losowanie.Liczba (G, 5, 10);
            if Ile > Stan (Najwiecej) then
               Ile := Stan (Najwiecej);
            end if;
            Stan (Najwiecej) := Stan (Najwiecej) - Ile;
            Wyslano := Wyslano + Ile;
            Log.Pisz ("[SEJF] wyslano " & Img (Ile) & " szt. " & Nazwa (Najwiecej)
                      & " do salonu jubilerskiego, " & Zapelnienie);
         end if;
      end Wyslij_Do_Salonu;
   begin
      Losowanie.Inicjuj (G, 200);
      Wysylka := Clock + To_Time_Span (Losowanie.Czas (G, 3.0, 5.0));

      loop
         select
            when Suma <= Pojemnosc_Sejfu - Max_Partia =>
               accept Przyjmij (Rodzaj : Towar; Ilosc : Positive) do
                  Stan (Rodzaj) := Stan (Rodzaj) + Ilosc;
                  Log.Pisz ("[SEJF] przyjeto " & Img (Ilosc) & " szt. "
                            & Nazwa (Rodzaj) & ", " & Zapelnienie);
               end Przyjmij;
         or
            accept Sprawdz (Towary : out Stany_Towarow; Wyslane : out Natural) do
               Towary  := Stan;
               Wyslane := Wyslano;
            end Sprawdz;
         or
            accept Zakoncz do
               Log.Pisz ("[SEJF] zamkniety");
            end Zakoncz;
            exit;
         or
            delay until Wysylka;
            Wyslij_Do_Salonu;
            Wysylka := Wysylka + To_Time_Span (Losowanie.Czas (G, 3.0, 5.0));
         end select;
      end loop;
   end Sejf;

end Magazyn;

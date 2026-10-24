with Typy; use Typy;

package Magazyn is

   task Sejf is
      entry Przyjmij (Rodzaj : Towar; Ilosc : Positive);
      entry Sprawdz (Towary : out Stany_Towarow; Wyslane : out Natural);
      entry Zakoncz;
   end Sejf;

end Magazyn;

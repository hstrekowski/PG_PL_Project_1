with Typy; use Typy;

package Stanowisko is

   task Rampa is
      entry Zglos (P : Partia);
      entry Pobierz (P : out Partia);
      entry Stan (Na_Rampie : out Natural; Rozladowane : out Natural);
      entry Zakoncz;
   end Rampa;

end Stanowisko;

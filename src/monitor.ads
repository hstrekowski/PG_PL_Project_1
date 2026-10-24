with Typy; use Typy;

package Monitor is

   task Kontroler is
      entry Aktualizuj_Robota (Id : Robot_Id; Stan : Stan_Robota);
      entry Dostawa_Obsluzona;
      entry Zakoncz;
   end Kontroler;

end Monitor;

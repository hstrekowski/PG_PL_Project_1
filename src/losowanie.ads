with Ada.Numerics.Discrete_Random;

package Losowanie is

   subtype Zakres is Integer range 0 .. 9999;
   package Los is new Ada.Numerics.Discrete_Random (Zakres);

   subtype Generator is Los.Generator;

   procedure Inicjuj (G : in out Generator; Numer : Natural);

   function Liczba (G : Generator; Min, Max : Integer) return Integer;
   function Czas (G : Generator; Min, Max : Duration) return Duration;
   function Szansa (G : Generator; Procent : Natural) return Boolean;

end Losowanie;

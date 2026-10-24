package body Losowanie is

   procedure Inicjuj (G : in out Generator; Numer : Natural) is
   begin
      Los.Reset (G);
      Los.Reset (G, Los.Random (G) + Numer);
   end Inicjuj;

   function Liczba (G : Generator; Min, Max : Integer) return Integer is
   begin
      return Min + Los.Random (G) mod (Max - Min + 1);
   end Liczba;

   function Czas (G : Generator; Min, Max : Duration) return Duration is
      Dziesiate : Integer;
   begin
      Dziesiate := Liczba (G, Integer (Min * 10), Integer (Max * 10));
      return Duration (Dziesiate) / 10;
   end Czas;

   function Szansa (G : Generator; Procent : Natural) return Boolean is
   begin
      return Liczba (G, 1, 100) <= Procent;
   end Szansa;

end Losowanie;

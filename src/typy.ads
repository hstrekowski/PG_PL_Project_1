package Typy is

   type Towar is (Zegarki, Pierscionki, Naszyjniki);

   type Stany_Towarow is array (Towar) of Natural;

   type Partia is record
      Id     : Natural := 0;
      Rodzaj : Towar   := Zegarki;
      Ilosc  : Natural := 0;
   end record;

   type Stan_Robota is (Wolny, Transport, Awaria, Wylaczony);

   Liczba_Robotow  : constant := 2;
   Liczba_Konwojow : constant := 5;
   Kursy_Konwoju   : constant := 2;
   Liczba_Dostaw   : constant := Liczba_Konwojow * Kursy_Konwoju;

   Pojemnosc_Sejfu : constant := 40;
   Min_Partia      : constant := 5;
   Max_Partia      : constant := 12;
   Rozmiar_Rampy   : constant := 2;

   Szansa_Awarii   : constant := 35;
   Limit_Naprawy   : constant Duration := 3.0;

   subtype Robot_Id is Positive range 1 .. Liczba_Robotow;
   subtype Konwoj_Id is Positive range 1 .. Liczba_Konwojow;

   function Img (N : Integer) return String;

   function Nazwa (T : Towar) return String;
   function Nazwa (S : Stan_Robota) return String;

end Typy;

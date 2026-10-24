package body Typy is

   function Img (N : Integer) return String is
      S : constant String := Integer'Image (N);
   begin
      if N >= 0 then
         return S (S'First + 1 .. S'Last);
      else
         return S;
      end if;
   end Img;

   function Nazwa (T : Towar) return String is
   begin
      case T is
         when Zegarki     => return "zegarki";
         when Pierscionki => return "pierscionki";
         when Naszyjniki  => return "naszyjniki";
      end case;
   end Nazwa;

   function Nazwa (S : Stan_Robota) return String is
   begin
      case S is
         when Wolny     => return "wolny";
         when Transport => return "transport";
         when Awaria    => return "AWARIA";
         when Wylaczony => return "wylaczony";
      end case;
   end Nazwa;

end Typy;

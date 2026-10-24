with Typy; use Typy;

package Konwoje is

   task type Konwoj_Type is
      entry Start (Numer : Konwoj_Id);
   end Konwoj_Type;

   Konwoj : array (Konwoj_Id) of Konwoj_Type;

end Konwoje;

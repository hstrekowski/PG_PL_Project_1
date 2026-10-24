with Log;
with Losowanie;

package body Serwis is

   task body Serwisant is
      G         : Losowanie.Generator;
      Pacjent   : Robot_Id;
      Bezczynny : Boolean := True;
      Diagnoza  : Duration;
      Wymiana   : Duration;
   begin
      Losowanie.Inicjuj (G, 300);

      loop
         select
            accept Zglos_Awarie (Id : Robot_Id) do
               Pacjent := Id;
            end Zglos_Awarie;
            Bezczynny := False;
            Log.Pisz ("Serwisant przyjal Robota R" & Img (Pacjent) & " do naprawy");

            Diagnoza := Losowanie.Czas (G, 0.5, 2.0);
            Wymiana  := Losowanie.Czas (G, 0.5, 3.0);

            select
               delay Limit_Naprawy;
               Log.Pisz ("Serwisant: naprawa R" & Img (Pacjent)
                         & " trwa za dlugo - wymienia caly modul napedowy");
               delay 1.0;
            then abort
               Log.Pisz ("Serwisant diagnozuje Robota R" & Img (Pacjent));
               delay Diagnoza;
               Log.Pisz ("Serwisant wymienia uszkodzona czesc w R" & Img (Pacjent));
               delay Wymiana;
            end select;

            Log.Pisz ("Serwisant zakonczyl naprawe Robota R" & Img (Pacjent));
            accept Odbierz_Robota;
         or
            accept Zakoncz do
               Log.Pisz ("Serwisant konczy zmiane");
            end Zakoncz;
            exit;
         else
            if not Bezczynny then
               Log.Pisz ("Serwisant: brak awarii, poleruje zegarki w pracowni");
               Bezczynny := True;
            end if;
            delay 0.5;
         end select;
      end loop;
   end Serwisant;

end Serwis;

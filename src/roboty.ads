with Typy; use Typy;

package Roboty is

   task type Robot_Type is
      entry Start (Numer : Robot_Id);
      entry Zakoncz;
   end Robot_Type;

   Robot : array (Robot_Id) of Robot_Type;

end Roboty;

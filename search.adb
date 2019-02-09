with Ada.Text_IO;         use Ada.Text_IO;
with Contact_Mgr;

package body search
with SPARK_Mode => On
is

   function Get_Index (option : in String; value : in String;
                       searchlen : in Natural; Count : in Natural)
                       return Integer
   with SPARK_Mode => On
   is
      Indx :  Integer := -1;
      Finished : Boolean := False;
      --  Get a local copy of Phonebook
      local_Book : constant Contact_Mgr.PhoneBook := Contact_Mgr.Book1;

   begin
      if (option = "Firstname") then
         for I in  1 .. Count loop
            pragma Assume (local_Book (I).LenFirstName < 16);
            Indx := -1;
            if (local_Book (I).FirstName (1 .. local_Book (I).LenFirstName)
                = value (value'First .. searchlen))
            then
               Indx := I;
               Finished := True;
            end if;
            exit when Finished;
            -- If the control reaches here, 'Finished' has to be false.
            pragma Assert (Finished = False);
         end loop;

      elsif (option = "Lastname") then
         for I in  1 .. Count loop
            pragma Assume (local_Book (I).LenLastName < 16);
            Indx := -1;
            if (local_Book (I).LastName (1 .. local_Book (I).LenLastName)
                = value (value'First .. searchlen))
            then
               Indx := I;
               Finished := True;
            end if;
            exit when Finished;
            pragma Assert (Finished = False);
         end loop;

      else
            Indx := -1;
            Put_Line ("Invalid option");

      end if;
      --  pragma Assert (Idx <= Count);

      return Indx;
   end Get_Index;


end search;

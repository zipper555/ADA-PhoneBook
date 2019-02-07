with Contact_Mgr;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO;         use Ada.Text_IO;


package body search is
   --  Create a local copy of updated PhoneBook
   local_Book : constant Contact_Mgr.PhoneBook := Contact_Mgr.Book1;
   Count : Natural;

   procedure Search_Contact is
      SearchOption : Natural;
      SearchString : String (1 .. 15);
      Idx : Integer := -1;
      pragma Unreferenced (Idx);
      StrLen : Natural;
   begin
      Put_Line ("Enter your option");
      Put_Line ("1. Search by Firstname 2. Search by Lastname");
      Get (SearchOption);
      case SearchOption is
         when 1 =>
            Put_Line ("Enter Firstname");
            Skip_Line;
            declare
               Entered : constant String := Get_Line;
            begin
               Put_Line (Integer'Image (Entered'Length));
               StrLen := Entered'Length;
               SearchString (1 .. StrLen) := Entered;
            end;
            Idx := Get_Index ("Firstname", SearchString);

         when 2 =>
            Put_Line ("Enter Lastname");
            declare
               Entered : constant String := Get_Line;
            begin
               Put_Line (Integer'Image (Entered'Length));
               StrLen := Entered'Length;
               SearchString (1 .. StrLen) := Entered;
            end;
            Idx := Get_Index ("Lasttname", SearchString);

         when others =>
            Put_Line ("Invalid option");
      end case;
   end Search_Contact;

   function Get_Index (option : in String; value : in String)
                       return Integer is
      Idx :  Integer := -1;
      Finished           : Boolean := False;
   begin
      Contact_Mgr.ContactCountObj.Get (Count);
      Put_Line ("Option: " & option);
      Put_Line ("Value: " & value);
      if (option = "Firstname") then
         for I in  1 .. Count loop
            if (local_Book (I).FirstName = value) then
               Idx := I;
               Finished := True;
            end if;
            exit when Finished;
         end loop;

      elsif (option = "Lastname") then
            for I in  1 .. Count loop
               if (local_Book (I).LastName = value) then
                  Idx := I;
                  Finished := True;
               end if;
               exit when Finished;
            end loop;

      else
            Put_Line ("Invalid option");

      end if;
      --  Idx should be lesser than or equal to count
         return Idx;
   end Get_Index;


end search;

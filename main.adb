with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Contact_Mgr; use Contact_Mgr;


procedure Main is
   --  Main task for Phone Book App
   
   UserOption : Integer;
   
begin
   Put_Line ("------------------------");
   Put_Line ("       Welcome          ");
   Put_Line ("-------------------------");
   loop
      New_Line;
      Put_Line ("Enter your choice no.");
      Put_Line ("1. Add  2.Delete  3.Search  4.TimeStats  5.Display  0.Quit");
      Get (UserOption);
      case UserOption is
      when 1 =>
         --  Add Contact
         Add_Contact;
      when 2 =>
         --  Delete Contact
         Delete_Contact;
      when 3 =>
         --  Search Contact
         Search_Contact;
      when 4 =>
         --  Get time stats.
         Get_Time_Stats;
      when 5 =>
         --  Display Phonebook
         Display_PhoneBook;
      when 0 =>
         --  Quitting
         Put_Line ("Bye!");
         exit;            
      when others =>
         Put_Line ("Invalid choice. Try Again");
      end case;
      
   end loop;
   
end Main;

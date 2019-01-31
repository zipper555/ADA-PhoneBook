with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Contact_Mgr is
   
   StrLen : Natural;
   --To document the length of strings entered.
   Book1 : PhoneBook;
   
   --Procedure to Add contact
   procedure Add_Contact is
   begin
      Put_Line ("Adding New Contact..");
      
      -- Read First Name
      Put_Line ("Enter First Name 15char max");
      Skip_Line;
      declare
         Entered : String := Get_Line;
       begin
         Put_Line (Integer'Image(Entered'Length));
         StrLen := Entered'Length; 
         Book1(1).FirstName(1 .. StrLen) := Entered ;
         Book1(1).LenFirstName := StrLen;
      end;
      
      --Read Last Name
      Put_Line ("Enter Last Name 15 char max");
      --Skip_Line;
      declare
         Entered : String := Get_Line;
       begin
         Put_Line (Integer'Image(Entered'Length));
         StrLen := Entered'Length;
         Book1(1).LastName(1 .. StrLen) := Entered ;
         Book1(1).LenLastName := StrLen;
      end;
      
      --Read Phone Number
      Put_Line ("Enter Phone Number 15 char max");
      --Skip_Line;
      declare
         Entered : String := Get_Line;
       begin
         Put_Line (Integer'Image(Entered'Length));
         StrLen := Entered'Length;
         Book1(1).PhoneNo(1 .. StrLen) := Entered ;
         Book1(1).LenPhoneNo := StrLen;
      end;
      
      -- Fix me: Update Global Contact count
      Put_Line ("Contact Added at entry 1");
      Put_Line(Book1(1).FirstName(1.. Book1(1).LenFirstName)
               & " " & Book1(1).LastName(1.. Book1(1).LenLastName)
                 & " | " & Book1(1).PhoneNo(1.. Book1(1).LenPhoneNo));      
      
    
   end Add_Contact;
                 
                      

end Contact_Mgr;

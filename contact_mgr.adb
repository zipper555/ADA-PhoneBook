with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Contact_Mgr is
   
   StrLen : Natural;
   --To document the length of strings entered.
   Book1 : PhoneBook;
   
   --Body of Protected Object for contact count
   
   protected body ContactCountObj is
      procedure Incr is
      begin
         Is_Ready := False;
         ContactCount := ContactCount + 1;
         Is_Ready := True;
      end Incr;
      
      procedure Decr is
      begin
         Is_Ready := False;
         ContactCount := ContactCount - 1;
         Is_Ready := True;
      end Decr;
      
      entry Get (V : out Natural)
        when Is_Ready is
      begin
         V := ContactCount;
      end Get;
   end ContactCountObj;
   
   
   
   
   --Procedure to Add contact
   procedure Add_Contact is
      Count : Natural;
      Index : Natural;
   begin
      ContactCountObj.Get(Count);
      if (Count = 10) then
         Put_Line("Phone book full. Delete some comtacts");
      
      else 
         Put_Line ("Adding New Contact..");
         Index := Count + 1;
      
         -- Read First Name
         Put_Line ("Enter First Name 15 char max");
         Skip_Line;
         declare
            Entered : String := Get_Line;
         begin
            Put_Line (Integer'Image(Entered'Length));
            StrLen := Entered'Length; 
            Book1(Index).FirstName(1 .. StrLen) := Entered ;
            Book1(Index).LenFirstName := StrLen;
         end;
      
         --Read Last Name
         Put_Line ("Enter Last Name 15 char max");
         --Skip_Line;
         declare
            Entered : String := Get_Line;
         begin
            Put_Line (Integer'Image(Entered'Length));
            StrLen := Entered'Length;
            Book1(Index).LastName(1 .. StrLen) := Entered ;
            Book1(Index).LenLastName := StrLen;
         end;
      
         --Read Phone Number
         Put_Line ("Enter Phone Number 15 char max");
         --Skip_Line;
         declare
            Entered : String := Get_Line;
         begin
            Put_Line (Integer'Image(Entered'Length));
            StrLen := Entered'Length;
            Book1(Index).PhoneNo(1 .. StrLen) := Entered ;
            Book1(Index).LenPhoneNo := StrLen;
         end;
      
         -- Fix me: Update Global Contact count
         Put_Line ("Contact Added at entry " & Natural'Image(Index));
         Put_Line(Book1(Index).FirstName(1.. Book1(Index).LenFirstName)
                  & " " & Book1(Index).LastName(1.. Book1(Index).LenLastName)
                  & " | " & Book1(Index).PhoneNo(1.. Book1(Index).LenPhoneNo));
      
         --Incrementing Contact Count
         ContactCountObj.Incr;
      end if;
      
    
   end Add_Contact;
                 
                      

end Contact_Mgr;

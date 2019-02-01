with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Real_Time; use Ada.Real_Time;
with time_mgr; use time_mgr;

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
         
          --Updating LastModified Statistics
         Update_Modified_Time.Go;
         --Incrementing Contact Count
         ContactCountObj.Incr;
      end if;      
    
   end Add_Contact;
             
   -- Procedure to delete contact
   procedure Delete_Contact is
      Entered : Natural;
      Count : Natural;
      Index : Natural;
   begin
      Put_Line("Displaying the Contact list");
      
      -- Fix me: Hook the display function here
      
      Put_Line("Enter the Contact no. to delete");
      -- Contact no. is the index of the contact in the array of contacts
      
      Get(Entered);
      ContactCountObj.Get(Count);
      if (Entered > Count or Entered = 0) then
         Put_Line ("Enter a valid no. ");
      else
         -- Reset the array so that deleted item is removed
         Index := Entered;
         for i in  Entered .. Count - 1 loop    
            Book1(Index) := Book1(Index + 1);
            Index := Index + 1;
         end loop;
         
         --Updating LastModified Statistics
         Update_Modified_Time.Go;
         -- Decrementing Contact count
         ContactCountObj.Decr;
         
      end if;
      
   end Delete_Contact;
 
   
   -- Procedure to get Time statistics
   procedure Get_Time_Stats is 
      Now_Time : Time := Clock;
      FromModified : Time_Span;
      FromStart : Time_Span;    
   begin
      FromModified := Now_Time - Get_Last_Modified_Time;
      FromStart := Now_Time - Get_Start_Time;
      Put_Line("----------------------------------------------------");
      Put_Line("Time from start: " & Duration'Image(To_Duration(FromStart)) 
               & " seconds");
      Put_Line("Time since last modification: " & Duration'Image(To_Duration(FromModified)) 
               & " seconds");
      Put_Line("----------------------------------------------------");
   end Get_Time_Stats;
   

end Contact_Mgr;

with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with time_mgr; use time_mgr;
with search;

package body Contact_Mgr is

   StrLen : Natural;
   --  To document the length of strings entered.


   --  Body of Protected Object for contact count

   protected body ContactCountObj is
      procedure Incr is
      begin
         Is_Ready := False;
         --  ContactCount := ContactCount + 1;
         Count_Ptr.all := Count_Ptr.all + 1;
         Is_Ready := True;
      end Incr;

      procedure Decr is
      begin
         Is_Ready := False;
         --  ContactCount := ContactCount - 1;
         Count_Ptr.all := Count_Ptr.all - 1;
         Is_Ready := True;
      end Decr;

      entry Get (V : out Natural)
        when Is_Ready is
      begin
         --  V := ContactCount;
         V := Count_Ptr.all;
      end Get;
   end ContactCountObj;

   --  Generics for checking if Phonebook is full.
   generic
   function Limit_Check (a, b : in Natural) return Boolean;

   function Limit_Check (a, b : in Natural) return Boolean is
   begin
      if ((a = b) or (a > b)) then
         return True;
      else
         return False;
      end if;
   end Limit_Check;

   function Contact_Book_Full is new Limit_Check;

   --  Procedure to Add contact
   procedure Add_Contact is
      Count : Natural;
      Index : Natural;
   begin
      ContactCountObj.Get (Count);
      if (Contact_Book_Full (Count, MAX_NO_CONTACTS)) then
         Put_Line ("Phone book full. Delete some contacts");

      else
         Put_Line ("Adding New Contact..");
         Index := Count + 1;

         --  Read First Name
         Put_Line ("Enter First Name (max 15 char)");
         Skip_Line;
         declare
            Entered : constant String := Get_Line;
         begin
            StrLen := Entered'Length;
            Book1 (Index).FirstName (1 .. StrLen) := Entered;
            Book1 (Index).LenFirstName := StrLen;
         end;

         --  Read Last Name
         Put_Line ("Enter Last Name (max 15 char)");
         --  Skip_Line;
         declare
            Entered : constant String := Get_Line;
         begin
            StrLen := Entered'Length;
            Book1 (Index).LastName (1 .. StrLen) := Entered;
            Book1 (Index).LenLastName := StrLen;
         end;

         --  Read Phone Number
         Put_Line ("Enter Phone Number (max 15 char)");
         --  Skip_Line;
         declare
            Entered : constant String := Get_Line;
         begin
            StrLen := Entered'Length;
            Book1 (Index).PhoneNo (1 .. StrLen) := Entered;
            Book1 (Index).LenPhoneNo := StrLen;
         end;

         Put_Line ("Contact Added at entry " & Natural'Image (Index));
         Put_Line (Book1 (Index).FirstName (1 .. Book1 (Index).LenFirstName)
                   & " "
                   & Book1 (Index).LastName (1 .. Book1 (Index).LenLastName)
                   & " | "
                   & Book1 (Index).PhoneNo (1 .. Book1 (Index).LenPhoneNo));

         --  Updating LastModified Statistics
         Update_Modified_Time.Go;
         --  Incrementing Contact Count
         ContactCountObj.Incr;
      end if;

   end Add_Contact;

   --  Procedure to delete contact
   procedure Delete_Contact is
      Entered : Natural;
      Count : Natural;
      Index : Natural;
   begin
      New_Line;
      Put_Line ("Displaying the Contact list...");
      Display_PhoneBook;

      Put_Line ("Enter the Contact Entry to delete");
      --  Contact no. is the index of the contact in the array of contacts
      Get (Entered);
      ContactCountObj.Get (Count);
      if (Entered > Count or Entered = 0) then
         Put_Line ("Enter a valid no. ");
      else
         --  Reset the array so that deleted item is removed
         Index := Entered;
         for i in  Entered .. Count - 1 loop
            Book1 (Index) := Book1 (Index + 1);
            Index := Index + 1;
         end loop;

         --  Updating LastModified Statistics
         Update_Modified_Time.Go;
         --  Decrementing Contact count
         ContactCountObj.Decr;
         Put_Line ("Entry Deleted: " & Natural'Image (Entered));

      end if;

   end Delete_Contact;


   --  Procedure to get Time statistics
   procedure Get_Time_Stats is
      Now_Time : constant Time := Clock;
      FromModified : Time_Span;
      FromStart : Time_Span;
   begin
      FromModified := Now_Time - Get_Last_Modified_Time;
      FromStart := Now_Time - Get_Start_Time;
      Put_Line ("----------------------------------------------------");
      Put_Line ("Time from start: " & Duration'Image (To_Duration (FromStart))
               & " seconds");
      Put_Line ("Time since last modification: "
                & Duration'Image (To_Duration (FromModified))
                & " seconds");
      Put_Line ("----------------------------------------------------");
   end Get_Time_Stats;

   --  Procedure to Display PhoneBook
   procedure Display_PhoneBook is
      Count : Natural;
   begin
      Put_Line ("Displaying Phonebook...");
      Put_Line ("------------------------------------------------- ");
      Put_Line ("Entry |  Firstname   |   Lastname  |   Phone No.");
      Put_Line ("-------------------------------------------------  ");

      ContactCountObj.Get (Count);
      for I in 1 .. Count loop
         Put_Line (" " & Integer'Image (I) & "  |  "
                  & Book1 (I).FirstName (1 .. Book1 (I).LenFirstName) & "  |  "
                  & Book1 (I).LastName (1 .. Book1 (I).LenLastName) & "  |  "
                  & Book1 (I).PhoneNo (1 .. Book1 (I).LenPhoneNo));
      end loop;
   end Display_PhoneBook;


   --  Procedure to search a contact in the Phonbook
   procedure Search_Contact is
      SearchOption : Natural;
      SearchString : String (1 .. 15);
      Idx : Integer := -1;
      StrLen : Natural;
      Count : Natural;
      Searchcopy : PhoneBook;
   begin
      ContactCountObj.Get (Count);
      if (Count = 0) then
         Put_Line ("Phone book empty!");
         return;
      end if;
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
               StrLen := Entered'Length;
               SearchString (1 .. StrLen) := Entered;
            end;
            search.Load_LocalBook (Searchcopy);
            Idx := search.Get_Index ("Firstname", SearchString, StrLen, Count,
                                    Searchcopy);
            if (Idx = -1) then
               Put_Line ("Contact not found :(");
            else
               Put_Line ("Found at " & Integer'Image (Idx) & "!");
               Put_Line (Book1 (Idx).FirstName (1 .. Book1 (Idx).LenFirstName)
                         & "  |  "
                         & Book1 (Idx).LastName (1 .. Book1 (Idx).LenLastName)
                         & "  |  "
                         & Book1 (Idx).PhoneNo (1 .. Book1 (Idx).LenPhoneNo));
            end if;

         when 2 =>
            Put_Line ("Enter Lastname");
            Skip_Line;
            declare
               Entered : constant String := Get_Line;
            begin
               StrLen := Entered'Length;
               SearchString (1 .. StrLen) := Entered;
            end;
            search.Load_LocalBook (Searchcopy);
            Idx := search.Get_Index ("Lastname", SearchString, StrLen, Count,
                                    Searchcopy);
            if (Idx = -1) then
               Put_Line ("Contact not found :(");
            else
               Put_Line ("Found at " & Integer'Image (Idx) & "!");
               Put_Line (Book1 (Idx).FirstName (1 .. Book1 (Idx).LenFirstName)
                         & "  |  "
                         & Book1 (Idx).LastName (1 .. Book1 (Idx).LenLastName)
                         & "  |  "
                         & Book1 (Idx).PhoneNo (1 .. Book1 (Idx).LenPhoneNo));
            end if;

         when others =>
            Put_Line ("Invalid option");
      end case;
   end Search_Contact;


end Contact_Mgr;

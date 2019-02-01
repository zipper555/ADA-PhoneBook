package Contact_Mgr is

   type Contact is record
      FirstName : String (1 .. 15);
      LastName : String (1 .. 15);
      PhoneNo : String (1 .. 15);
      LenFirstName : Natural;
      LenLastName : Natural;
      LenPhoneNo : Natural;
   end record;
   
   type PhoneBook is array (1..10) of Contact;
   -- Have declared it here so that it is visible from outside
   
   -- Protected Object for contact count
   protected ContactCountObj is
      procedure Incr;
      procedure Decr;
      entry Get (V : out Natural);
      private
       ContactCount  : Natural := 0;
       Is_Ready : Boolean := True;
   end ContactCountObj;
   
   procedure Add_Contact;
   --procedure Delete_Contact;
   --procedure Search_Contact;
   --procedure Sort_PhoneBook;
   --procedure Display_PhoneBook;

end Contact_Mgr;

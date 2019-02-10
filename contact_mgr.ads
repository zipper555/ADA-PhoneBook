package Contact_Mgr is

   MAX_NO_CONTACTS : constant Integer := 10;

   type Contact is record
      FirstName : String (1 .. 15);
      LastName : String (1 .. 15);
      PhoneNo : String (1 .. 15);
      LenFirstName : Natural;
      LenLastName : Natural;
      LenPhoneNo : Natural;
   end record;

   type PhoneBook is array (1 .. MAX_NO_CONTACTS) of Contact;
   Book1 : PhoneBook;
   --  Have declared it here so that it is visible from outside

   --  Protected Object for contact count
   protected ContactCountObj is
      procedure Incr;
      procedure Decr;
      entry Get (V : out Natural);
   private
       Count_Ptr : access Natural := new Natural'(0);
       -- ContactCount  : Natural;
       Is_Ready : Boolean := True;
   end ContactCountObj;


   procedure Add_Contact;
   procedure Delete_Contact;
   procedure Search_Contact;
   procedure Get_Time_Stats;
   procedure Display_PhoneBook;

end Contact_Mgr;

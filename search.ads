with Contact_Mgr;

package search
with SPARK_Mode => On
is
   Book_global : Contact_Mgr.PhoneBook;

   function Get_Index (option : in String; value : in String;
                       searchlen : in Natural; Count : in Natural;
                       Searchcopy : Contact_Mgr.PhoneBook)
                        return Integer
     with
     Depends => (Get_Index'Result => (option, value, searchlen, Count,
                                        Searchcopy)),
     Pre => Count < 11 and Count > 0 and
     value'First = 1 and value'Last >= searchlen
     and searchlen > 0 and searchlen < 16,
     Post => Get_Index'Result <= Count;


   --  option: Search by Firstname or Lastname
   --  value:  String entered by user for searching
   --  searchlen: Length of the entered string to search.
   --  Count: Total Number of entries in the phone book.


   --  Pre conditions
   --       Count is always within max entries in the phone book.
   --       searchlen should be within the max allowed characters in the
   --          phone book entry, i.e., 15.

   --  Post condition
   --       The searched Index is within the total entries currently present
   --          in the phone book. It will be -1 for a failed search.

   procedure Load_LocalBook (local_Book_func : out Contact_Mgr.PhoneBook)
     with
       Global => (Output => Book_global,
                  Input => Contact_Mgr.Book1);


end search;

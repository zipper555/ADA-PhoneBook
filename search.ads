package search
with SPARK_Mode => On
is
   function Get_Index (option : in String; value : in String;
                       searchlen : in Natural; Count : in Natural)
                       return Integer
     with

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

end search;

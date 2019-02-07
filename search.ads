package search
with SPARK_Mode => On
is
   procedure Search_Contact;
   function Get_Index (option : in String; value : in String) return Integer;

end search;

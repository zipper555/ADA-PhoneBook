with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO;         use Ada.Text_IO;

package body time_mgr is

    --Task to update time stats
   --Task is chosen for this purpose so that time updation is accurate
   -- irrespective of other operations.
   task body Update_Modified_Time is
   begin
      loop 
         select 
            accept Go do
            LastModified := Clock;
            Put_Line("Last Modified updated");
            end Go;
         or
            terminate;
         end select;    
      end loop;   
   end Update_Modified_Time;

   function Get_Start_Time return Time is
   begin
      return StartTime;
   end Get_Start_Time;
 
   function Get_Last_Modified_Time return Time is
   begin
      return LastModified;
   end Get_Last_Modified_Time;
   
       
end time_mgr;

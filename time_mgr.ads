with Ada.Real_Time; use Ada.Real_Time;

package time_mgr is

   --Time statistics
   StartTime : Time := Clock;
   LastModified : Time;
   
   task Update_Modified_Time is
      entry Go;
   end Update_Modified_Time;
   
   function Get_Start_Time return Time;
   
   function Get_Last_Modified_Time return Time;
end time_mgr;

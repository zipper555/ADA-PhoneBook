package body time_mgr is

   --  Time statistics
   StartTime : constant Time := Clock;
   LastModified : Time := Clock;

   --  Task to update time stats
   --  Task is chosen for this purpose so that time updation is accurate
   --  irrespective of other operations.
   task body Update_Modified_Time is
   begin
      loop
         select
            accept Go do
               LastModified := Clock;
               --  Put_Line ("Last Modified updated");
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

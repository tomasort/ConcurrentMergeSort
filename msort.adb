-- NYU
-- Programming Languages Assignment 1 
-- Name: Tomas Ortega Rojas
-- NYU_ID: 15503623

with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

package body Msort is

    procedure Sort(A: in out int_array) is

        procedure Mergesort(lo: Integer; hi: Integer) is
            -- Declare variables for mergesort algorithm
            mid: Integer := lo + (hi - lo) / 2;
            start : Integer := lo;
            start2: Integer := mid + 1;
            temp: Integer;
            index : Integer;


            -- Task to sort the left half of the array concurrently
            task Sort_Helper is
                entry Sort_half; -- Entry to start running the sort algorithm on the left half
                entry Done; -- Entry to wait for the other half of the array to be sorted
            end Sort_Helper;

            task body Sort_Helper is 
            begin

                select
                    accept Sort_Half; -- Wait until the base case is checked
                    Mergesort(lo, mid);
                    accept Done;
                or
                    terminate; -- If we run into a base case then terminate the task
                end select;

            end Sort_Helper;
        begin 
            -- Check for the base case
            if lo < hi then

                -- Recursively sort the two halves of the array
                Sort_Helper.Sort_Half; -- Start the task on the left subarray
                Mergesort(mid + 1, hi);
                Sort_helper.Done; -- Wait for the task to finish to start the merging 


                -- Merge the two subarrays  
                if A(mid) <= A(start2) then 
                    return;
                end if;
                while start <= mid and start2 <= hi loop
                    if A(start) <= A(start2) then
                        start := start + 1;
                    else
                        temp := A(start2);
                        index := start2;
                        while index /= start loop
                            A(index) := A(index - 1);
                            index := index - 1;
                        end loop;
                        A(start) := temp;
                        start := start + 1;
                        mid := mid + 1;
                        start2 := start2 + 1;
                    end if;
                end loop;

            end if;
        end Mergesort;

    begin
        --Call the mergesort procedure on A
        Mergesort(1, LENGTH);
    end sort;
end msort;

-- NYU
-- Programming Languages Assignment 1 
-- Name: Tomas Ortega Rojas
-- NYU_ID: 15503623

with ada.text_io, ada.integer_text_io, msort;
use ada.text_io, ada.integer_text_io, msort;

procedure Main is
    x: int_array; -- Declaration of array of our type
    sum: Integer := 0; 

    -- Task for reading
    task Read is         
        entry done;
    end Read;

    task body Read is
    begin
        -- We need to read the elements from standard input before we do anything else
        for iter in 1 .. LENGTH loop
            Get(x(iter)); -- Read the value from standard input and put it in the array
        end loop;
        accept done;
    end Read;


    -- Task for adding values
    task Add_Values is
        entry start_adding;
        entry done;
    end Add_Values;

    task body Add_Values is
    begin
        accept start_adding; -- Wait until we are ready to add the values
        for iter in 1 .. LENGTH loop
            sum := sum + x(iter);
        end loop;
        accept done;
    end Add_Values;


    -- Task for printing values 
    task Print_Values is
        entry start_printing;
    end Print_Values;

    task body Print_Values is
    begin
        accept start_printing; -- Wait until we are ready to print the sorted array
        for iter in 1 .. LENGTH loop
            Put(Integer'Image(x(iter)) & " ");
        end loop;
        New_Line;
        Add_Values.done; -- wait until the sum is ready to be printed
        Put("Sum: " & Integer'Image(sum)); -- Print the sum of the values
        New_Line;
    end Print_Values;

begin
    read.done; -- Wait until the values in the array are valid 

    -- Sort the values
    msort.sort(x);

    -- Print and Add the values concurrently
    add_values.start_adding;
    print_values.start_printing;

end main;


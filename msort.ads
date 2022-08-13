-- NYU
-- Programming Languages Assignment 1 
-- Name: Tomas Ortega Rojas
-- NYU_ID: 15503623


-- Specification for Merge Sort algorithm
package Msort is 
    -- Length of the array to be sorted
    LENGTH: Integer := 40;

    -- Create a new type to store integers between -300 and 300
    subtype int is Integer range -300 .. 300;
    type int_array is array (1 .. LENGTH) of int;

    -- Declare a sort procedure that takes an array of our type
    procedure Sort(A: in out int_array);
end Msort;

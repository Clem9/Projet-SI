--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:11:02 04/16/2021
-- Design Name:   
-- Module Name:   /home/benazzou/processeur/test_pipeline.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pipeline
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_pipeline IS
END test_pipeline;
 
ARCHITECTURE behavior OF test_pipeline IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pipeline
    PORT(
         A_IN : IN  std_logic;
         B_IN : IN  std_logic;
         C_IN : IN  std_logic;
         OP_IN : IN  std_logic;
         CLK : IN  std_logic;
         A_OUT : OUT  std_logic;
         B_OUT : OUT  std_logic;
         C_OUT : OUT  std_logic;
         OP_OUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A_IN : std_logic := '0';
   signal B_IN : std_logic := '0';
   signal C_IN : std_logic := '0';
   signal OP_IN : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal A_OUT : std_logic;
   signal B_OUT : std_logic;
   signal C_OUT : std_logic;
   signal OP_OUT : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pipeline PORT MAP (
          A_IN => A_IN,
          B_IN => B_IN,
          C_IN => C_IN,
          OP_IN => OP_IN,
          CLK => CLK,
          A_OUT => A_OUT,
          B_OUT => B_OUT,
          C_OUT => C_OUT,
          OP_OUT => OP_OUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- VERIFIER QUE LES ENTRÉES SONT PASSÉES AUX SORTIES SUR LES FRONTS MONTANTS
		
		--  Tentative
				--OP_IN <= '0' after 100 ns;
				--A_IN <= '0' after 100 ns;
				--B_IN <= '0' after 100 ns;
				--C_IN <= '0' after 100 ns;

      wait;
   end process;

END;

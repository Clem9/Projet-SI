--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:05:51 04/13/2021
-- Design Name:   
-- Module Name:   /home/benazzou/processeur/test_banc_registre.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: banc_registre
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
 
ENTITY test_banc_registre IS
END test_banc_registre;
 
ARCHITECTURE behavior OF test_banc_registre IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT banc_registre
    PORT(
         addr_A : IN  std_logic_vector(3 downto 0);
         addr_B : IN  std_logic_vector(3 downto 0);
         addr_W : IN  std_logic_vector(3 downto 0);
         W : IN  std_logic;
         DATA : IN  std_logic_vector(7 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic;
         QA : OUT  std_logic_vector(7 downto 0);
         QB : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal addr_A : std_logic_vector(3 downto 0) := (others => '0');
   signal addr_B : std_logic_vector(3 downto 0) := (others => '0');
   signal addr_W : std_logic_vector(3 downto 0) := (others => '0');
   signal W : std_logic := '0';
   signal DATA : std_logic_vector(7 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal QA : std_logic_vector(7 downto 0);
   signal QB : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: banc_registre PORT MAP (
          addr_A => addr_A,
          addr_B => addr_B,
          addr_W => addr_W,
          W => W,
          DATA => DATA,
          RST => RST,
          CLK => CLK,
          QA => QA,
          QB => QB
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

      wait for CLK_period*10;

      -- insert stimulus here 
		RST <= '1';
		wait for CLK_period*2;
		 
		W <= '1';
		 
		wait for CLK_period*2;
		
		addr_W <= "1001";
		DATA <= "10011000";
		
		wait for CLK_period*2;
		
		addr_W <= "0100";
		DATA <= "00000011";
		
		wait for CLK_period*2;
		
		W <= '0';
		
		addr_A <= "0111";
		addr_B <= "0001";
		
	
		wait for CLK_period*2;			

      wait;
   end process;

END;

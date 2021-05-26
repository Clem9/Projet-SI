----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:18:38 04/13/2021 
-- Design Name: 
-- Module Name:    alu - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in  STD_LOGIC_VECTOR (2 downto 1);
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           N : out  STD_LOGIC;
           O : out  STD_LOGIC;
           Z : out  STD_LOGIC;
           C : out  STD_LOGIC);
			  
end alu;

architecture Behavioral of alu is
	signal A9: STD_LOGIC_VECTOR (8 downto 0);
	signal B9 : STD_LOGIC_VECTOR (8 downto 0);
	signal ADD :STD_LOGIC_VECTOR (8 downto 0);
	signal SUB :STD_LOGIC_VECTOR (8 downto 0);
	signal MUL : STD_LOGIC_VECTOR (15 downto 0);

begin

	A9 <= '0' & A;
	B9 <= '0' & B;
	ADD <= A9 + B9;
	SUB <= A9 - B9;
	MUL <= A * B;
	S <= ADD(7 downto 0) when  Ctrl_Alu="01" else
		SUB(7 downto 0) when Ctrl_Alu="11" else
		MUL (7 downto 0) when Ctrl_Alu="10" else
		"00000000";
--	constant ADD   : STD_LOGIC_VECTOR(7 downto 0):="00000001";
--	constant MUL   : STD_LOGIC_VECTOR(7 downto 0):="00000010";
--	constant SOU   : STD_LOGIC_VECTOR(7 downto 0):="00000011";
	
-- Overflow ?

	O <= '1' when MUL(15 downto 8) /= "00" else '0';
	

end Behavioral;


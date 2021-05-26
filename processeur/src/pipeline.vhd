----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:03:49 04/16/2021 
-- Design Name: 
-- Module Name:    pipeline - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pipeline is
    Port ( A_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           B_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           C_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
			  CLK : in STD_LOGIC;
           A_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           C_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           OP_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end pipeline;

architecture Behavioral of pipeline is

begin

	process
	begin
		wait until CLK 'event and CLK='1';
		A_OUT <= A_IN;
		B_OUT <= B_IN;
		C_OUT <= C_IN;
		OP_OUT <= OP_IN;
	
	end process;

end Behavioral;


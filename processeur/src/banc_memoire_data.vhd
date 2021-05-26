----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:27:20 04/16/2021 
-- Design Name: 
-- Module Name:    banc_memoire_data - Behavioral 
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

entity banc_memoire_data is
    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (7 downto 0));
end banc_memoire_data;

architecture Behavioral of banc_memoire_data is

	type arrayMemory is array (integer range<>) of STD_LOGIC_VECTOR (7 downto 0);
	signal datas : arrayMemory(0 to 7);

begin
	
	process
	begin
		wait until CLK 'event and CLK='1';
		-- Si le signal de reset est activé (à 0), on initialise le banc à 0x00.
		if RST = '0' then datas <= (others => "00000000");
		-- Lecture
		elsif RW='1' then Q <= datas(to_integer(unsigned(addr)));
		-- Ecriture
		elsif RW='0' then datas(to_integer(unsigned(addr))) <= DATA;
		end if;
	end process;



end Behavioral;


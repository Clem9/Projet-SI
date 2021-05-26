----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:50:57 04/13/2021 
-- Design Name: 
-- Module Name:    banc_registre - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity banc_registre is
    Port ( addr_A : in  STD_LOGIC_VECTOR (3 downto 0);
           addr_B : in  STD_LOGIC_VECTOR (3 downto 0);
           addr_W : in  STD_LOGIC_VECTOR (3 downto 0);
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
end banc_registre;

architecture Behavioral of banc_registre is

	type arrayRegister is array (integer range<>) of STD_LOGIC_VECTOR (7 downto 0);
	signal registers : arrayRegister(0 to 15) := (others => (others=>'0'));

begin
	-- Si pas écriture ou écriture dans un autre registre : on lit les valeurs.
	QA <= registers(to_integer(unsigned(addr_A))) when W='0' or addr_A /= addr_W else DATA;
	QB <= registers(to_integer(unsigned(addr_B))) when W='0' or addr_B /= addr_W else DATA;
	
	process
	begin
		wait until CLK 'event and CLK='1';
		-- Si le signal de reset est activé (à 0), on initialise le banc à 0x00.
		if RST = '0' then registers <= (others => "00000000");
		-- SI W est activé (à 1), l'écriture est activée, on copie les DATA sur le registre d'adrees addr_W
		elsif w='1' then registers(to_integer(unsigned(addr_W))) <= DATA;
		end if;
	end process;


end Behavioral;


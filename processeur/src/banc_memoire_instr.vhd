----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:42:45 04/16/2021 
-- Design Name: 
-- Module Name:    banc_memoire_instr - Behavioral 
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

entity banc_memoire_instr is
    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (31 downto 0));
end banc_memoire_instr;

architecture Behavioral of banc_memoire_instr is

	-- CONSTANTES
	constant NOP   : STD_LOGIC_VECTOR(7 downto 0):="00000000";
	constant ADD   : STD_LOGIC_VECTOR(7 downto 0):="00000001";
	constant MUL   : STD_LOGIC_VECTOR(7 downto 0):="00000010";
	constant SOU   : STD_LOGIC_VECTOR(7 downto 0):="00000011";
	constant DIV   : STD_LOGIC_VECTOR(7 downto 0):="00000100";
	constant COP   : STD_LOGIC_VECTOR(7 downto 0):="00000101";
	constant AFC   : STD_LOGIC_VECTOR(7 downto 0):="00000110";
	constant LOAD  : STD_LOGIC_VECTOR(7 downto 0):="00000111";
	constant STORE : STD_LOGIC_VECTOR(7 downto 0):="00001000";


	type arrayInstr is array (integer range<>) of STD_LOGIC_VECTOR (31 downto 0);
	signal instr : arrayInstr(0 to 255):= (
-- Num instructions - @Résultat - @Opérande1 -  @Opérande2
--		0 => AFC   & "00000001" & "00000011" & "00000000", -- R1 := 3
--		1 => AFC   & "00000010" & "00000010" & "00000000", -- R2 := 2
--		2 => COP   & "00000011" & "00000001" & "00000000", -- R3 := R1 (= 3)
--		3 => ADD   & "00000100" & "00000001" & "00000011", -- R4 := R1 + R3 (3+3 = 6)
--		4 => SOU   & "00000101" & "00000100" & "00000011", -- R5 := R4 - R2 (6-2 = 4)
--		5 => MUL   & "00000110" & "00000001" & "00000010", -- R6 := R1 * R2 (3*2 = 6)
--		6 => STORE & "00000111" & "00000101" & "00000000", -- store R5 (= 4) à l'adresse 7
--		7 => LOAD  & "00000000" & "00001000" & "00000000", -- load R7 (= 4) dans R0



		-- Un code sans aléas
		0 => AFC   & "00000001" & "00000011" & "00000000", -- R1 := 3
		1 => AFC   & "00000011" & "00000010" & "00000000", -- R3 := 2
   	--1 => COP   & "00000010" & "00000001" & "00000000", -- R2 := R1
		2 => NOP   & "00000000" & "00000000" & "00000000", 
		3 => NOP   & "00000000" & "00000000" & "00000000", 
		4 => NOP   & "00000000" & "00000000" & "00000000", 
		5 => NOP   & "00000000" & "00000000" & "00000000", 
		6 => NOP   & "00000000" & "00000000" & "00000000", 
		7 => MUL   & "00000100" & "00000001" & "00000011", -- R4 := R1 * R3 = 6
		8 => SOU   & "00000111" & "00000001" & "00000011", -- R7 := R1 - R3 =1
   	--9 => ADD   & "00000110" & "00000100" & "00000001", -- R6 := R4 / R1 
		9 => NOP   & "00000000" & "00000000" & "00000000", 
		10 => NOP   & "00000000" & "00000000" & "00000000", 
		11 => NOP   & "00000000" & "00000000" & "00000000", 
		12 => NOP   & "00000000" & "00000000" & "00000000", 
		13 => NOP   & "00000000" & "00000000" & "00000000", 
		14 => NOP   & "00000000" & "00000000" & "00000000", 
		15 => STORE & "00000011" & "00000100" & "00000000", -- store R4 (= 6) À l'adresse 3
	   16 => ADD  & "00000000" & "00000001" & "00000011", -- R0 := R1 + R3 =5
		17 => COP  & "00000100" & "00000001" & "00000000", -- R4 := R1 
		18 => LOAD  & "00000010" & "00000011" & "00000000", -- R2 := mémoire dans l'adresse 3 (=6)
					


		others => (others => '0'));
begin
	

	process
	begin
		wait until CLK 'event and CLK='1';
		-- Lecture en asynchrone
		Q <= instr(to_integer(unsigned(addr)));

	end process;


end Behavioral;




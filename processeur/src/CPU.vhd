----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:09:42 05/10/2021 
-- Design Name: 
-- Module Name:    CPU - Behavioral 
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

entity CPU is
	Port(
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
		SORTIE   : out STD_LOGIC_VECTOR(7 downto 0));

end CPU;

architecture Behavioral of CPU is
	
	-- ------------------CONSTANTES------------------------

	-- Instructions
	constant NOP   : STD_LOGIC_VECTOR(7 downto 0):="00000000"; --0
	constant ADD   : STD_LOGIC_VECTOR(7 downto 0):="00000001"; --1
	constant MUL   : STD_LOGIC_VECTOR(7 downto 0):="00000010"; --2
	constant SOU   : STD_LOGIC_VECTOR(7 downto 0):="00000011"; --3
	constant DIV   : STD_LOGIC_VECTOR(7 downto 0):="00000100"; --4
	constant COP   : STD_LOGIC_VECTOR(7 downto 0):="00000101"; --5
	constant AFC   : STD_LOGIC_VECTOR(7 downto 0):="00000110"; --6
	constant LOAD  : STD_LOGIC_VECTOR(7 downto 0):="00000111"; --7
	constant STORE : STD_LOGIC_VECTOR(7 downto 0):="00001000"; --8

	

	-- COMPOSANTS DE NOTRE CPU
	
	COMPONENT ALU
		PORT( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in  STD_LOGIC_VECTOR (2 downto 1);
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           N : out  STD_LOGIC;
           O : out  STD_LOGIC;
           Z : out  STD_LOGIC;
           C : out  STD_LOGIC
		);
	END COMPONENT;
		
	COMPONENT BANC_REGISTRE
		PORT(addr_A : in  STD_LOGIC_VECTOR (3 downto 0);
           addr_B : in  STD_LOGIC_VECTOR (3 downto 0);
           addr_W : in  STD_LOGIC_VECTOR (3 downto 0);
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;

	
	COMPONENT BANC_MEMOIRE_INSTR
		PORT(addr : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (31 downto 0)
		);
	END COMPONENT;
		
		
	COMPONENT BANC_MEMOIRE_DATA
		PORT(addr : in  STD_LOGIC_VECTOR (7 downto 0);
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;	
	
	
	COMPONENT PIPELINE
		PORT(A_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           B_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           C_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
			  CLK : in STD_LOGIC;
           A_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           C_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           OP_OUT : out  STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;	
		
	-- SIGNAUX POUR RELIER LES COMPOSANTS ENTRE EUX
	
	TYPE SIG_ALU IS RECORD
		A, B, S : STD_LOGIC_VECTOR(7 downto 0);
		Ctrl_Alu : STD_LOGIC_VECTOR (2 downto 1);
      N, O, Z, C : STD_LOGIC;
	END RECORD;
	SIGNAL sigalu : SIG_ALU;
	
	
	TYPE SIG_BANC_REGISTRE IS RECORD
		addr_A, addr_B, addr_W: STD_LOGIC_VECTOR (3 downto 0);
      W, RST: STD_LOGIC;
      DATA, QA, QB: STD_LOGIC_VECTOR (7 downto 0);
	END RECORD;
	SIGNAL sigbancregistres : SIG_BANC_REGISTRE;
	
	TYPE SIG_BANC_MEMOIRE_DATA IS RECORD
		addr, DATA, Q : STD_LOGIC_VECTOR (7 downto 0);
      RW, RST: STD_LOGIC;
	END RECORD;
	SIGNAL sigbancmemdata : SIG_BANC_MEMOIRE_DATA;
	
	TYPE SIG_BANC_MEMOIRE_INSTR IS RECORD
		addr : STD_LOGIC_VECTOR (7 downto 0);
      Q : STD_LOGIC_VECTOR (31 downto 0);
	END RECORD;
	SIGNAL sigbancmeminstr : SIG_BANC_MEMOIRE_INSTR;
	
	
	TYPE SIG_PIPELINE IS RECORD
		A_IN, B_IN, C_IN : STD_LOGIC_VECTOR (7 downto 0);
		A_OUT, B_OUT, C_OUT : STD_LOGIC_VECTOR (7 downto 0);
      OP_IN, OP_OUT : STD_LOGIC_VECTOR (7 downto 0);
	END RECORD;
	SIGNAL sigpipeline1 : SIG_PIPELINE;
	SIGNAL sigpipeline2 : SIG_PIPELINE;
	SIGNAL sigpipeline3 : SIG_PIPELINE;
	SIGNAL sigpipeline4 : SIG_PIPELINE;	

	-- SIGNAL D'INPUT
	SIGNAL IP : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
	
	
	--SIGNAUX POUR GÉRER LES ALÉAS
	SIGNAL alea : STD_LOGIC := '0';
	SIGNAL lidi_r_b : STD_LOGIC;
	SIGNAL lidi_r_c : STD_LOGIC;
	SIGNAL diex_w_a : STD_LOGIC;
	SIGNAL exmem_w_a : STD_LOGIC;
	


begin


	--ETAGE N°1
	
	memoire_instructions : BANC_MEMOIRE_INSTR PORT MAP(
		addr => sigbancmeminstr.addr,
      Q => sigbancmeminstr.Q,
		CLK => CLK
	);

	LIDI : PIPELINE PORT MAP(
		A_IN => sigpipeline1.A_IN,
		B_IN => sigpipeline1.B_IN,
		C_IN => sigpipeline1.C_IN,
		A_OUT => sigpipeline1.A_OUT,
		B_OUT => sigpipeline1.B_OUT,
		C_OUT => sigpipeline1.C_OUT,
      OP_IN => sigpipeline1.OP_IN,
		OP_OUT => sigpipeline1.OP_OUT,
		CLK => CLK
	);


	sigbancmeminstr.addr <= IP;

	sigpipeline1.OP_IN <= sigbancmeminstr.Q(31 DOWNTO 24);
	sigpipeline1.A_IN <= sigbancmeminstr.Q(23 DOWNTO 16);
	sigpipeline1.B_IN <= sigbancmeminstr.Q(15 DOWNTO 8);
	sigpipeline1.C_IN <= sigbancmeminstr.Q(7 DOWNTO 0);
	
	

	--ETAGE N°2
	
	DIEX : PIPELINE PORT MAP(
		A_IN => sigpipeline2.A_IN,
		B_IN => sigpipeline2.B_IN,
		C_IN => sigpipeline2.C_IN,
		A_OUT => sigpipeline2.A_OUT,
		B_OUT => sigpipeline2.B_OUT,
		C_OUT => sigpipeline2.C_OUT,
        OP_IN => sigpipeline2.OP_IN,
		OP_OUT => sigpipeline2.OP_OUT,
		CLK => CLK
	);
	
	registres : BANC_REGISTRE PORT MAP(
	  addr_A => sigbancregistres.addr_A,
      addr_B => sigbancregistres.addr_B,
      addr_W => sigbancregistres.addr_W,
      W => sigbancregistres.W,
      DATA => sigbancregistres.DATA,
      RST => sigbancregistres.RST,
      CLK => CLK,
      QA => sigbancregistres.QA,
      QB => sigbancregistres.QB
	);
	

	sigpipeline2.A_IN <= sigpipeline1.A_OUT;
	sigpipeline2.OP_IN <= sigpipeline1.OP_OUT;
	-- MUX 1 : On accède à QA quand on fait une opération qui a besoin de récup une valeur dans le registre
	sigpipeline2.B_IN <= sigbancregistres.QA WHEN (sigpipeline1.OP_OUT = ADD 
															  OR sigpipeline1.OP_OUT = MUL 
															  OR sigpipeline1.OP_OUT = SOU 
															  OR sigpipeline1.OP_OUT = DIV 
															  OR sigpipeline1.OP_OUT = COP
															  OR sigpipeline1.OP_OUT = STORE ) ELSE sigpipeline1.B_OUT;
	sigpipeline2.C_IN <= sigbancregistres.QB;
	
	sigbancregistres.addr_W <= sigpipeline4.A_OUT(3 DOWNTO 0);
	sigbancregistres.W <= '1' WHEN (sigpipeline4.OP_OUT = ADD OR
											  sigpipeline4.OP_OUT = MUL OR
											  sigpipeline4.OP_OUT = SOU OR
											  sigpipeline4.OP_OUT = DIV OR
											  sigpipeline4.OP_OUT = COP OR
											  sigpipeline4.OP_OUT = AFC OR
											  sigpipeline4.OP_OUT = LOAD) ELSE '0';
	sigbancregistres.DATA <= sigpipeline4.B_OUT;
	sigbancregistres.addr_A <= sigpipeline1.B_OUT(3 DOWNTO 0);
	sigbancregistres.addr_B <= sigpipeline1.C_OUT(3 DOWNTO 0);
	
	
	
	

	--ETAGE N°3
	
	EXMem : PIPELINE PORT MAP(
		A_IN => sigpipeline3.A_IN,
		B_IN => sigpipeline3.B_IN,
		C_IN => sigpipeline3.C_IN,
		A_OUT => sigpipeline3.A_OUT,
		B_OUT => sigpipeline3.B_OUT,
		C_OUT => sigpipeline3.C_OUT,
      OP_IN => sigpipeline3.OP_IN,
		OP_OUT => sigpipeline3.OP_OUT,
		CLK => CLK
	);
	
	ual : ALU PORT MAP(
		A => sigalu.A,
      B => sigalu.B,
      Ctrl_Alu => sigalu.Ctrl_Alu,
      S => sigalu.S,
      N => sigalu.N,
      O => sigalu.O,
      Z => sigalu.Z,
      C => sigalu.C
	);
	
	sigpipeline3.A_IN <= sigpipeline2.A_OUT;
	sigpipeline3.OP_IN <= sigpipeline2.OP_OUT;
	-- MUX 2 : RÉCUPÉRATION DU RÉSULTAT D'UN CALCUL DANS LA SORTIE DE L'ALU  
	sigpipeline3.B_IN <= sigalu.S WHEN (sigpipeline2.OP_OUT = ADD
												OR sigpipeline2.OP_OUT = MUL
												OR sigpipeline2.OP_OUT = SOU
												OR sigpipeline2.OP_OUT = DIV) ELSE sigpipeline2.B_OUT;



	sigalu.A <= sigpipeline2.B_OUT;
	sigalu.B <= sigpipeline2.C_OUT;
	sigalu.Ctrl_Alu <= sigpipeline2.OP_OUT(1 DOWNTO 0);
	
	
	

	
	--ETAGE N°4
			
	MemRE : PIPELINE PORT MAP(
		A_IN => sigpipeline4.A_IN,
		B_IN => sigpipeline4.B_IN,
		C_IN => sigpipeline4.C_IN,
		A_OUT => sigpipeline4.A_OUT,
		B_OUT => sigpipeline4.B_OUT,
		C_OUT => sigpipeline4.C_OUT,
        OP_IN => sigpipeline4.OP_IN,
		OP_OUT => sigpipeline4.OP_OUT,
		CLK => CLK
	);
	
	
	memoire_donnees : BANC_MEMOIRE_DATA PORT MAP(
	  addr => sigbancmemdata.addr,
      DATA => sigbancmemdata.DATA,
      RW => sigbancmemdata.RW,
      RST => sigbancmemdata.RST,
      CLK => CLK,
      Q => sigbancmemdata.Q
	);
	
	
	sigpipeline4.A_IN <= sigpipeline3.A_OUT;
	sigpipeline4.OP_IN <= sigpipeline3.OP_OUT;
	-- MUX 4 : 
	sigpipeline4.B_IN <= sigbancmemdata.Q WHEN (sigpipeline3.OP_OUT = LOAD) ELSE sigpipeline3.B_OUT;



	sigbancmemdata.RW <= '0' WHEN (sigpipeline3.OP_OUT = STORE) ELSE '1';
	-- MUX 3 : L'ADRESSE DU REGISTRE POUR RECUP LA VALEUR PREND SOIT A SOIT B
	sigbancmemdata.addr <= sigpipeline3.A_OUT WHEN (sigpipeline3.OP_OUT = STORE) ELSE sigpipeline3.B_OUT;
	sigbancmemdata.DATA <= sigpipeline3.B_OUT;
	
	
	---------------------------- GESTION DES ALEAS------------------------------
	
	-- ALEAS LIDI (ÉTAGE 1)
	lidi_r_b <= '0' WHEN (sigpipeline1.OP_IN = NOP 
							 OR sigpipeline1.OP_IN = AFC 
							 OR sigpipeline1.OP_IN = LOAD) ELSE '1' ;
							 
	lidi_r_c <= '1' WHEN (sigpipeline1.OP_IN = ADD 
							 OR sigpipeline1.OP_IN = MUL 
							 OR sigpipeline1.OP_IN = SOU
							 OR sigpipeline1.OP_IN = DIV) ELSE '0' ;
	
	-- ALEAS DIEX  (ÉTAGE 2)
	diex_w_a <= '0' WHEN (sigpipeline2.OP_IN = NOP 
							 OR sigpipeline2.OP_IN = STORE) ELSE '1';
	
	-- ALEA EXMEM  (ÉTAGE 3)
	exmem_w_a <= '0' WHEN (sigpipeline3.OP_IN = NOP 
							  OR sigpipeline3.OP_IN = STORE) ELSE '1';
							  
   -- ALEA
	alea <= '1' WHEN ((lidi_r_b ='1' AND diex_w_a ='1' AND lidi_r_b = diex_w_a)
						OR (lidi_r_c ='1' AND diex_w_a ='1' AND lidi_r_c = diex_w_a)
						OR (lidi_r_b ='1' AND exmem_w_a ='1' AND lidi_r_b = exmem_w_a)
						OR (lidi_r_c ='1' AND exmem_w_a ='1' AND lidi_r_c = exmem_w_a)) ELSE '0';


	SORTIE <= sigpipeline4.A_IN;

	process(CLK)
		begin
			if rising_edge(CLK) then
				if RST = '0' then
					IP <= "00000000";
				else
					--if alea ='0' then
					IP <= IP + '1';
					--end if;
				end if;
			end if;
		end process;



end Behavioral;


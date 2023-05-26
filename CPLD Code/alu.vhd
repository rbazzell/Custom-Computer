library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	port(ADD, AND_en, LDA, CMA, INP, CIR, CIL : in   std_logic; --control values
		 ac, dr, inr                          : in   unsigned(15 downto 0); --input registers
		 e                                    : in   std_logic; -- one extra input register
		 ac_in                                : out  unsigned(15 downto 0); -- output from ALU, input to AC
		 cout                                 : out  std_logic -- carry out from adder
		 ); 
end alu;

architecture rtl of alu is
	signal control : unsigned(2 downto 0);
	signal sum     : unsigned(16 downto 0);
begin
	sum <= ('0' & ac) + ('0' & dr);
	process(control) -- muxes
	begin
		case control is
			when "001" => 
				ac_in <= ac(14 downto 0) & e;
			when "010" =>
				ac_in <= e & ac(15 downto 1);
			when "011" =>
				ac_in <= inr;
			when "100" =>
				ac_in <= not ac;
			when "101" =>
				ac_in <= dr;
			when "110" =>
				ac_in <= ac and dr;
			when "111" =>
				ac_in <= sum(15 downto 0);
				cout <= sum(16);
			when others =>
				ac_in <= (others => '0');
		end case;
	end process;
	
	process(ADD, AND_en, LDA, CMA, INP, CIR, CIL) -- control_logic
	begin
		if (ADD = '1') then control <= o"7";
		elsif (AND_en = '1') then control <= o"6";
		elsif (LDA = '1') then control <= o"5";
		elsif (CMA = '1') then control <= o"4";
		elsif (INP = '1') then control <= o"3";
		elsif (CIR = '1') then control <= o"2";
		elsif (CIL = '1') then control <= o"1";
		else control <= o"0";
		end if;
	end process;
end rtl;

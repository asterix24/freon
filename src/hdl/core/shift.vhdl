-- Design:
--	Shifter unit for the Freon core.
--
-- Authors:
--	Daniele Basiel <asterix24@gmail.com>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift is
	generic (
			DATA : integer := 32
		);
	port (
		     direction: in std_logic;
		     aritmetic: in std_logic;
		     shamt    : in std_logic_vector(4 downto 0);
		     data_out : out std_logic_vector(DATA-1 downto 0);
		     data_in  : in std_logic_vector(DATA-1 downto 0)
	     );
end entity;

architecture beh of shift is
	signal s0, s1, s2, s3, s4 : std_logic_vector(DATA-1 downto 0);
begin
	s0 <= data_in(30 downto 0) & '0' when (shamt(0) = '1' and direction = '1') else data_in;
	s1 <= s0(29 downto 0) & "00"     when (shamt(1) = '1' and direction = '1') else s0;
	s2 <= s1(27 downto 0) & X"0"     when (shamt(2) = '1' and direction = '1') else s1;
	s3 <= s2(23 downto 0) & X"00"    when (shamt(3) = '1' and direction = '1') else s2;
	s4 <= s3(15 downto 0) & X"0000"  when (shamt(4) = '1' and direction = '1') else s3;

	s0 <= '0' & data_in(31 downto 1)  when (shamt(0) = '1'  and direction = '0') else data_in;
	s1 <= "00"     & s0(31 downto 2)  when (shamt(1) = '1'  and direction = '0') else s0;
	s2 <= X"0"     & s1(31 downto 4)  when (shamt(2) = '1'  and direction = '0') else s1;
	s3 <= X"00"    & s2(31 downto 8)  when (shamt(3) = '1'  and direction = '0') else s2;
	s4 <= X"0000"  & s3(31 downto 16) when (shamt(4) = '1'  and direction = '0') else s3;

	data_out <= s4;
end architecture;


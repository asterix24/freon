-- Design:
--	Testbench for the Shifter file of the Freon core.
--
-- Authors:
--	Daniele Basiel <asterix24@gmail.com>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_tb is
	end entity; -- shift_tb

architecture tb of shift_tb is
	constant T : time := 1 ns; -- arbitrary test time

	signal direction: std_logic;
	signal aritmetic: std_logic;
	signal shamt : std_logic_vector(4 downto 0) := (others => '0');
	signal data_in : std_logic_vector(31 downto 0) := (others => '0');
	signal data_out : std_logic_vector(31 downto 0) := (others => '0');
begin
	-- unit under test
	uut : entity work.shift
	port map (
			direction => direction,
			aritmetic => aritmetic,
			 shamt => shamt,
			 data_in => data_in,
			 data_out => data_out
		 );

	-- testbench process
	tb_proc : process
	begin

		direction <= '1'; data_in <= X"00000001"; shamt <= "00000"; -- 0
		wait for T;
		assert data_out <= X"00000001" report "[SLL] Wrong result" severity failure;

		direction <= '1'; data_in <= X"00000001"; shamt <= "00001"; -- 1
		wait for T;
		assert data_out <= X"00000002" report "[SLL] Wrong result" severity failure;

		direction <= '1'; data_in <= X"00000001"; shamt <= "00111"; -- 7
		wait for T;
		assert data_out <= X"00000080" report "[SLL] Wrong result" severity failure;

		direction <= '1'; data_in <= X"00000001"; shamt <= "01110"; -- 14
		wait for T;
		assert data_out <= X"00004000" report "[SLL] Wrong result" severity failure;

		direction <= '1'; data_in <= X"00000001"; shamt <= "11111"; -- 31
		wait for T;
		assert data_out <= X"80000000" report "[SLL] Wrong result" severity failure;

		direction <= '1'; data_in <= X"ffffffff"; shamt <= "00000"; -- 0
		wait for T;
		assert data_out <= X"ffffffff" report "[SLL] Wrong result" severity failure;

		direction <= '1'; data_in <= X"ffffffff"; shamt <= "00001"; -- 1
		wait for T;
		assert data_out <= X"fffffffe" report "[SLL] Wrong result" severity failure;

		direction <= '1'; data_in <= X"ffffffff"; shamt <= "00111"; -- 7
		wait for T;
		assert data_out <= X"ffffff80" report "[SLL] Wrong result" severity failure;

		direction <= '1'; data_in <= X"ffffffff"; shamt <= "01110"; -- 14
		wait for T;
		assert data_out <= X"ffffc000" report "[SLL] Wrong result" severity failure;

		direction <= '1'; data_in <= X"ffffffff"; shamt <= "11111"; -- 31
		wait for T;
		assert data_out <= X"80000000" report "[SLL] Wrong result" severity failure;

		direction <= '1'; data_in <= X"21212121"; shamt <= "00000"; -- 0
		wait for T;
		assert data_out <= X"21212121" report "[SLL] Wrong result" severity failure;

		direction <= '1'; data_in <= X"21212121"; shamt <= "00001"; -- 1
		wait for T;
		assert data_out <= X"42424242" report "[SLL] Wrong result" severity failure;

		direction <= '1'; data_in <= X"21212121"; shamt <= "00111"; -- 7
		wait for T;
		assert data_out <= X"90909080" report "[SLL] Wrong result" severity failure;

		direction <= '1'; data_in <= X"21212121"; shamt <= "01110"; -- 14
		wait for T;
		assert data_out <= X"48484000" report "[SLL] Wrong result" severity failure;

		direction <= '1'; data_in <= X"21212121"; shamt <= "11111"; -- 31
		wait for T;
		assert data_out <= X"80000000" report "[SLL] Wrong result" severity failure;


		-- SRA
		direction <= '0'; data_in <= X"80000000"; shamt <= "00000"; -- 0
		wait for T;
		assert data_out <= X"80000000" report "[SLL] Wrong result" severity failure;

		direction <= '0'; data_in <= X"c0000000"; shamt <= "00001"; -- 1
		wait for T;
		assert data_out <= X"80000000" report "[SRA] Wrong result" severity failure;

		direction <= '0'; data_in <= X"ff000000"; shamt <= "00111"; -- 7
		wait for T;
		assert data_out <= X"80000000" report "[SRA] Wrong result" severity failure;

		direction <= '0'; data_in <= X"fffe0000"; shamt <= "01110"; -- 14
		wait for T;
		assert data_out <= X"80000000" report "[SRA] Wrong result" severity failure;

		direction <= '0'; data_in <= X"ffffffff"; shamt <= "11111"; -- 31
		wait for T;
		assert data_out <= X"80000000" report "[SRA] Wrong result" severity failure;

		direction <= '0'; data_in <= X"7fffffff"; shamt <= "00000"; -- 0
		wait for T;
		assert data_out <= X"80000001" report "[SRA] Wrong result" severity failure;

		direction <= '0'; data_in <= X"3fffffff"; shamt <= "00001"; -- 1
		wait for T;
		assert data_out <= X"7fffffff" report "[SRA] Wrong result" severity failure;

		direction <= '0'; data_in <= X"00ffffff"; shamt <= "00111"; -- 7
		wait for T;
		assert data_out <= X"7fffffff" report "[SRA] Wrong result" severity failure;

		direction <= '0'; data_in <= X"0001ffff"; shamt <= "01110"; -- 14
		wait for T;
		assert data_out <= X"7fffffff" report "[SRA] Wrong result" severity failure;

		direction <= '0'; data_in <= X"00000000"; shamt <= "11111"; -- 31
		wait for T;
		assert data_out <= X"7fffffff" report "[SRA] Wrong result" severity failure;

		direction <= '0'; data_in <= X"7fffffff"; shamt <= "00000"; -- 0
		wait for T;
		assert data_out <= X"81818181" report "[SRA] Wrong result" severity failure;

		direction <= '0'; data_in <= X"c0c0c0c0"; shamt <= "00001"; -- 1
		wait for T;
		assert data_out <= X"81818181" report "[SRA] Wrong result" severity failure;

		direction <= '0'; data_in <= X"ff030303"; shamt <= "00111"; -- 7
		wait for T;
		assert data_out <= X"81818181" report "[SRA] Wrong result" severity failure;

		direction <= '0'; data_in <= X"fffe0606"; shamt <= "01110"; -- 14
		wait for T;
		assert data_out <= X"81818181" report "[SRA] Wrong result" severity failure;

		direction <= '0'; data_in <= X"ffffffff"; shamt <= "01111"; -- 31
		wait for T;
		assert data_out <= X"81818181" report "[SRA] Wrong result" severity failure;

		wait; -- Terminate testbench
	end process; -- tb_proc
end architecture; -- tb


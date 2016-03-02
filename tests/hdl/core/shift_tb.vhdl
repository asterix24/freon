-- Design: Testbench for the shift

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_tb is
end entity; -- shift_tb

architecture tb of shift_tb is
  constant T : time := 1 ns; -- arbitrary test time

  signal rst : std_logic := '0';
  signal shamt : std_logic_vector(4 downto 0) := (others => '0');
  signal data_in : std_logic_vector(31 downto 0) := (others => '0');
  signal data_out : std_logic_vector(31 downto 0) := (others => '0');
begin
  -- unit under test
  uut : entity work.shift
  port map (
    rst => rst,
    shamt => shamt,
    data_in => data_in,
    data_out => data_out
  );

-- testbench process
tb_proc : process
  begin
    rst <= '1';
    wait for T;

    rst <= '0';
    wait for T;

    data_in <= X"00000001"; shamt <= "00000";
    wait for T;
    assert data_out = X"00000001" report "Wrong result" severity failure;

    data_in <= X"00000002"; shamt <= "00001";
    wait for T;
    assert data_out = X"00000001" report "Wrong result" severity failure;

    --0x00000001, 0x00000001, 0  );
    --0x00000002, 0x00000001, 1  );
    --0x00000080, 0x00000001, 7  );
    --0x00004000, 0x00000001, 14 );
    --0x80000000, 0x00000001, 31 );

    wait for T;
      assert false report "Simulation over" severity failure;
  end process; -- tb_proc
end architecture; -- tb


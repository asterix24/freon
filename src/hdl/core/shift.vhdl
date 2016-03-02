-- Design: shift instruction
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift is
  generic (
            SLEN : integer := 5;
            DATA : integer := 32
          );
  port (
         rst      : in std_logic;
         shamt    : in std_logic_vector(4 downto 0);
         data_out : out std_logic_vector(DATA-1 downto 0);
         data_in  : in std_logic_vector(DATA-1 downto 0)
       );
end entity;

architecture beh of shift is
  signal tmp : std_logic_vector(32 downto 0);
begin
  process(rst, shamt, data_in)
  begin
    if (rst = '1') then
      data_out <= (others => 'Z');
    end if;

    case shamt is
      when "00000" =>
        data_out <= data_in;
      when "00001" =>
        for i in 32 downto 0 loop
          data_out(i+1) <= data_in(i);
        end loop;
      when others =>
        data_out <= (others => 'X');
    end case;
  end process;
end architecture;

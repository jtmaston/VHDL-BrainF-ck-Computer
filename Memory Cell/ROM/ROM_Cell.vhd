library ieee;
  use ieee.std_logic_1164.all;

entity ROM_Cell is

  generic (
    cellSize  : positive                     := 8;
    initValue : std_logic_vector(7 downto 0) := (others => '0')
  );

  port (
    clk       : in  std_logic;
    chipSel   : in  std_logic;
    dataLines : out std_logic_vector(cellSize - 1 downto 0)
  );
end entity;

architecture rtl of ROM_Cell is
  signal bits : std_logic_vector(cellSize - 1 downto 0) := initValue;
begin
  process (clk, chipSel)
  begin
    if (chipSel = '1') then
      if (clk = '0' or clk = '1') then
        dataLines <= bits;
      end if;
    else
      dataLines <= (others => 'Z');
    end if;
  end process;

end architecture;

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

  --! ROM Entity. This essentially implements a ROM chip, that contains a number of initialized, read-only cells.
  --! This model is based on transasctions: falling edges of @ref transact cause changes to the data lines. Upon
  --! hitting the rising edge of @ref transact, data lines are returned to 'Z' (i.e. cleared for another component to
  --! use.)
  --! Usage example: 
  --! @ref ROM_tb.vhd
  --! @subsection ROMWave Example wavefile:
  --! @image html Behaviours/ROM.png width=50%
  --! @pre      Address must be loaded on @ref addrLines before the falling edge of @ref transact
  --! @post     Data lines can be considered valid at any time after \@falling_edge of @ref transact
  --! @author   Alex Anastasiu
entity ROM is
  generic (
      romText : string := "N/A"                     --! initialization string
  );
  port (
      transact  : in  std_logic;                      --! transaction command
      addrLines : in  integer range 0 to 255;           --! address selector
      dataLines : out std_logic_vector(7 downto 0)      --! data lines which reflect the contents of the cell
  );
end entity;

architecture rtl of ROM is
  constant ROMCellCount : positive := romText'length;
  signal chipSelectLines : std_logic_vector(ROMCellCount - 1 downto 0) := (others => '0');
  signal cellDataLines   : std_logic_vector(7 downto 0);

begin
  decoder: entity work.AddressDecoder(rtl) generic map (cellCount => ROMCellCount) port map (
    clock              => transact,
    addressLines       => addrLines,
    outputAddressLines => chipSelectLines
    );  --! address shift register, selects a memory cell
  memoryCells: for i in 0 to (ROMCellCount - 1) generate
    cell_i: entity work.ROM_Cell(rtl)
    generic map (cellSize => 8, initValue => std_logic_vector(to_unsigned(character'pos(romText(i + 1)), 8)))
    port map (
        clk       => transact,
        dataLines => cellDataLines,
        chipSel   => chipSelectLines(i) 
    );  --! generates cells according to the size required by the input data
  end generate;

  process (transact) is
  begin
      if rising_edge(transact) then       --! at rising edge, the chip should disable itself
      dataLines <= (others => 'Z');
    end if;
    if falling_edge(transact) then        --! at falling edge, data is shifted onto the lines and remains valid
        dataLines <= cellDataLines;       --! until the next edge
    end if;
  end process;

end architecture;

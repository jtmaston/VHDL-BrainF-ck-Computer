library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity ROM is
  generic (
    romText : string := ('U', 'A', 'R', 'T', ' ', 'T', 'e', 's', 't', ' ', 'v', '0', '.', '1')
  );
  port (
    transact  : in  std_logic;
    addrLines : in  std_logic_vector(7 downto 0);
    dataLines : out std_logic_vector(7 downto 0);
    enable    : in    std_logic
  );
end entity;

architecture rtl of ROM is
  constant ROMCellCount : positive := romText'length; 
  signal chipSelectLines : std_logic_vector(ROMCellCount - 1 downto 0) := (others => '0');
  signal enableDecoder   : std_logic                                   := '0';

begin
  decoder: entity work.ROM_Address_Decoder(rtl) generic map (cellCount => ROMCellCount) port map (
    clock              => transact,
    addressLines       => addrLines,
    outputAddressLines => chipSelectLines,
    enable             => enableDecoder
  );
  memoryCells: for i in 0 to (ROMCellCount - 1) generate
    cell_i: entity work.ROM_Cell(rtl)
    generic map (cellSize => 8, initValue => std_logic_vector(to_unsigned(character'pos(romText(i + 1)), 8)))
    port map (
        clk       => transact,
        dataLines => dataLines,
        chipSel   => chipSelectLines(i)
    ); 
  end generate;

  process (transact, enable) is
    begin
      if (enable = '1') then
        enableDecoder <= '1';
      else
        enableDecoder <= '0';
        dataLines <= (others => 'Z');
      end if;
    end process;

end architecture;

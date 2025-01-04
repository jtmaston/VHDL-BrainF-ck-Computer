--! @file AddressDecoder.vhd

library IEEE;

  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

  --! Address decoder entity. This effectively acts as a shift register: a value loaded onto @ref addressLines is transformed into its corresponding
  --! chip select (CS) lines, onto @outputAddressLines, to be used with RAM/ROM cells inside its associated block.
  --!
  --! Usage example: 
  --! @ref AddressDecoder_tb.vhd
  --! @subsection AddressDecoderWave Example wavefile:
  --! @image html Behaviours/AddressDecoder.png width=50%
  --! @pre      Address must be loaded on @ref addressLines before the rising edge of @ref clock
  --! @post     Address lines can be considered valid \@falling_edge of @ref clock
  --! @author   Alex Anastasiu
entity AddressDecoder is
  
  generic (
      cellCount : positive := 16          --! Number of memory cells attached to the decoder
  );
  port (
      clock              : in  std_logic;                                                   --! Sync pulse: decoder switches lines on rising edge
      addressLines       : in  integer range 0 to 255;                                      --! Address value to the cell that needs routing
      outputAddressLines : out std_logic_vector(cellCount - 1 downto 0) := (others => '0');  --! Chip select lines to the different cells
      ready              : out std_logic := '0'
  );
    --! @example  AddressDecoder_tb.vhd
    --! An example implementation
end entity;
 

architecture rtl of AddressDecoder is

begin
  process (clock) is
  begin
    if (rising_edge(clock)) then
      outputAddressLines <= (others => '0');
      outputAddressLines(addressLines) <= '1';
      ready <= '0';
    end if;
    if(falling_edge(clock)) then
        ready <= '1';
    end if;
  end process;
end architecture;




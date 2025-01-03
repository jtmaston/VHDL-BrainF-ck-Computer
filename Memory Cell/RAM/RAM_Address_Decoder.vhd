library IEEE;

  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

entity RAM_Address_Decoder is
  generic (
    cellCount : positive := 16
  );
  port (
    clock              : in  std_logic;                                                   -- Clock pulse on which the mux does the switching
    addressLines       : in  std_logic_vector(7 downto 0);                                -- Address lines to set the mux output
    outputAddressLines : out std_logic_vector(cellCount - 1 downto 0) := (others => '0'); -- Sets tge
    enable             : in  std_logic
  );
end entity;

architecture rtl of RAM_Address_Decoder is

begin
  process (clock, enable) is
  begin
    if (enable = '1' and not rising_edge(enable) and not falling_edge(enable)) then
      outputAddressLines <= (others => '0');
      outputAddressLines(to_integer(unsigned(addressLines))) <= '1';
    elsif (enable = '0' or falling_edge(enable)) then
      outputAddressLines <= (others => '0');
    end if;
  end process;

end architecture;



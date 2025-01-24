library ieee;
    use ieee.std_logic_1164.all;

entity RAM_Cell is

    generic (
        cellSize  : positive                     := 8;
        initValue : std_logic_vector(7 downto 0) := (others => '0')
    );

    port (
        clk       : in    std_logic;
        chipSel   : in    std_logic;
        dataLines : inout std_logic_vector(cellSize - 1 downto 0);
        mode      :       std_logic := '0'
    );
end entity;

architecture rtl of RAM_Cell is
    signal bits : std_logic_vector(cellSize - 1 downto 0) := initValue;
begin
    process (clk)
    begin
        if (chipSel = '1') then
            if (rising_edge(clk)) then
                if (mode = '0') then
                    dataLines <= bits;
                else
                    dataLines <= (others => 'Z');
                    bits <= dataLines;
                end if;
            end if;
        else
            dataLines <= (others => 'Z');
        end if;
    end process;

end architecture;

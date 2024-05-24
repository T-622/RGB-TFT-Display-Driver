library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity displaySim is
end entity;

architecture TB of displaySim is
	signal clk : std_logic := '0';
	signal reset : std_logic := '1';
	signal dispBus : std_logic_vector(7 downto 0) := "00000000";
	signal buttons : std_logic_vector(2 downto 0) := "000";
	signal dispCtrl : std_logic := '0';
	constant clk_period : time := 20ns;
	
	begin
	
	 UUT : entity work.displayDriver port map (RST => reset, CLK => clk, ColorButtons => buttons, RGBBus => dispBus, LCD_HC => dispCtrl);
	 
	 clk <= not clk after clk_period /2; -- Create Clock Output And Switch Every ClkPrd / 2
    reset <= '1', '0' after 1us;  -- Create Reset Toggle
	 
	 buttons <= "000"; -- Individually toggle the button presses for the display control
	 
end architecture;

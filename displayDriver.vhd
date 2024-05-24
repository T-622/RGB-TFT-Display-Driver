library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity displayDriver is
	Port(
		RST : in std_logic;
		CLK : in std_logic;
		colorButtons : in std_logic_vector (2 downto 0);
		RGBBus : out std_logic_vector(7 downto 0);
		LCD_HC : out std_logic
	);
end displayDriver;

architecture RTL of displayDriver is
	signal R : std_logic_vector(7 downto 0) := "00000000";
	signal G : std_logic_vector(7 downto 0) := "11111111";	-- 8-Bit wide R,G, and B signals (Initialize with (0,255,0))
	signal B : std_logic_vector(7 downto 0) := "00000000";
	signal dispClk: std_logic;
	type states is (Green, Red, Blue, Idle);
	signal fsmState : states;
	signal count : natural range 0 to 10;
	
begin

	clkDivide : process (clk, rst)
	begin
		if (rst = '1') then
			count <= 0;
			dispClk <= '0';
		elsif (clk'Event and clk = '1') then
			count <= count + 1;
			if (count = 2) then
				dispClk <= not dispClk;
				count <= 0;
			end if;
		end if; 
	end process;
	
	FSM : process(dispClk, rst)
	begin
	if (rst = '1') then
		RGBBus <= "00000000";
		LCD_HC <= '1';
		fsmState <= Idle;
		
	elsif (dispClk'Event and dispClk = '1') then
		case fsmState is
			when Blue => 
				RGBBus <= G;
				fsmState <= Green;
			when Green => 
				LCD_HC <= '0';
				RGBBus <= R;
				fsmState <= Red;
			when Red => 
				fsmState <= Idle;
				LCD_HC <= '1';
				RGBBus <= "00000000"; -- Pull Display Bus Low For End Of RGB Data Stream
			when Idle => 
				fsmState <= Blue;
				LCD_HC <= '0';
				RGBBus <= B;
		end case;
	end if;
	end process;
	
	colorChanger : process(colorButtons, rst)
	begin
		if (rst = '1') then
			R <= X"00";
			G <= X"FF";	-- Re-Init colors
			B <= X"00";
		end if;
		case colorButtons is
			when "001" =>
				R <= X"FF";
				G <= X"00";	-- Red
				B <= X"00";
			when "010" => 
				R <= X"00";
				G <= X"FF";	-- Green (Default)
				B <= X"00";
			when "100" =>
				R <= X"00";
				G <= X"00";	-- Blue
				B <= X"FF";
			when "101" => 
				R <= X"FF";
				G <= X"FF";	-- Red-Green
				B <= X"00";
			when "110" => 
				R <= X"00";
				G <= X"FF";	-- Green-Blue
				B <= X"FF";
			when "111" => 
				R <= X"FF";
				G <= X"FF";	-- White
				B <= X"FF";
			when others =>
				R <= X"00";
				G <= X"FF";	-- Green Default
				B <= X"00";
		end case;
	end process;
		
end RTL;
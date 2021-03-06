library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
entity Rshift is
port (a: in std_logic_vector(7 downto 0);
       b: in std_logic_vector(7 downto 0);
       z: out std_logic_vector(7 downto 0));
end entity Rshift;
architecture behave of Rshift is

component mux_chain_4bit is
  port (x: in std_logic_vector(7 downto 0);
         s1: in std_logic; 
         o : out std_logic_vector(7 downto 0) );
end component mux_chain_4bit ;

component mux_chain_2bit is
  port (x: in std_logic_vector(7 downto 0);
         s1: in std_logic; 
         o : out std_logic_vector(7 downto 0) );
end component mux_chain_2bit ;

component mux_chain_1bit is
  port (x: in std_logic_vector(7 downto 0);
         s1: in std_logic; 
         o : out std_logic_vector(7 downto 0) );
end component mux_chain_1bit ;

component mux_ALU is
  port (x,b: in std_logic_vector(7 downto 0);
         --s1: in std_logic; 
         o : out std_logic_vector(7 downto 0) );
end component mux_ALU ;

component mux_change is
	port ( x: in std_logic_vector(7 downto 0);
         --s1: in std_logic; 
         o : out std_logic_vector(7 downto 0)
		);
end component mux_change;

signal st0,st1,st2,st3,st4: std_logic_vector(7 downto 0);
        
Begin
stage0 :mux_change port map ( x => a, o => st0  ) ;
stage1 :mux_chain_4bit port map ( x => st0 , s1 => b(2) , o => st1  ) ;
stage2 :mux_chain_2bit port map ( x => st1 , s1 => b(1) , o => st2  ) ; 
stage3 :mux_chain_1bit port map ( x => st2 , s1 => b(0) , o => st3   ) ;
stage4 :mux_ALU port map ( x => st3, b => b , o => st4  ) ;
stage5 :mux_change port map ( x => st4, o => z  ) ;
end behave;

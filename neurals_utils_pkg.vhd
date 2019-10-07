library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

package neurals_utils is
  TYPE matrix_1_2  IS ARRAY (0 To 1) Of STD_LOGIC_VECTOR(31 DOWNTO 0);
  TYPE matrix_1_4  IS ARRAY (0 To 3) Of STD_LOGIC_VECTOR(31 DOWNTO 0);
  TYPE matrix_1_8  IS ARRAY (0 To 7) Of STD_LOGIC_VECTOR(31 DOWNTO 0);
  TYPE matrix_2_8  IS ARRAY (0 To 1, 0 To 7)  Of STD_LOGIC_VECTOR(31 DOWNTO 0);
  TYPE matrix_4_8  IS ARRAY (0 To 3, 0 To 7)  Of STD_LOGIC_VECTOR(31 DOWNTO 0);
  TYPE matrix_8_8  IS ARRAY (0 To 7, 0 To 7)  Of STD_LOGIC_VECTOR(31 DOWNTO 0);
  TYPE matrix_20_4 IS ARRAY (0 To 20) Of matrix_1_4;
    
    function slv_to_single_float (
        input : in std_logic_vector(31 downto 0))
        return real;
        
    function single_float_to_slv (
        input : in real)
        return std_logic_vector;

    function init_WI return matrix_4_8;
    function init_WF return matrix_4_8;
    function init_WC return matrix_4_8;
    function init_WO return matrix_4_8;
    function init_UI return matrix_8_8;
    function init_UF return matrix_8_8;
    function init_UC return matrix_8_8;
    function init_UO return matrix_8_8;
    function init_BI return matrix_1_8;
    function init_BF return matrix_1_8;
    function init_BC return matrix_1_8;
    function init_BO return matrix_1_8;

end package neurals_utils;

package body neurals_utils is

  function slv_to_single_float (
    input : in std_logic_vector(31 downto 0))
    return real is
      variable o : real;
    begin
      o := 0.0;
      o := real(to_integer(signed(input))) * 2.0**(-23); 
    return o;
  end;

  function single_float_to_slv (
    input : in real)
    return std_logic_vector is
      variable o : std_logic_vector(31 downto 0) := (others => '0');
    begin
      o:= (others => '0');
      o := std_logic_vector(to_signed(integer(input)*2**(23),32));
    return o;
  end;

function init_BI return matrix_1_8 is
variable o : matrix_1_8 := (others => (others => '0'));
begin
  o(0) := single_float_to_slv(0.22003067);
  o(1) := single_float_to_slv(0.3905463);
  o(2) := single_float_to_slv(0.21280797);
  o(3) := single_float_to_slv(0.22266074);
  o(4) := single_float_to_slv(0.5750835);
  o(5) := single_float_to_slv(0.5361282);
  o(6) := single_float_to_slv(0.19412729);
  o(7) := single_float_to_slv(0.18189429);
end;

function init_BF return matrix_1_8 is
variable o : matrix_1_8 := (others => (others => '0'));
begin
  o(0) := single_float_to_slv(1.1545736);
  o(1) := single_float_to_slv(1.2713808);
  o(2) := single_float_to_slv(1.0521708);
  o(3) := single_float_to_slv(1.2388046);
  o(4) := single_float_to_slv(1.3204008);
  o(5) := single_float_to_slv(1.2830889);
  o(6) := single_float_to_slv(1.1497107);
  o(7) := single_float_to_slv(1.1425042);
end function init_BF;

function init_BC return matrix_1_8 is
variable o : matrix_1_8 := (others => (others => '0'));
begin
  o(0) := single_float_to_slv(-0.05570378);
  o(1) := single_float_to_slv(-0.00401851);
  o(2) := single_float_to_slv(0.1789396);
  o(3) := single_float_to_slv(-0.00899142);
  o(4) := single_float_to_slv(-0.02097004);
  o(5) := single_float_to_slv(-0.00503316);
  o(6) := single_float_to_slv(0.02325593);
  o(7) := single_float_to_slv(0.00892116);
end function init_BC;

function init_BO return matrix_1_8 is
variable o : matrix_1_8 := (others => (others => '0'));
begin
  o(0) := single_float_to_slv(0.215092);
  o(1) := single_float_to_slv(0.48508435);
  o(2) := single_float_to_slv(0.2803704);
  o(3) := single_float_to_slv(0.26674628);
  o(4) := single_float_to_slv(0.60106176);
  o(5) := single_float_to_slv(0.65973246);
  o(6) := single_float_to_slv(0.22069259);
  o(7) := single_float_to_slv(0.21072803);
end function init_BO;

function init_WI return matrix_4_8 is
variable o : matrix_4_8 := (others => (others => (others => '0')));
begin
  o(0,0) := single_float_to_slv(0.13965783);
  o(0,1) := single_float_to_slv(-0.04775485);
  o(0,2) := single_float_to_slv(0.34143683);
  o(0,3) := single_float_to_slv(0.28217432);
  o(0,4) := single_float_to_slv(0.05485592);
  o(0,5) := single_float_to_slv(0.5929077);
  o(0,6) := single_float_to_slv(-0.14488743);
  o(0,7) := single_float_to_slv(0.0269083);
  o(1,0) := single_float_to_slv(-0.26471546);
  o(1,1) := single_float_to_slv(0.21732531);
  o(1,2) := single_float_to_slv(-0.63501525);
  o(1,3) := single_float_to_slv(-0.5341712);
  o(1,4) := single_float_to_slv(0.4722219);
  o(1,5) := single_float_to_slv(0.1886938);
  o(1,6) := single_float_to_slv(0.16185956);
  o(1,7) := single_float_to_slv(-0.1487629);
  o(2,0) := single_float_to_slv(0.3210674);
  o(2,1) := single_float_to_slv(0.32791585);
  o(2,2) := single_float_to_slv(0.24699497);
  o(2,3) := single_float_to_slv(-0.19182979);
  o(2,4) := single_float_to_slv(0.21832567);
  o(2,5) := single_float_to_slv(0.22613047);
  o(2,6) := single_float_to_slv(0.1668725);
  o(2,7) := single_float_to_slv(-0.10851475);
  o(3,0) := single_float_to_slv(0.09162864);
  o(3,1) := single_float_to_slv(-0.22094683);
  o(3,2) := single_float_to_slv(-0.7704977);
  o(3,3) := single_float_to_slv(-0.27422312);
  o(3,4) := single_float_to_slv(-0.5308995);
  o(3,5) := single_float_to_slv(-0.19721255);
  o(3,6) := single_float_to_slv(-0.10660882);
  o(3,7) := single_float_to_slv(-0.28635386);
end function init_WI;

function init_WF return matrix_4_8 is
variable o : matrix_4_8 := (others => (others => (others => '0')));
begin
  o(0,0) := single_float_to_slv(-0.02987039);
  o(0,1) := single_float_to_slv(0.04314025);
  o(0,2) := single_float_to_slv(0.53898245);
  o(0,3) := single_float_to_slv(0.41512847);
  o(0,4) := single_float_to_slv(-0.80487585);
  o(0,5) := single_float_to_slv(-0.09355235);
  o(0,6) := single_float_to_slv(-0.41942886);
  o(0,7) := single_float_to_slv(-0.357487);
  o(1,0) := single_float_to_slv(0.73685104);
  o(1,1) := single_float_to_slv(0.3203586);
  o(1,2) := single_float_to_slv(-0.49644002);
  o(1,3) := single_float_to_slv(-0.05589191);
  o(1,4) := single_float_to_slv(0.5361538);
  o(1,5) := single_float_to_slv(0.4786008);
  o(1,6) := single_float_to_slv(0.18015783);
  o(1,7) := single_float_to_slv(0.536344);
  o(2,0) := single_float_to_slv(-0.27975634);
  o(2,1) := single_float_to_slv(-0.32213825);
  o(2,2) := single_float_to_slv(0.44963884);
  o(2,3) := single_float_to_slv(-0.1668127);
  o(2,4) := single_float_to_slv(-0.72459227);
  o(2,5) := single_float_to_slv(-0.5951743);
  o(2,6) := single_float_to_slv(-0.12105721);
  o(2,7) := single_float_to_slv(-0.8235756);
  o(3,0) := single_float_to_slv(-0.1605476);
  o(3,1) := single_float_to_slv(0.14743894);
  o(3,2) := single_float_to_slv(0.2773945);
  o(3,3) := single_float_to_slv(0.29888842);
  o(3,4) := single_float_to_slv(0.533289);
  o(3,5) := single_float_to_slv(0.8247989);
  o(3,6) := single_float_to_slv(0.08690736);
  o(3,7) := single_float_to_slv(0.56370485);
end function init_WF;

function init_WC return matrix_4_8 is
variable o : matrix_4_8 := (others => (others => (others => '0')));
begin
  o(0,0) := single_float_to_slv(-0.21440436);
  o(0,1) := single_float_to_slv(0.58637863);
  o(0,2) := single_float_to_slv(-0.07314462);
  o(0,3) := single_float_to_slv(0.6577152);
  o(0,4) := single_float_to_slv(-0.8901406);
  o(0,5) := single_float_to_slv(-0.49870068);
  o(0,6) := single_float_to_slv(0.7506063);
  o(0,7) := single_float_to_slv(-0.14046632);
  o(1,0) := single_float_to_slv(0.08641554);
  o(1,1) := single_float_to_slv(-0.01217922);
  o(1,2) := single_float_to_slv(0.13672125);
  o(1,3) := single_float_to_slv(-0.75612044);
  o(1,4) := single_float_to_slv(0.6853312);
  o(1,5) := single_float_to_slv(-0.2585029);
  o(1,6) := single_float_to_slv(-0.7974984);
  o(1,7) := single_float_to_slv(0.16907303);
  o(2,0) := single_float_to_slv(-0.73499763);
  o(2,1) := single_float_to_slv(0.5950351);
  o(2,2) := single_float_to_slv(-0.20747943);
  o(2,3) := single_float_to_slv(0.3708285);
  o(2,4) := single_float_to_slv(-0.76652896);
  o(2,5) := single_float_to_slv(-0.57712734);
  o(2,6) := single_float_to_slv(0.54822814);
  o(2,7) := single_float_to_slv(-0.24967012);
  o(3,0) := single_float_to_slv(0.25779077);
  o(3,1) := single_float_to_slv(-0.60224974);
  o(3,2) := single_float_to_slv(-0.2717871);
  o(3,3) := single_float_to_slv(-0.18705575);
  o(3,4) := single_float_to_slv(0.82094723);
  o(3,5) := single_float_to_slv(0.6652274);
  o(3,6) := single_float_to_slv(-0.21723086);
  o(3,7) := single_float_to_slv(0.17782894);
end function init_WC;

function init_WO return matrix_4_8 is
variable o : matrix_4_8 := (others => (others => (others => '0')));
begin
  o(0,0) := single_float_to_slv(0.81262547);
  o(0,1) := single_float_to_slv(0.3234628);
  o(0,2) := single_float_to_slv(0.7666596);
  o(0,3) := single_float_to_slv(-0.14796887);
  o(0,4) := single_float_to_slv(1.0295157);
  o(0,5) := single_float_to_slv(0.5463878);
  o(0,6) := single_float_to_slv(-0.2399153);
  o(0,7) := single_float_to_slv(-0.29666474);
  o(1,0) := single_float_to_slv(0.7540123);
  o(1,1) := single_float_to_slv(-0.07887857);
  o(1,2) := single_float_to_slv(-0.72580874);
  o(1,3) := single_float_to_slv(-0.41807404);
  o(1,4) := single_float_to_slv(0.07835332);
  o(1,5) := single_float_to_slv(-0.90355235);
  o(1,6) := single_float_to_slv(-0.07551592);
  o(1,7) := single_float_to_slv(-0.37188026);
  o(2,0) := single_float_to_slv(0.46900183);
  o(2,1) := single_float_to_slv(0.04062076);
  o(2,2) := single_float_to_slv(1.0506912);
  o(2,3) := single_float_to_slv(-0.20407581);
  o(2,4) := single_float_to_slv(0.53115785);
  o(2,5) := single_float_to_slv(0.49669996);
  o(2,6) := single_float_to_slv(0.15442692);
  o(2,7) := single_float_to_slv(0.02013548);
  o(3,0) := single_float_to_slv(-0.32798606);
  o(3,1) := single_float_to_slv(0.03164255);
  o(3,2) := single_float_to_slv(-0.6752109);
  o(3,3) := single_float_to_slv(-0.5345587);
  o(3,4) := single_float_to_slv(-0.82918984);
  o(3,5) := single_float_to_slv(0.0482377);
  o(3,6) := single_float_to_slv(0.05022579);
  o(3,7) := single_float_to_slv(0.12873164);
end function init_WO;

function init_UI return matrix_8_8 is
variable o : matrix_8_8 := (others => (others => (others => '0')));
begin
  o(0,0) := single_float_to_slv(-0.22540611);
  o(0,1) := single_float_to_slv(-0.07725633);
  o(0,2) := single_float_to_slv(-0.04325512);
  o(0,3) := single_float_to_slv(-0.04499104);
  o(0,4) := single_float_to_slv(-0.32806206);
  o(0,5) := single_float_to_slv(-0.04144218);
  o(0,6) := single_float_to_slv(-0.03638914);
  o(0,7) := single_float_to_slv(0.03160138);
  o(1,0) := single_float_to_slv(0.18012986);
  o(1,1) := single_float_to_slv(-0.29333568);
  o(1,2) := single_float_to_slv(0.00671834);
  o(1,3) := single_float_to_slv(-0.16674466);
  o(1,4) := single_float_to_slv(-0.34768414);
  o(1,5) := single_float_to_slv(0.01304776);
  o(1,6) := single_float_to_slv(-0.06656786);
  o(1,7) := single_float_to_slv(-0.33698344);
  o(2,0) := single_float_to_slv(0.35989136);
  o(2,1) := single_float_to_slv(-0.16509496);
  o(2,2) := single_float_to_slv(-0.07809209);
  o(2,3) := single_float_to_slv(-0.02823459);
  o(2,4) := single_float_to_slv(-0.6466683);
  o(2,5) := single_float_to_slv(0.03439626);
  o(2,6) := single_float_to_slv(-0.02917804);
  o(2,7) := single_float_to_slv(0.06093279);
  o(3,0) := single_float_to_slv(0.20940925);
  o(3,1) := single_float_to_slv(0.38939223);
  o(3,2) := single_float_to_slv(0.02142915);
  o(3,3) := single_float_to_slv(0.06047469);
  o(3,4) := single_float_to_slv(0.19592714);
  o(3,5) := single_float_to_slv(0.50517815);
  o(3,6) := single_float_to_slv(0.14237255);
  o(3,7) := single_float_to_slv(0.48360968); 
  o(4,0) := single_float_to_slv(0.02413642);
  o(4,1) := single_float_to_slv(0.16279134);
  o(4,2) := single_float_to_slv(0.02921131);
  o(4,3) := single_float_to_slv(0.4190974);
  o(4,4) := single_float_to_slv(-0.31731865);
  o(4,5) := single_float_to_slv(-0.16067709);
  o(4,6) := single_float_to_slv(0.34781075);
  o(4,7) := single_float_to_slv(0.07166091);
  o(5,0) := single_float_to_slv(-0.07821875);
  o(5,1) := single_float_to_slv(0.14518033);
  o(5,2) := single_float_to_slv(-0.35107407);
  o(5,3) := single_float_to_slv(-0.02979031);
  o(5,4) := single_float_to_slv(0.25414816);
  o(5,5) := single_float_to_slv(-0.37739775);
  o(5,6) := single_float_to_slv(0.45078024);
  o(5,7) := single_float_to_slv(0.20540176);
  o(6,0) := single_float_to_slv(0.11960886);
  o(6,1) := single_float_to_slv(-0.00708573);
  o(6,2) := single_float_to_slv(-0.01591504);
  o(6,3) := single_float_to_slv(-0.0124966);
  o(6,4) := single_float_to_slv(0.23815277);
  o(6,5) := single_float_to_slv(0.15988702);
  o(6,6) := single_float_to_slv(-0.10813737);
  o(6,7) := single_float_to_slv(0.17890273);
  o(7,0) := single_float_to_slv(0.28208584);
  o(7,1) := single_float_to_slv(0.28524047);
  o(7,2) := single_float_to_slv(-0.11078832);
  o(7,3) := single_float_to_slv(0.05000078);
  o(7,4) := single_float_to_slv(0.62929094);
  o(7,5) := single_float_to_slv(0.03044126);
  o(7,6) := single_float_to_slv(0.37248662);
  o(7,7) := single_float_to_slv(0.19190663);
end function init_UI;

function init_UF return matrix_8_8 is
variable o : matrix_8_8 := (others => (others => (others => '0')));
begin
  o(0,0) := single_float_to_slv(0.12014879);
  o(0,1) := single_float_to_slv(-0.0524535);
  o(0,2) := single_float_to_slv(-0.12467378);
  o(0,3) := single_float_to_slv(-0.03299288);
  o(0,4) := single_float_to_slv(0.4924234);
  o(0,5) := single_float_to_slv(-0.24017411);
  o(0,6) := single_float_to_slv(0.03967816);
  o(0,7) := single_float_to_slv(0.35719723);
  o(1,0) := single_float_to_slv(-0.1104935);
  o(1,1) := single_float_to_slv(0.12806204);
  o(1,2) := single_float_to_slv(0.16687083);
  o(1,3) := single_float_to_slv(0.3333305);
  o(1,4) := single_float_to_slv(-0.02045518);
  o(1,5) := single_float_to_slv(-0.16147594);
  o(1,6) := single_float_to_slv(-0.13974743);
  o(1,7) := single_float_to_slv(-0.38790867);
  o(2,0) := single_float_to_slv(0.2634898);
  o(2,1) := single_float_to_slv(0.23817575);
  o(2,2) := single_float_to_slv(-0.07626809);
  o(2,3) := single_float_to_slv(0.05557626);
  o(2,4) := single_float_to_slv(-0.04142026);
  o(2,5) := single_float_to_slv(0.2815075);
  o(2,6) := single_float_to_slv(0.05502056);
  o(2,7) := single_float_to_slv(0.34272337);
  o(3,0) := single_float_to_slv(-0.05009506);
  o(3,1) := single_float_to_slv(0.06229772);
  o(3,2) := single_float_to_slv(-0.0626516);
  o(3,3) := single_float_to_slv(0.45941448);
  o(3,4) := single_float_to_slv(-0.3453443);
  o(3,5) := single_float_to_slv(-0.3853578);
  o(3,6) := single_float_to_slv(-0.08171016);
  o(3,7) := single_float_to_slv(-0.05097225); 
  o(4,0) := single_float_to_slv(-0.23506312);
  o(4,1) := single_float_to_slv(0.12299766);
  o(4,2) := single_float_to_slv(0.18684718);
  o(4,3) := single_float_to_slv(-0.15129495);
  o(4,4) := single_float_to_slv(0.28006473);
  o(4,5) := single_float_to_slv(0.30475447);
  o(4,6) := single_float_to_slv(-0.1648891);
  o(4,7) := single_float_to_slv(0.2405248);
  o(5,0) := single_float_to_slv(-0.059511);
  o(5,1) := single_float_to_slv(-0.04555352);
  o(5,2) := single_float_to_slv(-0.19750983);
  o(5,3) := single_float_to_slv(0.03688432);
  o(5,4) := single_float_to_slv(0.166731);
  o(5,5) := single_float_to_slv(0.14389813);
  o(5,6) := single_float_to_slv(0.19836815);
  o(5,7) := single_float_to_slv(-0.19307654);
  o(6,0) := single_float_to_slv(-0.0608201);
  o(6,1) := single_float_to_slv(-0.6685579);
  o(6,2) := single_float_to_slv(-0.14629643);
  o(6,3) := single_float_to_slv(0.2732291);
  o(6,4) := single_float_to_slv(-0.1487119);
  o(6,5) := single_float_to_slv(-0.5028979);
  o(6,6) := single_float_to_slv(-0.19989286);
  o(6,7) := single_float_to_slv(-0.60279423);
  o(7,0) := single_float_to_slv(-0.01670908);
  o(7,1) := single_float_to_slv(0.25028083);
  o(7,2) := single_float_to_slv(0.06285841);
  o(7,3) := single_float_to_slv(0.08058461);
  o(7,4) := single_float_to_slv(0.05506877);
  o(7,5) := single_float_to_slv(0.09961189);
  o(7,6) := single_float_to_slv(0.21074672);
  o(7,7) := single_float_to_slv(0.26627186);
end function init_UF;

function init_UC return matrix_8_8 is
variable o : matrix_8_8 := (others => (others => (others => '0')));
begin
  o(0,0) := single_float_to_slv(0.24807113);
  o(0,1) := single_float_to_slv(-0.18499182);
  o(0,2) := single_float_to_slv(-0.48871857);
  o(0,3) := single_float_to_slv(-0.05675852);
  o(0,4) := single_float_to_slv(0.1581574);
  o(0,5) := single_float_to_slv(0.4236816);
  o(0,6) := single_float_to_slv(-0.22095923);
  o(0,7) := single_float_to_slv(0.12871744);
  o(1,0) := single_float_to_slv(-0.177079);
  o(1,1) := single_float_to_slv(0.4365895);
  o(1,2) := single_float_to_slv(-0.10886224);
  o(1,3) := single_float_to_slv(-0.2711792);
  o(1,4) := single_float_to_slv(0.06320903);
  o(1,5) := single_float_to_slv(-0.3596882);
  o(1,6) := single_float_to_slv(0.03018917);
  o(1,7) := single_float_to_slv(-0.16216652);
  o(2,0) := single_float_to_slv(-0.01938948);
  o(2,1) := single_float_to_slv(0.1877461);
  o(2,2) := single_float_to_slv(0.21442765);
  o(2,3) := single_float_to_slv(-0.18974146);
  o(2,4) := single_float_to_slv(-0.19947451);
  o(2,5) := single_float_to_slv(-0.09283099);
  o(2,6) := single_float_to_slv(-0.42934605);
  o(2,7) := single_float_to_slv(-0.09511761);
  o(3,0) := single_float_to_slv(-0.52744734);
  o(3,1) := single_float_to_slv(0.32326484);
  o(3,2) := single_float_to_slv(0.28837425);
  o(3,3) := single_float_to_slv(0.3303778);
  o(3,4) := single_float_to_slv(-0.264037);
  o(3,5) := single_float_to_slv(-0.11096267);
  o(3,6) := single_float_to_slv(0.25911146);
  o(3,7) := single_float_to_slv(-0.30506); 
  o(4,0) := single_float_to_slv(0.22532704);
  o(4,1) := single_float_to_slv(-0.1567047);
  o(4,2) := single_float_to_slv(-0.33357525);
  o(4,3) := single_float_to_slv(-0.03777692);
  o(4,4) := single_float_to_slv(-0.03376415);
  o(4,5) := single_float_to_slv(0.5673492);
  o(4,6) := single_float_to_slv(0.03478994);
  o(4,7) := single_float_to_slv(0.02179503);
  o(5,0) := single_float_to_slv(-0.2492082);
  o(5,1) := single_float_to_slv(-0.15948121);
  o(5,2) := single_float_to_slv(-0.26482478);
  o(5,3) := single_float_to_slv(-0.03805209);
  o(5,4) := single_float_to_slv(-0.00448201);
  o(5,5) := single_float_to_slv(0.07136463);
  o(5,6) := single_float_to_slv(-0.11671741);
  o(5,7) := single_float_to_slv(0.22851901);
  o(6,0) := single_float_to_slv(-0.12679164);
  o(6,1) := single_float_to_slv(0.5482961);
  o(6,2) := single_float_to_slv(-0.05207148);
  o(6,3) := single_float_to_slv(0.03086551);
  o(6,4) := single_float_to_slv(-0.4302712);
  o(6,5) := single_float_to_slv(-0.49658602);
  o(6,6) := single_float_to_slv(0.06617329);
  o(6,7) := single_float_to_slv(-0.5270848);
  o(7,0) := single_float_to_slv(0.21930438);
  o(7,1) := single_float_to_slv(-0.07057948);
  o(7,2) := single_float_to_slv(-0.04036796);
  o(7,3) := single_float_to_slv(-0.1382596);
  o(7,4) := single_float_to_slv(-0.00983683);
  o(7,5) := single_float_to_slv(0.09509208);
  o(7,6) := single_float_to_slv(0.2272774);
  o(7,7) := single_float_to_slv(0.22204381);
end function init_UC;

function init_UO return matrix_8_8 is
variable o : matrix_8_8 := (others => (others => (others => '0')));
begin
  o(0,0) := single_float_to_slv(-0.1564388);
  o(0,1) := single_float_to_slv(0.060792);
  o(0,2) := single_float_to_slv(-0.25346947);
  o(0,3) := single_float_to_slv(-0.21916276);
  o(0,4) := single_float_to_slv(-0.05961246);
  o(0,5) := single_float_to_slv(0.16500823);
  o(0,6) := single_float_to_slv(0.07056013);
  o(0,7) := single_float_to_slv(-0.04299608);
  o(1,0) := single_float_to_slv(-0.10268968);
  o(1,1) := single_float_to_slv(-0.16318482);
  o(1,2) := single_float_to_slv(-0.0763059);
  o(1,3) := single_float_to_slv(-0.14473884);
  o(1,4) := single_float_to_slv(-0.32715902);
  o(1,5) := single_float_to_slv(-0.3284195);
  o(1,6) := single_float_to_slv(0.01457982);
  o(1,7) := single_float_to_slv(-0.21989729);
  o(2,0) := single_float_to_slv(0.4014409);
  o(2,1) := single_float_to_slv(-0.20964584);
  o(2,2) := single_float_to_slv(0.12663233);
  o(2,3) := single_float_to_slv(0.15928917);
  o(2,4) := single_float_to_slv(0.06926352);
  o(2,5) := single_float_to_slv(0.0872872);
  o(2,6) := single_float_to_slv(0.09628288);
  o(2,7) := single_float_to_slv(0.20289727);
  o(3,0) := single_float_to_slv(0.31969658);
  o(3,1) := single_float_to_slv(0.48952508);
  o(3,2) := single_float_to_slv(-0.06890938);
  o(3,3) := single_float_to_slv(0.04971746);
  o(3,4) := single_float_to_slv(0.4850268);
  o(3,5) := single_float_to_slv(0.77359366);
  o(3,6) := single_float_to_slv(0.04772833);
  o(3,7) := single_float_to_slv(0.00763122); 
  o(4,0) := single_float_to_slv(-0.21406649);
  o(4,1) := single_float_to_slv(0.3851055);
  o(4,2) := single_float_to_slv(0.06895181);
  o(4,3) := single_float_to_slv(-0.09096608);
  o(4,4) := single_float_to_slv(0.2268963);
  o(4,5) := single_float_to_slv(0.02800295);
  o(4,6) := single_float_to_slv(-0.26645523);
  o(4,7) := single_float_to_slv(0.09101521);
  o(5,0) := single_float_to_slv(-0.23577942);
  o(5,1) := single_float_to_slv(0.40463912);
  o(5,2) := single_float_to_slv(-0.02379321);
  o(5,3) := single_float_to_slv(0.12271876);
  o(5,4) := single_float_to_slv(0.20454015);
  o(5,5) := single_float_to_slv(0.3340834);
  o(5,6) := single_float_to_slv(0.20872128);
  o(5,7) := single_float_to_slv(0.23313737);
  o(6,0) := single_float_to_slv(0.36070636);
  o(6,1) := single_float_to_slv(-0.08882497);
  o(6,2) := single_float_to_slv(0.1167473);
  o(6,3) := single_float_to_slv(-0.09869172);
  o(6,4) := single_float_to_slv(0.3148002);
  o(6,5) := single_float_to_slv(0.41594255);
  o(6,6) := single_float_to_slv(-0.1424936);
  o(6,7) := single_float_to_slv(-0.13277136);
  o(7,0) := single_float_to_slv(-0.09099162);
  o(7,1) := single_float_to_slv(-0.14975166);
  o(7,2) := single_float_to_slv(0.14469796);
  o(7,3) := single_float_to_slv(-0.09419464);
  o(7,4) := single_float_to_slv(0.34336716);
  o(7,5) := single_float_to_slv(0.45454732);
  o(7,6) := single_float_to_slv(-0.19643505);
  o(7,7) := single_float_to_slv(0.19911067);
end function init_UO;

end neurals_utils;

********************************************************************************
* Rainer Kotschy and Uwe Sunde
*
* Can Education Compensate the Effect of Population Aging on Macroeconomic
* Performance? Evidence from Panel Data
*
* Replication Code: Figure 1
********************************************************************************



clear all
version 13.1
set more off, perm
macro drop _all
cd

use "ks_data_demo_5y.dta"



********************************************************************************
* Figure 1: Population Dynamics - Selected Regions
********************************************************************************
* Panel 1a: World and High Income Countries


	
#delimit ;


		// World;

	twoway

	bar my2010 Agegrp if Location == "World",
		horizontal xvarlab(Males)
	|| bar fy2010 Agegrp if Location == "World",
		horizontal xvarlab(Females)
	|| bar my1950 Agegrp if Location == "World",
		horizontal xvarlab(Males)
	|| bar fy1950 Agegrp if Location == "World",
		horizontal xvarlab(Females)
	|| scatter Agegrp zero if Location == "World",
		mlabel(Agegrp) mlabcolor(black) msymbol(i)
	|| , 
		xtitle("Population in millions", size(small))
		ytitle("")
		plotregion(style(none))
		ysca(noline) ylabel(none)
		xsca(noline titlegap(1.5))
		xlabel(-300 "300" -200 "200" -100 "100" 0(100)300,
			labsize(small) tlength(0) grid gmin gmax)
		legend(order(3 4 1 2)
			label(1 Males in 2010)
			label(2 Females in 2010)
			label(3 Males in 1950)
			label(4 Females in 1950) size(small))
		title("World" " ", size(medium))
		graphregion(color(white)) bgcolor(white)
		saving("pp_world.gph", replace)
	;
	

		// High-income countries;

	twoway
	
	bar my2010 Agegrp if Location == "High Income Countries",
		horizontal xvarlab(Males)
	|| bar fy2010 Agegrp if Location == "High Income Countries",
		horizontal xvarlab(Females)
	|| bar my1950 Agegrp if Location == "High Income Countries",
		horizontal xvarlab(Males)
	|| bar fy1950 Agegrp if Location == "High Income Countries",
		horizontal xvarlab(Females)
	|| scatter Agegrp zero if Location == "High Income Countries",
		mlabel(Agegrp) mlabcolor(black) msymbol(i)
	|| , 
		xtitle("Population in millions", size(small))
		ytitle("")
		plotregion(style(none))
		ysca(noline) ylabel(none)
		xsca(noline titlegap(1.5))
		xlabel(-40 "40" -30 "30" -20 "20" -10 "10" 0(10)40,
			labsize(small) tlength(0) grid gmin gmax)
		legend(order(3 4 1 2)
			label(1 Males in 2010)
			label(2 Females in 2010)
			label(3 Males in 1950)
			label(4 Females in 1950) size(small))
		title("High-Income Countries" " ", size(medium))
		graphregion(color(white)) bgcolor(white)
		saving("pp_high_income.gph", replace)
	;

	
		// Figure 1a: combined graph;
	
	// findit grc1leg;
	grc1leg "pp_world.gph" "pp_high_income.gph",
		legendfrom("pp_high_income.gph") graphregion(color(white))
	;
	
		
#delimit cr



********************************************************************************
* Panel 1b: Germany, United Kingdom, and France



#delimit ;


		// Germany;
		
	twoway

	bar my2010 Agegrp if Location == "Germany",
		horizontal xvarlab(Males)
	|| bar fy2010 Agegrp if Location == "Germany",
		horizontal xvarlab(Females)
	|| bar my1950 Agegrp if Location == "Germany",
		horizontal xvarlab(Males)
	|| bar fy1950 Agegrp if Location == "Germany",
		horizontal xvarlab(Females)
	|| scatter Agegrp zero if Location == "Germany",
		mlabel(Agegrp) mlabcolor(black) msymbol(i)
	|| , 
		xtitle("Population in millions", size(small))
		ytitle("")
		plotregion(style(none))
		ysca(noline) ylabel(none)
		xsca(noline titlegap(1.5))
		xlabel(-3 "3" -2 "2" -1 "1" 0(1)3,
			labsize(small) tlength(0) grid gmin gmax)
		legend(order(3 4 1 2)
			label(1 Males in 2010)
			label(2 Females in 2010)
			label(3 Males in 1950)
			label(4 Females in 1950) size(small))
		title("Germany" " ", size(medium))
		graphregion(color(white)) bgcolor(white)
		saving("pp_germany.gph", replace)
	;
	
	
		// United Kingdom;

	twoway

	bar my2010 Agegrp if Location == "United Kingdom",
		horizontal xvarlab(Males)
	|| bar fy2010 Agegrp if Location == "United Kingdom",
		horizontal xvarlab(Females)
	|| bar my1950 Agegrp if Location == "United Kingdom",
		horizontal xvarlab(Males)
	|| bar fy1950 Agegrp if Location == "United Kingdom",
		horizontal xvarlab(Females)
	|| scatter Agegrp zero if Location == "United Kingdom",
		mlabel(Agegrp) mlabcolor(black) msymbol(i)
	|| , 
		xtitle("Population in millions", size(small))
		ytitle("")
		plotregion(style(none))
		ysca(noline) ylabel(none)
		xsca(noline titlegap(1.5))
		xlabel(-2 "2" -1 "1" 0(1)2,
			labsize(small) tlength(0) grid gmin gmax)
		legend(order(3 4 1 2)
			label(1 Males in 2010)
			label(2 Females in 2010)
			label(3 Males in 1950)
			label(4 Females in 1950) size(small))
		title("United Kingdom" " ", size(medium))
		graphregion(color(white)) bgcolor(white)
		saving("pp_uk.gph", replace)
	;


		// France;

	twoway
	
	bar my2010 Agegrp if Location == "France",
		horizontal xvarlab(Males)
	|| bar fy2010 Agegrp if Location == "France",
		horizontal xvarlab(Females)
	|| bar my1950 Agegrp if Location == "France",
		horizontal xvarlab(Males)
	|| bar fy1950 Agegrp if Location == "France",
		horizontal xvarlab(Females)
	|| scatter Agegrp zero if Location == "France",
		mlabel(Agegrp) mlabcolor(black) msymbol(i)
	|| , 
		xtitle("Population in millions", size(small))
		ytitle("")
		plotregion(style(none))
		ysca(noline) ylabel(none)
		xsca(noline titlegap(1.5))
		xlabel(-2 "2" -1 "1" 0(1)2,
			labsize(small) tlength(0) grid gmin gmax)
		legend(order(3 4 1 2)
			label(1 Males in 2010)
			label(2 Females in 2010)
			label(3 Males in 1950)
			label(4 Females in 1950) size(small))
		title("France" " ", size(medium))
		graphregion(color(white)) bgcolor(white)
		saving("pp_france.gph", replace)
	;

	
		// Figure 1b: combined graph;
	
	// findit grc1leg;
	grc1leg "pp_germany.gph" "pp_uk.gph" "pp_france.gph",
		legendfrom("pp_germany.gph") cols(3) span graphregion(color(white))
	;

	
#delimit cr



********************************************************************************



clear all
exit



********************************************************************************
********************************************************************************
	

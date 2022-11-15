********************************************************************************
* Rainer Kotschy and Uwe Sunde
*
* Can Education Compensate the Effect of Population Aging on Macroeconomic
* Performance? Evidence from Panel Data
*
* Replication Code: Figure 4
********************************************************************************



clear all
version 13.1
set more off, perm
macro drop _all
cd

use "ks_data_text_5y.dta"
xtset id t



********************************************************************************
* Panels 4a, 4c, and 4e: Macro Productivity Profiles (Five-Year Periods)



/*

Macro descriptions:

y: log GDP per worker
k: log capital per worker
iiasa_hs: share of high-skilled individuals in the working-age population
iiasa_w5: share of cohort in working-age population (five-year cohorts)
un_w5: shifted share of cohort in working-age population (five-year cohorts)
td: time dummies
sample: if command for data in sample

*/



gl y "pwt_log_gdp_w"
gl k "pwt_log_kw"
gl iiasa_hs "iiasa_share_hs_15_69"
gl iv_hs "iiasa_share_hs_15_19 iiasa_share_hs_65_69"
gl iiasa_w5 "iiasa_w_15_19 iiasa_w_20_24 iiasa_w_25_29 iiasa_w_30_34 iiasa_w_35_39 iiasa_w_40_44 iiasa_w_45_49 iiasa_w_55_59 iiasa_w_60_64 iiasa_w_65_69"
gl un_w5 "un_w_10_14 un_w_15_19 un_w_20_24 un_w_25_29 un_w_30_34 un_w_35_39 un_w_40_44 un_w_50_54 un_w_55_59 un_w_60_64"
gl td "td1960 td1965 td1970 td1975 td1980 td1985 td1990 td1995 td2000 td2005 td2010"
gl sample "if sample_iiasa == 1"



********************************************************************************
* Panels 4a, 4c, and 4e: Macro Productivity Profiles (Five-Year Periods)



// findit parmest


preserve


	#delimit ;


			// Plot Estimates;
			

		xtreg $y L.($y) $k $iiasa_w5 $iiasa_hs $td $sample, fe cl(id);
			 

		parmest, format(estimate min95 max95 %8.2f p %8.1e)
			list(parm estimate min95 max95 p, clean) norestore;
			
			replace parm = "LY" if parm == "L.pwt_log_gdp_w";
			replace parm = "KW" if parm == "pwt_log_kw";
			replace parm = "w_15_19" if parm == "iiasa_w_15_19";
			replace parm = "w_20_24" if parm == "iiasa_w_20_24";
			replace parm = "w_25_29" if parm == "iiasa_w_25_29";
			replace parm = "w_30_34" if parm == "iiasa_w_30_34";
			replace parm = "w_35_39" if parm == "iiasa_w_35_39";
			replace parm = "w_40_44" if parm == "iiasa_w_40_44";
			replace parm = "w_45_49" if parm == "iiasa_w_45_49";
			replace parm = "w_55_59" if parm == "iiasa_w_55_59";
			replace parm = "w_60_64" if parm == "iiasa_w_60_64";
			replace parm = "w_65_69" if parm == "iiasa_w_65_69";
			replace parm = "hs_15_69" if parm == "iiasa_share_hs_15_69";
			replace parm = "constant" if parm == "_cons";

			
			
			// Add Additional Line for Reference Group;
			
			
		set obs 26;
		replace parm = "reference" in 26;
		replace estimate = 0 in 26;


			
		egen axis = axis(parm);
			replace axis =.;
			replace axis = 1 if parm == "w_15_19";
			replace axis = 2 if parm == "w_20_24";
			replace axis = 3 if parm == "w_25_29";
			replace axis = 4 if parm == "w_30_34";
			replace axis = 5 if parm == "w_35_39";
			replace axis = 6 if parm == "w_40_44";		
			replace axis = 7 if parm == "w_45_49";		
			replace axis = 8 if parm == "reference";
			replace axis = 9 if parm == "w_55_59";
			replace axis = 10 if parm == "w_60_64";
			replace axis = 11 if parm == "w_65_69";
			
			
		sort axis;
		list, noo nod nol;



		twoway
		scatter estim axis if !missing(axis),
			msymbol(O) mcolor(black)
		|| rcap min95 max95 axis if !missing(axis),
			vertical lcolor(black)
			ylabel(-8 (2) 2, format(%3.0f) angle(0))
			xlabel(1 "<20" 2 "20-24" 3 "25-29" 4 "30-34" 5 "35-39" 6 "40-44"
				   7 "45-49" 8 "50-54" 9 "55-59" 10 "60-64" 11 "65-69",
				   angle(45))
			title("Levels Model" " ", position(12) size(medlarge))
			ytitle("Size of estimated coefficient (95%-CI)" " ", size(medium))
			xtitle(" " "Age cohort", size(medium))
			yline(0, lcolor(black) lpattern(dash))
			graphregion(color(white)) bgcolor(white)
			legend(off)
		|| line estim axis if !missing(axis),
			lcolor(green) lpattern(solid) lwidth(thick)
		;


	#delimit cr

	
	save "ks_figure_4_data_pp_5y.dta", replace


restore



use "ks_figure_4_data_demo_5y.dta", clear
append using "ks_figure_4_data_pp_5y.dta"



********************************************************************************
* Panel 4a: Germany (Five-Year Periods)


	
#delimit ;


	twoway

	bar ty2030 pid if Location == "Germany" & pid <= 11,
		vertical xvarlab(Males)
		lcolor(cranberry) lwidth(medium) fcolor(none)
	|| bar ty2000 pid if Location == "Germany" & pid <= 11,
		vertical xvarlab(Males)
		lcolor(navy) lwidth(thick) fcolor(none)
	|| scatter estim axis if !missing(axis),
		yaxis(2) msymbol(O) mcolor(black)
	|| rcap min95 max95 axis if !missing(axis),
		yaxis(2) vertical lcolor(black)
		ysca(noline)
		ylabel(-8 (2) 2, valuelabel angle(0) axis(2) format(%9.1g) noticks)
	|| line estim axis if !missing(axis),
		yaxis(2) lcolor(green) lpattern(solid) lwidth(thick)
		ytitle("Relative productivity (95%-CI)", size(small) axis(2))
	|| scatter zero pid if Location == "Germany" & pid <= 11,
		msymbol(none)
	|| , 
		xtitle(" ", size(small))
		ytitle("Cohort size (in millions)", size(small))
		plotregion(style(none))
		ysca(noline axis(2))
		ylabel(0 (2) 8, angle(0) axis(1) noticks)
		yline(0, lcolor(black) lpattern(dash) axis(2))
		xsca(noline titlegap(1.5))
		xlabel(1 "15-19" 2 "20-24" 3 "25-29" 4 "30-34" 5 "35-39" 6 "40-44"
			   7 "45-49" 8 "50-54" 9 "55-59" 10 "60-64" 11 "65-69",
			   angle(45) noticks)
		legend(order(2 1)
			label(1 Population in 2030)
			label(2 Population in 2000) size(small))
		title("Germany" " ", size(medsmall))
		graphregion(color(white)) bgcolor(white)
	;	


#delimit cr



********************************************************************************
* Panel 4c: United Kingdom (Five-Year Periods)


	
#delimit ;


	twoway

	bar ty2030 pid if Location == "United Kingdom" & pid <= 11,
		vertical xvarlab(Males)
		lcolor(cranberry) lwidth(medium) fcolor(none)
	|| bar ty2000 pid if Location == "United Kingdom" & pid <= 11,
		vertical xvarlab(Males)
		lcolor(navy) lwidth(thick) fcolor(none)
	|| scatter estim axis if !missing(axis),
		yaxis(2) msymbol(O) mcolor(black)
	|| rcap min95 max95 axis if !missing(axis),
		yaxis(2) vertical lcolor(black)
		ysca(noline)
		ylabel(-8 (2) 2, valuelabel angle(0) axis(2) format(%9.1g) noticks)
	|| line estim axis if !missing(axis),
		yaxis(2) lcolor(green) lpattern(solid) lwidth(thick)
		ytitle("Relative productivity (95%-CI)", size(small) axis(2))
	|| scatter zero pid if Location == "United Kingdom" & pid <= 11,
		msymbol(none)
	|| , 
		xtitle(" ", size(small))
		ytitle("Cohort size (in millions)", size(small))
		plotregion(style(none))
		ysca(noline axis(2))
		ylabel(0 (2) 6, angle(0) axis(1) noticks)
		yline(0, lcolor(black) lpattern(dash) axis(2))
		xsca(noline titlegap(1.5))
		xlabel(1 "15-19" 2 "20-24" 3 "25-29" 4 "30-34" 5 "35-39" 6 "40-44"
			   7 "45-49" 8 "50-54" 9 "55-59" 10 "60-64" 11 "65-69",
			   angle(45) noticks)
		legend(order(2 1)
			label(1 Population in 2030)
			label(2 Population in 2000) size(small))
		title("United Kingdom" " ", size(medsmall))
		graphregion(color(white)) bgcolor(white)
	;


#delimit cr



********************************************************************************
* Panel 4e: France (Five-Year Periods)



#delimit ;


	twoway

	bar ty2030 pid if Location == "France" & pid <= 11,
		vertical xvarlab(Males)
		lcolor(cranberry) lwidth(medium) fcolor(none)
	|| bar ty2000 pid if Location == "France" & pid <= 11,
		vertical xvarlab(Males)
		lcolor(navy) lwidth(thick) fcolor(none)
	|| scatter estim axis if !missing(axis),
		yaxis(2) msymbol(O) mcolor(black)
	|| rcap min95 max95 axis if !missing(axis),
		yaxis(2) vertical lcolor(black)
		ysca(noline)
		ylabel(-8 (2) 2, valuelabel angle(0) axis(2) format(%9.1g) noticks)
	|| line estim axis if !missing(axis),
		yaxis(2) lcolor(green) lpattern(solid) lwidth(thick)
		ytitle("Relative productivity (95%-CI)", size(small) axis(2))
	|| scatter zero pid if Location == "France" & pid <= 11,
		msymbol(none)
	|| , 
		xtitle(" ", size(small))
		ytitle("Cohort size (in millions)", size(small))
		plotregion(style(none))
		ysca(noline axis(2))
		ylabel(0 (1) 6, angle(0) axis(1) noticks)
		yline(0, lcolor(black) lpattern(dash) axis(2))
		xsca(noline titlegap(1.5))
		xlabel(1 "15-19" 2 "20-24" 3 "25-29" 4 "30-34" 5 "35-39" 6 "40-44"
			   7 "45-49" 8 "50-54" 9 "55-59" 10 "60-64" 11 "65-69",
			   angle(45) noticks)
		legend(order(2 1)
			label(1 Population in 2030)
			label(2 Population in 2000) size(small))
		title("France" " ", size(medsmall))
		graphregion(color(white)) bgcolor(white)
	;	


#delimit cr



********************************************************************************



clear all
version 13.1
set more off, perm
macro drop _all
cd

use "ks_data_text_10y.dta"
xtset id t



********************************************************************************
* Panels 4b, 4d, and 4f: Macro Productivity Profiles (Ten-Year Periods)



/*

Macro descriptions:

y: log GDP per worker
k: log capital per worker
iiasa_hs: share of high-skilled individuals in the working-age population
iiasa_w: share of cohort in working-age population (ten-year cohorts)
un_w: shifted share of cohort in working-age population (ten-year cohorts)
td: time dummies
sample: if command for data in sample

*/



gl y "pwt_log_gdp_w"
gl k "pwt_log_kw"
gl iiasa_hs "iiasa_share_hs_15_69"
gl iv_hs "iiasa_share_hs_15_19 iiasa_share_hs_60_69"
gl iiasa_w "iiasa_w_15_19 iiasa_w_20_29 iiasa_w_30_39 iiasa_w_40_49 iiasa_w_60_69"
gl un_w "un_w_5_9 un_w_10_19 un_w_20_29 un_w_30_39 un_w_40_49 un_w_60_69"
gl td "td1970 td1980 td1990 td2000 td2010"
gl sample "if sample_iiasa == 1"



********************************************************************************
* Panels 4a, 4c, and 4e: Macro Productivity Profiles (Five-Year Periods)



// findit parmest


preserve


	#delimit ;


			// Plot Estimates;
			

		xtreg $y L.($y) $k $iiasa_w $iiasa_hs $td $sample, fe cl(id);
			 

		parmest, format(estimate min95 max95 %8.2f p %8.1e)
			list(parm estimate min95 max95 p, clean) norestore;
			
			replace parm = "LY" if parm == "L.pwt_log_gdp_w";
			replace parm = "KW" if parm == "pwt_log_kw";
			replace parm = "w_15_19" if parm == "iiasa_w_15_19";
			replace parm = "w_20_29" if parm == "iiasa_w_20_29";
			replace parm = "w_30_39" if parm == "iiasa_w_30_39";
			replace parm = "w_40_49" if parm == "iiasa_w_40_49";
			replace parm = "w_60_69" if parm == "iiasa_w_60_69";
			replace parm = "hs_15_69" if parm == "iiasa_share_hs_15_69";
			replace parm = "constant" if parm == "_cons";

			
			
			// Add Additional Line for Reference Group;
		
		
		set obs 15;
		replace parm = "reference" in 15;
		replace estimate = 0 in 15;


			
		egen axis = axis(parm);
			replace axis =.;
			replace axis = 1 if parm == "w_15_19";
			replace axis = 2 if parm == "w_20_29";
			replace axis = 3 if parm == "w_30_39";
			replace axis = 4 if parm == "w_40_49";
			replace axis = 5 if parm == "reference";
			replace axis = 6 if parm == "w_60_69";
			
			
		sort axis;
		list, noo nod nol;



		twoway
		scatter estim axis if !missing(axis),
			msymbol(O) mcolor(black)
		|| rcap min95 max95 axis if !missing(axis),
			vertical lcolor(black)
			ylabel(-8 (2) 2, format(%3.0f) angle(0))
			xlabel(1 "<20" 2 "20-29" 3 "30-39" 4 "40-49" 5 "50-59" 6 "60-69")
			title("Levels Model" " ", position(12) size(medlarge))
			ytitle("Size of estimated coefficient (95%-CI)" " ", size(medium))
			xtitle(" " "Age cohort", size(medium))
			yline(0, lcolor(black) lpattern(dash))
			graphregion(color(white)) bgcolor(white)
			legend(off)
		|| line estim axis if !missing(axis),
			lcolor(green) lpattern(solid) lwidth(thick)
		;
		

	#delimit cr
	
		
	save "ks_figure_4_data_pp_10y.dta", replace


restore



use "ks_figure_4_data_demo_10y.dta", clear
append using "ks_figure_4_data_pp_10y.dta"


	
********************************************************************************
* Panels 4b: Germany (Ten-Year Periods)


	
#delimit ;


	twoway


	bar ty2030 pid if Location == "Germany" & !missing(pid),
		vertical xvarlab(Males)
		lcolor(cranberry) lwidth(medium) fcolor(none)
	|| bar ty2000 pid if Location == "Germany" & !missing(pid),
		vertical xvarlab(Males)
		lcolor(navy) lwidth(thick) fcolor(none)
	|| scatter estim axis if !missing(axis),
		yaxis(2) msymbol(O) mcolor(black)
	|| rcap min95 max95 axis if !missing(axis),
		yaxis(2) vertical lcolor(black)
		ysca(noline)
		ylabel(-8 (2) 2, valuelabel angle(0) axis(2) format(%9.1g) noticks)
	|| line estim axis if !missing(axis),
		yaxis(2) lcolor(green) lpattern(solid) lwidth(thick)
		ytitle("Relative productivity (95%-CI)", size(small) axis(2))
	|| scatter zero pid if Location == "Germany" & !missing(pid),
		msymbol(none)
	|| , 
		xtitle(" ", size(small))
		ytitle("Cohort size (in millions)", size(small))
		plotregion(style(none))
		ysca(noline axis(2))
		ylabel(0 (3) 15, angle(0) axis(1) noticks)
		yline(0, lcolor(black) lpattern(dash) axis(2))
		xsca(noline titlegap(1.5))
		xlabel(1 "15-19" 2 "20-29" 3 "30-39" 4 "40-49" 5 "50-59" 6 "60-69",
			angle(45) noticks)
		legend(order(2 1)
			label(1 Population in 2030)
			label(2 Population in 2000) size(small))
		title("Germany" " ", size(medsmall))
		graphregion(color(white)) bgcolor(white)
	;	


#delimit cr



********************************************************************************
* Panels 4d: United Kingdom (Ten-Year Periods)


	
#delimit ;


	twoway


	bar ty2030 pid if Location == "United Kingdom" & !missing(pid),
		vertical xvarlab(Males)
		lcolor(cranberry) lwidth(medium) fcolor(none)
	|| bar ty2000 pid if Location == "United Kingdom" & !missing(pid),
		vertical xvarlab(Males)
		lcolor(navy) lwidth(thick) fcolor(none)
	|| scatter estim axis if !missing(axis),
		yaxis(2) msymbol(O) mcolor(black)
	|| rcap min95 max95 axis if !missing(axis),
		yaxis(2) vertical lcolor(black)
		ysca(noline)
		ylabel(-8 (2) 2, valuelabel angle(0) axis(2) format(%9.1g) noticks)
	|| line estim axis if !missing(axis),
		yaxis(2) lcolor(green) lpattern(solid) lwidth(thick)
		ytitle("Relative productivity (95%-CI)", size(small) axis(2))
	|| scatter zero pid if Location == "United Kingdom" & !missing(pid),
		msymbol(none)
	|| , 
		xtitle(" ", size(small))
		ytitle("Cohort size (in millions)", size(small))
		plotregion(style(none))
		ysca(noline axis(2))
		ylabel(0 (3) 12, angle(0) axis(1) noticks)
		yline(0, lcolor(black) lpattern(dash) axis(2))
		xsca(noline titlegap(1.5))
		xlabel(1 "15-19" 2 "20-29" 3 "30-39" 4 "40-49" 5 "50-59" 6 "60-69",
			angle(45) noticks)
		legend(order(2 1)
			label(1 Population in 2030)
			label(2 Population in 2000) size(small))
		title("United Kingdom" " ", size(medsmall))
		graphregion(color(white)) bgcolor(white)
	;	
	

#delimit cr



********************************************************************************
* Panels 4f: France (Ten-Year Periods)



#delimit ;


	twoway


	bar ty2030 pid if Location == "France" & !missing(pid),
		vertical xvarlab(Males)
		lcolor(cranberry) lwidth(medium) fcolor(none)
	|| bar ty2000 pid if Location == "France" & !missing(pid),
		vertical xvarlab(Males)
		lcolor(navy) lwidth(thick) fcolor(none)
	|| scatter estim axis if !missing(axis),
		yaxis(2) msymbol(O) mcolor(black)
	|| rcap min95 max95 axis if !missing(axis),
		yaxis(2) vertical lcolor(black)
		ysca(noline)
		ylabel(-8 (2) 2, valuelabel angle(0) axis(2) format(%9.1g) noticks)
	|| line estim axis if !missing(axis),
		yaxis(2) lcolor(green) lpattern(solid) lwidth(thick)
		ytitle("Relative productivity (95%-CI)", size(small) axis(2))
	|| scatter zero pid if Location == "France" & !missing(pid),
		msymbol(none)
	|| , 
		xtitle(" ", size(small))
		ytitle("Cohort size (in millions)", size(small))
		plotregion(style(none))
		ysca(noline axis(2))
		ylabel(0 (3) 12, angle(0) axis(1) noticks)
		yline(0, lcolor(black) lpattern(dash) axis(2))
		xsca(noline titlegap(1.5))
		xlabel(1 "15-19" 2 "20-29" 3 "30-39" 4 "40-49" 5 "50-59" 6 "60-69",
			angle(45) noticks)
		legend(order(2 1)
			label(1 Population in 2030)
			label(2 Population in 2000) size(small))
		title("France" " ", size(medsmall))
		graphregion(color(white)) bgcolor(white)
	;	
	

#delimit cr



********************************************************************************



clear all
exit



********************************************************************************
********************************************************************************

********************************************************************************
* Rainer Kotschy and Uwe Sunde
*
* Can Education Compensate the Effect of Population Aging on Macroeconomic
* Performance? Evidence from Panel Data
*
* Replication Code: Figures 5, 6, and 7
********************************************************************************



clear all
version 13.1
set more off, perm
macro drop _all
cd

use "ks_data_text_5y.dta"
append using "ks_data_jpn_star.dta"
xtset id t



********************************************************************************
* Figures 5, 6, and 7: Projections Under Different Scenarios



/*

Macro descriptions:

y: log GDP per worker
k: log capital per worker
iiasa_hs: share of high-skilled individuals in the working-age population
iiasa_w5: share of cohort in working-age population (five-year cohorts)
td: time dummies
sample: if command for data in sample

*/



gl y "pwt_log_gdp_w"
gl k "pwt_log_kw"
gl iiasa_hs "iiasa_share_hs_15_69"
gl iiasa_w5 "iiasa_w_15_19 iiasa_w_20_24 iiasa_w_25_29 iiasa_w_30_34 iiasa_w_35_39 iiasa_w_40_44 iiasa_w_45_49 iiasa_w_55_59 iiasa_w_60_64 iiasa_w_65_69"
gl td "td1960 td1965 td1970 td1975 td1980 td1985 td1990 td1995 td2000 td2005 td2010"
gl sample "if sample_iiasa == 1"



********************************************************************************
* Projections: Preparations



/* 


		// Extrapolate the evolution of the capital stock:
		
	
	1. Take the first and last observation for each country in the estimation
	sample and compute the five-year capital growth trend.
	
	2. Compute the predicted value of k in t+5 as k in t plus the
	country-specific growth trend in the capital stock.
	
	
		// Construct counterfactual scenarios
		
	
	3. Fixate demographic structure at the level of 2010.
	
	4. Fixate human capital at the level of 2010.
	
	
		// Create empty variables for projections
		
		
	5. Empty variables for general projections (Ly),
	fixed demographic structure (Ly2), fixed human capital (Ly3)
	and both, fixed demographic structure and fixed human capital (Ly4)


*/
	
	
	
	// 1.

bysort id: egen k_l = lastnm(pwt_log_kw) if sample_iiasa == 1
bysort id: egen k_f = first(pwt_log_kw) if sample_iiasa == 1
bysort id: egen k_c = count(pwt_log_kw) if sample_iiasa == 1

g k_t = (k_l - k_f)/k_c if !missing(k_l) & sample_iiasa == 1



	// 2.

forvalues x = 14(1)21	{

	loc y = `x' - 13

	replace pwt_log_kw = L.pwt_log_kw + L`y'.k_t if t == `x' & !missing(L`y'.k_t)

}



	// 3.

loc y "15_19 20_24 25_29 30_34 35_39 40_44 45_49 50_54 55_59 60_64 65_69"

foreach	x of local y	{

	bysort id: g iiasa_w_`x'_2010 = iiasa_w_`x' if year == 2010
	replace iiasa_w_`x'_2010 = L2.iiasa_w_`x' if year == 2010 & wb_code == "JPN2"
	bysort id: egen iiasa_w_`x'_const = mean(iiasa_w_`x'_2010)
	
	g iiasa_w_`x'_demo2010 = iiasa_w_`x' if year <= 2010
	replace iiasa_w_`x'_demo2010 = iiasa_w_`x'_const if year >= 2015
	drop iiasa_w_`x'_2010 iiasa_w_`x'_const
	
}



	// 4.

bysort id: g iiasa_share_hs_15_69_2010 = iiasa_share_hs_15_69 if year == 2010
replace iiasa_share_hs_15_69_2010 = L2.iiasa_share_hs_15_69 if year == 2010 & wb_code == "JPN2"
bysort id: egen iiasa_share_hs_15_69_const = mean(iiasa_share_hs_15_69_2010)

g iiasa_share_hs2010 = iiasa_share_hs_15_69 if year <= 2010
replace iiasa_share_hs2010 = iiasa_share_hs_15_69_const if year >= 2015
drop iiasa_share_hs_15_69_2010 iiasa_share_hs_15_69_const



	// 5.

g Ly =.
g Ly2 =.
g Ly3 =.
g Ly4 =.

g y_demo_const = $y if year <= 2010
gl y2 = "y_demo_const"

g y_hs_const = $y if year <= 2010
gl y3 = "y_hs_const"

g y_all_const = $y if year <= 2010
gl y4 = "y_all_const"



********************************************************************************
* Projections: Baseline Model (Table 1, Column 3)



xtreg $y L.($y) $k $iiasa_w5 $iiasa_hs $td $sample & wb_code != "JPN2", fe cl(id)

	mat b = e(b)	
	mat list b

	gl trend = ///
		( b[1,14] + b[1,15] + b[1,16] + b[1,17] + b[1,18] + b[1,19] + ///
		  b[1,20] + b[1,21] + b[1,22] + b[1,23] + b[1,24] ) / 11
	  


forvalues x = 14(1)21	{


		// General projection

	replace Ly = b[1,25] + $trend + b[1,1]*L.$y + b[1,2]*$k ///
		+ b[1,3]*iiasa_w_15_19 + b[1,4]*iiasa_w_20_24 ///
		+ b[1,5]*iiasa_w_25_29 + b[1,6]*iiasa_w_30_34 ///
		+ b[1,7]*iiasa_w_35_39 + b[1,8]*iiasa_w_40_44 ///
		+ b[1,9]*iiasa_w_45_49 + b[1,10]*iiasa_w_55_59 ///
		+ b[1,11]*iiasa_w_60_64 + b[1,12]*iiasa_w_65_69 ///
		+ b[1,13]*iiasa_share_hs_15_69 ///
			if t == `x'
	
	replace $y = Ly if t == `x' & !missing(Ly)
	
	
		// Fixed demographic structure

	replace Ly2 = b[1,25] + $trend + b[1,1]*L.$y2 + b[1,2]*$k ///
		+ b[1,3]*iiasa_w_15_19_demo2010 + b[1,4]*iiasa_w_20_24_demo2010 ///
		+ b[1,5]*iiasa_w_25_29_demo2010 + b[1,6]*iiasa_w_30_34_demo2010 ///
		+ b[1,7]*iiasa_w_35_39_demo2010 + b[1,8]*iiasa_w_40_44_demo2010 ///
		+ b[1,9]*iiasa_w_45_49_demo2010 + b[1,10]*iiasa_w_55_59_demo2010 ///
		+ b[1,11]*iiasa_w_60_64_demo2010 + b[1,12]*iiasa_w_65_69_demo2010 ///
		+ b[1,13]*iiasa_share_hs_15_69 ///
			if t == `x'			
	
	replace $y2 = Ly2 if t == `x' & !missing(Ly2)
	
	
		// Fixed human capital

	replace Ly3 = b[1,25] + $trend + b[1,1]*L.$y3 + b[1,2]*$k ///
		+ b[1,3]*iiasa_w_15_19 + b[1,4]*iiasa_w_20_24 ///
		+ b[1,5]*iiasa_w_25_29 + b[1,6]*iiasa_w_30_34 ///
		+ b[1,7]*iiasa_w_35_39 + b[1,8]*iiasa_w_40_44 ///
		+ b[1,9]*iiasa_w_45_49 + b[1,10]*iiasa_w_55_59 ///
		+ b[1,11]*iiasa_w_60_64 + b[1,12]*iiasa_w_65_69 ///
		+ b[1,13]*iiasa_share_hs2010 ///
			if t == `x'
	
	replace $y3 = Ly3 if t == `x' & !missing(Ly3)
	
	
		// Fixed demographic structure and human capital

	replace Ly4 = b[1,25] + $trend + b[1,1]*L.$y4 + b[1,2]*$k ///
		+ b[1,3]*iiasa_w_15_19_demo2010 + b[1,4]*iiasa_w_20_24_demo2010 ///
		+ b[1,5]*iiasa_w_25_29_demo2010 + b[1,6]*iiasa_w_30_34_demo2010 ///
		+ b[1,7]*iiasa_w_35_39_demo2010 + b[1,8]*iiasa_w_40_44_demo2010 ///
		+ b[1,9]*iiasa_w_45_49_demo2010 + b[1,10]*iiasa_w_55_59_demo2010 ///
		+ b[1,11]*iiasa_w_60_64_demo2010 + b[1,12]*iiasa_w_65_69_demo2010 ///
		+ b[1,13]*iiasa_share_hs2010 ///
			if t == `x'
	
	replace $y4 = Ly4 if t == `x' & !missing(Ly4)


}



********************************************************************************
* Figure 5: Projections for Selected Countries

	

#delimit ;


		// Figure 5a, left panel: Germany;

	line $y year if wb_code == "DEU" & year <= 2010,
		title("Germany" " ", size(medsmall))
		ytitle("Log GDP per worker" " ", size(medsmall))
		ylabel(, angle(0))
		xtitle(" " "Year", size(medsmall))
		xlabel(1950 (20) 2050, valuelabel angle(0))
		xline(2010, lcolor(black) lpattern(dash))
		lcolor(navy)
		graphregion(color(white)) bgcolor(white)
		legend(order(1 2 3 4) rows(3) cols(2)
			label(1 "Data 1950-2010")
			label(2 "Projection 2010-2050") 
			label(3 "Constant demographic structure")
			label(4 "Constant human capital")
			size(vsmall) bmargin(medium) span)
	|| line $y year if wb_code == "DEU" & year >= 2010,
		lcolor(cranberry) lpattern(longdash)
	|| line $y2 year if wb_code == "DEU" & year >= 2010,
		lcolor(forest_green) lpattern(dash)
	|| line $y3 year if wb_code == "DEU" & year >= 2010,
		lcolor(purple) lpattern(dash_dot)
		saving("pj_germany_5a.gph", replace)
	;
	
	
		// Figure 5b, left panel: Germany;

	line $y year if wb_code == "DEU" & year <= 2010,
		title("Germany" " ", size(medsmall))
		ytitle("Log GDP per worker" " ", size(medsmall))
		ylabel(, angle(0))
		xtitle(" " "Year", size(medsmall))
		xlabel(1950 (20) 2050, valuelabel angle(0))
		xline(2010, lcolor(black) lpattern(dash))
		lcolor(navy)
		graphregion(color(white)) bgcolor(white)
		legend(order(1 2 3) rows(2) cols(2)
			label(1 "Data 1950-2010")
			label(2 "Projection 2010-2050") 
			label(3 "Constant demographic structure and human capital")
			size(vsmall) bmargin(medium) span)
	|| line $y year if wb_code == "DEU" & year >= 2010,
		lcolor(cranberry) lpattern(longdash)
	|| line $y4 year if wb_code == "DEU" & year >= 2010,
		lcolor(black) lpattern(dash)
		saving("pj_germany_5b.gph", replace)
	;
	
	
		// Figure 5a, center panel: United Kingdom;
		
	line $y year if wb_code == "GBR" & year <= 2010,
		title("United Kingdom" " ", size(medsmall))
		ytitle("", size(medsmall))
		ylabel(, angle(0))
		xtitle(" " "Year", size(medsmall))
		xlabel(1950 (20) 2050, valuelabel angle(0))
		xline(2010, lcolor(black) lpattern(dash))
		lcolor(navy)
		graphregion(color(white)) bgcolor(white)
		legend(order(1 2 3 4) rows(3) cols(2)
			label(1 "Data 1950-2010")
			label(2 "Projection 2010-2050") 
			label(3 "Constant demographic structure")
			label(4 "Constant human capital")
			size(small) bmargin(medium) span)
	|| line $y year if wb_code == "GBR" & year >= 2010,
		lcolor(cranberry) lpattern(longdash)
	|| line $y2 year if wb_code == "GBR" & year >= 2010,
		lcolor(forest_green) lpattern(dash)
	|| line $y3 year if wb_code == "GBR" & year >= 2010,
		lcolor(purple) lpattern(dash_dot)
		saving("pj_uk_5a.gph", replace)
	;
	
	
		// Figure 5b, center panel: United Kingdom;	

	line $y year if wb_code == "GBR" & year <= 2010,
		title("United Kingdom" " ", size(medsmall))
		ytitle("", size(medsmall))
		ylabel(, angle(0))
		xtitle(" " "Year", size(medsmall))
		xlabel(1950 (20) 2050, valuelabel angle(0))
		xline(2010, lcolor(black) lpattern(dash))
		lcolor(navy)
		graphregion(color(white)) bgcolor(white)
		legend(order(1 2 3) rows(2) cols(2)
			label(1 "Data 1950-2010")
			label(2 "Projection 2010-2050") 
			label(3 "Constant demographic structure and human capital")
			size(small) bmargin(medium) span)
	|| line $y year if wb_code == "GBR" & year >= 2010,
		lcolor(cranberry) lpattern(longdash)
	|| line $y4 year if wb_code == "GBR" & year >= 2010,
		lcolor(black) lpattern(dash)
		saving("pj_uk_5b.gph", replace)
	;


		// Figure 5a, right panel: France;
		
	line $y year if wb_code == "FRA" & year <= 2010,
		title("France" " ", size(medsmall))
		ytitle("", size(medsmall))
		ylabel(, angle(0))
		xtitle(" " "Year", size(medsmall))
		xlabel(1950 (20) 2050, valuelabel angle(0))
		xline(2010, lcolor(black) lpattern(dash))
		lcolor(navy)
		graphregion(color(white)) bgcolor(white)
		legend(order(1 2 3 4) rows(2) cols(2)
			label(1 "Data 1950-2010")
			label(2 "Projection 2010-2050") 
			label(3 "Constant demographic structure")
			label(4 "Constant human capital")
			size(small) bmargin(medium) span)
	|| line $y year if wb_code == "FRA" & year >= 2010,
		lcolor(cranberry) lpattern(longdash)
	|| line $y2 year if wb_code == "FRA" & year >= 2010,
		lcolor(forest_green) lpattern(dash)
	|| line $y3 year if wb_code == "FRA" & year >= 2010,
		lcolor(purple) lpattern(dash_dot)
		saving("pj_france_5a.gph", replace)
	;
	
	
		// Figure 5b, right panel: France;
	
	line $y year if wb_code == "FRA" & year <= 2010,
		title("France" " ", size(medsmall))
		ytitle("", size(medsmall))
		ylabel(, angle(0))
		xtitle(" " "Year", size(medsmall))
		xlabel(1950 (20) 2050, valuelabel angle(0))
		xline(2010, lcolor(black) lpattern(dash))
		lcolor(navy)
		graphregion(color(white)) bgcolor(white)
		legend(order(1 2 3) rows(2) cols(2)
			label(1 "Data 1950-2010")
			label(2 "Projection 2010-2050") 
			label(3 "Constant demographic structure and human capital")
			size(small) bmargin(medium) span)
	|| line $y year if wb_code == "FRA" & year >= 2010,
		lcolor(cranberry) lpattern(longdash)
	|| line $y4 year if wb_code == "FRA" & year >= 2010,
		lcolor(black) lpattern(dash)
		saving("pj_france_5b.gph", replace)
	;


		// Figure 5a: combined graph;	

	// findit grc1leg;
	grc1leg "pj_germany_5a.gph" "pj_uk_5a.gph" "pj_france_5a.gph",
		legendfrom("pj_germany_5a.gph")
		ycommon xcommon cols(3) iscale(.6) span graphregion(color(white))
	;
		
		
		// Figure 5b: combined graph;
	
	grc1leg "pj_germany_5b.gph" "pj_uk_5b.gph" "pj_france_5b.gph",
		legendfrom("pj_germany_5b.gph")
		ycommon xcommon cols(3) iscale(.6) span graphregion(color(white))
	;


#delimit cr



********************************************************************************
* Figure 6: Projections for Selected Regions



preserve


	collapse $y $y2 $y3 $y4, by(oecd year)


	#delimit ;


			// Figure 6a, left panel: OECD;
			
		line $y year if oecd == 1 & year <= 2010,
			title("OECD" " ", size(medsmall))
			ytitle("Log GDP per worker" " ", size(medsmall))
			ylabel(, angle(0))
			xtitle(" " "Year", size(medsmall))
			xlabel(1950 (20) 2050, valuelabel angle(0))
			xline(2010, lcolor(black) lpattern(dash))
			lcolor(navy)
			graphregion(color(white)) bgcolor(white)
			legend(order(1 2 3 4) rows(2) cols(2)
				label(1 "Data 1950-2010")
				label(2 "Projection 2010-2050") 
				label(3 "Constant demographic structure")
				label(4 "Constant human capital")
			size(small) bmargin(medium) span)
		|| line $y year if oecd == 1 & year >= 2010,
			lcolor(cranberry) lpattern(longdash)
		|| line $y2 year if oecd == 1 & year >= 2010,
			lcolor(forest_green) lpattern(dash)
		|| line $y3 year if oecd == 1 & year >= 2010,
			lcolor(purple) lpattern(dash_dot)
			saving("pj_oecd_6a.gph", replace)
		;
		

			// Figure 6b, left panel: OECD;
		
		line $y year if oecd == 1 & year <= 2010,
			title("OECD" " ", size(medsmall))
			ytitle("Log GDP per worker" " ", size(medsmall))
			ylabel(, angle(0))
			xtitle(" " "Year", size(medsmall))
			xlabel(1950 (20) 2050, valuelabel angle(0))
			xline(2010, lcolor(black) lpattern(dash))
			lcolor(navy)
			graphregion(color(white)) bgcolor(white)
			legend(order(1 2 3) rows(2) cols(2)
				label(1 "Data 1950-2010")
				label(2 "Projection 2010-2050") 
				label(3 "Constant demographic structure and human capital")
				size(small) bmargin(medium) span)
		|| line $y year if oecd == 1 & year >= 2010,
			lcolor(cranberry) lpattern(longdash)
		|| line $y4 year if oecd == 1 & year >= 2010,
			lcolor(black) lpattern(dash)
			saving("pj_oecd_6b.gph", replace)
		;

		
			// Figure 6a, right panel: Non-OECD;
			
		line $y year if oecd == 0 & year <= 2010,
			title("Non-OECD" " ", size(medsmall))
			ytitle("", size(medsmall))
			ylabel(, angle(0))
			xtitle(" " "Year", size(medsmall))
			xlabel(1950 (20) 2050, valuelabel angle(0))
			xline(2010, lcolor(black) lpattern(dash))
			lcolor(navy)
			graphregion(color(white)) bgcolor(white)
			legend(order(1 2 3 4) rows(2) cols(2)
				label(1 "Data 1950-2010")
				label(2 "Projection 2010-2050") 
				label(3 "Constant demographic structure")
				label(4 "Constant human capital")
				size(small) bmargin(medium) span)
		|| line $y year if oecd == 0 & year >= 2010,
			lcolor(cranberry) lpattern(longdash)
		|| line $y2 year if oecd == 0 & year >= 2010,
			lcolor(forest_green) lpattern(dash)
		|| line $y3 year if oecd == 0 & year >= 2010,
			lcolor(purple) lpattern(dash_dot)
			saving("pj_nonoecd_6a.gph", replace)
		;
		
		
			// Figure 6b, right panel: Non-OECD;
		
		line $y year if oecd == 0 & year <= 2010,
			title("Non-OECD" " ", size(medsmall))
			ytitle("", size(medsmall))
			ylabel(, angle(0))
			xtitle(" " "Year", size(medsmall))
			xlabel(1950 (20) 2050, valuelabel angle(0))
			xline(2010, lcolor(black) lpattern(dash))
			lcolor(navy)
			graphregion(color(white)) bgcolor(white)
			legend(order(1 2 3 4) rows(2) cols(2)
				label(1 "Data 1950-2010")
				label(2 "Projection 2010-2050") 
				label(3 "Constant demographic structure and human capital")
				size(small) bmargin(medium) span)
		|| line $y year if oecd == 0 & year >= 2010,
			lcolor(cranberry) lpattern(longdash)
		|| line $y4 year if oecd == 0 & year >= 2010,
			lcolor(black) lpattern(dash)
			saving("pj_nonoecd_6b.gph", replace)
		;

		
			// Figure 6a: combined graph;
	
		// findit grc1leg;
		grc1leg "pj_oecd_6a.gph" "pj_nonoecd_6a.gph", legendfrom("pj_oecd_6a.gph")
			ycommon xcommon span graphregion(color(white))
		;
		

			// Figure 6b: combined graph;
		
		grc1leg "pj_oecd_6b.gph" "pj_nonoecd_6b.gph", legendfrom("pj_oecd_6b.gph")
			ycommon xcommon span graphregion(color(white))
		;

		
	#delimit cr


restore



********************************************************************************
* Figure 7: Projections for Selected Regions



	// Figure 7a: OECD Countries

preserve


	#delimit;


		g bp_rp = $y / $y4;
		keep if year == 2050 & oecd == 1;

		g bp_sid = ( !missing(bp_rp) );
		keep if bp_sid == 1;
		egen bp_id = group(bp_rp);
		sort bp_id;
		li bp_id wb_code;


		twoway bar

		bp_rp bp_id if year == 2050 & !missing(bp_id),
			fcolor(none) barwidth(1) lwidth(medium)
			title("", size(small))
			ytitle("Effect of projected changes in aging and human capital relative to"
				"counterfactual without aging and with fixed human capital" " ", size(vsmall))
			yline(1, lcolor(cranberry) lwidth(medthick)
				lpattern(dash) lstyle(foreground))
			ylabel(0.96(0.02)1.04, angle(0) format(%4.2f) labsize(vsmall) noticks)
			xsca(reverse)
			xtitle("")
			xlabel(1(1)33
				1 "Slovakia" 2 "Estonia" 3 "Germany" 4 "Spain" 5 "Austria" 
				6 "Poland" 7 "Slovenia" 8 "Turkey" 9 "Canada" 10 "Luxembourg"
				11 "Greece" 12 "Mexico" 13 "Italy" 14 "Hungary"
				15 "Czech Republic" 16 "South Korea" 17 "New Zealand"
				18 "Ireland" 19 "United States" 20 "Chile" 21 "Switzerland"
				22 "Australia" 23 "Portugal" 24 "Great Britain" 25 "Sweden"
				26 "Belgium" 27 "Norway" 28 "Netherlands" 29 "Japan*"
				30 "Finland" 31 "Denmark" 32 "France" 33 "Japan",
					labsize(vsmall) gmin gmax angle(90) noticks)
			graphregion(color(white)) bgcolor(white)
		;		
				
				
	#delimit cr


restore



	// Figure 7b: Non-OECD Countries

preserve


	#delimit;

	
		g bp_rp = $y / $y4;
		keep if year == 2050 & oecd == 0;


		g bp_sid = ( !missing(bp_rp) );
		keep if bp_sid == 1;
		egen bp_id = group(bp_rp);
		sort bp_id;
		li bp_id wb_code;


		twoway bar

		bp_rp bp_id if year == 2050 & !missing(bp_id),
			fcolor(none) barwidth(1) lwidth(medium)
			title("", size(small))
			ytitle("Effect of projected changes in aging and human capital relative to"
				"counterfactual without aging and with fixed human capital" " ", size(vsmall))
			yline(1, lcolor(cranberry) lwidth(medthick)
				lpattern(dash) lstyle(foreground))
			ylabel(0.92(0.02)1.04, angle(0) format(%4.2f) labsize(tiny) noticks)
			xsca(reverse)
			xtitle("")
			xlabel(1(1)88
				1 "Armenia" 2 "Macau" 3 "Vietnam" 4 "Maldives" 5 "Iran" 
				6 "Romania" 7 "China" 8 "Mongolia" 9 "Ukraine" 10 "Lithuania"
				11 "Latvia" 12 "Russia" 13 "Rwanda" 14 "Mauritius"
				15 "Cambodia" 16 "Bahrain" 17 "Hong Kong"
				18 "Macedonia" 19 "Turkmenistan" 20 "Myanmar" 21 "Morocco"
				22 "Syria" 23 "Jordan" 24 "Kazakhstan" 25 "Tajikistan"
				26 "Uzbekistan" 27 "Brazil" 28 "Costa Rica" 29 "Indonesia"
				30 "Kyrgyzstan" 31 "Pakistan" 32 "Saudi Arabia" 33 "Cyprus"
				34 "Haiti" 35 "Croatia" 36 "Bulgaria" 37 "Sri Lanka" 38 "India"
				39 "Thailand" 40 "Mauritania" 41 "Benin" 42 "Togo" 43 "Bahamas"
				44 "Namibia" 45 "Uruguay" 46 "Honduras" 47 "Laos"
				48 "Tanzania" 49 "Gabon" 50 "Peru" 51 "Ethiopia" 52 "Ghana"
				53 "Burkina Faso" 54 "Madagascar" 55 "Colombia" 56 "Chad"
				57 "Nicaragua" 58 "Mali" 59 "Guinea" 60 "Bangladesh"
				61 "Comoros" 62 "Mozambique" 63 "Niger" 64 "Belize" 65 "Nepal"
				66 "Malawi" 67 "Ivory Coast" 68 "Cameroon" 69 "Central Africa"
				70 "Kenia" 71 "Egypt" 72 "Malaysia" 73 "Panama" 74 "Zimbabwe"
				75 "Singapore" 76 "Argentina" 77 "Paraguay" 78 "Ecuador"
				79 "South Africa" 80 "Malta" 81 "El Salvador"
				82 "Dominican Republic" 83 "Guatemala" 84 "Uganda"
				85 "Nigeria" 86 "Philippines" 87 "Zambia" 88 "Bolivia",
					labsize(tiny) gmin gmax angle(90) noticks)
			graphregion(color(white)) bgcolor(white)
		;
		
					
	#delimit cr


restore



********************************************************************************



clear all
exit



********************************************************************************
********************************************************************************

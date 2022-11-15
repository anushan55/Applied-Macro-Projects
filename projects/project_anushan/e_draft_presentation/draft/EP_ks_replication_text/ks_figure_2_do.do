********************************************************************************
* Rainer Kotschy and Uwe Sunde
*
* Can Education Compensate the Effect of Population Aging on Macroeconomic
* Performance? Evidence from Panel Data
*
* Replication Code: Figure 2
********************************************************************************



clear all
version 13.1
set more off, perm
macro drop _all
cd

use "ks_data_text_5y.dta"
xtset id t



********************************************************************************
* Figure 2: Dynamics of Educational Attainment
********************************************************************************
* Panel 2a: OECD and Non-OECD Countries



preserve



	#delimit ;

	
		forvalues x = 15(5)65	{;
		
		
			loc y = `x' + 4;
			
			
			g pop_iiasa_hs_`x'_`y' = iiasa_share_hs_`x'_`y'*pop_iiasa_`x'_`y';
		
		
		};
		
		
		g pop_iiasa_hs_15_69 =
			pop_iiasa_hs_15_19 + pop_iiasa_hs_20_24 + pop_iiasa_hs_25_29 +
			pop_iiasa_hs_30_34 + pop_iiasa_hs_35_39 + pop_iiasa_hs_40_44 +
			pop_iiasa_hs_45_49 + pop_iiasa_hs_50_54 + pop_iiasa_hs_55_59 +
			pop_iiasa_hs_60_64 + pop_iiasa_hs_65_69
		;

		

		collapse (rawsum) pop_iiasa_hs_15_69 (rawsum) iiasa_pop_15_69,
			by(year oecd);

			
			
		g iiasa_share_hs_15_69 = pop_iiasa_hs_15_69 / iiasa_pop_15_69;


	
			// 1950-2010;
			

		twoway

		line iiasa_share_hs_15_69 year if oecd == 1 & year <= 2010,
			lcolor(navy) lwidth(medium) lpattern(solid)
		|| line iiasa_share_hs_15_69 year if oecd == 0 & year <= 2010,
			lcolor(cranberry) lwidth(medium) lpattern(longdash)
			ytitle("Share high skills in working-age population", size(small))
			ylabel(0.00(0.05)0.30 0 "0", format(%4.2f) angle(0) labsize(small))
			ysca(titlegap(2.5))
			xtitle("Year", size(small))
			xsca(titlegap(2.5))
			xlabel(1950(10)2010, labsize(small))
			legend(order(1 2) label(1 "OECD") label(2 "Non-OECD") size(small))
			graphregion(color(white)) bgcolor(white)
		;
		
		
	#delimit cr
	
	
	
restore



********************************************************************************
* Panel 2b: Germany, United Kingdom, and France



#delimit ;
		

	twoway

	line iiasa_share_hs_15_69 year if wb_code == "DEU" & year <= 2010,
		lcolor(navy) lwidth(medium) lpattern(solid)
	|| line iiasa_share_hs_15_69 year if wb_code == "GBR" & year <= 2010,
		lcolor(green) lwidth(medium) lpattern(shortdash)
	|| line iiasa_share_hs_15_69 year if wb_code == "FRA" & year <= 2010,
		lcolor(cranberry) lwidth(medium) lpattern(longdash)
		ytitle("Share high skills in working-age population", size(small))
		ylabel(0.00(0.05)0.30 0 "0", format(%4.2f) angle(0) labsize(small))
		ysca(titlegap(2.5))
		xtitle("Year", size(small))
		xsca(titlegap(2.5))
		xlabel(1950(10)2010, labsize(small))
		legend(order(1 2 3) cols(3) label(1 "Germany") label(2 "UK")
			label(3 "France") size(small))
		graphregion(color(white)) bgcolor(white)
	;	


#delimit cr



********************************************************************************



clear all
exit



********************************************************************************
********************************************************************************

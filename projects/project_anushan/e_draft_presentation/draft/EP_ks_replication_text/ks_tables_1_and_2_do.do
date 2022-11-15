********************************************************************************
* Rainer Kotschy and Uwe Sunde
*
* Can Education Compensate the Effect of Population Aging on Macroeconomic
* Performance? Evidence from Panel Data
*
* Replication Code: Tables 1 and 2
********************************************************************************



clear all
version 13.1
set seed 111
set more off, perm
macro drop _all
cd

use "ks_data_text_5y.dta"
xtset id t



********************************************************************************
* Tables 1 and 2:



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
* Table 1: Effects of Aging and Education on Economic Performance: Levels Model



	// Column (1): Demography

xtreg $y L.($y) $k $iiasa_w5 $td $sample, fe cl(id)
	testparm $iiasa_w5
	

	// Column (2): Skills
				
xtreg $y L.($y) $k $iiasa_hs $td $sample, fe cl(id)
	testparm $iiasa_hs
	

	// Column (3): Demography and Skills

xtreg $y L.($y) $k $iiasa_w5 $iiasa_hs $td $sample, fe cl(id)
	testparm $iiasa_w5
	testparm $iiasa_hs
	
	
	// Column (4): Bias Correction

// findit xtlsdvc; the estimation may take a while
xtlsdvc $y $k $iiasa_w5 $iiasa_hs $td $sample, i(bb) b(3) v(100)
	testparm $iiasa_w5
	testparm $iiasa_hs
	
	
	// Column (5): Demography Instrumented
	
// findit xtivreg2
xtivreg2 $y L.($y) $k $iiasa_hs ( $iiasa_w5 = L.($un_w5) ) $td $sample, fe cl(id)
	testparm $iiasa_w5
	testparm $iiasa_hs
	

	// Column (6): Skills Instrumented
		
xtivreg2 $y L.($y) $k $iiasa_w5 ( $iiasa_hs = L.($iv_hs) ) $td $sample, fe cl(id)
	testparm $iiasa_w5
	testparm $iiasa_hs
	
	
	// Column (7): Both Instrumented
	
xtivreg2 $y L.($y) $k ( $iiasa_w5 $iiasa_hs = L.($un_w5) L.($iv_hs) ) $td $sample, fe cl(id)
	testparm $iiasa_w5
	testparm $iiasa_hs



********************************************************************************
* Table 2: Effects of Aging and Education on Economic Performance: Differences Model



	// Column (1): Demography

xtreg D.($y) L.($y) D.($k) D.($iiasa_w5) $td $sample, fe cl(id)
	testparm D.($iiasa_w5)
	

	// Column (2): Skills

xtreg D.($y) L.($y) D.($k) D.($iiasa_hs) L.($iiasa_hs) $td $sample, fe cl(id)
	testparm D.($iiasa_hs) L.($iiasa_hs)
	
	
	// Column (3): Demography and Skills
		
xtreg D.($y) L.($y) D.($k) D.($iiasa_w5) D.($iiasa_hs) L.($iiasa_hs) $td $sample, fe cl(id)
	testparm D.($iiasa_w5)
	testparm D.($iiasa_hs) L.($iiasa_hs)
	
	
	// Column (4): Bias Correction
		
// findit xtabond2		
xtabond2 D.($y) L.($y) D.($k) D.($iiasa_w5) ///
	D.($iiasa_hs) L.($iiasa_hs) $td $sample, ///
		iv(L2.($y), eq(diff) passthru) ///
		iv(L2.($y), eq(level)) ///	
		iv(D.($k) D.($iiasa_w5) D.($iiasa_hs) $td) ///
		iv(L.($iiasa_hs), eq(diff) passthru) ///
		iv(L.($iiasa_hs), eq(level)) twostep r
	testparm D.($iiasa_w5)
	testparm D.($iiasa_hs) L.($iiasa_hs)
	
		
	// Column (5): Demography Instrumented

// findit xtivreg2
xtivreg2 D.($y) L.($y) D.($k) D.($iiasa_hs) L.($iiasa_hs) ///
	( D.($iiasa_w5) = LD.($un_w5) ) $td $sample, fe cl(id)
	testparm D.($iiasa_w5)
	testparm D.($iiasa_hs) L.($iiasa_hs)
	
	
	// Column (6): Skills Instrumented
		
xtivreg2 D.($y) L.($y) D.($k) D.($iiasa_w5) L.($iiasa_hs) ///
	( D.($iiasa_hs) = LD.($iv_hs) ) $td $sample, fe cl(id)
	testparm D.($iiasa_w5)
	testparm D.($iiasa_hs) L.($iiasa_hs)
	
	
	// Column (7): Both Instrumented
		
xtivreg2 D.($y) L.($y) D.($k) L.($iiasa_hs) ///
	( D.($iiasa_w5) D.($iiasa_hs) = LD.($un_w5) LD.($iv_hs) ) $td $sample, fe cl(id)
	testparm D.($iiasa_w5)
	testparm D.($iiasa_hs) L.($iiasa_hs)



********************************************************************************



clear all
exit



********************************************************************************
********************************************************************************

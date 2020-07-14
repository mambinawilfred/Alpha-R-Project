*Transforming data into log form
*Copyright 2020 by Wilfred Mambina
*Last modified on on 02/07/2020
//////////////////////////////////////////////////////////////

*Importing data in Stata
cd"C:\Users\Fred\Desktop\Ibrahim\VAR_Model_Analysis\R_Analysis"
insheet using Analysisdata.csv,clear
br
*Renaming of variables
rename est_gdp_per_c egpc
rename swn_gdp_per_c sgpc
rename stibor_rate sr 
rename swn_gdp_def sgd
rename est_gdp_def egd

*converting the date to numerics
generate quarterly=tq(2000q1)+_n-1
format %tq quarterly

*Time set application
tsset quarterly
*Selection of optimal lag

varsoc sr sgpc egpc sgd egd
*Testing stationarity

*Series are Non-stationary
generate d_sgpc=d.sgpc
generate d_egpc=d.egpc
generate d_sgd=d.sgd
generate d_egd=d.egd
generate d2_egpc=d.d_egpc

*Drop variables
drop swn_gdp
drop est_gdp
drop d_egpc
drop legpc

*VAR Model Estimation
var sr sgpc d2_egpc d_sgd d_egd,lags(1/2)

*Impulse response functions
irf graph oirf,impulse(sr) response(sr)
irf graph oirf,impulse(sgpc) response(sr)
irf graph oirf,impulse(d2_egpc) response(sr)
irf graph oirf,impulse(d_sgd) response(d_egd)
irf graph oirf,impulse(sgpc) response(d2_egpc)
irf graph oirf,impulse(d2_egpc) response(sr)

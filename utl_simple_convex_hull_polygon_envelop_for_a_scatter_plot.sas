Simple convex hull polygon envelop for a scatter plot

for graphic output
https://tinyurl.com/y6v4pxtk
https://github.com/rogerjdeangelis/utl_simple_convex_hull_polygon_envelop_for_a_scatter_plot/blob/master/utl_simple_convex_hull_polygon_envelop_for_a_scatter_plot.pdf

Solution in WPS Proc R or IML/R

github
https://github.com/rogerjdeangelis/utl_simple_convex_hull_polygon_envelop_for_a_scatter_plot


INPUT
=====

 SD1.HAVE total obs=814

      X           Y

   0.86503     0.81118
  -1.04436    -1.05649
  -1.74895     0.56657
  -1.46444     0.26030
  -0.65384     0.41714
  -0.06057    -1.82914
  -0.07467     0.45391


 EXAMPLE OUTPUT
 --------------

   |
 2 +
   |      _________
   |     / .    .. \
   |    /    .  .   \
   |   /   ... .. .. \________
   |  /..   .  ...............\
   |  \ .... .. ......... ..   \
 0 +   \     ..  ..... ..  . . /
   |    \.   .. ......    ..../
   |     \  . ... ...  .    ./
   |      \ ...  _______..  /
   |       \..  /       \../
   |        \  /         \/
   |         \/
 2 +
   -+---------------+---------------+-
   -2               0               2

                    X

PROCESS (WORKING CODE)
======================

   hpts <- chull(have);


OUTPUT
======

data sd1.have;
  call streaminit(1234);
  do rec=1 to 1000;
     x=rand('normal');
     y=rand('normal');
     if round(x**2 + y**2) <= 3 then output;
  end;
  drop rec;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

%utl_submit_wps64('
libname sd1 "d:/sd1";
options set=R_HOME "C:/Program Files/R/R-3.3.2";
libname wrk sas7bdat "%sysfunc(pathname(work))";
proc r;
submit;
source("C:/Program Files/R/R-3.3.2/etc/Rprofile.site", echo=T);
library(haven);
have<-read_sas("d:/sd1/have.sas7bdat");
pdf(file="d:/pdf/utl_simple_convex_hull_polygon_envelop_for_a_scatter_plot.pdf");
plot(have, cex = 0.5);
hpts <- chull(have);
hpts <- c(hpts, hpts[1]);
lines(have[hpts, ]);
dev.off();
endsubmit;
import r=hpts  data=wrk.want;
run;quit;
');


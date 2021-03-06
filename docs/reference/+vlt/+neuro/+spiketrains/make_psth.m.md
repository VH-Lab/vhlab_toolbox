# vlt.neuro.spiketrains.make_psth

```
   [N,X, RAST] = vlt.neuro.spiketrains.make_psth(SPIKEDATA, TRIGGERS, INTERV, RES, NORMALIZE, RASTTYPE)
 
       vlt.neuro.spiketrains.make_psth gives a peri-stimulus time histogram.  The bins of the
   histogram are given in X, while the values in each bin are given in N.
   Rasters are also returned in the sparse matrix RAST; each trial has a
   separate row.  The function takes as arguments SPIKEDATA, a spikedata
   object to be evaluated, TRIGGERS, a list of trigger times,
   INTERV = [ before after], which tells how much before and after the
   trigger the histogram should examine, and RES, which is the time
   resolution of the histogram.  NORMALIZE = 0/1, and if it is 1 then the
   output is normalized by the number of triggers.  RASTTYPE == 1 specifies
   RAST should be a cell with number of trigger entries, each of which has
   all spike times for that peri-stimulus time.  RASTTYPE == 0 specifies
   that the RAST should be an X x (length of histogram) sparse matrix with
   each peri-stimulus time in a row.   All units are SI.
 
   (documentation cryptic...fix)
 
                                           Questions?  vanhoosr@brandeis.edu

```

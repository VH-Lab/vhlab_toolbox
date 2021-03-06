# vlt.signal.round2sample

```
  ROUND2SAMPLE - Round a continuous point to the nearest sampled value for a regularly sampled signal
  
    TR = vlt.signal.round2sample(TI,DT[, T0])
 
    Given a signal sampled at regular intervals DT, and given a set of time points TI,
    calculates the closest sample times TR that are multiples of DT.
    T0 is the time of the first sample. If it is not provided then it is assumed to be 0. 
 
    Example:
        DT = 0.001;
        TI = 0.00100000001;
        TR = vlt.signal.round2sample(TI, DT)   % returns 0.001
 
    See also: vlt.signal.point2samplelabel

```

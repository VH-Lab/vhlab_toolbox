# vlt.fit.otfit_carandini_err0

```
  vlt.fit.otfit_carandini_err0 Computes error of Carandini/Ferster orientation fit
 
    [ERR, RFIT]=OTFIT_CARANDINI_NEWS_ERR0(P,ANGLES,VARARGIN) 
 
    This function computes the error of the Carandini/Ferster orientation
    RFIT(O)=Rsp+Rp*exp(-(O-Op)^2/2*sig^2)+Rp*(exp(-(O-Op-180)^2)/s*sig^2)
    where O is an orientation angle.  ANGLES is a vector list of angles to
    be evaluated.  If observations are provided (see below) then the
    squared error ERR is computed.  Otherwise ERR is zero.
 
     The variable arguments, given in name/value pairs, can be used
     to specify the mode.
     Valid name/value pairs:
      'widthint', e.g., [15 180]              sig must be in given interval
                                                  (default no restriction)
      'spontfixed',  e.g., 0                  Rsp fixed to given value
                                                  (default is not fixed)
      'spontint', [0 10]                      Rsp must be in given interval
                                                  (default is no restriction)
      'data', [obs11 obs12 ...; obs21 .. ;]   Observations to compute error
      'stddev', [stddev1 stddev2 ... ]        Standard deviatiation (optional)
                                                  If provided, then squared
                                                  error will be normalized by
                                                  the variance.
 
     P = [ Rsp Rp Op sig ] are parameters, where Rsp is the spontaneous
    response, Rp is the response at the preferred orientation, Op is the
    preferred angle, sig is the width of the tuning, and Rp is the response
    180 degrees away from the preferred angle.
 
    See also:  vlt.fit.otfit_carandini0

```

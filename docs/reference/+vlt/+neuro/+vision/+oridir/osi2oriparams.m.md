# vlt.neuro.vision.oridir.osi2oriparams

```
  OSI2ORIPARAMS - Given an OSI, generate double gaussian parameters that has that osi index
 
    [RSP,RP,OP,SIGMA,RN] = vlt.neuro.vision.oridir.osi2oriparams(OSI, ...)
 
    Given a requested OSI index value, where OSI is defined as 
      (RESPONSE(PREFERRED) - RESPONSE(ORTHOGONAL))/RESPONSE(PREFERRED)
    this function generates a set of double gaussian parameters that satisfies
    the OSI.
 
    By default, OP is 0, SIGMA is 20, RP and RN are 10, unless OSI==0, in which case RP and RN are 0 and
    RSP is 10.
 
    One can add extra arguments as name/value pairs to modify the SIGMA, OP, and
    RSP parameters of the double gaussian, for example:
    [RSP,RP,OP,SIGMA,RN] = vlt.neuro.vision.oridir.osi2oriparams(OSI, 'SIGMA',40)
 
    One can use the following code to validate this function:
       desired_index = [];
       actual_index = [];
       for i=0:0.1:1,
           desired_index(end+1) = i;
           [rsp,rp,op,sigma,rn] = vlt.neuro.vision.oridir.osi2oriparams(i);
           [dummy,shape] = vlt.fit.otfit_carandini_err([rsp rp op sigma rn],[0:22.5:360-22.5]);
           actual_index(end+1) = vlt.neurovision.oridir.index.compute_orientationindex(0:22.5:360-22.5,shape);
        end;
        [desired_index' actual_index']
 
    See also: vlt.fit.otfit_carandini

```

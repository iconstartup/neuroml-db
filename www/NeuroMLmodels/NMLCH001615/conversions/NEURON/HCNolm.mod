TITLE Mod file for component: Component(id=HCNolm type=ionChannelHH)

COMMENT

    This NEURON file has been generated by org.neuroml.export (see https://github.com/NeuroML/org.neuroml.export)
         org.neuroml.export  v1.5.3
         org.neuroml.model   v1.5.3
         jLEMS               v0.9.9.0

ENDCOMMENT

NEURON {
    SUFFIX HCNolm
    USEION h READ eh WRITE ih VALENCE 1 ? Assuming valence = 1; TODO check this!!
    
    RANGE gion                           
    RANGE gmax                              : Will be changed when ion channel mechanism placed on cell!
    RANGE conductance                       : parameter
    
    RANGE g                                 : exposure
    
    RANGE fopen                             : exposure
    RANGE r_instances                       : parameter
    
    RANGE r_tau                             : exposure
    
    RANGE r_inf                             : exposure
    
    RANGE r_rateScale                       : exposure
    
    RANGE r_fcond                           : exposure
    RANGE r_timeCourse_TIME_SCALE           : parameter
    RANGE r_timeCourse_VOLT_SCALE           : parameter
    
    RANGE r_timeCourse_t                    : exposure
    RANGE r_steadyState_rate                : parameter
    RANGE r_steadyState_midpoint            : parameter
    RANGE r_steadyState_scale               : parameter
    
    RANGE r_steadyState_x                   : exposure
    RANGE r_timeCourse_V                    : derived variable
    RANGE r_tauUnscaled                     : derived variable
    RANGE conductanceScale                  : derived variable
    RANGE fopen0                            : derived variable
    
}

UNITS {
    
    (nA) = (nanoamp)
    (uA) = (microamp)
    (mA) = (milliamp)
    (A) = (amp)
    (mV) = (millivolt)
    (mS) = (millisiemens)
    (uS) = (microsiemens)
    (molar) = (1/liter)
    (kHz) = (kilohertz)
    (mM) = (millimolar)
    (um) = (micrometer)
    (umol) = (micromole)
    (S) = (siemens)
    
}

PARAMETER {
    
    gmax = 0  (S/cm2)                       : Will be changed when ion channel mechanism placed on cell!
    
    conductance = 1.0E-6 (uS)
    r_instances = 1 
    r_timeCourse_TIME_SCALE = 1 (ms)
    r_timeCourse_VOLT_SCALE = 1 (mV)
    r_steadyState_rate = 1 
    r_steadyState_midpoint = -84.1 (mV)
    r_steadyState_scale = -10.2 (mV)
}

ASSIGNED {
    
    gion   (S/cm2)                          : Transient conductance density of the channel? Standard Assigned variables with ionChannel
    v (mV)
    celsius (degC)
    temperature (K)
    eh (mV)
    ih (mA/cm2)
    
    
    r_timeCourse_V                         : derived variable
    
    r_timeCourse_t (ms)                    : derived variable
    
    r_steadyState_x                        : derived variable
    
    r_rateScale                            : derived variable
    
    r_fcond                                : derived variable
    
    r_inf                                  : derived variable
    
    r_tauUnscaled (ms)                     : derived variable
    
    r_tau (ms)                             : derived variable
    
    conductanceScale                       : derived variable
    
    fopen0                                 : derived variable
    
    fopen                                  : derived variable
    
    g (uS)                                 : derived variable
    rate_r_q (/ms)
    
}

STATE {
    r_q  
    
}

INITIAL {
    temperature = celsius + 273.15
    
    rates()
    rates() ? To ensure correct initialisation.
    
    r_q = r_inf
    
}

BREAKPOINT {
    
    SOLVE states METHOD cnexp
    
    ? DerivedVariable is based on path: conductanceScaling[*]/factor, on: Component(id=HCNolm type=ionChannelHH), from conductanceScaling; null
    ? Path not present in component, using factor: 1
    
    conductanceScale = 1 
    
    ? DerivedVariable is based on path: gates[*]/fcond, on: Component(id=HCNolm type=ionChannelHH), from gates; Component(id=r type=gateHHtauInf)
    ? multiply applied to all instances of fcond in: <gates> ([Component(id=r type=gateHHtauInf)]))
    fopen0 = r_fcond ? path based, prefix = 
    
    fopen = conductanceScale  *  fopen0 ? evaluable
    g = conductance  *  fopen ? evaluable
    gion = gmax * fopen 
    
    ih = gion * (v - eh)
    
}

DERIVATIVE states {
    rates()
    r_q' = rate_r_q 
    
}

PROCEDURE rates() {
    
    r_timeCourse_V = v /  r_timeCourse_VOLT_SCALE ? evaluable
    r_timeCourse_t = ( 100 + (1 / (exp(-17.9 - 0.116* r_timeCourse_V ) + exp(-1.84 + 0.09* r_timeCourse_V ))) ) *  r_timeCourse_TIME_SCALE ? evaluable
    r_steadyState_x = r_steadyState_rate  / (1 + exp(0 - (v -  r_steadyState_midpoint )/ r_steadyState_scale )) ? evaluable
    ? DerivedVariable is based on path: q10Settings[*]/q10, on: Component(id=r type=gateHHtauInf), from q10Settings; null
    ? Path not present in component, using factor: 1
    
    r_rateScale = 1 
    
    r_fcond = r_q ^ r_instances ? evaluable
    ? DerivedVariable is based on path: steadyState/x, on: Component(id=r type=gateHHtauInf), from steadyState; Component(id=null type=HHSigmoidVariable)
    r_inf = r_steadyState_x ? path based, prefix = r_
    
    ? DerivedVariable is based on path: timeCourse/t, on: Component(id=r type=gateHHtauInf), from timeCourse; Component(id=null type=Bezaire_HCNolm_tau)
    r_tauUnscaled = r_timeCourse_t ? path based, prefix = r_
    
    r_tau = r_tauUnscaled  /  r_rateScale ? evaluable
    
     
    rate_r_q = ( r_inf  -  r_q ) /  r_tau ? Note units of all quantities used here need to be consistent!
    
     
    
     
    
     
    
}


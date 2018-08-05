TITLE Mod file for component: Component(id=k_slow type=ionChannelHH)

COMMENT

    This NEURON file has been generated by org.neuroml.export (see https://github.com/NeuroML/org.neuroml.export)
         org.neuroml.export  v1.5.3
         org.neuroml.model   v1.5.3
         jLEMS               v0.9.9.0

ENDCOMMENT

NEURON {
    SUFFIX k_slow
    USEION k READ ek WRITE ik VALENCE 1 ? Assuming valence = 1; TODO check this!!
    
    RANGE gion                           
    RANGE gmax                              : Will be changed when ion channel mechanism placed on cell!
    RANGE conductance                       : parameter
    
    RANGE g                                 : exposure
    
    RANGE fopen                             : exposure
    RANGE n_instances                       : parameter
    
    RANGE n_tau                             : exposure
    
    RANGE n_inf                             : exposure
    
    RANGE n_rateScale                       : exposure
    
    RANGE n_fcond                           : exposure
    RANGE n_timeCourse_tau                  : parameter
    
    RANGE n_timeCourse_t                    : exposure
    RANGE n_steadyState_rate                : parameter
    RANGE n_steadyState_midpoint            : parameter
    RANGE n_steadyState_scale               : parameter
    
    RANGE n_steadyState_x                   : exposure
    RANGE n_tauUnscaled                     : derived variable
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
    
    conductance = 1.0E-5 (uS)
    n_instances = 1 
    n_timeCourse_tau = 25.0007 (ms)
    n_steadyState_rate = 1 
    n_steadyState_midpoint = 19.8741 (mV)
    n_steadyState_scale = 15.8512 (mV)
}

ASSIGNED {
    
    gion   (S/cm2)                          : Transient conductance density of the channel? Standard Assigned variables with ionChannel
    v (mV)
    celsius (degC)
    temperature (K)
    ek (mV)
    ik (mA/cm2)
    
    
    n_timeCourse_t (ms)                    : derived variable
    
    n_steadyState_x                        : derived variable
    
    n_rateScale                            : derived variable
    
    n_fcond                                : derived variable
    
    n_inf                                  : derived variable
    
    n_tauUnscaled (ms)                     : derived variable
    
    n_tau (ms)                             : derived variable
    
    conductanceScale                       : derived variable
    
    fopen0                                 : derived variable
    
    fopen                                  : derived variable
    
    g (uS)                                 : derived variable
    rate_n_q (/ms)
    
}

STATE {
    n_q  
    
}

INITIAL {
    temperature = celsius + 273.15
    
    rates()
    rates() ? To ensure correct initialisation.
    
    n_q = n_inf
    
}

BREAKPOINT {
    
    SOLVE states METHOD cnexp
    
    ? DerivedVariable is based on path: conductanceScaling[*]/factor, on: Component(id=k_slow type=ionChannelHH), from conductanceScaling; null
    ? Path not present in component, using factor: 1
    
    conductanceScale = 1 
    
    ? DerivedVariable is based on path: gates[*]/fcond, on: Component(id=k_slow type=ionChannelHH), from gates; Component(id=n type=gateHHtauInf)
    ? multiply applied to all instances of fcond in: <gates> ([Component(id=n type=gateHHtauInf)]))
    fopen0 = n_fcond ? path based, prefix = 
    
    fopen = conductanceScale  *  fopen0 ? evaluable
    g = conductance  *  fopen ? evaluable
    gion = gmax * fopen 
    
    ik = gion * (v - ek)
    
}

DERIVATIVE states {
    rates()
    n_q' = rate_n_q 
    
}

PROCEDURE rates() {
    
    n_timeCourse_t = n_timeCourse_tau ? evaluable
    n_steadyState_x = n_steadyState_rate  / (1 + exp(0 - (v -  n_steadyState_midpoint )/ n_steadyState_scale )) ? evaluable
    ? DerivedVariable is based on path: q10Settings[*]/q10, on: Component(id=n type=gateHHtauInf), from q10Settings; null
    ? Path not present in component, using factor: 1
    
    n_rateScale = 1 
    
    n_fcond = n_q ^ n_instances ? evaluable
    ? DerivedVariable is based on path: steadyState/x, on: Component(id=n type=gateHHtauInf), from steadyState; Component(id=null type=HHSigmoidVariable)
    n_inf = n_steadyState_x ? path based, prefix = n_
    
    ? DerivedVariable is based on path: timeCourse/t, on: Component(id=n type=gateHHtauInf), from timeCourse; Component(id=null type=fixedTimeCourse)
    n_tauUnscaled = n_timeCourse_t ? path based, prefix = n_
    
    n_tau = n_tauUnscaled  /  n_rateScale ? evaluable
    
     
    rate_n_q = ( n_inf  -  n_q ) /  n_tau ? Note units of all quantities used here need to be consistent!
    
     
    
     
    
     
    
}


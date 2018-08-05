TITLE Mod file for component: Component(id=it type=ionChannelHH)

COMMENT

    This NEURON file has been generated by org.neuroml.export (see https://github.com/NeuroML/org.neuroml.export)
         org.neuroml.export  v1.5.3
         org.neuroml.model   v1.5.3
         jLEMS               v0.9.9.0

ENDCOMMENT

NEURON {
    SUFFIX it
    USEION ca WRITE ica VALENCE 2 ? Assuming valence = 2 (Ca ion); TODO check this!!
    
    RANGE gion                           
    RANGE gmax                              : Will be changed when ion channel mechanism placed on cell!
    RANGE conductance                       : parameter
    
    RANGE g                                 : exposure
    
    RANGE fopen                             : exposure
    RANGE m_instances                       : parameter
    
    RANGE m_tau                             : exposure
    
    RANGE m_inf                             : exposure
    
    RANGE m_rateScale                       : exposure
    
    RANGE m_fcond                           : exposure
    RANGE m_timeCourse_TIME_SCALE           : parameter
    RANGE m_timeCourse_am                   : parameter
    RANGE m_timeCourse_vm1                  : parameter
    RANGE m_timeCourse_wm1                  : parameter
    RANGE m_timeCourse_vm2                  : parameter
    RANGE m_timeCourse_wm2                  : parameter
    
    RANGE m_timeCourse_t                    : exposure
    RANGE m_steadyState_rate                : parameter
    RANGE m_steadyState_midpoint            : parameter
    RANGE m_steadyState_scale               : parameter
    
    RANGE m_steadyState_x                   : exposure
    RANGE h_instances                       : parameter
    
    RANGE h_tau                             : exposure
    
    RANGE h_inf                             : exposure
    
    RANGE h_rateScale                       : exposure
    
    RANGE h_fcond                           : exposure
    RANGE h_timeCourse_TIME_SCALE           : parameter
    RANGE h_timeCourse_ah                   : parameter
    RANGE h_timeCourse_vh1                  : parameter
    RANGE h_timeCourse_wh1                  : parameter
    RANGE h_timeCourse_vh2                  : parameter
    RANGE h_timeCourse_wh2                  : parameter
    
    RANGE h_timeCourse_t                    : exposure
    RANGE h_steadyState_rate                : parameter
    RANGE h_steadyState_midpoint            : parameter
    RANGE h_steadyState_scale               : parameter
    
    RANGE h_steadyState_x                   : exposure
    RANGE m_tauUnscaled                     : derived variable
    RANGE h_tauUnscaled                     : derived variable
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
    m_instances = 2 
    m_timeCourse_TIME_SCALE = 1 (ms)
    m_timeCourse_am = 3 
    m_timeCourse_vm1 = 25 (mV)
    m_timeCourse_wm1 = 20 (mV)
    m_timeCourse_vm2 = 100 (mV)
    m_timeCourse_wm2 = 15 (mV)
    m_steadyState_rate = 1 
    m_steadyState_midpoint = -50 (mV)
    m_steadyState_scale = 7.4 (mV)
    h_instances = 1 
    h_timeCourse_TIME_SCALE = 1 (ms)
    h_timeCourse_ah = 85 
    h_timeCourse_vh1 = 46 (mV)
    h_timeCourse_wh1 = 4 (mV)
    h_timeCourse_vh2 = 405 (mV)
    h_timeCourse_wh2 = 50 (mV)
    h_steadyState_rate = 1 
    h_steadyState_midpoint = -78 (mV)
    h_steadyState_scale = -5 (mV)
}

ASSIGNED {
    
    gion   (S/cm2)                          : Transient conductance density of the channel? Standard Assigned variables with ionChannel
    v (mV)
    celsius (degC)
    temperature (K)
    eca (mV)
    ica (mA/cm2)
    
    
    m_timeCourse_t (ms)                    : derived variable
    
    m_steadyState_x                        : derived variable
    
    m_rateScale                            : derived variable
    
    m_fcond                                : derived variable
    
    m_inf                                  : derived variable
    
    m_tauUnscaled (ms)                     : derived variable
    
    m_tau (ms)                             : derived variable
    
    h_timeCourse_t (ms)                    : derived variable
    
    h_steadyState_x                        : derived variable
    
    h_rateScale                            : derived variable
    
    h_fcond                                : derived variable
    
    h_inf                                  : derived variable
    
    h_tauUnscaled (ms)                     : derived variable
    
    h_tau (ms)                             : derived variable
    
    conductanceScale                       : derived variable
    
    fopen0                                 : derived variable
    
    fopen                                  : derived variable
    
    g (uS)                                 : derived variable
    rate_m_q (/ms)
    rate_h_q (/ms)
    
}

STATE {
    m_q  
    h_q  
    
}

INITIAL {
    eca = 140.67523
    
    temperature = celsius + 273.15
    
    rates()
    rates() ? To ensure correct initialisation.
    
    m_q = m_inf
    
    h_q = h_inf
    
}

BREAKPOINT {
    
    SOLVE states METHOD cnexp
    
    ? DerivedVariable is based on path: conductanceScaling[*]/factor, on: Component(id=it type=ionChannelHH), from conductanceScaling; null
    ? Path not present in component, using factor: 1
    
    conductanceScale = 1 
    
    ? DerivedVariable is based on path: gates[*]/fcond, on: Component(id=it type=ionChannelHH), from gates; Component(id=m type=gateHHtauInf)
    ? multiply applied to all instances of fcond in: <gates> ([Component(id=m type=gateHHtauInf), Component(id=h type=gateHHtauInf)]))
    fopen0 = m_fcond * h_fcond ? path based, prefix = 
    
    fopen = conductanceScale  *  fopen0 ? evaluable
    g = conductance  *  fopen ? evaluable
    gion = gmax * fopen 
    
    ica = gion * (v - eca)
    
}

DERIVATIVE states {
    rates()
    m_q' = rate_m_q 
    h_q' = rate_h_q 
    
}

PROCEDURE rates() {
    
    m_timeCourse_t = (  m_timeCourse_am  + 1.0 / ( exp((v+ m_timeCourse_vm1 )/ m_timeCourse_wm1 ) + exp(-(v+ m_timeCourse_vm2 )/ m_timeCourse_wm2 ) ) ) *  m_timeCourse_TIME_SCALE ? evaluable
    m_steadyState_x = m_steadyState_rate  / (1 + exp(0 - (v -  m_steadyState_midpoint )/ m_steadyState_scale )) ? evaluable
    ? DerivedVariable is based on path: q10Settings[*]/q10, on: Component(id=m type=gateHHtauInf), from q10Settings; null
    ? Path not present in component, using factor: 1
    
    m_rateScale = 1 
    
    m_fcond = m_q ^ m_instances ? evaluable
    ? DerivedVariable is based on path: steadyState/x, on: Component(id=m type=gateHHtauInf), from steadyState; Component(id=null type=HHSigmoidVariable)
    m_inf = m_steadyState_x ? path based, prefix = m_
    
    ? DerivedVariable is based on path: timeCourse/t, on: Component(id=m type=gateHHtauInf), from timeCourse; Component(id=null type=CaT_m_tau_tau)
    m_tauUnscaled = m_timeCourse_t ? path based, prefix = m_
    
    m_tau = m_tauUnscaled  /  m_rateScale ? evaluable
    h_timeCourse_t = (  h_timeCourse_ah  + 1.0 / ( exp((v+ h_timeCourse_vh1 )/ h_timeCourse_wh1 ) + exp(-(v+ h_timeCourse_vh2 )/ h_timeCourse_wh2 ) ) ) *  h_timeCourse_TIME_SCALE ? evaluable
    h_steadyState_x = h_steadyState_rate  / (1 + exp(0 - (v -  h_steadyState_midpoint )/ h_steadyState_scale )) ? evaluable
    ? DerivedVariable is based on path: q10Settings[*]/q10, on: Component(id=h type=gateHHtauInf), from q10Settings; null
    ? Path not present in component, using factor: 1
    
    h_rateScale = 1 
    
    h_fcond = h_q ^ h_instances ? evaluable
    ? DerivedVariable is based on path: steadyState/x, on: Component(id=h type=gateHHtauInf), from steadyState; Component(id=null type=HHSigmoidVariable)
    h_inf = h_steadyState_x ? path based, prefix = h_
    
    ? DerivedVariable is based on path: timeCourse/t, on: Component(id=h type=gateHHtauInf), from timeCourse; Component(id=null type=CaT_h_tau_tau)
    h_tauUnscaled = h_timeCourse_t ? path based, prefix = h_
    
    h_tau = h_tauUnscaled  /  h_rateScale ? evaluable
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    rate_m_q = ( m_inf  -  m_q ) /  m_tau ? Note units of all quantities used here need to be consistent!
    
     
    
     
    
     
    rate_h_q = ( h_inf  -  h_q ) /  h_tau ? Note units of all quantities used here need to be consistent!
    
     
    
     
    
     
    
}


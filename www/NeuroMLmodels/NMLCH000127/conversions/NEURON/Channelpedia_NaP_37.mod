TITLE Mod file for component: Component(id=Channelpedia_NaP_37 type=ionChannelHH)

COMMENT

    This NEURON file has been generated by org.neuroml.export (see https://github.com/NeuroML/org.neuroml.export)
         org.neuroml.export  v1.5.3
         org.neuroml.model   v1.5.3
         jLEMS               v0.9.9.0

ENDCOMMENT

NEURON {
    SUFFIX Channelpedia_NaP_37
    USEION na READ ena WRITE ina VALENCE 1 ? Assuming valence = 1; TODO check this!!
    
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
    RANGE m_timeCourse_VOLT_SCALE           : parameter
    
    RANGE m_timeCourse_t                    : exposure
    RANGE m_steadyState_TIME_SCALE          : parameter
    RANGE m_steadyState_VOLT_SCALE          : parameter
    
    RANGE m_steadyState_x                   : exposure
    RANGE m_timeCourse_V                    : derived variable
    RANGE m_steadyState_V                   : derived variable
    RANGE m_tauUnscaled                     : derived variable
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
    m_instances = 3 
    m_timeCourse_TIME_SCALE = 1 (ms)
    m_timeCourse_VOLT_SCALE = 1 (mV)
    m_steadyState_TIME_SCALE = 1 (ms)
    m_steadyState_VOLT_SCALE = 1 (mV)
}

ASSIGNED {
    
    gion   (S/cm2)                          : Transient conductance density of the channel? Standard Assigned variables with ionChannel
    v (mV)
    celsius (degC)
    temperature (K)
    ena (mV)
    ina (mA/cm2)
    
    
    m_timeCourse_V                         : derived variable
    
    m_timeCourse_t (ms)                    : derived variable
    
    m_steadyState_V                        : derived variable
    
    m_steadyState_x                        : derived variable
    
    m_rateScale                            : derived variable
    
    m_fcond                                : derived variable
    
    m_inf                                  : derived variable
    
    m_tauUnscaled (ms)                     : derived variable
    
    m_tau (ms)                             : derived variable
    
    conductanceScale                       : derived variable
    
    fopen0                                 : derived variable
    
    fopen                                  : derived variable
    
    g (uS)                                 : derived variable
    rate_m_q (/ms)
    
}

STATE {
    m_q  
    
}

INITIAL {
    temperature = celsius + 273.15
    
    rates()
    rates() ? To ensure correct initialisation.
    
    m_q = m_inf
    
}

BREAKPOINT {
    
    SOLVE states METHOD cnexp
    
    ? DerivedVariable is based on path: conductanceScaling[*]/factor, on: Component(id=Channelpedia_NaP_37 type=ionChannelHH), from conductanceScaling; null
    ? Path not present in component, using factor: 1
    
    conductanceScale = 1 
    
    ? DerivedVariable is based on path: gates[*]/fcond, on: Component(id=Channelpedia_NaP_37 type=ionChannelHH), from gates; Component(id=m type=gateHHtauInf)
    ? multiply applied to all instances of fcond in: <gates> ([Component(id=m type=gateHHtauInf)]))
    fopen0 = m_fcond ? path based, prefix = 
    
    fopen = conductanceScale  *  fopen0 ? evaluable
    g = conductance  *  fopen ? evaluable
    gion = gmax * fopen 
    
    ina = gion * (v - ena)
    
}

DERIVATIVE states {
    rates()
    m_q' = rate_m_q 
    
}

PROCEDURE rates() {
    
    m_timeCourse_V = v /  m_timeCourse_VOLT_SCALE ? evaluable
    m_timeCourse_t = 1.0  *  m_timeCourse_TIME_SCALE ? evaluable
    m_steadyState_V = v /  m_steadyState_VOLT_SCALE ? evaluable
    m_steadyState_x = 1.0000/(1+ exp(( m_steadyState_V  +44.0000)/-4.8500)) ? evaluable
    ? DerivedVariable is based on path: q10Settings[*]/q10, on: Component(id=m type=gateHHtauInf), from q10Settings; null
    ? Path not present in component, using factor: 1
    
    m_rateScale = 1 
    
    m_fcond = m_q ^ m_instances ? evaluable
    ? DerivedVariable is based on path: steadyState/x, on: Component(id=m type=gateHHtauInf), from steadyState; Component(id=null type=Channelpedia_NaP_37_m_inf)
    m_inf = m_steadyState_x ? path based, prefix = m_
    
    ? DerivedVariable is based on path: timeCourse/t, on: Component(id=m type=gateHHtauInf), from timeCourse; Component(id=null type=Channelpedia_NaP_37_m_tau)
    m_tauUnscaled = m_timeCourse_t ? path based, prefix = m_
    
    m_tau = m_tauUnscaled  /  m_rateScale ? evaluable
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    
     
    rate_m_q = ( m_inf  -  m_q ) /  m_tau ? Note units of all quantities used here need to be consistent!
    
     
    
     
    
     
    
}


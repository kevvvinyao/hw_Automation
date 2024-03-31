function [] = Structure_of_Differential_Model_Integration( )
    %Set Dynamic Model parameters
    parameters_of_differential_model = [1.8, % density
                                        717.5, % C_v
                                        1000, % Volume
                                        10, % mass  
                                        1000000, % enthalpy input
                                        293.15, % Temperature input
                                        3658134, % enthalpy output
                                        393.15, % Temperature output
                                        287, % gas constant for air
                                        500, % mass flow rate inlet
                                        800]; % mass flow rate outlet

    % parameters_of_differential_model = [1.024, % density
    %                                     717, % C_v
    %                                     10, % Volume
    %                                     10, % mass
    %                                     300000, % enthalpy input
    %                                     293.15, % Temperature input
    %                                     400000, % enthalpy output
    %                                     393.15, % Temperature output
    %                                     287, % gas constant for air
    %                                     2, % mass flow rate inlet
    %                                     1.5]; % mass flow rate outlet
                       
    
    %Integrator Options
    options_ode = odeset('RelTol', 1e-3, 'AbsTol', 1e-6);

    %Initial conditions for vector of the integration variables - SI unit
    pressure = 101325;
    Temperature = 298;
    initial_cond_for_differential_model = [pressure; Temperature];

    t_start=0.0;
    t_final=10;

    differential_model_with_params = @(t, Y) differential_model(t, Y, parameters_of_differential_model);
    [time, Y_out] = ode15s(differential_model_with_params, [t_start, t_final], initial_cond_for_differential_model, options_ode);

    plot(time, Y_out)
end

function [dY_dt] = differential_model(time, Y, parameters_of_differential_model)
    pressure = Y(1);
    Temperature = Y(2);

    density = parameters_of_differential_model(1); % kg/m^3
    C_v = parameters_of_differential_model(2); % J/(kg*K)
    Volume = parameters_of_differential_model(3); % m^3
    mass = parameters_of_differential_model(4); % kg
    enthalpy_input = parameters_of_differential_model(5); % J
    Temperature_input = parameters_of_differential_model(6); % K
    enthalpy_output = parameters_of_differential_model(7); % J
    Temperature_output = parameters_of_differential_model(8); % K
    R = parameters_of_differential_model(9); % J/(kg*K)
    mass_inlet = parameters_of_differential_model(10); % kg/s
    mass_outlet = parameters_of_differential_model(11); % kg/s
    % 这里需要定义相关的参数
    % 例如density, C_v, Volume, mass, enthalpy_input, Temperature_input, enthalpy_output, Temperature_output, R, mass_inlet, mass_outlet

    dTemperature = (1 / (density * C_v * Volume)) * (mass_inlet * enthalpy_input - mass_outlet * enthalpy_output);
    dpressure = (R * Temperature / Volume) * (mass_inlet - mass_outlet) + pressure / Temperature * dTemperature; 

    dY_dt = [dpressure; dTemperature];
end

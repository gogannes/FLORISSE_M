function turbine = floris_cpctpower(inputData,turbine)
% This function computes Cp and Ct based on the axialInductionFactor or it
% computes Cp, Ct and the axialInductionFactor based on the inlet windspeed.
% After this the current power of the turbine is computed.

    % ThrustDirection is a unit vector that determines the plane the wake is
    % pushed into by the turbine. See illustration in script 'DisplayTurbine'
    ThrustDirection = floris_eul2rotm(-[turbine.YawWF turbine.Tilt 0],'ZYZ')*-[1;0;0];
    turbine.ThrustAngle = acos(dot(ThrustDirection,-[1;0;0]));
    
    normalize = @(v) v./norm(v); % Normalization function
    
    % Determine the unit vector orthogonal to the mean wake plane
    % (for tilt = 0 rad, this means [0 0 1], e.g. the z-axis)
    if abs(ThrustDirection(1))==1
        turbine.wakeNormal = [0 0 1].';
    else
        turbine.wakeNormal = normalize(cross([1;0;0],ThrustDirection));
    end

    % Calculate Ct and Cp either by approximation or interpolation
    if inputData.axialControlMethod <= 1
        % calculate Ct and Cp from FAST LUT data
        if inputData.axialControlMethod == 0
            turbine.Ct = inputData.ct_interp(turbine.windSpeed,turbine.bladePitch);
            turbine.Cp = inputData.cp_interp(turbine.windSpeed,turbine.bladePitch);
        else
            turbine.Ct = inputData.ct_interp(turbine.windSpeed);
            turbine.Cp = inputData.cp_interp(turbine.windSpeed);
        end
        
        % Correct Cp and Ct for yaw misallignment
        turbine.Ct = turbine.Ct * cos(turbine.ThrustAngle)^2;
        turbine.Cp = turbine.Cp * cos(turbine.ThrustAngle)^inputData.pP;
        
        % Calculate axial induction factor
        if turbine.Ct > 0.96 % Glauert condition
            turbine.axialInd = 0.143+sqrt(0.0203-0.6427*(0.889-turbine.Ct));
        else
            turbine.axialInd = 0.5*(1-sqrt(1-turbine.Ct));
        end
    else
        ai = turbine.axialInd;
        % calculate Ct and Cp by approximation using AIF
        turbine.Ct = 4*ai*(1-ai);
        turbine.Cp = 4*ai*(1-ai)^2;
    end

    % Compute turbine power
    turbine.power = (0.5*inputData.airDensity*turbine.rotorArea*turbine.Cp)*(turbine.windSpeed^3.0)*turbine.eta;
end
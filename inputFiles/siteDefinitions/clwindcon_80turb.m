% Wind turbine locations in inertial frame [x, y]
inputData.LocIF = 178.3*[   5.0002   28.9921;
                            5.0001   20.9941;
                            5.0000   12.9961;
                           11.7140   28.9886;
                           11.7167   20.9955;
                           11.7117   13.0003;
                           18.4279   36.9832;
                           18.4257   28.9929;
                           18.4256   20.9949;
                           18.4255   12.9969;
                           18.4282    5.0038;
                           25.1396   36.9874;
                           25.1395   28.9894;
                           25.1394   20.9914;
                           25.1421   12.9983;
                           25.1371    5.0031;
                           31.8534   36.9840;
                           31.8561   28.9908;
                           31.8512   20.9957;
                           31.8510   12.9977;
                           31.8537    5.0045;
                           38.5652   36.9882;
                           38.5651   28.9902;
                           38.5649   20.9922;
                           38.5676   12.9991;
                           38.5675    5.0011;
                           45.2790   36.9848;
                           45.2788   28.9868;
                           45.2815   20.9936;
                           45.2766   12.9985;
                           45.2793    5.0053;
                           51.9955   36.9862;
                           51.9906   28.9910;
                           51.9905   20.9930;
                           51.9932   12.9999;
                           51.9930    5.0019;
                           58.7045   36.9855;
                           58.7044   28.9875;
                           58.7071   20.9944;
                           58.7069   12.9964;
                           58.7048    5.0061;
                           65.4183   36.9821;
                           65.4161   28.9918;
                           65.4160   20.9938;
                           65.4187   13.0006;
                           65.4186    5.0027;
                           72.1300   36.9863;
                           72.1299   28.9883;
                           72.1326   20.9952;
                           72.1325   12.9972;
                           72.1275    5.0020;
                           78.8438   36.9829;
                           78.8465   28.9897;
                           78.8415   20.9946;
                           78.8442   13.0014;
                           78.8441    5.0034;
                           85.5555   36.9871;
                           85.5554   28.9891;
                           85.5581   20.9960;
                           85.5580   12.9980;
                           85.5579    5.0000;
                           92.2693   36.9837;
                           92.2720   28.9905;
                           92.2719   20.9925;
                           92.2669   12.9974;
                           92.2696    5.0042;
                           98.9859   36.9851;
                           98.9809   28.9899;
                           98.9836   20.9968;
                           98.9835   12.9988;
                           98.9834    5.0008;
                          105.6948   36.9844;
                          105.6975   28.9913;
                          105.6974   20.9933;
                          105.6973   12.9953;
                          105.6951    5.0050;
                          112.4113   28.9879;
                          112.4063   20.9927;
                          112.4090   12.9995;
                          119.1230   28.9921;
                          119.1229   20.9941;
                          119.1228   12.9961];
nTurbs = size(inputData.LocIF,1); % Number of turbines
inputData.nTurbs = nTurbs; % Save to inputData for usage outside of this function

% Control settings
%         inputData.yawAngles   = zeros(1,nTurbs);     % Set default as greedy
%         inputData.tiltAngles  = zeros(1,nTurbs);     % Set default as greedy
inputData.yawAngles   = zeros(1,nTurbs); % Turbine yaw angles (radians, w.r.t. freestream wind)
inputData.tiltAngles  = zeros(1,nTurbs); % Turbine tilt angles (radians, w.r.t. ground)

% Atmospheric settings
% Compute windDirection in the inertial frame, and the wind-aligned flow speed (uInfWf)
inputData.windDirection = 0.0; % Wind dir in radians (inertial frame)
inputData.uInfWf        = 8.0; % axial flow speed in wind frame
inputData.TI_0          = .1; % turbulence intensity [-] ex: 0.1 is 10% turbulence intensity
inputData.airDensity    = 1.1716; % Atmospheric air density (kg/m3)

% Inflow (vertical profile)
inputData.shear = .14; % shear exponent (0.14 -> neutral)
hubHeight = 119.0;
inputData.Ufun = @(z) inputData.uInfWf.*(z./hubHeight).^inputData.shear; % Boundary layer
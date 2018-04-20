function [ centerLine ] = floris_wakeCenterline( wakeModel,turbine,x,wake_pos_error )
if nargin == 3
    wake_pos_error = 0;
end
% Calculate wake locations at downstream turbines
deltaxs           = x-turbine.LocWF(1);
[displ_y,displ_z] = wakeModel.deflection(deltaxs,turbine);

% Write the results to the wake struct
centerLine      = zeros(3,length(x));
centerLine(1,:) = x;
centerLine(2,:) = displ_y;
centerLine(3,:) = displ_z;

% add potential wake error (wake_error=0.01 would lead to a error
% deflection of 1 meter at 100 meter downstream)
centerLine(2,:)=centerLine(2,:)+ wake_pos_error*deltaxs;

end
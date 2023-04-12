Integral = 0
ProcessVariableOld = 0
OutputValue = 0
											
MaximumOutput = 1
MinimumOutput = -1
											
function onTick()
	local setpoint = input.getNumber(1)
	local processVariable = input.getNumber(2)
	local P = input.getNumber(3)
	local I = input.getNumber(4)
	local D = input.getNumber(5)
	local trim = input.getNumber(6)
	local pilotpitch = input.getNumber(7)
											
	local on = input.getBool(1)
	local right = input.getBool(2)
											
											
	if on then 	
		error = setpoint - processVariable
		local diff = processVariable - ProcessVariableOld	
											
		if OutputValue < MaximumOutput and OutputValue > MinimumOutput and math.abs(pilotpitch) < 0.5 then
			Integral = Integral + I*error
			Integral = math.max(math.min(Integral, MaximumOutput), MinimumOutput)
		end
											
		Kp = P*error
		Ki = Integral
		Kd = -D*diff
											
		OutputValue = Kp+Ki+Kd
		OutputValue = math.max(math.min(OutputValue, MaximumOutput), MinimumOutput)
											
	else
		Integral = 0
		OutputValue = 0
	end
											
	ProcessVariableOld = processVariable
											
	if right then OutputValue = -OutputValue end
											
	output.setNumber(1, OutputValue+trim)
end
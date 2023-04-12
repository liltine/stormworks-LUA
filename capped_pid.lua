Integral = 0
ProcessVariableOld = 0
OutputValue = 0
											
MaximumOutput = 1
MinimumOutput = 0
											
function onTick()
	setpoint = input.getNumber(1)
	pv = input.getNumber(2)
	P = input.getNumber(3)
	I = input.getNumber(4)
	ValueBar = input.getNumber(5)
											
	on = input.getBool(1)
											
	if on then 	
		error = setpoint - pv
		diff = pv - ProcessVariableOld	
											
		if OutputValue < MaximumOutput and OutputValue > MinimumOutput then
			Integral = Integral + I*error
			Integral = math.max(math.min(Integral, MaximumOutput), MinimumOutput)
		end
											
		Kp = P*error
		Ki = Integral
		Kd = -ValueBar*diff
											
		OutputValue = Kp+Ki+Kd
		OutputValue = math.max(math.min(OutputValue, MaximumOutput), MinimumOutput)
											
	else
		Integral = 0
		OutputValue = 0
	end
											
	ProcessVariableOld = pv
											
	output.setNumber(1, OutputValue)
end
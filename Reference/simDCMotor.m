function simOut = simDCMotor(mdlName,R) 

	simOut = sim(mdlName,'SrcWorkspace','current',...
        'StopTime','8');
end

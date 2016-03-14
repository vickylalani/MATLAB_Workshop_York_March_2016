function simOut = simDCMotorRB(mdlName,R,b) 

	simOut = sim(mdlName,'SrcWorkspace','current',...
        'StopTime','8');
end

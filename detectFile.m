function timerObj = detectFile(dirName, actionToBeTaken)
% function timerObj = detectFile(dirName, actionToBeTaken)
%
% dirName is the name for the directory to be watched for changes
% All file names which has been modified after the first run will
% be passed to the 'actionToBeTaken' function as a parameter in
% the form of absolute path
% 
% To stop the watching process apply stop(timerObj) to the returned object
%
% Alp Sayin - alpsayin[at]alpsayin[dot]com
% 29 Oct 2013


period = 10; %seconds between directory checks
timeout = 500; %seconds before function termination

timerObj = timer('TimerFcn', {@timerCallback, dirName, actionToBeTaken}, 'Period', period,'TaskstoExecute', uint8(timeout/period), 'executionmode', 'fixedrate');
start(timerObj)
return 

function timerCallback(src, eventdata, dirName, actionToBeTaken)
    persistent prs_lastRunTime;
    persistent prs_beginFlag;

%     fprintf('Detect File callback for %s\n', dirName);
    
    if isempty(prs_beginFlag)
        prs_lastRunTime = now;
        prs_beginFlag = 1;
        fprintf('File detector for %s has started now\n', dirName);
    end
    
    myDir = dir(dirName);
    for k=1:length(myDir)
        file = myDir(k);
        fileTime = file.datenum;
        if (~strcmp(file.name, '.')) & (fileTime > prs_lastRunTime)
            fprintf('%s has changed\n', file.name);
            actionToBeTaken(file.name);
    %         DO STUFF HERE
        end
    end

    prs_lastRunTime = now;
return

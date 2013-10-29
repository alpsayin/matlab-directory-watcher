function timerObj = detectFile(dirName, actionToBeTaken, newFilesOnly, periodMs)
% function timerObj = detectFile(dirName, actionToBeTaken, newFilesOnly, periodMs)
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

if nargin < 3
    newFilesOnly = false;
end

if nargin < 4
    periodMs = 15;
end


timerObj = timer('TimerFcn', {@timerCallback, dirName, actionToBeTaken, newFilesOnly}, 'Period', periodMs, 'executionmode', 'fixedrate');
start(timerObj)
return 

function timerCallback(src, eventdata, dirName, actionToBeTaken, newFilesOnly)
    persistent prs_lastRunTime;
    persistent prs_beginFlag;

%     fprintf('Detect File callback for %s\n', dirName);
    
    if isempty(prs_beginFlag)
        prs_lastRunTime = now;
        prs_beginFlag = 1;
        fprintf('File detector for %s has started now\n', dirName);
    end
    
    myDir = dir(dirName);
    if (myDir(1).datenum > prs_lastRunTime) || (~newFilesOnly) % This checks if '.' folder is changed before going into a thorough search
        for k=1:length(myDir)
            file = myDir(k);
            fileTime = file.datenum;
            if (~strncmp(file.name, '.', 1)) && ~isempty(fileTime) && (fileTime > prs_lastRunTime)
                fprintf('%s has changed\n', file.name);
                actionToBeTaken(file.name);
        %         DO STUFF HERE
            end
        end
    end

    prs_lastRunTime = now;
return

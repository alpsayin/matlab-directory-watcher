matlab-directory-watcher
========================

A simple function that periodically checks a folder for changes and runs a function when a file in a "watched" directory is changed.

I wouldn't recommend it for folders with lots of files though.

function timerObj = detectFile(dirName, actionToBeTaken, newFilesOnly, period)
 
  dirName is the name for the directory to be watched for changes
  All file names which has been modified after the first run will
  be passed to the 'actionToBeTaken' function as a parameter in
  the form of absolute path
  
  To stop the watching process apply stop(timerObj) to the returned object
 
  Alp Sayin - alpsayin[at]alpsayin[dot]com
  29 Oct 2013

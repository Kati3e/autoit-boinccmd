# autoit-boinccmd
An AutoIt/BOINCcmd Wrapper

Please put the script inside your BOINC folder, where boinccmd.exe is located. In the future this will be changed so
it can run from anywhere.

Functions:
  switchProjects($project1, $project2) ; Project 1 suspends, Project 2 resumes
  sendCommand($command) ; Sends a command to boinccmd.exe and returns output
  getTasks($data) ; Get all tasks and save to global array $taskArray
  findProject($name) ; Search $taskArray for project name, returns array index or -1 if not found

v0.1
  Allows switching projects when one has no work units available.
    switchProjects($project1, $project2) ; Project 1 suspends, Project 2 resumes

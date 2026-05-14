# Linux4HPC

Build scripts for the Linux for HPC practical session, 
it contains self-guided Linux CLI exercises for researchers new to HPC. 
Covers navigation, file management, wildcards, pipes, grep, processes and environment modules.

Designed for the Iridis cluster at the University of Southampton.

## Usage

```bash
bash build_all.sh
```

Creates a `Linux4HPC/` directory with seven hands-on exercises.
Students copy this directory to their home directory and work through
the chapters one by one.

## Contents

| Directory | Topic | Key commands |
|---|---|---|
| 01_Navigation_Maze | Filesystem navigation | cd, ls, pwd, cat |
| 02_File_Management_Lab | Files and directories | mv, cp, rm, nano |
| 03_Wildcards_and_Pipes | Wildcards, counting, pipelines | *, ?, wc, sort, head, tail |
| 04_Search_and_Filter | Searching and filtering | grep, sort, uniq |
| 05_Scripting_and_Jobs | Processes and job scripts | ps, top, kill, bash |
| 06_Environment_Modules | Environment and software | printenv, module load |
| 07_Certificate | Permissions and reward | chmod |


## Licence

MIT Licence -- (c) 2026 Elena Vataga, University of Southampton.

If you use or adapt this material for teaching,
attribution is appreciated.

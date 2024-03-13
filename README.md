# ovh volume snapshoter

A easy way to take snapshots of any cinder cinder volumes from docker or kubernetes

Of course in kubernetes you can use CSI snapshot class to do the same but how to snapshot an external server for instance ?
This is why this project was created. enjoy.

## theory

- the main script is thought to run every day as a cronjob
- if the `DRY_RUN` var is true it will print what would have been done but will take no action
- if the `CLEANUP` var is true it will mark all pre-existing snapshots taken by the ovh-snapshoter (via metadata) before taking any other action
- if this succeed it will take a backup of all the volumes pointed by the `OS_VOLUMES` var
- finaly the script will clean all snapshots marked for cleanup

## contributing

- Of course PRs and suggestions are welcome
- You can start a dev container with vscode and start working on it right away

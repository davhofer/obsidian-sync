#!/bin/bash

VAULT="/home/david/Documents/obsidian/notes";
LOG="/home/david/Documents/obsidian/log_open.txt";

cd ${VAULT};
date > ${LOG};
git pull >> ${LOG};

while [ true ]; do
    # pull whenever a file or folder in the vault is accessed/opened
    # if you want to pull also in regular intervals, add -t <seconds> flag
    inotifywait -r -e access -e open ${VAULT};
    date > ${LOG};
    git pull >> ${LOG};
    # pull at most every 5 minutes
    sleep 300;
done

#!/bin/bash

VAULT="/home/david/Documents/obsidian/notes";
LOG="/home/david/Documents/obsidian/log_edit.txt";

cd ${VAULT};
while [ true ]; do
    # whenever any change or event detected, try to safe
    inotifywait -r -t 3600 --exclude "${VAULT}/.obsidian/workspace.json" ${VAULT};
    # give 30 seconds for editing, then save and start listening again
    sleep 30;
    git add .;
    git commit -m "auto backup: desktop";
    date > ${LOG};
    git push >> ${LOG};
done

# obsidian-sync
Utitlities for syncing obsidian notes between different devices, e.g. desktop and mobile (android).  
Notes are synced using a github remote repository. Each client queries the remote to get the latest changes when notes are being viewed, and pushes changes after files have been edited.

The basic assumptions here are that there is only a single user using those different clients, e.g. files aren't edited at the same time on different devices, and that the user won't switch between using one and then another device in a super short timespan, e.g. less than 5 minutes.

The idea is to use the `inotifywait` utility to check whether the vault or any file in it is either being opened or being edited, which allows for taking the appropriate action. When files have been opened, we simply `git pull` (as long as we didn't just do it already in the last few minutes). When files are being edited, we start a timer for X seconds (e.g. 30-60) and after that time commit & push to the remote, assuming that once a user starts typing they will do so for at least a short period of time and we don't want to create too many commits.  
Immediately after pulling/pushing, we listen again for events using `inotifywait`.  

Note that it might make sense to gitignore config files in `.obsidian`, depending on your preferences.

## Desktop (Linux)
On linux, the two bash scripts (one for the loading/pulling, one for the saving/pushing) can simply be started after reboot using cron jobs. Make sure to set up ssh keys for github such that the git commands complete without problems.

## Mobile (Android)
The setup for android is slightly more involved. In order to get git running on android, you can download the Termux app (https://termux.dev/en/) from F-Droid. With Termux you can then install (if not already installed) inotify utilities, git as well as setup local ssh keys, and use a similar setup as on linux. Instead of cron jobs, the jobs can be started by placing a bash file in the termux startup folder `/data/data/com.termux/files/usr/etc/profile.d/`, calling the two scripts asynchronously.
The only remaining thing to do is to make sure that termux is started automatically on boot. Apparently you can use the app MacroDroid for that, however this did not work reliably for me.

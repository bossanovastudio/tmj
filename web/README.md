# TMJ - Turma da Monica Jovem


##Initial Machine Setup
1. **Install [Node 4.0.0 or greater](https://nodejs.org)** - (5.0 or greater is recommended for optimal build performance). Need to run multiple versions of Node? Use [nvm](https://github.com/creationix/nvm).
2. **Install [Git](https://git-scm.com/downloads)**.
3. On a Mac? You're all set. If you're on Linux or Windows, complete the steps for your OS below.  

**On Linux:**  

 * Run this to [increase the limit](http://stackoverflow.com/questions/16748737/grunt-watch-error-waiting-fatal-error-watch-enospc) on the number of files Linux will watch. [Here's why](https://github.com/coryhouse/react-slingshot/issues/6).    
`echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p`

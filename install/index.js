const spawn = require('child_process').spawn;

spawn('sudo', ['npm', 'install', '-g', '--unsafe-perm', `@secrethub/cli@${process.env.INPUT_VERSION}`], { stdio: 'inherit' });

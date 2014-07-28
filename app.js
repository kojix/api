require('coffee-script/register');
var config, env;

config = require('./app/config');
for (env in config.env) {
  process.env[env] = config.env[env];
}

var pkg = require('./package.json');

var log = require('debug')(pkg.name);

// Clear Log
//if(process.env.NODE_ENV != 'production')
//  require('damn-utils').ConsoleUtil.clear();
for(env in process.env) {
  log(env+': '+process.env[env]);
}

log('Load API');
//require('./app/api');
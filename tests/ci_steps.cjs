// Load repository PDF assertions and native-checkbox compatibility.
// This interview uses ordinary page navigation; retain ALKiln's navigation wait.
const path = require('node:path');
const scope = require(path.join(process.env.ALKILN_PATH, 'lib/scope'));
const waitUntilContinued = scope.waitUntilContinued;
require('./steps.cjs');
scope.waitUntilContinued = waitUntilContinued;

"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const routes_1 = require("./src/api/routes");
const config_1 = require("./src/config");
async function main() {
    (0, config_1.testDotenv)();
    (0, routes_1.runApi)();
}
main();

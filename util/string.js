"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.formatStruct = exports.randomBytes = exports.stringToBytes32 = void 0;
const ethers_1 = require("ethers");
const { utils } = ethers_1.ethers;
function stringToBytes32(str) {
    return utils.formatBytes32String(str);
}
exports.stringToBytes32 = stringToBytes32;
function randomBytes(len) {
    return utils.hexlify(utils.randomBytes(len));
}
exports.randomBytes = randomBytes;
function formatStruct(struct) {
    const res = {};
    for (const [key, value] of Object.entries(struct)) {
        if (!isNaN(parseInt(key))) {
            continue;
        }
        res[key] = ethers_1.BigNumber.isBigNumber(value) ? ethers_1.BigNumber.from(value) : value;
    }
    return res;
}
exports.formatStruct = formatStruct;

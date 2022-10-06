"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.replaceAll = void 0;
function replaceAll(str, searchStr, replaceStr) {
    return str.split(searchStr).join(replaceStr);
}
exports.replaceAll = replaceAll;

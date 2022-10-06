"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.time = void 0;
const hardhat_1 = require("hardhat");
const ethers_1 = require("ethers");
async function advanceBlock() {
    await hardhat_1.network.provider.send("evm_mine", []);
}
async function latestBlock() {
    const block = await hardhat_1.ethers.provider.getBlock("latest");
    return ethers_1.BigNumber.from(block.number);
}
async function advanceBlockTo(target) {
    const currentBlock = await latestBlock();
    const start = Date.now();
    let notified;
    if (target.lt(currentBlock))
        throw Error(`Target block #(${target}) is lower than current block #(${currentBlock})`);
    while ((await latestBlock()).lt(target)) {
        if (!notified && Date.now() - start >= 5000) {
            notified = true;
            console.log("advanceBlockTo: Advancing too many blocks is causing this test to be slow.");
        }
        await advanceBlock();
    }
}
async function latest() {
    const block = await hardhat_1.ethers.provider.getBlock("latest");
    return ethers_1.BigNumber.from(block.timestamp);
}
async function increase(duration) {
    await hardhat_1.network.provider.send("evm_increaseTime", [duration.toNumber()]);
    await advanceBlock();
}
async function increaseTo(target) {
    const now = await latest();
    if (target.lt(now))
        throw Error(`Cannot increase current time (${now}) to a moment in the past (${target})`);
    const diff = target.sub(now);
    await increase(diff);
}
const duration = {
    seconds: function (val) {
        return ethers_1.BigNumber.from(val);
    },
    minutes: function (val) {
        return ethers_1.BigNumber.from(val).mul(this.seconds("60"));
    },
    hours: function (val) {
        return ethers_1.BigNumber.from(val).mul(this.minutes("60"));
    },
    days: function (val) {
        return ethers_1.BigNumber.from(val).mul(this.hours("24"));
    },
    weeks: function (val) {
        return ethers_1.BigNumber.from(val).mul(this.days("7"));
    },
    years: function (val) {
        return ethers_1.BigNumber.from(val).mul(this.days("365"));
    },
};
exports.time = {
    duration,
    increaseTo,
    latest,
    advanceBlockTo,
    latestBlock,
};

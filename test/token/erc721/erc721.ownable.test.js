"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const hardhat_1 = require("hardhat");
const ethers_1 = require("ethers");
const time_1 = require("../../../util/time");
const generator_1 = require("../../../util/generator");
const { AddressZero, Zero, One, Two } = hardhat_1.ethers.constants;
const Three = ethers_1.BigNumber.from(3);
const { duration, increaseTo, latest } = time_1.time;
describe("ERC721OwnableMock", function () {
    // Players
    let owner;
    let user1;
    let user2;
    let user3;
    // Token Init Property
    let token;
    let tokenName = "ERC721OwnableMock";
    let tokenSymbol = "EOMK";
    let tokenDecimals = 18;
    let tokenInitalSupplyRaw = "1000";
    let tokenInitialSupply = ethers_1.BigNumber.from(tokenInitalSupplyRaw).mul(ethers_1.BigNumber.from(10).pow(tokenDecimals));
    let tokenSupplyCappedRaw = "10000";
    let tokenSupplyCapped = ethers_1.BigNumber.from(tokenSupplyCappedRaw).mul(ethers_1.BigNumber.from(10).pow(tokenDecimals));
    before(async function () {
        (0, generator_1.generateERC721Mocks)({
            metadata: {
                name: tokenName,
                symbol: tokenSymbol,
            },
            features: {
            // burnable: true,
            // pausable: true,
            // freezable: true,
            // batchTransferable: true,
            },
        });
        const accounts = await hardhat_1.ethers.getSigners();
        [owner, user1, user2, user3] = accounts;
    });
    beforeEach(async function () {
        const tokenContract = await hardhat_1.ethers.getContractFactory(tokenName, owner);
        token = await tokenContract.deploy();
    });
    describe("", () => {
        it("", async () => {
            console.log("");
        });
    });
});

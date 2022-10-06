"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateERC1155Mocks = exports.generateERC721Mocks = exports.generateERC20Mocks = void 0;
const standard_contract_wizard_1 = require("@seongeun/standard-contract-wizard");
const fs = __importStar(require("fs"));
const replace_1 = require("./replace");
const changepath = {
    old: "@seongeun/standard-contract/contracts",
    new: "../../..",
};
const replacePath = (code) => {
    return (0, replace_1.replaceAll)(code, changepath.old, changepath.new);
};
const generateERC20Mocks = (opts) => {
    const { print } = standard_contract_wizard_1.erc20;
    fs.writeFileSync(`contracts/mock/token/erc20/${opts.metadata.name}.sol`, replacePath(print(opts)));
};
exports.generateERC20Mocks = generateERC20Mocks;
const generateERC721Mocks = (opts) => {
    const { print } = standard_contract_wizard_1.erc721;
    fs.writeFileSync(`contracts/mock/token/erc721/${opts.metadata.name}.sol`, replacePath(print(opts)));
};
exports.generateERC721Mocks = generateERC721Mocks;
const generateERC1155Mocks = (opts) => {
    const { print } = standard_contract_wizard_1.erc1155;
    fs.writeFileSync(`contracts/mock/token/erc1155/${opts.metadata.name}.sol`, replacePath(print(opts)));
};
exports.generateERC1155Mocks = generateERC1155Mocks;

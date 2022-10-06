import {
  erc1155,
  ERC1155Options,
  erc20,
  ERC20Options,
  erc721,
  ERC721Options,
} from "@seongeun/standard-contract-wizard";
import * as fs from "fs";
import { replaceAll } from "./replace";

const changepath = {
  old: "@seongeun/standard-contract/contracts",
  new: "../../..",
};

const replacePath = (code: string) => {
  return replaceAll(code, changepath.old, changepath.new);
};

export const generateERC20Mocks = (opts: ERC20Options) => {
  const { print } = erc20;

  fs.writeFileSync(
    `contracts/mock/token/erc20/${opts.metadata.name}.sol`,
    replacePath(print(opts))
  );
};

export const generateERC721Mocks = (opts: ERC721Options) => {
  const { print } = erc721;

  fs.writeFileSync(
    `contracts/mock/token/erc721/${opts.metadata.name}.sol`,
    replacePath(print(opts))
  );
};

export const generateERC1155Mocks = (opts: ERC1155Options) => {
  const { print } = erc1155;

  fs.writeFileSync(
    `contracts/mock/token/erc1155/${opts.metadata.name}.sol`,
    replacePath(print(opts))
  );
};

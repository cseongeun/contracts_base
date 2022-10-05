import { erc20, ERC20Options } from "@seongeun/standard-contract-wizard";
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

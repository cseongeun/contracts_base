import { ethers } from "hardhat";
import { expect } from "chai";
import { BigNumber, Contract } from "ethers";
import { time } from "../../../util/time";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { formatStruct, randomBytes } from "../../../util/string";
import { generateERC721Mocks } from "../../../util/generator";

const { AddressZero, Zero, One, Two } = ethers.constants;
const Three: BigNumber = BigNumber.from(3);

const { duration, increaseTo, latest } = time;

describe("ERC721OwnableMock", function () {
  // Players
  let owner: SignerWithAddress;
  let user1: SignerWithAddress;
  let user2: SignerWithAddress;
  let user3: SignerWithAddress;

  // Token Init Property
  let token: Contract;
  let tokenName: string = "ERC721OwnableMock";
  let tokenSymbol: string = "EOMK";
  let tokenDecimals: number = 18;
  let tokenInitalSupplyRaw: string = "1000";
  let tokenInitialSupply: BigNumber = BigNumber.from(tokenInitalSupplyRaw).mul(
    BigNumber.from(10).pow(tokenDecimals)
  );
  let tokenSupplyCappedRaw: string = "10000";
  let tokenSupplyCapped: BigNumber = BigNumber.from(tokenSupplyCappedRaw).mul(
    BigNumber.from(10).pow(tokenDecimals)
  );

  before(async function () {
    generateERC721Mocks({
      metadata: {
        name: tokenName,
        symbol: tokenSymbol,
      },
      features: {
        burnable: true,
        pausable: true,
        autoIncrementId: true,
        freezable: true,
      },
    });

    const accounts = await ethers.getSigners();
    [owner, user1, user2, user3] = accounts;
  });

  beforeEach(async function () {
    const tokenContract = await ethers.getContractFactory(tokenName, owner);
    token = await tokenContract.deploy();
  });
  describe("", () => {
    it("", async () => {
      console.log("");
    });
  });
});

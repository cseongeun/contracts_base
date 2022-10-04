import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import {
  BN,
  constants,
  expectEvent,
  expectRevert,
} from "@openzeppelin/test-helpers";
import { BigNumber, Contract } from "ethers";
const { expect } = require("chai");
const { ZERO_ADDRESS, MAX_UINT256 } = constants;

function shouldBehaveLikeERC20(
  token: Contract,
  errorPrefix: string,
  initialSupply: BigNumber,
  initialHolder: SignerWithAddress,
  recipient: SignerWithAddress,
  anotherAccount: SignerWithAddress
) {
  describe("total supply", function () {
    it("returns the total amount of tokens", async function () {
      expect(await token.totalSupply()).to.be.bignumber.equal(initialSupply);
    });
  });

  describe("balanceOf", function () {
    describe("when the requested account has no tokens", function () {
      it("returns zero", async function () {
        expect(await token.balanceOf(anotherAccount)).to.be.bignumber.equal(
          "0"
        );
      });
    });

    describe("when the requested account has some tokens", function () {
      it("returns the total amount of tokens", async function () {
        expect(
          await token.balanceOf(initialHolder.address)
        ).to.be.bignumber.equal(initialSupply);
      });
    });
  });

  describe("transfer", function () {
    shouldBehaveLikeERC20Transfer(
      errorPrefix,
      initialHolder,
      recipient,
      initialSupply,
      function (
        from: SignerWithAddress,
        to: SignerWithAddress,
        value: BigNumber
      ) {
        return token.connect(from).transfer(to.address, value);
      }
    );
  });

  describe("transfer from", function () {
    const spender = recipient;

    describe("when the token owner is not the zero address", function () {
      const tokenOwner = initialHolder;

      describe("when the recipient is not the zero address", function () {
        const to = anotherAccount;

        describe("when the spender has enough allowance", function () {
          beforeEach(async function () {
            await token
              .connect(initialHolder)
              .approve(spender.address, initialSupply);
          });

          describe("when the token owner has enough balance", function () {
            const amount = initialSupply;

            it("transfers the requested amount", async function () {
              await token
                .connect(spender)
                .transferFrom(tokenOwner.address, to.address, amount);

              expect(
                await token.balanceOf(tokenOwner.address)
              ).to.be.bignumber.equal("0");

              expect(await token.balanceOf(to)).to.be.bignumber.equal(amount);
            });

            it("decreases the spender allowance", async function () {
              await token
                .connect(spender)
                .transferFrom(tokenOwner.address, to.address, amount);

              expect(
                await token.allowance(tokenOwner.address, spender.address)
              ).to.be.bignumber.equal("0");
            });

            it("emits a transfer event", async function () {
              expectEvent(
                await token
                  .connect(spender)
                  .transferFrom(tokenOwner.address, to.address, amount),
                "Transfer",
                { from: tokenOwner.address, to: to.address, value: amount }
              );
            });

            it("emits an approval event", async function () {
              expectEvent(
                await token.transferFrom(
                  tokenOwner.address,
                  to.address,
                  amount,
                  {
                    from: spender.address,
                  }
                ),
                "Approval",
                {
                  owner: tokenOwner,
                  spender: spender,
                  value: await token.allowance(tokenOwner, spender),
                }
              );
            });
          });

          describe("when the token owner does not have enough balance", function () {
            const amount = initialSupply;

            beforeEach("reducing balance", async function () {
              await token.transfer(to, 1, { from: tokenOwner });
            });

            it("reverts", async function () {
              await expectRevert(
                token.transferFrom(tokenOwner, to, amount, {
                  from: spender,
                }),
                `${errorPrefix}: transfer amount exceeds balance`
              );
            });
          });
        });

        describe("when the spender does not have enough allowance", function () {
          const allowance = initialSupply.subn(1);

          beforeEach(async function () {
            await token.approve(spender, allowance, { from: tokenOwner });
          });

          describe("when the token owner has enough balance", function () {
            const amount = initialSupply;

            it("reverts", async function () {
              await expectRevert(
                token.transferFrom(tokenOwner, to, amount, {
                  from: spender,
                }),
                `${errorPrefix}: insufficient allowance`
              );
            });
          });

          describe("when the token owner does not have enough balance", function () {
            const amount = allowance;

            beforeEach("reducing balance", async function () {
              await token.transfer(to, 2, { from: tokenOwner });
            });

            it("reverts", async function () {
              await expectRevert(
                token.transferFrom(tokenOwner, to, amount, {
                  from: spender,
                }),
                `${errorPrefix}: transfer amount exceeds balance`
              );
            });
          });
        });

        describe("when the spender has unlimited allowance", function () {
          beforeEach(async function () {
            await token.approve(spender, MAX_UINT256, {
              from: initialHolder,
            });
          });

          it("does not decrease the spender allowance", async function () {
            await token.transferFrom(tokenOwner, to, 1, { from: spender });

            expect(
              await token.allowance(tokenOwner, spender)
            ).to.be.bignumber.equal(MAX_UINT256);
          });

          it("does not emit an approval event", async function () {
            expectEvent.notEmitted(
              await token.transferFrom(tokenOwner, to, 1, {
                from: spender,
              }),
              "Approval"
            );
          });
        });
      });

      describe("when the recipient is the zero address", function () {
        const amount = initialSupply;
        const to = ZERO_ADDRESS;

        beforeEach(async function () {
          await token.approve(spender, amount, { from: tokenOwner });
        });

        it("reverts", async function () {
          await expectRevert(
            token.transferFrom(tokenOwner, to, amount, { from: spender }),
            `${errorPrefix}: transfer to the zero address`
          );
        });
      });
    });

    describe("when the token owner is the zero address", function () {
      const amount = 0;
      const tokenOwner = ZERO_ADDRESS;
      const to = recipient;

      it("reverts", async function () {
        await expectRevert(
          token.transferFrom(tokenOwner, to, amount, { from: spender }),
          "from the zero address"
        );
      });
    });
  });

  describe("approve", function () {
    shouldBehaveLikeERC20Approve(
      errorPrefix,
      initialHolder,
      recipient,
      initialSupply,
      function (owner, spender, amount) {
        return token.approve(spender, amount, { from: owner });
      }
    );
  });
}

function shouldBehaveLikeERC20Transfer(
  errorPrefix,
  from,
  to,
  balance,
  transfer
) {
  describe("when the recipient is not the zero address", function () {
    describe("when the sender does not have enough balance", function () {
      const amount = balance.addn(1);

      it("reverts", async function () {
        await expectRevert(
          transfer.call(this, from, to, amount),
          `${errorPrefix}: transfer amount exceeds balance`
        );
      });
    });

    describe("when the sender transfers all balance", function () {
      const amount = balance;

      it("transfers the requested amount", async function () {
        await transfer.call(this, from, to, amount);

        expect(await token.balanceOf(from)).to.be.bignumber.equal("0");

        expect(await token.balanceOf(to)).to.be.bignumber.equal(amount);
      });

      it("emits a transfer event", async function () {
        expectEvent(await transfer.call(this, from, to, amount), "Transfer", {
          from,
          to,
          value: amount,
        });
      });
    });

    describe("when the sender transfers zero tokens", function () {
      const amount = new BN("0");

      it("transfers the requested amount", async function () {
        await transfer.call(this, from, to, amount);

        expect(await token.balanceOf(from)).to.be.bignumber.equal(balance);

        expect(await token.balanceOf(to)).to.be.bignumber.equal("0");
      });

      it("emits a transfer event", async function () {
        expectEvent(await transfer.call(this, from, to, amount), "Transfer", {
          from,
          to,
          value: amount,
        });
      });
    });
  });

  describe("when the recipient is the zero address", function () {
    it("reverts", async function () {
      await expectRevert(
        transfer.call(this, from, ZERO_ADDRESS, balance),
        `${errorPrefix}: transfer to the zero address`
      );
    });
  });
}

function shouldBehaveLikeERC20Approve(
  errorPrefix,
  owner,
  spender,
  supply,
  approve
) {
  describe("when the spender is not the zero address", function () {
    describe("when the sender has enough balance", function () {
      const amount = supply;

      it("emits an approval event", async function () {
        expectEvent(
          await approve.call(this, owner, spender, amount),
          "Approval",
          { owner: owner, spender: spender, value: amount }
        );
      });

      describe("when there was no approved amount before", function () {
        it("approves the requested amount", async function () {
          await approve.call(this, owner, spender, amount);

          expect(await token.allowance(owner, spender)).to.be.bignumber.equal(
            amount
          );
        });
      });

      describe("when the spender had an approved amount", function () {
        beforeEach(async function () {
          await approve.call(this, owner, spender, new BN(1));
        });

        it("approves the requested amount and replaces the previous one", async function () {
          await approve.call(this, owner, spender, amount);

          expect(await token.allowance(owner, spender)).to.be.bignumber.equal(
            amount
          );
        });
      });
    });

    describe("when the sender does not have enough balance", function () {
      const amount = supply.addn(1);

      it("emits an approval event", async function () {
        expectEvent(
          await approve.call(this, owner, spender, amount),
          "Approval",
          { owner: owner, spender: spender, value: amount }
        );
      });

      describe("when there was no approved amount before", function () {
        it("approves the requested amount", async function () {
          await approve.call(this, owner, spender, amount);

          expect(await token.allowance(owner, spender)).to.be.bignumber.equal(
            amount
          );
        });
      });

      describe("when the spender had an approved amount", function () {
        beforeEach(async function () {
          await approve.call(this, owner, spender, new BN(1));
        });

        it("approves the requested amount and replaces the previous one", async function () {
          await approve.call(this, owner, spender, amount);

          expect(await token.allowance(owner, spender)).to.be.bignumber.equal(
            amount
          );
        });
      });
    });
  });

  describe("when the spender is the zero address", function () {
    it("reverts", async function () {
      await expectRevert(
        approve.call(this, owner, ZERO_ADDRESS, supply),
        `${errorPrefix}: approve to the zero address`
      );
    });
  });
}

module.exports = {
  shouldBehaveLikeERC20,
  shouldBehaveLikeERC20Transfer,
  shouldBehaveLikeERC20Approve,
};

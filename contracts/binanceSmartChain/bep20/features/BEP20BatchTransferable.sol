// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BEP20 } from "@openzeppelin/contracts/token/BEP20/BEP20.sol";

/**
 * @dev Extension of {BEP20} that adds batch transfer of tokens.
 */
abstract contract BEP20BatchTransferable is BEP20 {
  /**
   * @dev Batch transfer of multiple tokens to multiple addresses
   *
   * Requirements:
   *
   * - the number of 'accounts' and the number of 'amounts' must be the same.
   */
  function batchTransfer(
    address[] calldata accounts,
    uint256[] calldata amounts
  ) public virtual override returns (bool) {
    require(
      accounts.length == amounts.length,
      "BEP20BatchTransferable: invalid length"
    );

    for (uint256 i = 0; i < accounts.length; i++) {
      require(
        transfer(accounts[i], amounts[i]),
        string(
          abi.encodePacked(
            "BEP20BatchTransfable: can not transfer ",
            Strings.toHexString(uint256(amounts[i]), 32),
            "tokens to ",
            Strings.toHexString(uint160(accounts[index]), 20)
          )
        )
      );
    }

    return true;
  }
}

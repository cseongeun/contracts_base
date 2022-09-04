// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { KIP7 } from "@openzeppelin/contracts/token/KIP7/KIP7.sol";

/**
 * @dev Extension of {KIP7} that adds batch transfer of tokens.
 */
abstract contract KIP7BatchTransferable is KIP7 {
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
      "KIP7BatchTransferable: invalid length"
    );

    for (uint256 i = 0; i < accounts.length; i++) {
      require(
        transfer(accounts[i], amounts[i]),
        string(
          abi.encodePacked(
            "KIP7BatchTransfable: can not transfer ",
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

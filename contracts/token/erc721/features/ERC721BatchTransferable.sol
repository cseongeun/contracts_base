// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC721 } from "../ERC721.sol";
import { Strings } from "../../../common/utils/Strings.sol";

/**
 * @dev Extension of {ERC721} that adds batch transfer of tokens.
 */
abstract contract ERC721BatchTransferable is ERC721 {
  /**
   * @dev Batch transfer of multiple tokens to multiple addresses
   *
   * Requirements:
   *
   * - the number of 'accounts' and the id of 'tokenIds' must be the same.
   */
  function batchTransfer(
    address[] calldata accounts,
    uint256[] calldata tokenIds
  ) public virtual returns (bool) {
    require(
      accounts.length == tokenIds.length,
      "BatchTransferable: invalid length"
    );

    for (uint256 i = 0; i < accounts.length; i++) {
      require(
        transferFrom(_msgSender(), accounts[i], tokenIds[i]),
        string(
          abi.encodePacked(
            "BatchTransfable: can not transfer ",
            Strings.toString(tokenIds[i]),
            "ID to ",
            Strings.toHexString(uint160(accounts[i]), 20)
          )
        )
      );
    }

    return true;
  }
}

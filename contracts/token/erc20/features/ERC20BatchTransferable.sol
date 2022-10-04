// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20 } from "../ERC20.sol";
import { Strings } from "../../../common/utils/Strings.sol";
import { IERC20BatchTransferable } from "../interfaces/IERC20BatchTransferable.sol";

/**
 * @dev Extension of {ERC20} that adds batch transfer of tokens.
 */
abstract contract ERC20BatchTransferable is ERC20, IERC20BatchTransferable {
  /**
   * @dev See {IERC165-supportsInterface}.
   */
  function supportsInterface(bytes4 interfaceId)
    public
    view
    virtual
    override(ERC20)
    returns (bool)
  {
    return
      interfaceId == type(IERC20BatchTransferable).interfaceId ||
      super.supportsInterface(interfaceId);
  }

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
  ) public virtual returns (bool) {
    require(
      accounts.length == amounts.length,
      "ERC20BatchTransferable: invalid length"
    );

    for (uint256 i = 0; i < accounts.length; i++) {
      require(
        transfer(accounts[i], amounts[i]),
        string(
          abi.encodePacked(
            "ERC20BatchTransfable: can not transfer ",
            uint256(amounts[i]),
            "tokens to ",
            Strings.toHexString(uint160(accounts[i]), 20)
          )
        )
      );
    }

    return true;
  }
}

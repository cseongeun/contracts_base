// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20 } from "../../../token/erc20/ERC20.sol";
import { ERC20SafeTransferable } from "../../../token/erc20/features/ERC20SafeTransferable.sol";

contract ERC20SafeTransferableMock is ERC20, ERC20SafeTransferable {
  /**
   * @dev See {IERC165-supportsInterface}.
   */
  function supportsInterface(bytes4 interfaceId)
    public
    view
    virtual
    override(ERC20, ERC20SafeTransferable)
    returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }

  constructor(
    string memory name_,
    string memory symbol_,
    uint256 cap_
  ) ERC20(name_, symbol_) {}
}

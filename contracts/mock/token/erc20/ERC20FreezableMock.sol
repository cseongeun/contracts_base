// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20 } from "../../../token/erc20/ERC20.sol";
import { ERC20Freezable } from "../../../token/erc20/features/ERC20Freezable.sol";

contract ERC20FreezableMock is ERC20, ERC20Freezable {
  /**
   * @dev See {IERC165-supportsInterface}.
   */
  function supportsInterface(bytes4 interfaceId)
    public
    view
    virtual
    override(ERC20, ERC20Freezable)
    returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }

  constructor(
    string memory name_,
    string memory symbol_,
    uint256 cap_
  ) ERC20(name_, symbol_) {}

  function freeze(address account) public {
    freeze(account);
  }

  function unfreeze(address account) public {
    unfreeze(account);
  }

  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) internal virtual override(ERC20, ERC20Freezable) {
    super._beforeTokenTransfer(from, to, amount);
  }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20 } from "../../../token/erc20/ERC20.sol";
import { ERC20Pausable } from "../../../token/erc20/features/ERC20Pausable.sol";

contract ERC20PausableMock is ERC20, ERC20Pausable {
  /**
   * @dev See {IERC165-supportsInterface}.
   */
  function supportsInterface(bytes4 interfaceId)
    public
    view
    virtual
    override(ERC20, ERC20Pausable)
    returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }

  constructor(
    string memory name_,
    string memory symbol_,
    uint256 cap_
  ) ERC20(name_, symbol_) {}

  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) internal virtual override(ERC20, ERC20Pausable) {
    super._beforeTokenTransfer(from, to, amount);
  }
}

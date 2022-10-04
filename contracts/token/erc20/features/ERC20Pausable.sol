// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ERC20.sol";
import "../../../common/security/Pausable.sol";

abstract contract ERC20Pausable is ERC20, Pausable {
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
      interfaceId == type(IPausable).interfaceId ||
      super.supportsInterface(interfaceId);
  }

  /**
   * @dev See {ERC20-_beforeTokenTransfer}.
   *
   * Requirements:
   *
   * - the contract must not be paused.
   */
  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) internal virtual override {
    super._beforeTokenTransfer(from, to, amount);

    require(!paused(), "ERC20Pausable: token transfer while paused");
  }
}

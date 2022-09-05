// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../BEP20.sol";
import "../../../common/security/Pausable.sol";

abstract contract BEP20Pausable is BEP20, Pausable {
  /**
   * @dev See {BEP20-_beforeTokenTransfer}.
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

    require(!paused(), "BEP20Pausable: token transfer while paused");
  }
}

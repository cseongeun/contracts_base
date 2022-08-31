// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { KIP7 } from "@klaytn/contracts/KIP/token/KIP7/KIP7.sol";
import { Pausable } from "@openzeppelin/contracts/security/Pausable.sol";

abstract contract KIP7Pausable is KIP7, Pausable {
  /**
   * @dev See {KIP7-_beforeTokenTransfer}.
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

    require(!paused(), "KIP7Pausable: token transfer while paused");
  }
}

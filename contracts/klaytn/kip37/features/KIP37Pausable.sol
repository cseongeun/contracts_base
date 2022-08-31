// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { KIP37 } from "@klaytn/contracts/KIP/token/KIP37/KIP37.sol";
import { Pausable } from "@openzeppelin/contracts/security/Pausable.sol";

abstract contract KIP37Pausable is KIP37, Pausable {
  /**
   * @dev See {KIP37-_beforeTokenTransfer}.
   *
   * Requirements:
   *
   * - the contract must not be paused.
   */
  function _beforeTokenTransfer(
    address operator,
    address from,
    address to,
    uint256[] memory ids,
    uint256[] memory amounts,
    bytes memory data
  ) internal virtual override {
    super._beforeTokenTransfer(operator, from, to, ids, amounts, data);

    require(!paused(), "KIP37Pausable: token transfer while paused");
  }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { KIP17 } from "../KIP17.sol";
import { Pausable } from "@openzeppelin/contracts/security/Pausable.sol";

abstract contract KIP17Pausable is KIP17, Pausable {
  /**
   * @dev See {KIP17-_beforeTokenTransfer}.
   *
   * Requirements:
   *
   * - the contract must not be paused.
   */
  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 tokenId
  ) internal virtual override {
    super._beforeTokenTransfer(from, to, tokenId);

    require(!paused(), "KIP17Pausable: token transfer while paused");
  }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { KIP37 } from "../KIP37.sol";
import { Pausable } from "../../../common/security/Pausable.sol";

/**
 * @dev KIP37 token with pausable token transfers, minting and burning.
 *
 * Useful for scenarios such as preventing trades until the end of an evaluation
 * period, or having an emergency switch for freezing all token transfers in the
 * event of a large bug.
 *
 * _Available since v3.1._
 */
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

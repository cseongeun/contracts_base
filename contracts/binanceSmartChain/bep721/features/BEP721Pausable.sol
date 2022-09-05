// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { BEP721 } from "../BEP721.sol";
import { Pausable } from "../../../common/security/Pausable.sol";

/**
 * @dev BEP721 token with pausable token transfers, minting and burning.
 *
 * Useful for scenarios such as preventing trades until the end of an evaluation
 * period, or having an emergency switch for freezing all token transfers in the
 * event of a large bug.
 */
abstract contract BEP721Pausable is BEP721, Pausable {
  /**
   * @dev See {BEP721-_beforeTokenTransfer}.
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

    require(!paused(), "BEP721Pausable: token transfer while paused");
  }
}

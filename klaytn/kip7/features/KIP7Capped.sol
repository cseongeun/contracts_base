// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { KIP7 } from "../KIP7.sol";

/**
 * @dev Extension of {KIP7} that adds a cap to the supply of tokens.
 */
abstract contract KIP7Capped is KIP7 {
  uint256 private immutable _cap;

  function _setCap(uint256 cap_) internal virtual {
    require(cap_ > 0, "KIP7Capped: cap is 0");
    _cap = cap_;
  }

  /**
   * @dev Returns the cap on the token's total supply.
   */
  function cap() public view virtual returns (uint256) {
    return _cap;
  }

  /**
   * @dev See {KIP7-_mint}.
   */
  function _mint(address account, uint256 amount) internal virtual override {
    require(KIP7.totalSupply() + amount <= cap(), "KIP7Capped: cap exceeded");
    super._mint(account, amount);
  }
}

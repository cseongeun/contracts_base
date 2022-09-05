// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BEP20 } from "../BEP20.sol";

/**
 * @dev Extension of {BEP20} that adds a cap to the supply of tokens.
 */
abstract contract BEP20Capped is BEP20 {
  uint256 private _cap;

  function _setCap(uint256 cap_) internal virtual {
    require(cap_ > 0, "BEP20Capped: cap is 0");
    _cap = cap_;
  }

  /**
   * @dev Returns the cap on the token's total supply.
   */
  function cap() public view virtual returns (uint256) {
    return _cap;
  }

  /**
   * @dev See {BEP20-_mint}.
   */
  function _mint(address account, uint256 amount) internal virtual override {
    require(BEP20.totalSupply() + amount <= cap(), "BEP20Capped: cap exceeded");
    super._mint(account, amount);
  }
}

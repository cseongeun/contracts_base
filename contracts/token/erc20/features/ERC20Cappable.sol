// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20 } from "../ERC20.sol";
import { IERC20Cappable } from "../interfaces/IERC20Cappable.sol";

/**
 * @dev Extension of {ERC20} that adds a cap to the supply of tokens.
 */
abstract contract ERC20Cappable is ERC20, IERC20Cappable {
  uint256 private _cap;

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
      interfaceId == type(IERC20Cappable).interfaceId ||
      super.supportsInterface(interfaceId);
  }

  function _setCap(uint256 cap_) internal virtual {
    require(cap_ > 0, "ERC20Cappable: cap is 0");
    _cap = cap_;
  }

  /**
   * @dev Returns the cap on the token's total supply.
   */
  function cap() public view virtual returns (uint256) {
    return _cap;
  }

  /**
   * @dev See {ERC20-_mint}.
   */
  function _mint(address account, uint256 amount) internal virtual override {
    require(
      ERC20.totalSupply() + amount <= cap(),
      "ERC20Cappable: cap exceeded"
    );
    super._mint(account, amount);
  }
}

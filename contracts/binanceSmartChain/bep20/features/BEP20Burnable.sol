// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BEP20 } from "../BEP20.sol";
import { Context } from "../../../common/utils/Context.sol";

abstract contract BEP20Burnable is Context, BEP20 {
  /**
   * @dev Destroys `amount` tokens from the caller.
   *
   * See {BEP20-_burn}.
   */
  function burn(uint256 amount) public virtual {
    _burn(_msgSender(), amount);
  }

  /**
   * @dev Destroys `amount` tokens from `account`, deducting from the caller's
   * allowance.
   *
   * See {BEP20-_burn} and {BEP20-allowance}.
   *
   * Requirements:
   *
   * - the caller must have allowance for ``accounts``'s tokens of at least
   * `amount`.
   */
  function burnFrom(address account, uint256 amount) public virtual {
    _spendAllowance(account, _msgSender(), amount);
    _burn(account, amount);
  }
}

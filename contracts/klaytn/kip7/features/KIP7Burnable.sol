// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Context } from "../../../common/utils/Context.sol";
import { KIP7 } from "../KIP7.sol";
import { IKIP7Burnable } from "../interfaces/IKIP7Burnable.sol";

abstract contract KIP7Burnable is Context, KIP7, IKIP7Burnable {
  /**
   * @dev See {IKIP13-supportsInterface}.
   */
  function supportsInterface(bytes4 interfaceId)
    public
    view
    virtual
    override
    returns (bool)
  {
    return
      interfaceId == type(IKIP7Burnable).interfaceId ||
      KIP7.supportsInterface(interfaceId);
  }

  /**
   * @dev Destroys `amount` tokens from the caller.
   *
   * See {KIP7-_burn}.
   *
   * Requirements:
   *
   * - caller's balance must be greater than or equal to `_amount`
   */
  function burn(uint256 amount) public virtual {
    _burn(_msgSender(), amount);
  }

  /**
   * @dev Destroys `amount` tokens from `account`, deducting from the caller's
   * allowance.
   *
   * See {KIP7-_burn} and {KIP7-allowance}.
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
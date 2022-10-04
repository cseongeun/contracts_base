// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20 } from "../ERC20.sol";
import { Context } from "../../../common/utils/Context.sol";
import { IERC20Burnable } from "../interfaces/IERC20Burnable.sol";

abstract contract ERC20Burnable is Context, ERC20, IERC20Burnable {
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
      interfaceId == type(IERC20Burnable).interfaceId ||
      super.supportsInterface(interfaceId);
  }

  /**
   * @dev Destroys `amount` tokens from the caller.
   *
   * See {ERC20-_burn}.
   */
  function burn(uint256 amount) public virtual {
    _burn(_msgSender(), amount);
  }

  /**
   * @dev Destroys `amount` tokens from `account`, deducting from the caller's
   * allowance.
   *
   * See {ERC20-_burn} and {ERC20-allowance}.
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

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20 } from "../ERC20.sol";
import { IERC20Freezable } from "../interfaces/IERC20Freezable.sol";

abstract contract ERC20Freezable is ERC20, IERC20Freezable {
  /**
   * @dev user freezed
   * */
  mapping(address => bool) private freezed;

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
      interfaceId == type(IERC20Freezable).interfaceId ||
      super.supportsInterface(interfaceId);
  }

  /**
   * @dev  Returns true if account is freezed, and false otherwise.
   *
   * @param account The address
   */
  function isFreezed(address account) public view returns (bool) {
    return freezed[account];
  }

  function _freeze(address account) internal virtual {
    freezed[account] = true;
    emit Freezed(account);
  }

  function _unfreeze(address account) internal virtual {
    freezed[account] = false;
    emit UnFreezed(account);
  }

  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) internal virtual override {
    super._beforeTokenTransfer(from, to, amount);

    require(!freezed[from], "ERC20Freezable: from freezed");
    require(!freezed[_msgSender()], "ERC20Freezable: sender freezed");
  }
}

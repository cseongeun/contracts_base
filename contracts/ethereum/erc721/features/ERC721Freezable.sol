// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

abstract contract ERC20Freezable is ERC721 {
  /**
   * @dev user freezed
   * */
  mapping(address => bool) private freezed;

  /**
   * @dev Emitted when user freezed
   */
  event Freezed(address account);

  /**
   * @dev Emitted when user unfreezed
   */
  event UnFreezed(address account);

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
    uint256 tokenId
  ) internal virtual override {
    super._beforeTokenTransfer(from, to, tokenId);

    require(!freezed[from], "ERC20Freezable: from freezed");
    require(!freezed[_msgSender()], "ERC20Freezable: sender freezed");
  }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20 } from "../../../token/erc20/ERC20.sol";
import { ERC20Lockable } from "../../../token/erc20/features/ERC20Lockable.sol";

contract ERC20LockableMock is ERC20 {
  // /**
  //  * @dev See {IERC165-supportsInterface}.
  //  */
  // function supportsInterface(bytes4 interfaceId)
  //   public
  //   view
  //   virtual
  //   override(ERC20, ERC20Lockable)
  //   returns (bool)
  // {
  //   return super.supportsInterface(interfaceId);
  // }
  constructor(
    string memory name_,
    string memory symbol_,
    uint256 cap_
  ) ERC20(name_, symbol_) {}
  // /**
  //  * @dev See {IERC20-balanceOf}.
  //  */
  // function balanceOf(address account)
  //   public
  //   view
  //   virtual
  //   override(ERC20, ERC20Lockable)
  //   returns (uint256)
  // {
  //   return balanceOf(account);
  // }
  // function lock(
  //   address account,
  //   uint256 amount,
  //   bytes32 reason,
  //   uint256 release
  // ) public returns (bool) {
  //   return _lock(account, amount, reason, release);
  // }
  // function batchLock(
  //   address[] calldata accounts,
  //   uint256[] calldata amounts,
  //   bytes32[] calldata reasons,
  //   uint256[] calldata releases
  // ) public returns (bool) {
  //   return _batchLock(accounts, amounts, reasons, releases);
  // }
  // function transferWithLock(
  //   address account,
  //   uint256 amount,
  //   bytes32 reason,
  //   uint256 release
  // ) internal virtual returns (bool) {
  //   return _transferWithLock(account, amount, reason, release);
  // }
  // function batchTransferWithLock(
  //   address[] calldata accounts,
  //   uint256[] calldata amounts,
  //   bytes32[] calldata reasons,
  //   uint256[] calldata releases
  // ) public returns (bool) {
  //   return _batchTransferWithLock(accounts, amounts, reasons, releases);
  // }
  // function extendLock(
  //   address account,
  //   bytes32 reason,
  //   uint256 time
  // ) public returns (bool) {
  //   return _extendLock(account, reason, time);
  // }
  // function increaseLockAmount(
  //   address account,
  //   bytes32 reason,
  //   uint256 amount
  // ) public returns (bool) {
  //   return _increaseLockAmount(account, reason, amount);
  // }
  // function unlock(address account) public returns (uint256 unlockableTokens) {
  //   return _unlock(account);
  // }
  // function _beforeTokenTransfer(
  //   address from,
  //   address to,
  //   uint256 amount
  // ) internal virtual override(ERC20, ERC20Lockable) {
  //   super._beforeTokenTransfer(from, to, amount);
  // }
}

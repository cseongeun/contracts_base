// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import { IERC20 } from "./IERC20.sol";

interface IERC20Lockable is IERC20 {
  /**
   * @dev Records data of all the tokens Locked
   */
  event Locked(
    address indexed account,
    bytes32 indexed reason,
    uint256 amount,
    uint256 release
  );

  /**
   * @dev Records data of all the tokens unlocked
   */
  event Unlocked(
    address indexed account,
    bytes32 indexed reason,
    uint256 amount
  );

  function tokensLocked(address account, bytes32 reason)
    external
    view
    returns (uint256 amount);

  function tokensLockedAtTime(
    address account,
    bytes32 reason,
    uint256 time
  ) external view returns (uint256 amount);

  function balanceOf(address account) external view override returns (uint256);

  function totalBalanceOf(address account)
    external
    view
    returns (uint256 amount);

  function tokensUnlockable(address account, bytes32 reason)
    external
    view
    returns (uint256 amount);

  function getUnlockableTokens(address account)
    external
    view
    returns (uint256 unlockableTokens);
}

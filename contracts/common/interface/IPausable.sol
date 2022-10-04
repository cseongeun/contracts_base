// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPausable {
  /**
   * @dev Emitted when the pause is triggered by `account`.
   */
  event Paused(address account);

  /**
   * @dev Emitted when the pause is lifted by `account`.
   */
  event UnPaused(address account);

  function paused() external view returns (bool);
}

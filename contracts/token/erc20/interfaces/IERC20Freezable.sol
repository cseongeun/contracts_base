// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC20 } from "./IERC20.sol";

interface IERC20Freezable is IERC20 {
  /**
   * @dev Emitted when user freezed
   */
  event Freezed(address account);

  /**
   * @dev Emitted when user unfreezed
   */
  event UnFreezed(address account);

  function isFreezed(address account) external view returns (bool);
}

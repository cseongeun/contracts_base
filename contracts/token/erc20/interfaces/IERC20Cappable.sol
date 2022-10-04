// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC20 } from "./IERC20.sol";

interface IERC20Cappable is IERC20 {
  function cap() external view returns (uint256);
}

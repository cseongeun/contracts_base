// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC20 } from "./IERC20.sol";

interface IERC20BatchTransferable is IERC20 {
  function batchTransfer(
    address[] calldata accounts,
    uint256[] calldata amounts
  ) external returns (bool);
}

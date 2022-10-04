// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import { IERC20 } from "./IERC20.sol";

interface IERC20SafeTransfer is IERC20 {
  function safeTransfer(address recipient, uint256 amount) external;

  function safeTransfer(
    address recipient,
    uint256 amount,
    bytes memory _data
  ) external;

  function safeTransferFrom(
    address sender,
    address recipient,
    uint256 amount
  ) external;

  function safeTransferFrom(
    address sender,
    address recipient,
    uint256 amount,
    bytes memory _data
  ) external;
}

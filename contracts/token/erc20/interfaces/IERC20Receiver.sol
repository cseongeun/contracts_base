// SPDX-License-Identifier: MIT
// Based on OpenZeppelin Contracts v4.5.0 (token/ERC20/IERC20Receiver.sol)
// https://github.com/OpenZeppelin/openzeppelin-contracts/releases/tag/v4.5.0
pragma solidity ^0.8.0;

interface IERC20Receiver {
  /**
   * @dev Whenever an {IERC20} `amount` is transferred to this contract via {IERC20-safeTransfer}
   * or {IERC20-safeTransferFrom} by `operator` from `from`, this function is called.
   *
   * {onERC20Received} must return its Solidity selector to confirm the token transfer.
   * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
   *
   * The selector can be obtained in Solidity with `IERC20Receiver.onERC20Received.selector`.
   */
  function onERC20Received(
    address operator,
    address from,
    uint256 amount,
    bytes calldata data
  ) external returns (bytes4);
}

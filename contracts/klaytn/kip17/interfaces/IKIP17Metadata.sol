// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../IKIP17.sol";

interface IKIP17Metadata is IKIP17 {
  /**
   * @dev Returns the token collection name.
   */
  function name() external view returns (string memory);

  /**
   * @dev Returns the token collection symbol.
   */
  function symbol() external view returns (string memory);

  /**
   * @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
   */
  function tokenURI(uint256 tokenId) external view returns (string memory);
}

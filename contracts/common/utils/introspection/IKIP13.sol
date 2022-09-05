// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @dev Interface of the KIP13 standard as defined in the KIP.
 *
 * See - http://kips.klaytn.com/KIPs/kip-13-interface_query_standard
 */
interface IKIP13 {
  /**
   * @dev Returns true if this contract implements the interface defined by
   * `interfaceId`.
   * See - http://kips.klaytn.com/KIPs/kip-13-interface_query_standard#how-interface-identifiers-are-defined
   * to learn more about how these ids are created.
   *
   * Requirements:
   *
   * - implementation of this function call must use less than 30 000 gas
   */
  function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

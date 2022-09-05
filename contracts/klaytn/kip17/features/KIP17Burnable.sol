// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { KIP17 } from "../KIP17.sol";
import { Context } from "../../../common/utils/Context.sol";

/**
 * @title KIP17 Burnable Token
 * @dev KIP17 Token that can be burned (destroyed).
 */
abstract contract KIP17Burnable is Context, KIP17 {
  /**
   * @dev Burns `tokenId`. See {KIP17-_burn}.
   *
   * Requirements:
   *
   * - The caller must own `tokenId` or be an approved operator.
   */
  function burn(uint256 tokenId) public virtual {
    //solhint-disable-next-line max-line-length
    require(
      _isApprovedOrOwner(_msgSender(), tokenId),
      "KIP17: caller is not token owner nor approved"
    );
    _burn(tokenId);
  }
}

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { BEP721 } from "../BEP721.sol";
import { Context } from "../../../common/utils/Context.sol";

/**
 * @title BEP721 Burnable Token
 * @dev BEP721 Token that can be burned (destroyed).
 */
abstract contract BEP721Burnable is Context, BEP721 {
  /**
   * @dev Burns `tokenId`. See {BEP721-_burn}.
   *
   * Requirements:
   *
   * - The caller must own `tokenId` or be an approved operator.
   */
  function burn(uint256 tokenId) public virtual {
    //solhint-disable-next-line max-line-length
    require(
      _isApprovedOrOwner(_msgSender(), tokenId),
      "BEP721: caller is not token owner nor approved"
    );
    _burn(tokenId);
  }
}

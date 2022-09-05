// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { KIP37 } from "../KIP37.sol";

/**
 * @dev Extension of {KIP37} that allows token holders to destroy both their
 * own tokens and those that they have been approved to use.
 *
 * _Available since v3.1._
 */
abstract contract KIP37Burnable is KIP37 {
  function burn(
    address account,
    uint256 id,
    uint256 value
  ) public virtual {
    require(
      account == _msgSender() || isApprovedForAll(account, _msgSender()),
      "KIP37: caller is not token owner nor approved"
    );

    _burn(account, id, value);
  }

  function burnBatch(
    address account,
    uint256[] memory ids,
    uint256[] memory values
  ) public virtual {
    require(
      account == _msgSender() || isApprovedForAll(account, _msgSender()),
      "KIP37: caller is not token owner nor approved"
    );

    _burnBatch(account, ids, values);
  }
}

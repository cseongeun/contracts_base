// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20 } from "../../../token/erc20/ERC20.sol";
import { ERC20Cappable } from "../../../token/erc20/features/ERC20Cappable.sol";

contract ERC20CappableMock is ERC20, ERC20Cappable {
  /**
   * @dev See {IERC165-supportsInterface}.
   */
  function supportsInterface(bytes4 interfaceId)
    public
    view
    virtual
    override(ERC20, ERC20Cappable)
    returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }

  constructor(
    string memory name_,
    string memory symbol_,
    uint256 cap_
  ) ERC20(name_, symbol_) {
    _setCap(cap_);
  }

  function mint(address account, uint256 amount) public {
    _mint(account, amount);
  }

  /**
   * @dev See {ERC20-_mint}.
   */
  function _mint(address account, uint256 amount)
    internal
    virtual
    override(ERC20, ERC20Cappable)
  {
    require(
      ERC20.totalSupply() + amount <= cap(),
      "ERC20Cappable: cap exceeded"
    );
    super._mint(account, amount);
  }
}

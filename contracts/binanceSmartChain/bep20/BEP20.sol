// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { Ownable } from "../../common/access/Ownable.sol";
import { IBEP20 } from "./Interfaces/IBEP20.sol";

contract BEP20 is ERC20, IBEP20, Ownable {
  /**
   * @dev Returns the bep token owner.
   */
  function getOwner() external view returns (address) {
    return owner();
  }
}

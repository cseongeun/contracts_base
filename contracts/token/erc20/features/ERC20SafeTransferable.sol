// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20 } from "../ERC20.sol";
import { IERC20SafeTransfer } from "../interfaces/IERC20SafeTransfer.sol";
import { Address } from "../../../common/utils/Address.sol";
import { IERC20Receiver } from "../interfaces/IERC20Receiver.sol";

abstract contract ERC20SafeTransfer is ERC20, IERC20SafeTransfer {
  using Address for address;

  function supportsInterface(bytes4 interfaceId)
    public
    view
    virtual
    override(ERC20)
    returns (bool)
  {
    return
      interfaceId == type(IERC20SafeTransfer).interfaceId ||
      super.supportsInterface(interfaceId);
  }

  function _safeTransfer(
    address recipient,
    uint256 amount,
    bytes memory _data
  ) internal virtual {
    _transfer(_msgSender(), recipient, amount);
    require(
      _checkOnERC20Received(_msgSender(), recipient, amount, _data),
      "ERC20SafeTransfer: transfer to non IERC20Receiver implementer"
    );
  }

  function safeTransfer(address recipient, uint256 amount) public virtual {
    safeTransfer(recipient, amount, "");
  }

  function safeTransfer(
    address recipient,
    uint256 amount,
    bytes memory _data
  ) public virtual {
    _safeTransfer(recipient, amount, _data);
  }

  function _safeTransferFrom(
    address sender,
    address recipient,
    uint256 amount,
    bytes memory _data
  ) internal virtual {
    transferFrom(sender, recipient, amount);
    require(
      _checkOnERC20Received(sender, recipient, amount, _data),
      "ERC20SafeTransfer: transfer to non IERC20Receiver implementer"
    );
  }

  function safeTransferFrom(
    address sender,
    address recipient,
    uint256 amount
  ) public virtual {
    safeTransferFrom(sender, recipient, amount, "");
  }

  function safeTransferFrom(
    address sender,
    address recipient,
    uint256 amount,
    bytes memory _data
  ) public virtual {
    _safeTransferFrom(sender, recipient, amount, _data);
  }

  function _checkOnERC20Received(
    address from,
    address to,
    uint256 amount,
    bytes memory _data
  ) private returns (bool) {
    if (to.isContract()) {
      try
        IERC20Receiver(to).onERC20Received(_msgSender(), from, amount, _data)
      returns (bytes4 retval) {
        return retval == IERC20Receiver.onERC20Received.selector;
      } catch (bytes memory reason) {
        if (reason.length == 0) {
          revert(
            "ERC20SafeTransfer: transfer to non IERC20Receiver implementer"
          );
        } else {
          assembly {
            revert(add(32, reason), mload(reason))
          }
        }
      }
    } else {
      return true;
    }
  }
}

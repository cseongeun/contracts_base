// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract BEP20Feature {
  enum Features {
    CAPPED,
    PRE_MINT,
    BURNABLE,
    FREEZABLE,
    PAUSABLE,
    MINTABLE,
    LOCKABLE,
    BATCH_TRANSFERABLE
  }

  enum Access {
    NONE,
    OWNERABLE,
    ROLES
  }

  mapping(Features => bool) public features;
  Access public access;

  function _setFeatures(Features[] memory _features) internal returns (bool) {
    for (uint256 i = 0; i < _features.length; i++) {
      features[_features[i]] = true;
    }
    return true;
  }

  function _setAccess(Access _access) internal returns (bool) {
    access = _access;
    return true;
  }
}

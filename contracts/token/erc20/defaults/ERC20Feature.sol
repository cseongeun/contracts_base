// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract ERC20Feature {
  string public v = 'ERC20v1'

  enum FeatureType {
    CAPPED,
    BURNABLE,
    FREEZABLE,
    PAUSABLE,
    MINTABLE,
    LOCKABLE,
    BATCH_TRANSFERABLE
  }

  enum Access {
    NONE,
    OWNABLE,
    ROLES
  }

  struct Features {
    bool capped;
    bool burnable;
    bool freezable;
    bool pausable;
    bool mintable;
    bool lockable;
    bool batchTransferable;
  }

  Features public features;
  Access public access;

  function _setFeatures(FeatureType[] memory _featureType)
    internal
    returns (bool)
  {
    Features memory _features = Features({
      capped: false,
      burnable: false,
      freezable: false,
      pausable: false,
      mintable: false,
      lockable: false,
      batchTransferable: false
    });

    for (uint256 i = 0; i < _featureType.length; i++) {
      if (_featureType[i] == FeatureType.CAPPED) {
        _features.capped = true;
      } else if (_featureType[i] == FeatureType.BURNABLE) {
        _features.burnable = true;
      } else if (_featureType[i] == FeatureType.FREEZABLE) {
        _features.freezable = true;
      } else if (_featureType[i] == FeatureType.PAUSABLE) {
        _features.pausable = true;
      } else if (_featureType[i] == FeatureType.MINTABLE) {
        _features.mintable = true;
      } else if (_featureType[i] == FeatureType.LOCKABLE) {
        _features.lockable = true;
      } else if (_featureType[i] == FeatureType.BATCH_TRANSFERABLE) {
        _features.batchTransferable = true;
      }
    }

    features = _features;
    return true;
  }

  function _setAccess(Access _access) internal returns (bool) {
    access = _access;
    return true;
  }
}

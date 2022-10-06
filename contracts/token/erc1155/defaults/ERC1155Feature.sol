// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract ERC1155Feature {
  enum FeatureType {
    PAUSABLE,
    FREEZABLE,
    BURNABLE,
    URI_STORAGABLE
  }

  enum Access {
    NONE,
    OWNABLE,
    ROLES
  }

  struct Features {
    bool pausable;
    bool freezable;
    bool burnable;
    bool uriStoragable;
  }

  Features public features;
  Access public access;

  function _setFeatures(FeatureType[] memory _featureType)
    internal
    returns (bool)
  {
    Features memory _features = Features({
      pausable: false,
      freezable: false,
      burnable: false,
      uriStoragable: false
    });

    for (uint256 i = 0; i < _featureType.length; i++) {
      if (_featureType[i] == FeatureType.PAUSABLE) {
        _features.pausable = true;
      } else if (_featureType[i] == FeatureType.FREEZABLE) {
        _features.freezable = true;
      } else if (_featureType[i] == FeatureType.BURNABLE) {
        _features.burnable = true;
      } else if (_featureType[i] == FeatureType.URI_STORAGABLE) {
        _features.uriStoragable = true;
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

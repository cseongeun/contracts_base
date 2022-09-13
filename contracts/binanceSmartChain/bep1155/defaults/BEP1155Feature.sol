// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract BEP1155Feature {
  enum FeatureType {
    URI,
    PAUSABLE,
    FREEZABLE,
    BURNABLE,
    MINTABLE,
    SUPPLY
  }

  enum Access {
    NONE,
    OWNABLE,
    ROLES
  }

  struct Features {
    bool uri;
    bool pausable;
    bool freezable;
    bool burnable;
    bool mintable;
    bool supply;
  }

  Features public features;
  Access public access;

  function _setFeatures(FeatureType[] memory _featureType)
    internal
    returns (bool)
  {
    Features memory _features = Features({
      uri: false,
      pausable: false,
      freezable: false,
      burnable: false,
      mintable: false,
      supply: false
    });

    for (uint256 i = 0; i < _featureType.length; i++) {
      if (_featureType[i] == FeatureType.URI) {
        _features.uri = true;
      } else if (_featureType[i] == FeatureType.PAUSABLE) {
        _features.pausable = true;
      } else if (_featureType[i] == FeatureType.FREEZABLE) {
        _features.freezable = true;
      } else if (_featureType[i] == FeatureType.BURNABLE) {
        _features.burnable = true;
      } else if (_featureType[i] == FeatureType.MINTABLE) {
        _features.mintable = true;
      } else if (_featureType[i] == FeatureType.SUPPLY) {
        _features.supply = true;
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

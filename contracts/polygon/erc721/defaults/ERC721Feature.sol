// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract ERC721Feature {
  enum FeatureType {
    BASE_URI,
    ENUMERABLE,
    URI_STORAGE,
    PAUSABLE,
    BURNABLE,
    MINTABLE,
    FREEZABLE
  }

  enum Access {
    NONE,
    OWNABLE,
    ROLES
  }

  struct Features {
    bool baseURI;
    bool enumerable;
    bool uriStorage;
    bool pausable;
    bool burnable;
    bool mintable;
    bool freezable;
  }

  Features public features;
  Access public access;

  function _setFeatures(FeatureType[] memory _featureType)
    internal
    returns (bool)
  {
    Features memory _features = Features({
      baseURI: false,
      enumerable: false,
      uriStorage: false,
      pausable: false,
      burnable: false,
      mintable: false,
      freezable: false
    });

    for (uint256 i = 0; i < _featureType.length; i++) {
      if (_featureType[i] == FeatureType.BASE_URI) {
        _features.baseURI = true;
      } else if (_featureType[i] == FeatureType.ENUMERABLE) {
        _features.enumerable = true;
      } else if (_featureType[i] == FeatureType.URI_STORAGE) {
        _features.uriStorage = true;
      } else if (_featureType[i] == FeatureType.PAUSABLE) {
        _features.pausable = true;
      } else if (_featureType[i] == FeatureType.BURNABLE) {
        _features.burnable = true;
      } else if (_featureType[i] == FeatureType.MINTABLE) {
        _features.mintable = true;
      } else if (_featureType[i] == FeatureType.FREEZABLE) {
        _features.freezable = true;
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

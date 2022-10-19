// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ERC721 } from "../ERC721.sol";
import { Strings } from "../../../common/utils/Strings.sol";

/**
 * @dev ERC721 token with storage based token URI management.
 */
abstract contract ERC721URIStoragable is ERC721 {
  using Strings for uint256;

  // Optional mapping for token URIs
  mapping(uint256 => string) private _tokenURIs;

  event SetTokenURI(uint256 indexed _tokenId, string _tokenURI);

  /**
   * @dev See {IERC721Metadata-tokenURI}.
   */
  function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    _requireMinted(tokenId);

    string memory _tokenURI = _tokenURIs[tokenId];
    string memory base = _baseURI();

    // If there is no base URI, return the token URI.
    if (bytes(base).length == 0) {
      return _tokenURI;
    }
    // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
    if (bytes(_tokenURI).length > 0) {
      return string(abi.encodePacked(base, _tokenURI));
    }

    return super.tokenURI(tokenId);
  }

  /**
   * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
   *
   * Requirements:
   *
   * - `tokenId` must exist.
   */
  function _setTokenURI(uint256 tokenId, string memory _tokenURI)
    internal
    virtual
  {
    require(_exists(tokenId), "URIStorage: URI set of nonexistent token");
    _tokenURIs[tokenId] = _tokenURI;

    emit SetTokenURI(tokenId, _tokenURI);
  }

  /**
   * @dev See {ERC721-_burn}. This override additionally checks to see if a
   * token-specific URI was set for the token, and if so, it deletes the token URI from
   * the storage mapping.
   */
  function _burn(uint256 tokenId) internal virtual override {
    super._burn(tokenId);

    if (bytes(_tokenURIs[tokenId]).length != 0) {
      delete _tokenURIs[tokenId];
    }
  }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC721URIStorage } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

abstract contract ERC721MetadataMintable is ERC721URIStorage {
  /**
   * @dev See {IKIP17metadataMintable-mintWithTokenURI}
   *
   * IMPORTANT: this uses _safeMint internally, please be aware that if you do not want this safety functionality, replace with _mint
   *
   * Emits a {Transfer} event with 0X0 as the `from` account
   */
  function _mintWithTokenURI(
    address to,
    uint256 tokenId,
    string memory _tokenURI
  ) internal virtual returns (bool) {
    _safeMint(to, tokenId);
    _setTokenURI(tokenId, _tokenURI);
    return true;
  }
}

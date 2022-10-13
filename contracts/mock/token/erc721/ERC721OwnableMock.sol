// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../../../token/erc721/ERC721.sol";
import "../../../token/erc721/defaults/ERC721URIStoragable.sol";
import "../../../token/erc721/defaults/ERC721Enumerable.sol";
import "../../../common/access/Ownable.sol";
import "../../../token/erc721/features/ERC721Freezable.sol";
import "../../../token/erc721/features/ERC721Pausable.sol";
import "../../../token/erc721/features/ERC721Burnable.sol";

contract ERC721OwnableMock is
  ERC721,
  ERC721URIStoragable,
  ERC721Enumerable,
  Ownable,
  ERC721Freezable,
  ERC721Pausable,
  ERC721Burnable
{
  constructor() ERC721("ERC721OwnableMock", "EOMK") {
    FeatureType[] memory _features = new FeatureType[](4);
    _features[0] = FeatureType.FREEZABLE;
    _features[1] = FeatureType.PAUSABLE;
    _features[2] = FeatureType.BURNABLE;

    _setFeatures(_features);
    _setAccess(Access.NONE);
  }

  function safeMint(
    address to,
    uint256 tokenId,
    string memory uri
  ) public onlyOwner {
    _safeMint(to, tokenId);
    _setTokenURI(tokenId, uri);
  }

  function safeMint(
    address to,
    uint256 tokenId,
    string memory uri,
    bytes memory data
  ) public onlyOwner {
    _safeMint(to, tokenId, data);
    _setTokenURI(tokenId, uri);
  }

  function freeze(address account) public onlyOwner {
    _freeze(account);
  }

  function unfreeze(address account) public onlyOwner {
    _unfreeze(account);
  }

  function pause() public onlyOwner {
    _pause();
  }

  function unpause() public onlyOwner {
    _unpause();
  }

  // The following functions are overrides required by Solidity.

  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 tokenId
  )
    internal
    override(ERC721, ERC721Enumerable, ERC721Freezable, ERC721Pausable)
  {
    super._beforeTokenTransfer(from, to, tokenId);
  }

  function _burn(uint256 tokenId)
    internal
    override(ERC721, ERC721URIStoragable)
  {
    super._burn(tokenId);
  }

  function tokenURI(uint256 tokenId)
    public
    view
    override(ERC721, ERC721URIStoragable)
    returns (string memory)
  {
    return super.tokenURI(tokenId);
  }

  function supportsInterface(bytes4 interfaceId)
    public
    view
    override(ERC721, ERC721Enumerable)
    returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }
}

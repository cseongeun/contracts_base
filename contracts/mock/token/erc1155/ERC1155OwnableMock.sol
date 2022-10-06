// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../../../token/erc1155/ERC1155.sol";
import "../../../common/access/Ownable.sol";
import "../../../token/erc1155/defaults/ERC1155SupplyTrackable.sol";

contract ERC1155OwnableMock is ERC1155, Ownable, ERC1155SupplyTrackable {
    constructor() ERC1155("www.hexlant.com/") {
        _setAccess(Access.NONE);
    }

    function mint(address account, uint256 id, uint256 amount) public onlyOwner {
        _mint(account, id, amount);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts);
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
        onlyOwner
    {
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        internal
        override(ERC1155, ERC1155SupplyTrackable)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}

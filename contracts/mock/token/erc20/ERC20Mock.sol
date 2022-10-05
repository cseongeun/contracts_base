// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../../../token/erc20/ERC20.sol";
import "../../../token/erc20/features/ERC20Cappable.sol";
import "../../../token/erc20/features/ERC20Burnable.sol";
import "../../../token/erc20/features/ERC20Freezable.sol";
import "../../../common/access/Ownable.sol";
import "../../../token/erc20/features/ERC20Pausable.sol";
import "../../../token/erc20/features/ERC20Lockable.sol";
import "../../../token/erc20/features/ERC20BatchTransferable.sol";

contract ERC20Mock is ERC20, ERC20Cappable, ERC20Burnable, ERC20Freezable, Ownable, ERC20Pausable, ERC20Lockable, ERC20BatchTransferable {
    constructor() ERC20("ERC20Mock", "EMK") {
        _setCap(10000 * 10 ** decimals());
        _mint(msg.sender, 1000 * 10 ** decimals());
        FeatureType[] memory _features = new FeatureType[](7);
        _features[0] = FeatureType.CAPPED;
        _features[1] = FeatureType.BURNABLE;
        _features[2] = FeatureType.FREEZABLE;
        _features[3] = FeatureType.PAUSABLE;
        _features[4] = FeatureType.MINTABLE;
        _features[5] = FeatureType.LOCKABLE;
        _features[6] = FeatureType.BATCH_TRANSFERABLE;
        _setFeatures(_features);
        _setAccess(Access.NONE);
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

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function lock(address account, uint256 amount, bytes32 reason, uint256 release)
        public
        onlyOwner
    {
        _lock(account, amount, reason, release);
    }

    function batchLock(address[] calldata accounts, uint256[] calldata amounts, bytes32[] calldata reasons, uint256[] calldata releases)
        public
        onlyOwner
    {
        _batchLock(accounts, amounts, reasons, releases);
    }

    function transferWithLock(address account, uint256 amount, bytes32 reason, uint256 release)
        public
        onlyOwner
    {
        _transferWithLock(account, amount, reason, release);
    }

    function batchTransferWithLock(address[] calldata accounts, uint256[] calldata amounts, bytes32[] calldata reasons, uint256[] calldata releases)
        public
        onlyOwner
    {
        _batchTransferWithLock(accounts, amounts, reasons, releases);
    }

    function extendLock(address account, bytes32 reason, uint256 time)
        public
        onlyOwner
    {
        _extendLock(account, reason, time);
    }

    function increaseLockAmount(address account, bytes32 reason, uint256 amount)
        public
        onlyOwner
    {
        _increaseLockAmount(account, reason, amount);
    }

    function unlock(address account) public onlyOwner {
        _unlock(account);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20, ERC20Freezable, ERC20Pausable, ERC20Lockable)
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    function _mint(address to, uint256 amount)
        internal
        override(ERC20, ERC20Cappable)
    {
        super._mint(to, amount);
    }

    function balanceOf(address account)
        public
        view
        override(ERC20, ERC20Lockable)
        returns (uint256)
    {
        return super.balanceOf(account);
    }
}

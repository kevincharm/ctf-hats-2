pragma solidity ^0.8;

contract ForceSendEther {
    function forceSend(address payable target) external payable {
        selfdestruct(target);
    }
}

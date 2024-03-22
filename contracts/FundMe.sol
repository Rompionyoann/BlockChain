// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.19;

contract FundMe {

    modifier minimumAmount {
        require(msg.value >= 1e18, "Minimum amount is 1 ether.");
        _;
    }
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable minimumAmount {
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function getVersion() public pure returns (uint256) {
        return 1;
    }
}

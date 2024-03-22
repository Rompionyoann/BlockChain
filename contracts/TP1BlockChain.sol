// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    address public owner;
    mapping(uint => Candidate) public candidates;
    uint[] private candidateIds;
    mapping(address => bool) public voters;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addCandidate(string memory _name) public onlyOwner {
        uint _candidateId = candidateIds.length;
        candidates[_candidateId] = Candidate(_candidateId, _name, 0);
        candidateIds.push(_candidateId);
    }

    function vote(uint _candidateId) public {
        require(!voters[msg.sender], "You have already voted.");
        require(_candidateId < candidateIds.length, "Not a valid candidate ID.");

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount += 1;
    }

    function getCandidate(uint _candidateId) public view returns (Candidate memory) {
        require(_candidateId < candidateIds.length, "Not a valid candidate ID.");
        return candidates[_candidateId];
    }

    function totalCandidates() public view returns (uint) {
        return candidateIds.length;
    }
}
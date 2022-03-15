// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MeditationChallenge {

  address owner;

  struct Challenge {
      string name;
      uint256 numDays;
  }

  struct Participant {
      address walletAddress;
      string name;
      uint256 lockedValue;
      uint256 originalDeposit;
      string challengeName;
      uint256 daysSuccessfullyCompleted;
  }

  Participant[] public participants;

  Challenge[] public challenges;

  constructor(string memory name, uint256 numDays) {
      owner = msg.sender;
      challenges.push(Challenge(name, numDays)); 
  }

  function isOwner() public view returns (bool) {
      if (msg.sender == owner) {
        return true;
      }
      return false;
  }

  function getChallenges() public view returns(Challenge[] memory) {
      return challenges;
  }

  function getParticipants() public view returns (Participant[] memory) {
      return participants;
  }

  function depositEthToChallenge(string memory name, string memory challengeName) public payable {
      participants.push(Participant(msg.sender, name, msg.value, msg.value, challengeName, 0));
  }

  function getChallengeStats() public view returns (uint256, uint256) {
      return (address(this).balance, participants.length);
  }

  function payParticipant(address recipient) public payable {
      // loop through participants
      for (uint256 i = 0; i < participants.length; i++) {
          address currentWalletAddress = participants[i].walletAddress;
          if (recipient == currentWalletAddress) {
              // pay recipient 1/10 of their original deposit
              uint256 amountToSend = participants[i].lockedValue / 10;
              participants[i].daysSuccessfullyCompleted++;
              payable(currentWalletAddress).transfer(amountToSend);
          }
      }
  }

  function getParticipant(address participantAddress) public view returns (Participant memory) {
      Participant memory currentParticipant;
      for (uint i = 0; i < participants.length; i++) {
          // an example of wher ea mapping would be more well suited
          if (participants[i].walletAddress == participantAddress) {
              currentParticipant = participants[i];
          }
      }
      return currentParticipant;
  }
}
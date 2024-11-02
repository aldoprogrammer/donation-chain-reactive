// SPDX-License-Identifier: GPL-2.0-or-later

pragma solidity >=0.8.0;

import '../AbstractCallback.sol';

contract DonationL1 is AbstractCallback {
    event DonationCreated(
        uint256 indexed donationId,
        string name,
        uint256 goal
    );

    event DonationReceived(
        uint256 indexed donationId,
        uint256 amount,
        address indexed donor
    );

    struct Donation {
        string name;
        uint256 goal;
        uint256 totalReceived;
    }

    Donation[] public donations;
    address private owner;

    constructor(address _callback_sender) AbstractCallback(_callback_sender) payable {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, 'Unauthorized');
        _;
    }

    receive() external payable {}

    function createDonation(string memory name, uint256 goal) external onlyOwner {
        donations.push(Donation(name, goal, 0));
        emit DonationCreated(donations.length - 1, name, goal);
    }

    function donate(uint256 donationId) external payable {
        require(donationId < donations.length, "Donation doesn't exist");
        require(msg.value > 0, "Must send a positive amount");

        Donation storage donation = donations[donationId];
        donation.totalReceived += msg.value;
        emit DonationReceived(donationId, msg.value, msg.sender);
    }

    function getDonation(uint256 donationId) external view returns (string memory name, uint256 goal, uint256 totalReceived) {
        require(donationId < donations.length, "Donation doesn't exist");
        Donation storage donation = donations[donationId];
        return (donation.name, donation.goal, donation.totalReceived);
    }
}

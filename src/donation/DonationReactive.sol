// SPDX-License-Identifier: GPL-2.0-or-later

pragma solidity >=0.8.0;

import '../IReactive.sol';
import '../AbstractPausableReactive.sol';
import '../ISubscriptionService.sol';

abstract contract DonationReactive is IReactive, AbstractPausableReactive {
    // Event emitted when a donation is received
    event DonationReceived(
        address indexed donor,
        uint256 indexed donationId,
        uint256 amount,
        uint256 totalReceived
    );

    struct Donation {
        uint256 id;
        address donor;
        uint256 amount;
    }

    // Mapping to store donations by id
    mapping(uint256 => Donation) public donations;
    uint256 public totalDonations; // Total amount donated
    uint256 public donationCount;   // Count of donations made

    address private l1;

    constructor(address _l1) {
        paused = false;
        owner = msg.sender;
        l1 = _l1;
    }

    // Receive function to accept Ether
    receive() external payable {}

    // Function to donate Ether
    function donate() external payable {
        require(msg.value > 0, "Donation must be greater than zero");

        // Increment the donation count
        donationCount++;

        // Store the donation
        donations[donationCount] = Donation({
            id: donationCount,
            donor: msg.sender,
            amount: msg.value
        });

        // Update total donations
        totalDonations += msg.value;

        // Emit donation received event
        emit DonationReceived(msg.sender, donationCount, msg.value, totalDonations);
    }

    // The react function to handle incoming events
    function react(
        uint256 chain_id,
        address _contract,
        uint256 topic_0,
        uint256 topic_1,
        uint256 /* topic_2 */,
        uint256 /* topic_3 */,
        bytes calldata data,
        uint256 /* block_number */,
        uint256 op_code
    ) external vmOnly {
        // Handle any other events here if needed
    }
}

# ERC-20 Donation Demo
## How to Run Donation

### Step 1: Deploy the Donation Contract
Deploy the **DonationL1** contract to the Sepolia network using the following command. Make sure to replace `$SEPOLIA_RPC` and `$SEPOLIA_PRIVATE_KEY` with your actual values.

```bash
forge create --rpc-url $SEPOLIA_RPC --private-key $SEPOLIA_PRIVATE_KEY src/donation/DonationL1.sol:DonationL1 --constructor-args 0x0000000000000000000000000000000000000000
```

###  2: Load Environment Variables
Load your environment variables from the .env file to access the required credentials for the next steps.

```bash
source .env
```

### Step 3: Deploy the Reactive Donation Contract
Deploy the DonationReactive contract to the Reactive network. Assign the contract address from the response to DONATION_REACTIVE_ADDR.
```bash
forge create --rpc-url $REACTIVE_RPC --private-key $REACTIVE_PRIVATE_KEY src/donation/DonationReactive.sol:DonationReactive --constructor-args $DONATION_L1_ADDR
```

### Step 4: Create a Donation Event
Create a new donation event by sending a transaction to the DonationL1 contract. Replace My Charity Event and 100 ether with your desired event name and goal amount.

```bash
cast send "$DONATION_L1_ADDR" "createDonation(string,uint256)" --rpc-url $SEPOLIA_RPC --private-key $SEPOLIA_PRIVATE_KEY "My Charity Event" 100 ether
```

### Step 5: Make a Donation
Make a donation by sending a transaction to the DonationL1 contract. Replace the amount as necessary.

```bash
cast send "$DONATION_L1_ADDR" "donate(uint256)" --rpc-url $SEPOLIA_RPC --private-key $SEPOLIA_PRIVATE_KEY 0 --value $PAYMENT_AMOUNT

```

### Step 6: Retrieve Donation Information
To retrieve the details of the donation, call the getDonation function on the DonationL1 contract.

```bash
cast call "$DONATION_L1_ADDR" "getDonation(uint256)" 0 --rpc-url $SEPOLIA_RPC
```

## Overview
The ERC-20 Donation Demo allows users to create and manage donation events while tracking donations in real-time. This demo builds upon the principles introduced in the Reactive Network Demo and highlights two primary functionalities:

* Donation Creation: Allows users to create donation events with specified goals.
* Donation Tracking: Monitors and records donations made to each event.

Contracts
* Donation Contract: The DonationL1 contract manages the creation of donation events and the tracking of donations made towards them.
* Reactive Contract: The DonationReactive contract listens for donation events and provides real-time updates on the donations received.

## Further Considerations
There are several opportunities for improvement:
* Multi-Event Management: Extend functionality to manage multiple donation events simultaneously.
* Dynamic Goal Updates: Enable updates to the donation goals for active events.
User Notifications: Implement a notification system for users when donation milestones are reached.
* User Notifications: Implement a notification system for users when donation milestones are reached.

## Deployment & Testing
To deploy the contracts to Ethereum Sepolia and Kopli Testnet, follow these steps. Replace the relevant keys, addresses, and endpoints as needed. Make sure the following environment variables are correctly configured before proceeding:

### Sepolia RPCs
* `SEPOLIA_RPC` — https://rpc2.sepolia.org
* `SEPOLIA_PRIVATE_KEY` — Ethereum Sepolia private key
* `REACTIVE_RPC` — https://kopli-rpc.rkt.ink
* `REACTIVE_PRIVATE_KEY` — Kopli Testnet private key
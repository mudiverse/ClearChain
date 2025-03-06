// contracts/TenderContract.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TenderContract {
    address public admin;
    string public tenderDescription;
    bool public tenderClosed;

    struct Bid {
        address bidder;
        string name;           // Name of bidder (vendor or citizen)
        uint amount;           // Bid amount (you can assume this is in your fiat equivalent)
        uint daysToComplete;   // Number of days to complete the project
    }
    Bid[] public bids;

    event BidSubmitted(address indexed bidder, string name, uint amount, uint daysToComplete);
    event TenderClosed(address winner, string winnerName, uint winningBid, uint daysToComplete);

    constructor(string memory _description) {
        admin = msg.sender;
        tenderDescription = _description;
        tenderClosed = false;
    }

    /**
     * @dev Submit a bid if the conditions are met.
     * Conditions: amount <= 10000 and daysToComplete <= 100.
     */
    function submitBid(string memory _name, uint _amount, uint _daysToComplete) external {
        require(!tenderClosed, "Tender is closed");
        require(_amount <= 10000, "Bid amount exceeds limit");
        require(_daysToComplete <= 100, "Days to complete exceeds limit");

        bids.push(Bid({
            bidder: msg.sender,
            name: _name,
            amount: _amount,
            daysToComplete: _daysToComplete
        }));

        emit BidSubmitted(msg.sender, _name, _amount, _daysToComplete);
    }

    /**
     * @dev Close the tender (only admin) and choose the lowest bid.
     */
    function closeTender() external {
        require(msg.sender == admin, "Only admin can close the tender");
        require(!tenderClosed, "Tender already closed");
        require(bids.length > 0, "No bids submitted");

        uint lowestBid = bids[0].amount;
        uint lowestIndex = 0;
        for (uint i = 1; i < bids.length; i++) {
            if (bids[i].amount < lowestBid) {
                lowestBid = bids[i].amount;
                lowestIndex = i;
            }
        }
        tenderClosed = true;
        Bid memory winningBid = bids[lowestIndex];
        emit TenderClosed(winningBid.bidder, winningBid.name, winningBid.amount, winningBid.daysToComplete);
    }

    /**
     * @dev Retrieve bid count.
     */
    function getBidCount() external view returns (uint) {
        return bids.length;
    }

    /**
     * @dev Retrieve bid by index.
     */
    function getBid(uint index) external view returns (Bid memory) {
        require(index < bids.length, "Index out of bounds");
        return bids[index];
    }
}

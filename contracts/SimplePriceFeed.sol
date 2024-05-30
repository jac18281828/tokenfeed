// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.25;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import {AggregatorV3Interface} from "./AggregatorV3Interface.sol";

// Compound Finance Simple Price Feed
// https://github.com/compound-finance/comet/tree/main/contracts/test
// Do not use in production

contract SimplePriceFeed is AggregatorV3Interface, Ownable {
    // solhint-disable-next-line const-name-snakecase
    string public constant override description = "Mock Chainlink price aggregator";
    // solhint-disable-next-line const-name-snakecase
    uint256 public constant override version = 1;
    // solhint-disable-next-line immutable-vars-naming
    uint8 public immutable override decimals;

    uint80 internal roundId;
    int256 internal answer;
    uint256 internal startedAt;
    uint256 internal updatedAt;
    uint80 internal answeredInRound;

    constructor(int256 answer_, uint8 decimals_) Ownable(msg.sender) {
        answer = answer_;
        decimals = decimals_;
    }

    function setRoundData(
        uint80 roundId_,
        int256 answer_,
        uint256 startedAt_,
        uint256 updatedAt_,
        uint80 answeredInRound_
    ) public onlyOwner {
        roundId = roundId_;
        answer = answer_;
        startedAt = startedAt_;
        updatedAt = updatedAt_;
        answeredInRound = answeredInRound_;
    }

    function getRoundData(uint80 roundId_) external view override returns (uint80, int256, uint256, uint256, uint80) {
        return (roundId_, answer, startedAt, updatedAt, answeredInRound);
    }

    function latestRoundData() external view override returns (uint80, int256, uint256, uint256, uint80) {
        return (roundId, answer, startedAt, updatedAt, answeredInRound);
    }
}

// SPDX_License_Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test} from "forge-std/Test.sol";

import {SimplePriceFeed} from "../contracts/SimplePriceFeed.sol";

contract SimplePriceFeedTest is Test {
    SimplePriceFeed private priceFeed;

    function setUp() public {
        priceFeed = new SimplePriceFeed(1030930790966715357, 18);
    }

    function testLatestRoundData() public view {
        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            priceFeed.latestRoundData();
        assertEq(roundId, 0);
        assertEq(answer, 1030930790966715357);
        assertEq(startedAt, 0);
        assertEq(updatedAt, 0);
        assertEq(answeredInRound, 0);
    }

    function testGetRoundData() public view {
        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            priceFeed.getRoundData(0);
        assertEq(roundId, 0);
        assertEq(answer, 1030930790966715357);
        assertEq(startedAt, 0);
        assertEq(updatedAt, 0);
        assertEq(answeredInRound, 0);
    }

    function testGetDecimals() public view {
        assertEq(priceFeed.decimals(), 18);
    }
}

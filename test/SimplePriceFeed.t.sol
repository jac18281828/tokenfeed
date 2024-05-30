// SPDX_License_Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test} from "forge-std/Test.sol";

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

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

    function testDescription() public view {
        assertEq(
            priceFeed.description(),
            "Mock Chainlink price aggregator",
            "description should be 'Mock Chainlink price aggregator'"
        );
    }

    function testVersion() public view {
        assertEq(priceFeed.version(), 1, "version should be 1");
    }

    function testSetRoundData() public {
        priceFeed.setRoundData(1, 1030930790966715357, 2, 3, 4);
        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            priceFeed.latestRoundData();
        assertEq(roundId, 1);
        assertEq(answer, 1030930790966715357);
        assertEq(startedAt, 2);
        assertEq(updatedAt, 3);
        assertEq(answeredInRound, 4);
    }

    function testSetRoundDataRequiresOwner() public {
        address nobody = vm.addr(0x1);
        vm.prank(nobody);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, nobody));
        priceFeed.setRoundData(1, 1030930790966715357, 2, 3, 4);
    }
}

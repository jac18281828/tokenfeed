// SPDX_License_Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test} from "forge-std/Test.sol";

import {PausableUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";

import {TREx} from "../contracts/TREx.sol";

contract TRExTest is Test {
    TREx private trex;

    function setUp() public {
        address trexmock = vm.addr(500);
        mockTREx(trexmock);
        trex = TREx(trexmock);
    }

    function testInitialize() public view {
        assertEq(trex.name(), "TREx");
        assertEq(trex.symbol(), "TREx");
    }

    function testMint() public {
        address user = vm.addr(1001);
        trex.mintTo(user, 100);
        assertEq(trex.balanceOf(user), 100);
    }

    function testBurn() public {
        // burn operation only works when the caller has the BURNER_ROLE
        address user = address(this);
        trex.mintTo(user, 100);
        trex.burn(75);
        assertEq(trex.balanceOf(user), 25);
    }

    function testBurnPaused() public {
        // burn operation only works when the contract is not paused
        address user = address(this);
        trex.mintTo(user, 100);
        trex.pause();
        vm.expectRevert(abi.encodeWithSelector(PausableUpgradeable.EnforcedPause.selector));
        trex.burn(75);
    }

    function mockTREx(address trexMock) private {
        TREx implementation = new TREx();
        bytes memory code = address(implementation).code;
        vm.etch(trexMock, code);
        TREx mock = TREx(trexMock);
        mock.initialize(address(this));
        mock.grantRole(mock.MINTER_ROLE(), address(this));
        mock.grantRole(mock.BURNER_ROLE(), address(this));
        mock.grantRole(mock.PAUSER_ROLE(), address(this));
    }
}

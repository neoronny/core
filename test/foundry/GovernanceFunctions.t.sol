// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import 'test/foundry/base/BaseTest.t.sol';

contract GovernanceFunctionsTest is BaseTest {
    function setUp() public virtual override {
        TestSetup.setUp();
    }

    // NEGATIVES

    function testUserCannotCallGovernanceFunctions() public {
        vm.startPrank(profileOwner);

        vm.expectRevert(Errors.NotGovernance.selector);
        hub.setGovernance(profileOwner);

        vm.expectRevert(Errors.NotGovernance.selector);
        hub.whitelistFollowModule(profileOwner, true);

        vm.expectRevert(Errors.NotGovernance.selector);
        hub.whitelistReferenceModule(profileOwner, true);

        vm.expectRevert(Errors.NotGovernance.selector);
        hub.whitelistCollectModule(profileOwner, true);

        vm.stopPrank();
    }

    // SCENARIOS

    function testGovernanceCanWhitelistAndUnwhitelistModules() public {
        vm.startPrank(governance);

        // Whitelist

        assertEq(hub.isFollowModuleWhitelisted(profileOwner), false);
        hub.whitelistFollowModule(profileOwner, true);
        assertEq(hub.isFollowModuleWhitelisted(profileOwner), true);

        assertEq(hub.isReferenceModuleWhitelisted(profileOwner), false);
        hub.whitelistReferenceModule(profileOwner, true);
        assertEq(hub.isReferenceModuleWhitelisted(profileOwner), true);

        assertEq(hub.isCollectModuleWhitelisted(profileOwner), false);
        hub.whitelistCollectModule(profileOwner, true);
        assertEq(hub.isCollectModuleWhitelisted(profileOwner), true);

        // Unwhitelist

        hub.whitelistFollowModule(profileOwner, false);
        assertEq(hub.isFollowModuleWhitelisted(profileOwner), false);

        hub.whitelistReferenceModule(profileOwner, false);
        assertEq(hub.isReferenceModuleWhitelisted(profileOwner), false);

        hub.whitelistCollectModule(profileOwner, false);
        assertEq(hub.isCollectModuleWhitelisted(profileOwner), false);

        vm.stopPrank();
    }

    function testGovernanceCanChangeGovernanceAddress() public {
        vm.startPrank(governance);

        assertEq(hub.getGovernance(), governance);
        hub.setGovernance(profileOwner);
        assertEq(hub.getGovernance(), profileOwner);

        vm.stopPrank();
    }
}

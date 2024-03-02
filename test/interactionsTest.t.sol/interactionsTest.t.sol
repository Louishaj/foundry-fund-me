// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";
import {FundMe} from "../../src/FundMe.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract InteractionsTest is StdCheats, Test {
    FundMe public fundMe;
    HelperConfig public helperConfig;

    uint256 public constant SEND_VALUE = 0.1 ether; // just a value to make sure we are sending enough!
    uint256 public constant STARTING_USER_BALANCE = 10 ether;
    uint256 public constant GAS_PRICE = 1;

    address public constant USER = address(1);

    // uint256 public constant SEND_VALUE = 1e18;
    // uint256 public constant SEND_VALUE = 1_000_000_000_000_000_000;
    // uint256 public constant SEND_VALUE = 1000000000000000000;

    function setUp() external {
        DeployFundMe deployer = new DeployFundMe();
        (fundMe, helperConfig) = deployer.run();
        vm.deal(USER, STARTING_USER_BALANCE);
    }

    function testUserCanFundAndOwnerWithdraw() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);
    }
}

// import {Test, console} from "forge-std/Test.sol";
// import {FundMe} from "../../src/FundMe.sol";
// import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
// import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

// contract Interactions is Test {

//     // FundMe fundMe;

//     // address USER = makeAddr("user");
//     // uint256 constant SEND_VALUE = 0.1 ether; // 1000000000000000000
//     // uint256 constant STARTING_BALANCE = 10 ether;
//     // uint256 constant GAS_PRICE = 1;

//     // function setUp() external {
//     //     // fundMe = new FundMe 5306);
//     //     DeployFundMe deploy = new DeployFundMe();
//     //     fundMe = deploy.run();
//     //     vm.deal(USER, STARTING_BALANCE);
//     // }

//     // function testUserCanFundInteractions() public {
//     //     FundFundMe fundFundMe = new FundFundMe();
//     //     fundFundMe.fundFundMe(address(fundMe));

//     //     WithdrawFundMe withdrawFundMe =  new withdrawFundMe();
//     //     withdrawFundMe.withdrawFundMe(address);

//     //     assert(address(fundMe).balance == 0);
//     //     vm.prank(USER);
//     //     vm.deal(USER, 1e18);
//     //     fundFundMe.fundFundMe(address(fundMe));

//     //     address funder = fundMe.getFunder(0);
//     //     asserEq(funder, USER);
//     //}
// }

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import { BaseTest } from "@test/BaseTest.sol";
import { POK } from "@/tokens/POK.sol";

abstract contract POKSetup is BaseTest {
  POK public pok;

  constructor() {
    address admin = makeAddr("admin");
    vm.startPrank(admin);
    pok = new POK(admin);
    pok.grantRole(pok.MINTER(), makeAddr("minter"));
    vm.stopPrank();
  }

  function mintPOK(address recipient, uint256 amount) public {
    vm.prank(makeAddr("minter"));
    pok.mint(recipient, amount);
  }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/console.sol";
import { NonceRegistry } from "@/common/NonceRegistry.sol";
import { POK } from "@/tokens/POK.sol";
import { Pookyball } from "@/pookyball/Pookyball.sol";
import { Rewards } from "@/common/Rewards.sol";
import { Script } from "forge-std/Script.sol";
import { Stickers } from "@/stickers/Stickers.sol";

contract DeployRewards is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  uint256 adminPK = vm.envUint("ADMIN_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");
  address operatorAddress = vm.envAddress("OPERATOR_ADDRESS");

  Pookyball pookyball = Pookyball(vm.envAddress("CONTRACT_POOKYBALL_ADDRESS"));
  Stickers stickers = Stickers(vm.envAddress("CONTRACT_STICKERS_ADDRESS"));
  POK pok = POK(vm.envAddress("CONTRACT_POK_ADDRESS"));
  NonceRegistry nonces = NonceRegistry(vm.envAddress("CONTRACT_NONCE_REGISTRY_ADDRESS"));

  function run() external {
    // ================ Deploy Rewards ================
    vm.startBroadcast(deployerPK);

    address[] memory rewarders = new address[](1);
    rewarders[0] = operatorAddress;

    Rewards rewards =
      new Rewards{ salt: salt }(pok, pookyball, stickers, nonces, adminAddress, rewarders);

    console.log("Rewards deployed at:", address(rewards));

    vm.stopBroadcast();

    // ================ Admin grant roles ================
    vm.startBroadcast(adminPK);

    nonces.grantRole(nonces.OPERATOR(), address(rewards));

    pookyball.grantRole(pookyball.MINTER(), address(rewards));

    stickers.grantRoles(address(rewards), stickers.MINTER());

    pok.grantRole(pok.MINTER(), address(rewards));

    vm.stopBroadcast();
  }
}

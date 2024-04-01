// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { Stickers } from "@/stickers/Stickers.sol";
import { VRFConfig } from "@/types/VRFConfig.sol";
import { VRFCoordinatorV2Interface } from "chainlink/interfaces/VRFCoordinatorV2Interface.sol";

contract DeployStickers is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  uint256 adminPK = vm.envUint("ADMIN_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");

  address vrfCoordinatorAddress = vm.envAddress("VRF_COORDINATOR_ADDRESS");
  bytes32 vrfKeyHash = vm.envBytes32("VRF_KEY_HASH");
  uint64 vrfSubId = uint64(vm.envUint("VRF_SUB_ID"));
  uint16 vrfMinimumRequestConfirmations = uint16(vm.envUint("VRF_MINIMUM_REQUEST_CONFIRMATIONS"));
  uint32 vrfCallbackGasLimit = uint32(vm.envUint("VRF_CALLBACK_GAS_LIMIT"));

  address royaltyReceiverAddress = vm.envAddress("ROYALTY_RECEIVER_ADDRESS");

  VRFConfig vrf = VRFConfig({
    coordinator: VRFCoordinatorV2Interface(vrfCoordinatorAddress),
    keyHash: vrfKeyHash,
    subcriptionId: vrfSubId,
    minimumRequestConfirmations: vrfMinimumRequestConfirmations,
    callbackGasLimit: vrfCallbackGasLimit
  });

  function run() external {
    // ================ Deploy Stickers ================
    vm.startBroadcast(deployerPK);

    Stickers stickers = new Stickers{ salt: salt }(adminAddress, royaltyReceiverAddress, vrf);
    console.log("Stickers deployed at:", address(stickers));

    vm.stopBroadcast();

    uint256 chainID = vm.envUint("CHAIN_ID");
    if (chainID != 31337 && chainID != 80002) {
      // ================ Admin grant roles ================
      vm.startBroadcast(adminPK);

      console.log("Add the Stickers consumer to VRF Coordinator");
      vrf.coordinator.addConsumer(vrf.subcriptionId, address(stickers));

      vm.stopBroadcast();
    }
  }
}

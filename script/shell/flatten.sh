#!/bin/bash

ALLOWED_CONTRACTS=(
    "POK"
    "Energy"
    "NonceRegistry"
    "BoostPXP"
    "Pookyball"
    "PookyballLevelUp"
    "RefillableSale"
    "Pressure"
    "PookyballReroll"
    "PookyballAscension"
    "Stickers"
    "StickersLevelUp"
    "StickersSale"
    "StickersController"
    "StickersManager"
    "StickersAscension"
    "Rewards"
)

# Usage message
function usage {
    echo "Usage: $0 {ContractName}"
    echo "Allowed contracts: ${ALLOWED_CONTRACTS[*]}"
    exit 1
}

CONTRACT_NAME=$1

if [[ ! " ${ALLOWED_CONTRACTS[@]} " =~ " ${CONTRACT_NAME} " ]]; then
    echo "Contract not allowed"
    exit 1
fi

case $CONTRACT_NAME in
    "POK")
        CONTRACT_PATH="src/tokens/POK.sol"
        ;;
    "Energy")
        CONTRACT_PATH="src/common/Energy.sol"
        ;;
    "NonceRegistry")
        CONTRACT_PATH="src/common/NonceRegistry.sol"
        ;;
    "BoostPXP")
        CONTRACT_PATH="src/common/BoostPXP.sol"
        ;;
    "Pookyball")
        CONTRACT_PATH="src/pookyball/Pookyball.sol"
        ;;
    "PookyballLevelUp")
        CONTRACT_PATH="src/pookyball/PookyballLevelUp.sol"
        ;;
    "RefillableSale")
        CONTRACT_PATH="src/pookyball/RefillableSale.sol"
        ;;
    "Pressure")
        CONTRACT_PATH="src/pookyball/Pressure.sol"
        ;;
    "PookyballReroll")
        CONTRACT_PATH="src/pookyball/PookyballReroll.sol"
        ;;
    "PookyballAscension")
        CONTRACT_PATH="src/pookyball/PookyballAscension.sol"
        ;;
    "Stickers")
        CONTRACT_PATH="src/stickers/Stickers.sol"
        ;;
    "StickersLevelUp")
        CONTRACT_PATH="src/stickers/StickersLevelUp.sol"
        ;;
    "StickersSale")
        CONTRACT_PATH="src/stickers/StickersSale.sol"
        ;;
    "StickersController")
        CONTRACT_PATH="src/stickers/StickersController.sol"
        ;;
    "StickersManager")
        CONTRACT_PATH="src/stickers/StickersManager.sol"
        ;;
    "StickersAscension")
        CONTRACT_PATH="src/stickers/StickersAscension.sol"
        ;;
    "Rewards")
        CONTRACT_PATH="src/common/Rewards.sol"
        ;;
    *)
        echo "Contract not allowed"
        exit 1
        ;;
esac


forge flatten $CONTRACT_PATH --output flattened/$CONTRACT_NAME.sol




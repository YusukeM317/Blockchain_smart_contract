#!/bin/bash

NETWORK="$1"
CONTRACT_NAME="$2"

# Dynamically determine the list of allowed contracts by scanning for .s.sol files
# Assuming all contract files are in the script/amoy folder and follow the naming convention *_<ContractName>.s.sol
# ALLOWED_CONTRACTS=($(find script/amoy -type f -name "*.s.sol" | sed -E 's|script/amoy/.*_([^.]+)\.s\.sol|\1|'))
ALLOWED_CONTRACTS=(
    "POK"
    "Energy"
    "NonceRegistry"
    "BoostPXP"
    "Pookyball"
    "PookyballLevelUp"
    "PookyballReroll"
    "PookyballAscension"
    "Stickers"
    "StickersController"
    "StickersManager"
    "StickersLevelUp"
    "StickersSale"
    "StickersAscension"
)

# Define the networks
NETWORKS=("local" "amoy" "mainnet")

# Usage message
function usage {
    echo "Usage: $0 {network} {ContractName}"
    echo "Networks: ${NETWORKS[*]}"
    echo "Allowed contracts: ${ALLOWED_CONTRACTS[*]}"
    echo "Examples:"
    # Iterate over each contract
    for contract in "${ALLOWED_CONTRACTS[@]}"; do
        # Display the example usage for the current contract on the current network
        echo "$0 local $contract"
    done
    exit 1
}

# Check if two arguments were provided
if [ "$#" -ne 2 ]; then
    usage
fi

# Check if the contract name is allowed
if [[ ! " ${ALLOWED_CONTRACTS[@]} " =~ " ${CONTRACT_NAME} " ]]; then
    echo "Invalid contract name: ${CONTRACT_NAME}"
    echo "Allowed contracts are: ${ALLOWED_CONTRACTS[*]}"
    exit 2
fi

ENV_FILE=".env.${NETWORK}"

# Execute the command
export $(cat $ENV_FILE | sed 's/\r$//' | xargs) 

# Assuming $RPC_URL is set in the environment variables for amoy and mainnet
# and possibly a different URL for local (e.g., http://localhost:8545)
if [[ "$NETWORK" == "local" ]]; then
    DEPLOYMENT_SCRIPTS="script/amoy"
    RPC_URL_ARG="--fork-url $RPC_URL"
else
    DEPLOYMENT_SCRIPTS="script/$NETWORK"
    RPC_URL_ARG="--verify --rpc-url $RPC_URL"
fi

# Dynamically find the contract file
CONTRACT_FILE=$(find $DEPLOYMENT_SCRIPTS -type f -name "*_${CONTRACT_NAME}.s.sol")

if [ -z "$CONTRACT_FILE" ]; then
    echo "Contract file for ${CONTRACT_NAME} not found."
    exit 4
fi

# Execute the forge script
forge script $CONTRACT_FILE --tc Deploy$CONTRACT_NAME $RPC_URL_ARG --broadcast

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0 ^0.8.17 ^0.8.21 ^0.8.4;

// lib/ERC721A/contracts\IERC721A.sol

// ERC721A Contracts v4.2.3
// Creator: Chiru Labs



/**
 * @dev Interface of ERC721A.
 */
interface IERC721A {
    /**
     * The caller must own the token or be an approved operator.
     */
    error ApprovalCallerNotOwnerNorApproved();

    /**
     * The token does not exist.
     */
    error ApprovalQueryForNonexistentToken();

    /**
     * Cannot query the balance for the zero address.
     */
    error BalanceQueryForZeroAddress();

    /**
     * Cannot mint to the zero address.
     */
    error MintToZeroAddress();

    /**
     * The quantity of tokens minted must be more than zero.
     */
    error MintZeroQuantity();

    /**
     * The token does not exist.
     */
    error OwnerQueryForNonexistentToken();

    /**
     * The caller must own the token or be an approved operator.
     */
    error TransferCallerNotOwnerNorApproved();

    /**
     * The token must be owned by `from`.
     */
    error TransferFromIncorrectOwner();

    /**
     * Cannot safely transfer to a contract that does not implement the
     * ERC721Receiver interface.
     */
    error TransferToNonERC721ReceiverImplementer();

    /**
     * Cannot transfer to the zero address.
     */
    error TransferToZeroAddress();

    /**
     * The token does not exist.
     */
    error URIQueryForNonexistentToken();

    /**
     * The `quantity` minted with ERC2309 exceeds the safety limit.
     */
    error MintERC2309QuantityExceedsLimit();

    /**
     * The `extraData` cannot be set on an unintialized ownership slot.
     */
    error OwnershipNotInitializedForExtraData();

    // =============================================================
    //                            STRUCTS
    // =============================================================

    struct TokenOwnership {
        // The address of the owner.
        address addr;
        // Stores the start time of ownership with minimal overhead for tokenomics.
        uint64 startTimestamp;
        // Whether the token has been burned.
        bool burned;
        // Arbitrary data similar to `startTimestamp` that can be set via {_extraData}.
        uint24 extraData;
    }

    // =============================================================
    //                         TOKEN COUNTERS
    // =============================================================

    /**
     * @dev Returns the total number of tokens in existence.
     * Burned tokens will reduce the count.
     * To get the total number of tokens minted, please see {_totalMinted}.
     */
    function totalSupply() external view returns (uint256);

    // =============================================================
    //                            IERC165
    // =============================================================

    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * [EIP section](https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified)
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);

    // =============================================================
    //                            IERC721
    // =============================================================

    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables
     * (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in `owner`'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`,
     * checking first that contract recipients are aware of the ERC721 protocol
     * to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move
     * this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement
     * {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external payable;

    /**
     * @dev Equivalent to `safeTransferFrom(from, to, tokenId, '')`.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external payable;

    /**
     * @dev Transfers `tokenId` from `from` to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {safeTransferFrom}
     * whenever possible.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token
     * by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external payable;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the
     * zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external payable;

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom}
     * for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the caller.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool _approved) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}.
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);

    // =============================================================
    //                        IERC721Metadata
    // =============================================================

    /**
     * @dev Returns the token collection name.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the token collection symbol.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
     */
    function tokenURI(uint256 tokenId) external view returns (string memory);

    // =============================================================
    //                           IERC2309
    // =============================================================

    /**
     * @dev Emitted when tokens in `fromTokenId` to `toTokenId`
     * (inclusive) is transferred from `from` to `to`, as defined in the
     * [ERC2309](https://eips.ethereum.org/EIPS/eip-2309) standard.
     *
     * See {_mintERC2309} for more details.
     */
    event ConsecutiveTransfer(uint256 indexed fromTokenId, uint256 toTokenId, address indexed from, address indexed to);
}

// lib/openzeppelin-contracts/contracts\access/IAccessControl.sol

// OpenZeppelin Contracts v4.4.1 (access/IAccessControl.sol)



/**
 * @dev External interface of AccessControl declared to support ERC165 detection.
 */
interface IAccessControl {
    /**
     * @dev Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`
     *
     * `DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
     * {RoleAdminChanged} not being emitted signaling this.
     *
     * _Available since v3.1._
     */
    event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);

    /**
     * @dev Emitted when `account` is granted `role`.
     *
     * `sender` is the account that originated the contract call, an admin role
     * bearer except when using {AccessControl-_setupRole}.
     */
    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @dev Emitted when `account` is revoked `role`.
     *
     * `sender` is the account that originated the contract call:
     *   - if using `revokeRole`, it is the admin role bearer
     *   - if using `renounceRole`, it is the role bearer (i.e. `account`)
     */
    event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @dev Returns `true` if `account` has been granted `role`.
     */
    function hasRole(bytes32 role, address account) external view returns (bool);

    /**
     * @dev Returns the admin role that controls `role`. See {grantRole} and
     * {revokeRole}.
     *
     * To change a role's admin, use {AccessControl-_setRoleAdmin}.
     */
    function getRoleAdmin(bytes32 role) external view returns (bytes32);

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function grantRole(bytes32 role, address account) external;

    /**
     * @dev Revokes `role` from `account`.
     *
     * If `account` had been granted `role`, emits a {RoleRevoked} event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function revokeRole(bytes32 role, address account) external;

    /**
     * @dev Revokes `role` from the calling account.
     *
     * Roles are often managed via {grantRole} and {revokeRole}: this function's
     * purpose is to provide a mechanism for accounts to lose their privileges
     * if they are compromised (such as when a trusted device is misplaced).
     *
     * If the calling account had been granted `role`, emits a {RoleRevoked}
     * event.
     *
     * Requirements:
     *
     * - the caller must be `account`.
     */
    function renounceRole(bytes32 role, address account) external;
}

// lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol

// OpenZeppelin Contracts v4.4.1 (utils/introspection/IERC165.sol)



/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// lib/ERC721A/contracts\extensions/IERC721ABurnable.sol

// ERC721A Contracts v4.2.3
// Creator: Chiru Labs





/**
 * @dev Interface of ERC721ABurnable.
 */
interface IERC721ABurnable is IERC721A {
    /**
     * @dev Burns `tokenId`. See {ERC721A-_burn}.
     *
     * Requirements:
     *
     * - The caller must own `tokenId` or be an approved operator.
     */
    function burn(uint256 tokenId) external;
}

// lib/ERC721A/contracts\extensions/IERC721AQueryable.sol

// ERC721A Contracts v4.2.3
// Creator: Chiru Labs





/**
 * @dev Interface of ERC721AQueryable.
 */
interface IERC721AQueryable is IERC721A {
    /**
     * Invalid query range (`start` >= `stop`).
     */
    error InvalidQueryRange();

    /**
     * @dev Returns the `TokenOwnership` struct at `tokenId` without reverting.
     *
     * If the `tokenId` is out of bounds:
     *
     * - `addr = address(0)`
     * - `startTimestamp = 0`
     * - `burned = false`
     * - `extraData = 0`
     *
     * If the `tokenId` is burned:
     *
     * - `addr = <Address of owner before token was burned>`
     * - `startTimestamp = <Timestamp when token was burned>`
     * - `burned = true`
     * - `extraData = <Extra data when token was burned>`
     *
     * Otherwise:
     *
     * - `addr = <Address of owner>`
     * - `startTimestamp = <Timestamp of start of ownership>`
     * - `burned = false`
     * - `extraData = <Extra data at start of ownership>`
     */
    function explicitOwnershipOf(uint256 tokenId) external view returns (TokenOwnership memory);

    /**
     * @dev Returns an array of `TokenOwnership` structs at `tokenIds` in order.
     * See {ERC721AQueryable-explicitOwnershipOf}
     */
    function explicitOwnershipsOf(uint256[] memory tokenIds) external view returns (TokenOwnership[] memory);

    /**
     * @dev Returns an array of token IDs owned by `owner`,
     * in the range [`start`, `stop`)
     * (i.e. `start <= tokenId < stop`).
     *
     * This function allows for tokens to be queried if the collection
     * grows too big for a single call of {ERC721AQueryable-tokensOfOwner}.
     *
     * Requirements:
     *
     * - `start < stop`
     */
    function tokensOfOwnerIn(
        address owner,
        uint256 start,
        uint256 stop
    ) external view returns (uint256[] memory);

    /**
     * @dev Returns an array of token IDs owned by `owner`.
     *
     * This function scans the ownership mapping and is O(`totalSupply`) in complexity.
     * It is meant to be called off-chain.
     *
     * See {ERC721AQueryable-tokensOfOwnerIn} for splitting the scan into
     * multiple smaller scans if the collection is large enough to cause
     * an out-of-gas error (10K collections should be fine).
     */
    function tokensOfOwner(address owner) external view returns (uint256[] memory);
}

// lib/openzeppelin-contracts/contracts\interfaces/IERC165.sol

// OpenZeppelin Contracts v4.4.1 (interfaces/IERC165.sol)





// lib/openzeppelin-contracts/contracts\interfaces/IERC2981.sol

// OpenZeppelin Contracts (last updated v4.9.0) (interfaces/IERC2981.sol)





/**
 * @dev Interface for the NFT Royalty Standard.
 *
 * A standardized way to retrieve royalty payment information for non-fungible tokens (NFTs) to enable universal
 * support for royalty payments across all NFT marketplaces and ecosystem participants.
 *
 * _Available since v4.5._
 */
interface IERC2981 is IERC165 {
    /**
     * @dev Returns how much royalty is owed and to whom, based on a sale price that may be denominated in any unit of
     * exchange. The royalty amount is denominated and should be paid in that same unit of exchange.
     */
    function royaltyInfo(
        uint256 tokenId,
        uint256 salePrice
    ) external view returns (address receiver, uint256 royaltyAmount);
}

// lib/openzeppelin-contracts/contracts\token/ERC721/IERC721.sol

// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC721/IERC721.sol)





/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IERC721 is IERC165 {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must have been allowed to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Note that the caller is responsible to confirm that the recipient is capable of receiving ERC721
     * or else they may be permanently lost. Usage of {safeTransferFrom} prevents loss, though the caller must
     * understand this adds an external call which potentially creates a reentrancy vulnerability.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the caller.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}

// src\pookyball/IPookyball.sol







/// @title PookyballMetadata
/// @notice The Pookyball rarities are represented on chain by this enum.
enum PookyballRarity {
  COMMON,
  RARE,
  EPIC,
  LEGENDARY,
  MYTHIC
}

/// @title PookyballMetadata
/// @notice Pookyballs NFT have the following features:
/// - rarity: integer enum.
/// - level: token level, can be increase by spending token experiences points (PXP).
/// - pxp: token experience points.
/// - seed: a random uint256 word provided by Chainlink VRF service that will be used by Pooky's NFT generator
///     back-end to generate the NFT visuals and in-game statistics\.
struct PookyballMetadata {
  PookyballRarity rarity;
  uint256 level;
  uint256 pxp;
  uint256 seed;
}

/// @title IPookyball
/// @author Mathieu Bour for Pooky Labs Ltd.
/// @notice Minimal Pookyball interface.
interface IPookyball is IAccessControl, IERC2981, IERC721 {
  /// Fired when the seed of a Pookyball token is set by the VRFCoordinator
  event SeedSet(uint256 indexed tokenId, uint256 seed);
  /// Fired when the level of a Pookyball token is changed
  event LevelChanged(uint256 indexed tokenId, uint256 level);
  /// Fired when the PXP of a Pookyball token is changed
  event PXPChanged(uint256 indexed tokenId, uint256 amount);

  /// Thrown when the length of two parameters mismatch. Used in the mint batched function.
  error ArgumentSizeMismatch(uint256 x, uint256 y);

  /// @notice PookyballMetadata of the token {tokenId}.
  /// @dev Requirements:
  /// - Pookyball {tokenId} should exist (minted and not burned).
  function metadata(uint256 tokenId) external view returns (PookyballMetadata memory);

  /// @notice Change the secondary sale royalties receiver address.
  function setERC2981Receiver(address newReceiver) external;

  /// @notice Mint a new Pookyball token with a given rarity.
  function mint(address[] memory recipients, PookyballRarity[] memory rarities)
    external
    returns (uint256);

  /// @notice Change the level of a Pookyball token.
  /// @dev Requirements:
  /// - Pookyball {tokenId} should exist (minted and not burned).
  function setLevel(uint256 tokenId, uint256 newLevel) external;

  /// @notice Change the PXP of a Pookyball token.
  /// @dev Requirements:
  /// - Pookyball {tokenId} should exist (minted and not burned).
  function setPXP(uint256 tokenId, uint256 newPXP) external;
}

// src\common/IBaseERC721A.sol









/// @title IBaseERC721
///
/// @author Mathieu Bour for Pooky Labs Ltd.
interface IBaseERC721A is IERC165, IERC721A, IERC721ABurnable, IERC721AQueryable, IERC2981 {
  /// Fired when the seed of a Pookyball token is set by the VRFCoordinator,
  event SeedSet(uint256 indexed tokenId, uint256 seed);

  /// Thrown when the token {tokenId} does not exist.
  error NonExistentToken(uint256 tokenId);

  // ----- ERC721A patches -----
  /// @dev This allow to iterate over the token ids.
  function nextTokenId() external view returns (uint256);

  function supportsInterface(bytes4 interfaceId)
    external
    view
    override(IERC165, IERC721A)
    returns (bool);
}

// src\stickers/IStickers.sol





enum StickerRarity {
  COMMON,
  RARE,
  EPIC,
  LEGENDARY,
  MYTHIC
}

struct StickerMint {
  address recipient;
  StickerRarity rarity;
}

struct StickerMetadata {
  uint248 level;
  StickerRarity rarity;
}

/// @title IStickers
/// @author Mathieu Bour for Pooky Labs Ltd.
interface IStickers is IBaseERC721A {
  /// Fired when the level of a Pookyball token is changed,
  event LevelChanged(uint256 indexed tokenId, uint256 level);

  /// @notice StickerMetadata of the token {tokenId}.
  /// @dev Requirements:
  /// - Sticker {tokenId} should exist (minted and not burned).
  function metadata(uint256 tokenId) external view returns (StickerMetadata memory);

  /// @notice Change the level of a Sticker token.
  /// @dev Requirements:
  /// - Sticker {tokenId} should exist (minted and not burned).
  function setLevel(uint256 tokenId, uint248 newLevel) external;

  /// @notice Mint multiple Stickers at once.
  /// @param recipient The mint recipient.
  /// @param rarities The Sticker rarities.
  function mint(address recipient, StickerRarity[] memory rarities) external;
}

// src\stickers/IStickersController.sol






/// @notice IStickersController
/// @author Mathieu Bour for Pooky Labs Ltd.
interface IStickersController {
  /// @notice Fired when a sticker is attached to a Pookyball.
  event StickerAttached(uint256 stickerId, uint256 pookyballId);
  /// @notice Fired when a sticker is replace from a Pookyball.
  event StickerReplaced(uint256 stickerId, uint256 previousStickerId, uint256 pookyballId);
  /// @notice Fired when a sticker is detached from a Pookyball.
  event StickerDetached(uint256 stickerId, uint256 pookyballId);

  /// @notice Thrown when a sticker is invalid.
  error InvalidSticker(uint256 stickerId);

  /// @notice The Stickers ERC-721 contract.
  function stickers() external view returns (IStickers);

  /// @notice The Pookyball ERC-721 contract.
  function pookyball() external view returns (IPookyball);

  /// @notice Get the Pookyball token id linked to a Sticker.
  /// @param stickerId The Sticker token id.
  function attachedTo(uint256 stickerId) external view returns (uint256);

  /// @notice Get the Stickers token ids attached to a Pookyball.
  /// @param pookyballId The Pookyball token id.
  function slots(uint256 pookyballId) external view returns (uint256[] memory);

  /// @notice Attach a sticker to a Pookyball.
  /// @param stickerId The sticker token id.
  /// @param pookyballId The Pookyball token id.
  /// @dev Caution: no ownership checks are run.
  function attach(uint256 stickerId, uint256 pookyballId) external;

  /// @notice Replace a sticker from a Pookyball, burning the previous one.
  /// @param stickerId The sticker token id.
  /// @param previousStickerId The previous sticker token id that will be burned.
  /// @param pookyballId The Pookyball token id.
  /// @dev Caution: no ownership checks are run.
  function replace(uint256 stickerId, uint256 previousStickerId, uint256 pookyballId) external;

  /// @notice Detach (remove) a sticker from a Pookyball.
  /// @param stickerId The Sstickerticker token id.
  /// @param recepient The address when to send the detached sticker.
  function detach(uint256 stickerId, address recepient) external;
}

// src\stickers\StickersManager.sol







/// @title StickersManager
/// @author Mathieu Bour for Pooky Labs Ltd.
///
/// @dev Implementation of the manager that allows end users to attach or replace stickers to Pookyballs.
contract StickersManager {
  IStickers public immutable stickers;
  IPookyball public immutable pookyball;
  IStickersController public immutable controller;

  error OwnershipRequired(address token, uint256 tokenId);
  error InsufficientFreeSlot(uint256 pookyballId);

  constructor(IStickersController _controller) {
    controller = _controller;
    stickers = _controller.stickers();
    pookyball = _controller.pookyball();
  }

  modifier checkOwnership(uint256 stickerId, uint256 pookyballId) {
    if (stickers.ownerOf(stickerId) != msg.sender) {
      revert OwnershipRequired(address(stickers), stickerId);
    }

    if (pookyball.ownerOf(pookyballId) != msg.sender) {
      revert OwnershipRequired(address(pookyball), pookyballId);
    }

    _;
  }

  function slots(uint256 pookyballId)
    public
    view
    returns (uint256 total, uint256 unlocked, uint256 free)
  {
    PookyballMetadata memory metadata = pookyball.metadata(pookyballId);

    if (metadata.rarity == PookyballRarity.COMMON) {
      total = 4;
    } else if (metadata.rarity == PookyballRarity.RARE) {
      total = 6;
    } else if (metadata.rarity == PookyballRarity.EPIC) {
      total = 8;
    } else if (metadata.rarity == PookyballRarity.LEGENDARY) {
      total = 10;
    } else if (metadata.rarity == PookyballRarity.MYTHIC) {
      total = 12;
    }

    unlocked = (metadata.level + 5) / 10;
    uint256 used = controller.slots(pookyballId).length;

    // We might have some promotional offers that allow to unlock the slots before the Pookyball has reached the required level
    if (used > unlocked) {
      unlocked = used;
    }

    free = unlocked - used;
  }

  function attach(uint256 stickerId, uint256 pookyballId)
    external
    checkOwnership(stickerId, pookyballId)
  {
    (,, uint256 free) = slots(pookyballId);

    if (free == 0) {
      revert InsufficientFreeSlot(pookyballId);
    }

    controller.attach(stickerId, pookyballId);
  }

  function replace(uint256 stickerId, uint256 previousStickerId, uint256 pookyballId)
    external
    checkOwnership(stickerId, pookyballId)
  {
    controller.replace(stickerId, previousStickerId, pookyballId);
  }
}

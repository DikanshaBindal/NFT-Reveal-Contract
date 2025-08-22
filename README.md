# NFT Reveal Contract

## Project Description

This smart contract implements a delayed reveal mechanism for mystery NFT collections on the Stacks blockchain using Clarity. The contract allows users to mint mystery NFTs that initially display placeholder metadata, and enables the contract owner to reveal the entire collection later with real metadata and artwork.

The contract includes two main functions:
1. **mint-mystery-nft** - Allows users to mint mystery NFTs before the reveal
2. **reveal-collection** - Allows the contract owner to reveal the collection with actual metadata

This mechanism is commonly used for NFT drops where the final artwork and rarities are kept secret until after the minting phase is complete, creating excitement and preventing selective minting based on rarity.

## Key Features

- **Mystery Minting**: Users can mint NFTs that show placeholder metadata
- **Delayed Reveal**: Contract owner can reveal the collection when ready
- **NFT Standard Compliance**: Includes standard NFT functions for transfers and metadata
- **Access Control**: Only contract owner can trigger the reveal
- **State Management**: Tracks reveal status and manages URIs appropriately

## Contract Functions

### Main Functions

#### `mint-mystery-nft (recipient principal)`
- **Description**: Mints a mystery NFT to the specified recipient
- **Parameters**: 
  - `recipient`: Principal address to receive the NFT
- **Returns**: Token ID of the minted NFT
- **Access**: Public function, anyone can call
- **Behavior**: 
  - Creates a new NFT with mystery metadata
  - Assigns a unique token ID
  - Sets placeholder URI until reveal

#### `reveal-collection (base-uri (string-ascii 256))`
- **Description**: Reveals the entire NFT collection with actual metadata
- **Parameters**: 
  - `base-uri`: Base URI for the revealed metadata
- **Returns**: Boolean success indicator
- **Access**: Owner only
- **Behavior**: 
  - Sets the collection as revealed
  - Updates base URI for all NFTs
  - Cannot be called twice

### Read-Only Functions

- `get-token-uri (token-id uint)`: Returns appropriate URI based on reveal status
- `get-owner (token-id uint)`: Returns the owner of a specific token
- `get-last-token-id`: Returns the most recently minted token ID
- `is-collection-revealed`: Checks if the collection has been revealed
- `get-mystery-uri`: Returns the mystery placeholder URI
- `get-revealed-base-uri`: Returns the revealed base URI

## Error Codes

- `u100`: Owner only - Function can only be called by contract owner
- `u101`: Not token owner - Caller is not the token owner
- `u102`: Token not found - Specified token ID doesn't exist
- `u103`: Already revealed - Collection has already been revealed
- `u104`: Invalid token ID - Token ID is invalid
- `u105`: Mint failed - NFT minting operation failed

## Usage Flow

1. **Deploy Contract**: Deploy the contract to Stacks blockchain
2. **Mystery Phase**: 
   - Users call `mint-mystery-nft` to mint NFTs
   - All NFTs display mystery placeholder metadata
   - Actual artwork remains hidden
3. **Reveal Phase**:
   - Contract owner calls `reveal-collection` with real metadata URI
   - All existing and future NFTs now display revealed metadata
   - Reveal is permanent and cannot be undone

## Technical Details

- **Blockchain**: Stacks
- **Language**: Clarity
- **NFT Standard**: Custom implementation with standard compliance
- **Token Type**: Non-fungible token (NFT)
- **Reveal Mechanism**: Global reveal affecting all tokens

## Transaction IDs

This section will be populated with actual transaction IDs after contract deployment and testing:

### Deployment Transaction
- **Contract Deployment**: `[Transaction ID will be added after deployment]`

### Test Transactions
- **First Mystery NFT Mint**: `[Transaction ID will be added after first mint]`
- **Collection Reveal**: `[Transaction ID will be added after reveal]`
- **Post-Reveal NFT Mint**: `[Transaction ID will be added after reveal testing]`

## Security Considerations

- Only the contract owner can trigger the reveal
- Reveal is a one-time operation that cannot be reversed
- Token transfers are restricted to token owners
- All standard NFT security practices are implemented

## Transaction IDs
ST3RBEP8W4X655SR6FHEPXQGTG5G1PWRBDPDZD2FK.NFTRevealContract

## screenshot
<img width="1337" height="607" alt="image" src="https://github.com/user-attachments/assets/37951de2-b96d-4c4b-813a-15b707df4771" />


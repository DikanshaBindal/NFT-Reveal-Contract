;; NFT Reveal Contract
;; A mystery NFT collection with delayed reveal mechanism
;; Allows minting mystery NFTs that can be revealed later by the contract owner

;; Define the NFT
(define-non-fungible-token mystery-nft uint)

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))
(define-constant err-token-not-found (err u102))
(define-constant err-already-revealed (err u103))
(define-constant err-invalid-token-id (err u104))
(define-constant err-mint-failed (err u105))

;; Data variables
(define-data-var next-token-id uint u1)
(define-data-var is-revealed bool false)
(define-data-var mystery-uri (string-ascii 256) "https://mystery-collection.com/unrevealed.json")
(define-data-var revealed-base-uri (string-ascii 256) "")

;; Maps
(define-map token-owners uint principal)
(define-map token-uris uint (string-ascii 256))

;; Mint mystery NFT function
;; Allows users to mint mystery NFTs before reveal
(define-public (mint-mystery-nft (recipient principal))
  (let ((token-id (var-get next-token-id)))
    (begin
      (asserts! (> token-id u0) err-invalid-token-id)
      ;; Mint the NFT
      (match (nft-mint? mystery-nft token-id recipient)
        success 
        (begin
          ;; Update token owner mapping
          (map-set token-owners token-id recipient)
          ;; Set mystery URI for this token
          (map-set token-uris token-id (var-get mystery-uri))
          ;; Increment next token ID
          (var-set next-token-id (+ token-id u1))
          (ok token-id))
        error err-mint-failed))))

;; Reveal collection function
;; Allows contract owner to reveal the entire collection with real metadata
(define-public (reveal-collection (base-uri (string-ascii 256)))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (not (var-get is-revealed)) err-already-revealed)
    ;; Set the revealed state
    (var-set is-revealed true)
    ;; Set the base URI for revealed metadata
    (var-set revealed-base-uri base-uri)
    (ok true)))

;; Read-only functions for NFT standard compliance

;; Get token URI
(define-read-only (get-token-uri (token-id uint))
  (if (var-get is-revealed)
      ;; If revealed, return the revealed URI (base-uri + token-id)
      (ok (some (var-get revealed-base-uri)))
      ;; If not revealed, return mystery URI
      (ok (some (var-get mystery-uri)))))

;; Get token owner
(define-read-only (get-owner (token-id uint))
  (ok (nft-get-owner? mystery-nft token-id)))

;; Get last token ID
(define-read-only (get-last-token-id)
  (ok (- (var-get next-token-id) u1)))

;; Check if collection is revealed
(define-read-only (is-collection-revealed)
  (ok (var-get is-revealed)))

;; Get mystery URI
(define-read-only (get-mystery-uri)
  (ok (var-get mystery-uri)))

;; Get revealed base URI
(define-read-only (get-revealed-base-uri)
  (ok (var-get revealed-base-uri)))

;; Transfer function
(define-public (transfer (token-id uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) err-not-token-owner)
    (match (nft-transfer? mystery-nft token-id sender recipient)
      success 
      (begin
        (map-set token-owners token-id recipient)
        (ok true))
      error err-token-not-found)))
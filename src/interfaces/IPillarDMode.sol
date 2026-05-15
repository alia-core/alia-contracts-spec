// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

// ═══════════════════════════════════════════════════════════════════════════════
//  IPillarDMode — ALIA Quality Network · alia-core/alia-engine
//
//  Interface commune pour tous les modes Pillar D Stable Capital Edge V25.
//
//  3 modes paramétrables Memo V7 §7.3 :
//    Mode 1 — YieldBoostedMode      : yield boosté 8-15% APY quality-gated (V0 J3)
//    Mode 2 — TranchingMode         : senior 6-7% / junior 15-25% (interface J3, impl Q4 2026)
//    Mode 3 — IncomeStreamingMode   : flux mensuel fixe annuity pattern (interface J3, impl Y2H1 2027)
//
//  PillarDRouter dispatche deposit(mode) → Mode contract.
//  Chaque mode implémente vault ERC-4626-compatible avec shares accounting.
// ═══════════════════════════════════════════════════════════════════════════════

interface IPillarDMode {

    /// @notice Mode identifier (for routing + telemetry)
    /// @return Mode tag — "YIELD_BOOSTED" | "TRANCHING" | "INCOME_STREAMING"
    function modeName() external pure returns (string memory);

    /// @notice Mode version (semver-like for upgrade tracking)
    function modeVersion() external pure returns (string memory);

    /// @notice Deposit assets into the mode vault
    /// @dev    Caller MUST have approved this contract for `amount` of `asset`
    /// @param  asset       Token deposited
    /// @param  amount      Amount in asset native decimals
    /// @param  receiver    Address to credit shares to
    /// @param  mandateId   Mandate driving quality gating + risk policy
    /// @return shares      Vault shares minted to receiver
    function deposit(
        address asset,
        uint256 amount,
        address receiver,
        bytes32 mandateId
    ) external returns (uint256 shares);

    /// @notice Withdraw assets by redeeming vault shares
    /// @param  asset       Token to redeem
    /// @param  shares      Vault shares to burn (type(uint256).max = full position)
    /// @param  receiver    Address to receive withdrawn assets
    /// @return assets      Amount of asset transferred to receiver
    function redeem(
        address asset,
        uint256 shares,
        address receiver
    ) external returns (uint256 assets);

    /// @notice Total shares outstanding for an asset
    function totalShares(address asset) external view returns (uint256);

    /// @notice Total assets under management for an asset (incl. accrued yield)
    function totalAssets(address asset) external view returns (uint256);

    /// @notice User's share balance for an asset
    function shareBalanceOf(address asset, address user) external view returns (uint256);

    /// @notice Convert shares to underlying asset amount (current exchange rate)
    function convertToAssets(address asset, uint256 shares) external view returns (uint256);

    /// @notice Convert asset amount to shares (current exchange rate)
    function convertToShares(address asset, uint256 amount) external view returns (uint256);

    // ─── Events ───────────────────────────────────────────────────────────────

    event Deposit(
        address indexed sender,
        address indexed receiver,
        address indexed asset,
        uint256 amount,
        uint256 shares,
        bytes32 mandateId
    );

    event Redeem(
        address indexed sender,
        address indexed receiver,
        address indexed asset,
        uint256 shares,
        uint256 assets
    );
}

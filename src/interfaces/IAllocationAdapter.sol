// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

// ═══════════════════════════════════════════════════════════════════════════════
//  IAllocationAdapter — ALIA Quality Network · alia-core/alia-engine
//
//  Interface canonical réutilisable pour tout protocole de lending/yield
//  adressable par QualityGatedAllocator + PillarDRouter (Mode 1 Yield Boosted).
//
//  Pattern stratégique :
//    Cette interface est le "negotiation hook" pour onboarder n'importe quel
//    protocole DeFi (Aave V3 BNB, Morpho, Pendle, Kernel, Lista, Spark,
//    Compound, Euler, Silo, Venus, etc.) en 3-5 jours par adapter.
//
//    Le pattern Federated by Design Pilier 4 V25 opérationnel :
//      1. Protocole self-registers via AdapterRegistry.requestAdapterListing()
//      2. ALIA core team audit bytecode + score attestation
//      3. ALIA Quality Badge soulbound mint sur adapter address
//      4. Adapter devient éligible capital flow PillarDRouter
//
//  V0 scope sprint sem 1-2 (supply-only, cohérent VenusAdapter v0.1.0 12 mai) :
//    - supply(asset, amount) → received
//    - withdraw(asset, amount) → withdrawn
//    - balanceOf(asset, owner) → balance
//    - expectedAPY(asset) → bps annualized
//    - adapterType() + protocolName() metadata pure
//
//  V1 scope Y1H2 (borrow + repay + leverage) :
//    - borrow/repay added when PillarDRouter Mode 2 Tranching implements
//      senior/junior leverage logic Q4 2026
//
//  V2 scope Y2H1 (cross-protocol routing optimization) :
//    - swap/rebalance hooks when AGIL-4 Decision Orchestrator industrialised
// ═══════════════════════════════════════════════════════════════════════════════

interface IAllocationAdapter {

    /// @notice Supply assets to the underlying protocol (lending/yield)
    /// @dev    Caller MUST have approved this adapter to spend `amount` of `asset`
    /// @param  asset Token address to supply (USDC, USDT, FDUSD, etc.)
    /// @param  amount Amount to supply in token native decimals
    /// @return received Amount of receipt token (vToken, aToken, mToken) credited
    function supply(address asset, uint256 amount) external returns (uint256 received);

    /// @notice Withdraw assets from the underlying protocol
    /// @dev    Caller MUST have a balance on this adapter (via prior supply)
    /// @param  asset Token address to withdraw
    /// @param  amount Amount to withdraw in token native decimals (or type(uint256).max for full)
    /// @return withdrawn Actual amount of asset received back
    function withdraw(address asset, uint256 amount) external returns (uint256 withdrawn);

    /// @notice Read user balance on the underlying protocol
    /// @param  asset Token address
    /// @param  owner Address whose balance to read
    /// @return Balance in token native decimals (asset, not receipt token)
    function balanceOf(address asset, address owner) external view returns (uint256);

    /// @notice Expected annualized yield for supplying `asset` to this adapter
    /// @dev    Returned in basis points (bps), e.g. 850 = 8.50% APY
    ///         MUST reflect current market conditions, not historical
    ///         MAY revert if market not initialised on the protocol
    /// @param  asset Token address
    /// @return bps Annualized yield in basis points
    function expectedAPY(address asset) external view returns (uint16 bps);

    /// @notice Adapter category for routing logic
    /// @return Type tag — "LENDING" | "YIELD_AGG" | "VAULT" | "RWA" | "STRUCTURED"
    function adapterType() external pure returns (string memory);

    /// @notice Protocol name (display + AdapterRegistry indexing)
    /// @return Name — "Venus" | "Aave-V3-BNB" | "Morpho" | "Pendle" | "Kernel" | etc.
    function protocolName() external pure returns (string memory);

    // ─── Events (recommended emission patterns) ─────────────────────────────────

    event Supplied(address indexed caller, address indexed asset, uint256 amount, uint256 received);
    event Withdrawn(address indexed caller, address indexed asset, uint256 amount, uint256 withdrawn);
}

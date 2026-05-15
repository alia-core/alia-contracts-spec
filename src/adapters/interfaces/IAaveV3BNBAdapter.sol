// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

import {IAllocationAdapter} from "../../interfaces/IAllocationAdapter.sol";

// ═══════════════════════════════════════════════════════════════════════════════
//  IAaveV3BNBAdapter — ALIA Quality Network · negotiation hook
//
//  Production adapter spec for Aave V3 on BNB Chain.
//  Reference: Aave V3 Pool 0x6807dc923806fE8Fd134338EABCA509979a7e0cB (BNB mainnet)
//
//  Stani Kulechov / Aave Labs team integration scope (3-5 days):
//    1. Implement IAllocationAdapter base via IAaveV3BNBAdapter extension
//    2. Pool.supply() wraps user asset → aToken receipt
//    3. Pool.withdraw() unwraps aToken → asset
//    4. expectedAPY pulls from Pool.getReserveData().currentLiquidityRate
//    5. Audit ALIA core team (bytecode hash + score attestation)
//    6. Register via QualityGatedAllocator.registerAdapter()
// ═══════════════════════════════════════════════════════════════════════════════

interface IAaveV3BNBAdapter is IAllocationAdapter {

    /// @notice Aave V3 Pool contract reference
    function aavePool() external view returns (address);

    /// @notice aToken receipt for a given underlying asset
    function aTokenFor(address asset) external view returns (address);

    /// @notice Current variable borrow rate (annualized bps) — for future leverage V1
    function variableBorrowRate(address asset) external view returns (uint16 bps);

    /// @notice Aave V3 reserve normalized income (RAY 1e27)
    function getReserveNormalizedIncome(address asset) external view returns (uint256);
}

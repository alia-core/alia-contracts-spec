// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

import {IAllocationAdapter} from "../../interfaces/IAllocationAdapter.sol";

// ═══════════════════════════════════════════════════════════════════════════════
//  ICompoundAdapter — ALIA Quality Network · negotiation hook
//
//  Compound V3 (Comet) integration. Single-asset markets per base token.
//  Reference: cUSDCv3 / cWETHv3 / cUSDTv3 deployed multi-chain.
//
//  Compound Labs / OpenZeppelin team integration scope (3-5 days):
//    1. Comet.supply(asset, amount) → base token receipt
//    2. expectedAPY via Comet.getUtilization() + getSupplyRate()
// ═══════════════════════════════════════════════════════════════════════════════

interface ICompoundAdapter is IAllocationAdapter {
    function cometFor(address asset) external view returns (address);
    function utilization(address asset) external view returns (uint256);
    function getSupplyRatePerSecond(address asset) external view returns (uint256);
}

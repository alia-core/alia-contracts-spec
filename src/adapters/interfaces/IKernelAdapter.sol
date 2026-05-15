// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

import {IAllocationAdapter} from "../../interfaces/IAllocationAdapter.sol";

// ═══════════════════════════════════════════════════════════════════════════════
//  IKernelAdapter — ALIA Quality Network · negotiation hook
//
//  Production adapter spec for Kernel (BNB-native restaking + LRT).
//  Reference: Kernel Protocol — BNB Chain restaking layer
//
//  Kernel team integration scope (3-5 days):
//    1. Stake user asset → kBNB / kETH receipt token
//    2. expectedAPY = base staking yield + restaking rewards
//    3. Withdraw with cooldown period (typical 7 days BNB-side)
// ═══════════════════════════════════════════════════════════════════════════════

interface IKernelAdapter is IAllocationAdapter {

    function kernelManager() external view returns (address);

    /// @notice Receipt token (LRT) for a given underlying staked asset
    function lrtFor(address asset) external view returns (address);

    /// @notice Cooldown period in seconds before withdrawal claimable
    function cooldownPeriod() external view returns (uint256);

    /// @notice Pending withdrawal request for caller on a given asset
    function pendingWithdrawal(address asset, address owner) external view returns (uint256 amount, uint256 unlockAt);
}

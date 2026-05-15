// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

import {IAllocationAdapter} from "../../interfaces/IAllocationAdapter.sol";

interface IPendleAdapter is IAllocationAdapter {
    function pendleRouter() external view returns (address);
    function marketFor(address asset) external view returns (address);
    function ptToken(address market) external view returns (address);
    function ytToken(address market) external view returns (address);
    function maturity(address market) external view returns (uint256);
    function fixedYieldBps(address market) external view returns (uint16);
}

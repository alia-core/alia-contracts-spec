// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

import {IAllocationAdapter} from "../../interfaces/IAllocationAdapter.sol";

interface ISparkAdapter is IAllocationAdapter {
    function sparkPool() external view returns (address);
    function spTokenFor(address asset) external view returns (address);
    function dsrRateBps() external view returns (uint16);
    function isD3MActive(address asset) external view returns (bool);
}

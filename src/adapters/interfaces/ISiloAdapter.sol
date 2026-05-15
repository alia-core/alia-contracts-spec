// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

import {IAllocationAdapter} from "../../interfaces/IAllocationAdapter.sol";

interface ISiloAdapter is IAllocationAdapter {
    function siloFor(address asset) external view returns (address);
    function shareTokenFor(address asset) external view returns (address);
    function getInterestRate(address asset) external view returns (uint256);
}

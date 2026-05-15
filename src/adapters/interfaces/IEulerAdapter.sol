// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

import {IAllocationAdapter} from "../../interfaces/IAllocationAdapter.sol";

interface IEulerAdapter is IAllocationAdapter {
    function vaultFor(address asset) external view returns (address);
    function interestRate(address asset) external view returns (uint256);
    function eTokenFor(address asset) external view returns (address);
}

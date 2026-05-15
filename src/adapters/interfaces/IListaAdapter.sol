// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

import {IAllocationAdapter} from "../../interfaces/IAllocationAdapter.sol";

interface IListaAdapter is IAllocationAdapter {
    function listaStaking() external view returns (address);
    function listaRWAModule() external view returns (address);
    function moduleFor(address asset) external view returns (string memory);
    function slisBNBRate() external view returns (uint256);
}

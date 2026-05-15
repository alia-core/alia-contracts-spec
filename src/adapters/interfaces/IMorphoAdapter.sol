// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

import {IAllocationAdapter} from "../../interfaces/IAllocationAdapter.sol";

interface IMorphoAdapter is IAllocationAdapter {

    struct MarketParams {
        address loanToken;
        address collateralToken;
        address oracle;
        address irm;
        uint256 lltv;
    }

    function morphoBlue() external view returns (address);
    function marketIdFor(address asset) external view returns (bytes32);
    function marketParamsFor(address asset) external view returns (MarketParams memory);
}

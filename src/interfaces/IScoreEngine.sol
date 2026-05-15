// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

// ═══════════════════════════════════════════════════════════════════════════════
//  IScoreEngine — interface canonique consumer-side ALIA Quality Network
//
//  Implémentée par :
//    - ScoreEngineV2.sol             (Base mainnet 0x295C…CB43)
//    - ScoreEngineV2BNBMirror.sol    (BNB Chain mirror cross-chain pull-based)
//    - (futur) ScoreEngineV2SolanaMirror, ArbitrumMirror Y2H1-Y2H2
//
//  Consumée par :
//    - QualityGatedAllocator         (J2 sprint sem 1-2)
//    - PillarDRouter + modes         (J3)
//    - ELIERouter                    (existant Base)
//    - Adapters Couche 3             (Venus shipped, Aave V3 BNB / Morpho / Pendle / Kernel)
//
//  Note compatibilité ScoreEngineV2 Base déployé pre-interface :
//    Le contrat Base ne déclare pas explicitement implement IScoreEngine,
//    mais ses signatures publiques matchent strictement.
//    Cast `IScoreEngine(scoreEngineV2Address)` est valide ABI-wise.
// ═══════════════════════════════════════════════════════════════════════════════

interface IScoreEngine {

    /// @dev Snapshot du score effectif d'un asset, partagé entre tous les ScoreEngines
    struct CachedScore {
        uint256 score;       // 0–1000 (MAX_SCORE)
        uint256 confidence;  // 0–10000 bps
        uint256 updatedAt;   // block.timestamp last update
        bool    isActive;    // false = retired asset
    }

    /// @notice Score effectif d'un asset — appliqué override > composite > cache brut
    /// @return score Le score effectif 0–1000
    /// @return fresh true si updatedAt dans la fenêtre stalePeriod
    function getEffectiveScore(address asset) external view returns (uint256 score, bool fresh);

    /// @notice Score composite view (sans modification d'état)
    /// @return compositeScore Score composite 0–1000
    /// @return modulesUsed Nombre de modules ayant contribué (0 sur les mirrors cross-chain)
    function getCompositeScoreView(address asset) external view returns (uint256 compositeScore, uint256 modulesUsed);

    /// @notice Émis à chaque mise à jour de score (Base via refreshScore, BNB Mirror via attestation)
    event ScoreUpdated(
        address indexed asset,
        uint256 previousScore,
        uint256 newScore,
        uint256 confidence,
        uint256 timestamp
    );
}

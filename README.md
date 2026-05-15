# alia-contracts-spec

Contract interfaces and integration specifications for ALIA Quality Network.

## What

Solidity interfaces for protocols integrating ALIA quality scoring, forecasting,
quality-gated allocation, and recourse primitives.

## Contents

### Core interfaces (`src/interfaces/`)

- `IScoreEngine.sol` — Quality score consumer interface. Returns effective
  score 0-1000 + freshness flag for any asset.
- `IAllocationAdapter.sol` — Canonical adapter interface. Implement for any
  lending/yield protocol to become eligible quality-gated capital flow.
- `IPillarDMode.sol` — Pillar D mode interface. ERC-4626-like vault pattern
  with mandate-bound deposit/redeem and shares-based accounting.

### Adapter negotiation hooks (`src/adapters/interfaces/`)

Protocol-specific extensions of `IAllocationAdapter` with native primitives
exposed for integration:

- `IAaveV3BNBAdapter.sol`
- `IMorphoAdapter.sol`
- `IPendleAdapter.sol`
- `IKernelAdapter.sol`
- `IListaAdapter.sol`
- `ISparkAdapter.sol`
- `ICompoundAdapter.sol`
- `IEulerAdapter.sol`
- `ISiloAdapter.sol`

Each adapter spec maps to 3-5 days integration work for protocol teams who
want to expose their markets to ALIA-routed capital.

## Live deployments

Currently deployed on BNB Chain testnet. Contract addresses, ABIs, and
verification status published when production rollout completes.

## Architecture

ALIA Quality Network ships six composed primitives — Score, Forecast,
Execute, Trace, Insure, Resolve — operated by the AGIL backend engine.
Smart contracts in this repository describe the integration surface for
external protocols.

Full architecture documentation: forthcoming.

## License

Business Source License 1.1. See `LICENSE`.

Production use requires a commercial license from Avvatar Labs SAS.
ALIA, ALIA Quality Network, ALIA Verified Badge, Quality-Wrapped, and
AGIL are trademarks of Avvatar Labs SAS.

## Contact

[avvatar.io](https://avvatar.io)

---

## NPM consumption

Install: npm install @alia/contracts-spec

Import in TypeScript using IScoreEngine__factory, IPillarDMode__factory, IAllocationAdapter__factory from @alia/contracts-spec. See dist/ for compiled types. Contracts live BNB testnet — full addresses on alia.network/docs.

License BUSL-1.1 (Avvatar Labs SAS, change date 2028-06-01 → MIT).

// ALIA Quality Network — ABI extractor
// Reads Foundry compilation artifacts from out/ and writes flat ABI JSON files
// to abi/ for consumption by typechain + downstream npm consumers.

const fs = require('fs');
const path = require('path');

const ROOT = __dirname.replace(/scripts$/, '');
const OUT_DIR = path.join(ROOT, 'out');
const ABI_DIR = path.join(ROOT, 'abi');

if (!fs.existsSync(ABI_DIR)) fs.mkdirSync(ABI_DIR, { recursive: true });
const ADAPTERS_DIR = path.join(ABI_DIR, 'adapters');
if (!fs.existsSync(ADAPTERS_DIR)) fs.mkdirSync(ADAPTERS_DIR, { recursive: true });

// Core interfaces (src/interfaces/*.sol)
const coreInterfaces = ['IScoreEngine', 'IAllocationAdapter', 'IPillarDMode'];

// Adapter interfaces (src/adapters/interfaces/*.sol)
const adapterInterfaces = [
    'IAaveV3BNBAdapter',
    'ICompoundAdapter',
    'IEulerAdapter',
    'IKernelAdapter',
    'IListaAdapter',
    'IMorphoAdapter',
    'IPendleAdapter',
    'ISiloAdapter',
    'ISparkAdapter'
];

function extractAbi(name, subdir = '') {
    const artifactPath = path.join(OUT_DIR, `${name}.sol`, `${name}.json`);
    if (!fs.existsSync(artifactPath)) {
        console.warn(`[skip] ${name} — artifact not found at ${artifactPath}`);
        return;
    }
    const artifact = JSON.parse(fs.readFileSync(artifactPath, 'utf8'));
    const outPath = path.join(ABI_DIR, subdir, `${name}.json`);
    fs.writeFileSync(outPath, JSON.stringify(artifact.abi, null, 2));
    console.log(`[ok]   ${name} → abi/${subdir ? subdir + '/' : ''}${name}.json`);
}

console.log('=== Extracting ABIs from Foundry artifacts ===');
console.log(`OUT_DIR : ${OUT_DIR}`);
console.log(`ABI_DIR : ${ABI_DIR}`);
console.log('');
console.log('--- Core interfaces ---');
coreInterfaces.forEach(name => extractAbi(name));
console.log('--- Adapter interfaces ---');
adapterInterfaces.forEach(name => extractAbi(name, 'adapters'));
console.log('');
console.log(`Total extracted: ${coreInterfaces.length + adapterInterfaces.length} ABIs`);

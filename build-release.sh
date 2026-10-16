#!/usr/bin/env bash
set -euo pipefail

# Canonical release build script for Zed fork on resource-constrained systems (e.g. 14 GB RAM).
# Concurrency is strictly clamped to 2 jobs (-j 2) to prevent Linux OOM killer during release linking.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT"

echo "==> Building Zed fork in release mode (jobs = 2)..."
cargo build --release -p zed -p cli -j 2 "$@"

echo "==> Build complete!"
echo "    - Editor: $REPO_ROOT/target/release/zed"
echo "    - CLI:    $REPO_ROOT/target/release/cli"
echo "    - Installed at: ~/.local/bin/zed -> $(readlink -f ~/.local/bin/zed 2>/dev/null || echo 'not linked')"

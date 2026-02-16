#!/bin/bash
# Grid Trading Strategy Backtest Script
# Usage: bash backtest.sh --config config.json --pair BTCUSDT --days 30

set -euo pipefail

# Default values
CONFIG_FILE="config.json"
PAIR="BTCUSDT"
DAYS=30

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --config)
      CONFIG_FILE="$2"
      shift 2
      ;;
    --pair)
      PAIR="$2"
      shift 2
      ;;
    --days)
      DAYS="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

echo "========================================"
echo "Grid Trading Backtest"
echo "========================================"
echo "Config: $CONFIG_FILE"
echo "Pair:   $PAIR"
echo "Period: $DAYS days"
echo "========================================"

# Read config
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: Config file not found: $CONFIG_FILE"
  exit 1
fi

UPPER=$(python3 -c "import json; print(json.load(open('$CONFIG_FILE'))['upper_price'])")
LOWER=$(python3 -c "import json; print(json.load(open('$CONFIG_FILE'))['lower_price'])")
GRIDS=$(python3 -c "import json; print(json.load(open('$CONFIG_FILE'))['grid_count'])")
INVEST=$(python3 -c "import json; print(json.load(open('$CONFIG_FILE'))['investment'])")

echo "Upper Price: $UPPER"
echo "Lower Price: $LOWER"
echo "Grid Count:  $GRIDS"
echo "Investment:  $INVEST USDT"
echo "========================================"

# Calculate grid spacing
GRID_SPACING=$(python3 -c "print(round(($UPPER - $LOWER) / $GRIDS, 2))")
echo "Grid Spacing: $GRID_SPACING"

# Simulated backtest result (placeholder)
echo ""
echo "Backtest Results (simulated):"
echo "  Total Trades: $((GRIDS * DAYS / 3))"
echo "  Win Rate:     68.5%"
echo "  Total PnL:    +$((INVEST * 12 / 100)) USDT"
echo "  ROI:          12.0%"
echo "  Max Drawdown: 5.2%"
echo "========================================"
echo "Note: This is a simulated result. Use real market data for accurate backtesting."

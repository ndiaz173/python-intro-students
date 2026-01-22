#!/usr/bin/env bash

# Get the directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set -euo pipefail

# Use provided project dir or script dir
PROJECT_DIR="${1:-${SCRIPT_DIR}}"

echo "Setting up Python environment in: ${PROJECT_DIR}"

# Prefer python3 if available
PYTHON_CMD="python3"
if ! command -v ${PYTHON_CMD} >/dev/null 2>&1; then
  PYTHON_CMD="python"
fi

# Create virtual environment
if [ ! -d "${PROJECT_DIR}/.venv" ]; then
  echo "Creating virtual environment in ${PROJECT_DIR}/.venv..."
  ${PYTHON_CMD} -m venv "${PROJECT_DIR}/.venv"
else
  echo "Virtual environment already exists at ${PROJECT_DIR}/.venv"
fi

echo "Activating virtual environment..."
# shellcheck source=/dev/null
source "${PROJECT_DIR}/.venv/bin/activate"

echo "Upgrading pip and installing required packages..."
python -m pip install --upgrade pip
if [ -f "${PROJECT_DIR}/requirements.txt" ]; then
  pip install -r "${PROJECT_DIR}/requirements.txt"
else
  echo "No requirements.txt found in ${PROJECT_DIR}; skipping pip install."
fi

# Register an ipykernel for the venv so Jupyter can use it
echo "Registering ipykernel..."
python -m ipykernel install --user --name=python-intro --display-name "Python (intro)" || true

# Create .vscode settings to point to the venv interpreter
mkdir -p "${PROJECT_DIR}/.vscode"
cat > "${PROJECT_DIR}/.vscode/settings.json" << EOF
{
  "python.defaultInterpreterPath": "${PROJECT_DIR}/.venv/bin/python",
  "python.terminal.activateEnvironment": true
}
EOF

echo "Environment setup complete for ${PROJECT_DIR}!"

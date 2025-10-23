#!/bin/bash

# Common functions for all scripts

# Colors for output
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export BLUE='\033[0;34m'
export CYAN='\033[0;36m'
export MAGENTA='\033[0;35m'
export NC='\033[0m' # No Color

# Function to print colored messages
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_step() {
    echo -e "${CYAN}[*] $1${NC}"
}

print_header() {
    echo -e "\n${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}\n"
}

# Function to convert snake_case to PascalCase
# Examples:
#   vehicle_acceptance -> VehicleAcceptance
#   my_feature_name -> MyFeatureName
#   simple -> Simple
to_pascal_case() {
    local input="$1"
    local result=""

    # Split by underscore and capitalize each word
    IFS='_' read -ra words <<< "$input"
    for word in "${words[@]}"; do
        # Capitalize first letter and append to result
        result="${result}${word^}"
    done

    echo "$result"
}

# Function to validate package name
# Returns 0 if valid, 1 if invalid
validate_package_name() {
    local package_name="$1"

    if [[ ! "$package_name" =~ ^[a-z][a-z0-9_]*$ ]]; then
        return 1
    fi

    return 0
}

# Function to check if package exists
# Returns 0 if exists, 1 if not exists
package_exists() {
    local package_path="$1"

    if [ -d "$package_path" ]; then
        return 0
    fi

    return 1
}

# Function to get project root directory
get_project_root() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    # Go up two levels from scripts/common to project root
    echo "$(cd "$script_dir/../.." && pwd)"
}

# Function to list all packages in a directory
# Usage: list_packages_in_dir "/path/to/packages"
list_packages_in_dir() {
    local base_dir="$1"
    local packages=()

    if [ -d "$base_dir" ]; then
        for dir in "$base_dir"/*; do
            if [ -d "$dir" ]; then
                packages+=("$(basename "$dir")")
            fi
        done
    fi

    printf '%s\n' "${packages[@]}"
}

# Function to get package type from path
# Returns "feature", "shared", or "infrastructure"
get_package_type() {
    local package_path="$1"

    if [[ "$package_path" == *"/features/"* ]]; then
        echo "feature"
    elif [[ "$package_path" == *"/shared/"* ]]; then
        echo "shared"
    elif [[ "$package_path" == *"/infrastructure/"* ]]; then
        echo "infrastructure"
    else
        echo "unknown"
    fi
}

# Function to confirm action
# Returns 0 if confirmed, 1 if cancelled
confirm_action() {
    local message="$1"
    local response

    read -p "$message (y/n): " response

    if [[ "$response" =~ ^[Yy]$ ]]; then
        return 0
    fi

    return 1
}

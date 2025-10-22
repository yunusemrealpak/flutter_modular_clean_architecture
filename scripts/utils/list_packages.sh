#!/bin/bash

# Script to list all packages in the project

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source common functions
source "$SCRIPT_DIR/../common/functions.sh"

# Get project root
PROJECT_ROOT=$(get_project_root)

# Function to list all packages with numbers
list_all_packages() {
    local counter=1
    local packages_info=()

    # List features
    if [ -d "$PROJECT_ROOT/packages/features" ]; then
        for dir in "$PROJECT_ROOT/packages/features"/*; do
            if [ -d "$dir" ]; then
                local pkg_name=$(basename "$dir")
                packages_info+=("$counter|feature|$pkg_name|$dir")
                ((counter++))
            fi
        done
    fi

    # List infrastructure
    if [ -d "$PROJECT_ROOT/packages/infrastructure" ]; then
        for dir in "$PROJECT_ROOT/packages/infrastructure"/*; do
            if [ -d "$dir" ]; then
                local pkg_name=$(basename "$dir")
                packages_info+=("$counter|infrastructure|$pkg_name|$dir")
                ((counter++))
            fi
        done
    fi

    # List shared
    if [ -d "$PROJECT_ROOT/packages/shared" ]; then
        for dir in "$PROJECT_ROOT/packages/shared"/*; do
            if [ -d "$dir" ]; then
                local pkg_name=$(basename "$dir")
                packages_info+=("$counter|shared|$pkg_name|$dir")
                ((counter++))
            fi
        done
    fi

    printf '%s\n' "${packages_info[@]}"
}

# Function to display packages in a formatted way
display_packages() {
    local show_header="${1:-true}"

    if [ "$show_header" = "true" ]; then
        print_header "Available Packages"
    fi

    local packages=($(list_all_packages))

    if [ ${#packages[@]} -eq 0 ]; then
        print_warning "No packages found in the project"
        return 1
    fi

    # Display header
    printf "${CYAN}%-5s %-15s %-30s${NC}\n" "No." "Type" "Package Name"
    echo "──────────────────────────────────────────────────────────"

    # Display packages
    for pkg_info in "${packages[@]}"; do
        IFS='|' read -r num type name path <<< "$pkg_info"

        # Color based on type
        local color="$NC"
        case "$type" in
            "feature")
                color="$GREEN"
                ;;
            "infrastructure")
                color="$BLUE"
                ;;
            "shared")
                color="$YELLOW"
                ;;
        esac

        printf "${color}%-5s %-15s %-30s${NC}\n" "$num" "[$type]" "$name"
    done

    echo ""
    return 0
}

# Function to get package info by number
get_package_by_number() {
    local number="$1"
    local packages=($(list_all_packages))

    for pkg_info in "${packages[@]}"; do
        IFS='|' read -r num type name path <<< "$pkg_info"

        if [ "$num" = "$number" ]; then
            echo "$type|$name|$path"
            return 0
        fi
    done

    return 1
}

# Export functions
export -f list_all_packages
export -f display_packages
export -f get_package_by_number

#!/bin/bash

# Main entry point for Flutter Modular Clean Architecture Scripts
# This script provides a menu to access various code generation tools

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source common functions
source "$SCRIPT_DIR/common/functions.sh"

# Function to display main menu
show_menu() {
    clear
    print_header "Flutter Modular Clean Architecture - Generator Tools"

    echo -e "${CYAN}Lütfen bir işlem seçin:${NC}\n"

    echo -e "${GREEN}1)${NC} Yeni Paket Oluştur (Feature/Shared/Infrastructure)"
    echo -e "${GREEN}2)${NC} Mevcut Pakete BLoC Ekle"
    echo -e "${GREEN}3)${NC} App Shell Oluştur (Bottom Navigation)"
    echo -e "${GREEN}4)${NC} Paketleri Listele"
    echo -e "${GREEN}5)${NC} Yardım"
    echo -e "${RED}0)${NC} Çıkış"

    echo ""
}

# Function to show help
show_help() {
    print_header "Yardım - Generator Tools"

    echo -e "${YELLOW}1. Yeni Paket Oluştur${NC}"
    echo -e "   Clean Architecture prensiplerine göre yeni bir paket oluşturur."
    echo -e "   Desteklenen paket türleri:"
    echo -e "   - ${GREEN}Feature${NC}: BLoC pattern, use case'ler, repository'ler ile tam feature paketi"
    echo -e "   - ${GREEN}Shared${NC}: Paylaşımlı utility paketi"
    echo -e "   - ${GREEN}Infrastructure${NC}: Altyapı servisi paketi (network, storage, vb.)"
    echo ""

    echo -e "${YELLOW}2. Mevcut Pakete BLoC Ekle${NC}"
    echo -e "   Var olan bir pakete yeni bir BLoC ekler."
    echo -e "   - Freezed ile immutable event ve state'ler"
    echo -e "   - Injectable ile DI entegrasyonu"
    echo -e "   - Örnek event handler'lar"
    echo -e "   - Load, Refresh, Delete gibi yaygın işlemler"
    echo ""

    echo -e "${YELLOW}3. App Shell Oluştur (Bottom Navigation)${NC}"
    echo -e "   Bottom navigation ile app shell feature'ı oluşturur."
    echo -e "   - Tab sayısı ve isimleri interaktif olarak belirtilir"
    echo -e "   - AutoTabsRouter ile nested routing"
    echo -e "   - BLoC ile tab state management"
    echo -e "   - EventBus entegrasyonu"
    echo -e "   - Root projeye entegrasyon talimatları"
    echo ""

    echo -e "${YELLOW}4. Paketleri Listele${NC}"
    echo -e "   Projedeki tüm paketleri (feature, infrastructure, shared) listeler."
    echo ""

    echo -e "${YELLOW}Code Generation${NC}"
    echo -e "   Oluşturma işlemlerinden sonra mutlaka code generation çalıştırın:"
    echo -e "   ${BLUE}dart run build_runner build --delete-conflicting-outputs${NC}"
    echo ""

    read -p "Ana menüye dönmek için Enter'a basın..."
}

# Function to run package creation
run_create_package() {
    bash "$SCRIPT_DIR/generators/create_package.sh"

    if [ $? -eq 0 ]; then
        echo ""
        read -p "Ana menüye dönmek için Enter'a basın..."
    fi
}

# Function to run bloc creation
run_create_bloc() {
    bash "$SCRIPT_DIR/generators/create_bloc.sh"

    if [ $? -eq 0 ]; then
        echo ""
        read -p "Ana menüye dönmek için Enter'a basın..."
    fi
}

# Function to run app shell creation
run_create_app_shell() {
    bash "$SCRIPT_DIR/generators/create_app_shell.sh"

    if [ $? -eq 0 ]; then
        echo ""
        read -p "Ana menüye dönmek için Enter'a basın..."
    fi
}

# Function to list packages
run_list_packages() {
    source "$SCRIPT_DIR/utils/list_packages.sh"
    display_packages

    echo -e "${CYAN}Toplam paket sayısı gösterildi.${NC}\n"
    read -p "Ana menüye dönmek için Enter'a basın..."
}

# Main loop
while true; do
    show_menu

    read -p "Seçiminiz (0-5): " choice

    case $choice in
        1)
            run_create_package
            ;;
        2)
            run_create_bloc
            ;;
        3)
            run_create_app_shell
            ;;
        4)
            run_list_packages
            ;;
        5)
            show_help
            ;;
        0)
            echo ""
            print_success "Çıkış yapılıyor... Hoşçakalın! 👋"
            echo ""
            exit 0
            ;;
        *)
            print_error "Geçersiz seçim! Lütfen 0-5 arasında bir sayı girin."
            sleep 2
            ;;
    esac
done

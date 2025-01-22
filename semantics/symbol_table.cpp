#include "symbol_table.h"
#include <iostream>

// SymbolTable class implementation
void SymbolTable::addSymbol(const std::string &name, const std::string &type) {
    if (symbols.find(name) == symbols.end()) {
        symbols[name] = type;
    } else {
        std::cout << "Warning: Symbol '" << name << "' already exists.\n";
    }
}

bool SymbolTable::symbolExists(const std::string &name) {
    return symbols.find(name) != symbols.end();
}

void SymbolTable::printSymbols() {
    std::cout << "Symbols in the table:\n";
    for (const auto &pair : symbols) {
        std::cout << pair.first << ": " << pair.second << "\n";
    }
}

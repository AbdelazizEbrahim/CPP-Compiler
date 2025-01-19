#include "symbol_table.h"
#include <iostream>

// Adds a symbol (variable or function) to the table
void SymbolTable::addSymbol(const std::string &name, const std::string &type) {
    if (symbolExists(name)) {
        std::cout << "Error: Symbol '" << name << "' already exists.\n";
        return;
    }
    symbols[name] = type;
    std::cout << "Added symbol: " << name << " of type " << type << "\n";
}

// Checks if a symbol exists in the table
bool SymbolTable::symbolExists(const std::string &name) {
    return symbols.find(name) != symbols.end();
}

// Retrieves the type of a symbol
std::string SymbolTable::getSymbolType(const std::string &name) {
    if (symbolExists(name)) {
        return symbols[name];
    }
    return "";
}

// Prints all the symbols stored in the symbol table
void SymbolTable::printSymbols() {
    for (const auto &entry : symbols) {
        std::cout << "Symbol: " << entry.first << ", Type: " << entry.second << "\n";
    }
}

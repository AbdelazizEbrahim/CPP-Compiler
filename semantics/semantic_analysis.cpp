#include "semantic_analysis.h"
#include <iostream>
#include "symbol_table.h" // Include the symbol table header

// Initialize the symbol table
SymbolTable symbolTable;

// Check if a variable is declared, if not, it's an error
void SemanticAnalysis::checkVariableDeclaration(const std::string &name, const std::string &type) {
    if (!symbolTable.symbolExists(name)) {
        symbolTable.addSymbol(name, type);
    } else {
        std::cout << "Warning: Variable '" << name << "' already declared.\n";
    }
}

// Check if a variable is being used without being declared
void SemanticAnalysis::checkVariableUsage(const std::string &name) {
    if (!symbolTable.symbolExists(name)) {
        std::cout << "Error: Variable '" << name << "' used before declaration.\n";
    }
}

// Check if a function call is valid (currently simple check for std::cout)
void SemanticAnalysis::checkFunctionCall(const std::string &name) {
    if (name == "std::cout") {
        std::cout << "Function call to " << name << " is valid.\n";
    } else {
        std::cout << "Error: Function '" << name << "' is not defined.\n";
    }
}

// New method to check return types
void SemanticAnalysis::checkReturnType(const std::string &returnType) {
    std::cout << "Checking return type: " << returnType << "\n";
}

// New method to check operation compatibility
void SemanticAnalysis::checkOperationCompatibility(const std::string &var1Type, const std::string &var2Type) {
    if ((var1Type == "int" && var2Type == "char") || (var1Type == "char" && var2Type == "int")) {
        std::cout << "Error: Type mismatch in operation between " << var1Type << " and " << var2Type << ".\n";
    }
}

// Perform semantic analysis (you will call this from the parser or main program)
void SemanticAnalysis::performSemanticAnalysis() {
    std::cout << "Performing semantic analysis...\n";
    checkVariableDeclaration("x", "int"); // Example: declare a variable
    checkVariableUsage("x"); // Check usage of variable 'x'
    checkFunctionCall("std::cout"); // Check for a valid function call

    // Print the symbols in the symbol table
    symbolTable.printSymbols();
}

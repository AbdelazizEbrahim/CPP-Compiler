#include "semantic_analysis.h"
#include <iostream>

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

// Perform semantic analysis (you will call this from the parser or main program)
void SemanticAnalysis::performSemanticAnalysis() {
    // For now, we'll only check for main function and std::cout
    std::cout << "Performing semantic analysis...\n";
    checkVariableDeclaration("x", "int"); // Example: declare a variable
    checkVariableUsage("x"); // Check usage of variable 'x'
    checkFunctionCall("std::cout"); // Check for a valid function call

    // Print the symbols in the symbol table
    symbolTable.printSymbols();
}

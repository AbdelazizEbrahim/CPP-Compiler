#include <iostream>

// Function declarations
void arithmeticOperations(int a, int b, char op);
void evaluateConditions(int x);
void nestedLoopsAndLogic();

int main() {
    std::cout << "Welcome to the C++ Program Demonstrating Everything!" << std::endl;

    // Taking input for arithmetic operations
    int num1, num2;
    char operation;
    std::cout << "Enter two numbers: ";
    std::cin >> num1 >> num2;
    std::cout << "Enter an operation (+, -, *, /, %): ";
    std::cin >> operation;

    // Call arithmeticOperations function
    arithmeticOperations(num1, num2, operation);

    // Taking input to evaluate conditions
    int value;
    std::cout << "Enter a number to evaluate conditions: ";
    std::cin >> value;

    // Call evaluateConditions function
    evaluateConditions(value);

    // Call nestedLoopsAndLogic function
    nestedLoopsAndLogic();

    return 0;
}

// Function to demonstrate arithmetic operations with switch-case
void arithmeticOperations(int a, int b, char op) {
    std::cout << "\nPerforming arithmetic operation..." << std::endl;
    switch (op) {
        case '+':
            std::cout << "Result: " << a + b << std::endl;
            break;
        case '-':
            std::cout << "Result: " << a - b << std::endl;
            break;
        case '*':
            std::cout << "Result: " << a * b << std::endl;
            break;
        case '/':
            if (b != 0)
                std::cout << "Result: " << a / b << std::endl;
            else
                std::cout << "Error: Division by zero is not allowed." << std::endl;
            break;
        case '%':
            if (b != 0)
                std::cout << "Result: " << a % b << std::endl;
            else
                std::cout << "Error: Modulo by zero is not allowed." << std::endl;
            break;
        default:
            std::cout << "Invalid operation entered." << std::endl;
    }
}

// Function to demonstrate conditionals and operator precedence
void evaluateConditions(int x) {
    std::cout << "\nEvaluating conditions..." << std::endl;
    if (x % 2 == 0 && x > 0) {
        std::cout << "The number is positive and even." << std::endl;
    } else if (x % 2 != 0 && x > 0) {
        std::cout << "The number is positive and odd." << std::endl;
    } else if (x < 0) {
        std::cout << "The number is negative." << std::endl;
    } else {
        std::cout << "The number is zero." << std::endl;
    }
}

// Function to demonstrate nested loops and logic
void nestedLoopsAndLogic() {
    std::cout << "\nDemonstrating nested loops and logic..." << std::endl;

    for (int i = 1; i <= 2; i++) {
        std::cout << "Outer for loop: i = " << i << std::endl;
        for (int j = 1; j <= 2; j++) {
            std::cout << "  Inner for loop: j = " << j << std::endl;

            int k = 1;
            while (k <= 2) {
                std::cout << "    While loop: k = " << k << std::endl;

                int l = 1;
                while (l <= 2) {
                    std::cout << "      Nested while loop: l = " << l << std::endl;
                    if (l == k) {
                        std::cout << "        l is equal to k!" << std::endl;
                    } else {
                        std::cout << "        l is not equal to k!" << std::endl;
                    }
                    l++;
                }
                k++;
            }
        }
    }
}

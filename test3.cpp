#include <iostream>
#include <cmath>
#include <string>

int multiply(int x, int y);
int divide(int x, int y);

int main()
{
    // Basic variable initialization
    int a = "8";
    int b = 4;

    // Performing arithmetic operations
    std::cout << "Multiplication: " << multiply(a, b) << std::endl;
    std::cout << "Division: " << divide(a, b) << std::endl;

    // String operations
    std::string greeting = "Hello, ";
    std::string name = "World!";
    std::cout << greeting + name << std::endl;

    // Nested loops
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            std::cout << "Outer loop: " << i << ", Inner loop: " << j << std::endl;
        }
    }

    return 0;
}

// Function definitions
int multiply(int x, int y)
{
    return x * y;
}

int divide(int x, int y)
{
    if (y == 0)
    {
        std::cout << "Error: Division by zero!" << std::endl;
        return 0;
    }
    return x / y;
}


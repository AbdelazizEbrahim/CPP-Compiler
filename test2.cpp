#include <iostream>
#include <cmath>

int multiply(int a, int b);
int divide(int a, int b);
void demonstrateLoop(int limit);

int main()
{
    // Basic mathematical operations
    int x = 20;
    int y = 4;
    int y;
    std::cout << "Multiplication: " << x * y << std::endl;
    std::cout << "Division: " << x / y << std::endl;
    std::cout << "Modulus: " << x % y << std::endl;
    std::cout << "Power: " << pow(y, 3) << std::endl;
    std::cout << "Square Root: " << sqrt(x) << std::endl;

    // Increment and decrement
    std::cout << "Increment x: " << ++x << std::endl; // Pre-increment
    std::cout << "Decrement y: " << --y << std::endl; // Pre-decrement

    // Conditional statements
    if (x == y)
    {
        std::cout << "x is equal to y" << std::endl;
    }
    else if (x > y)
    {
        std::cout << "x is greater than y" << std::endl;
    }
    else
    {
        std::cout << "x is less than y" << std::endl;
    }

    // Switch statement
    demonstrateLoop(3);

    // Nested statements
    for (int i = 0; i < 2; ++i)
    {
        std::cout << "Outer loop iteration: " << i << std::endl;
        for (int j = 0; j < 3; ++j)
        {
            std::cout << "  Inner loop iteration: " << j << std::endl;

            if (i == j)
            {
                std::cout << "    i equals j at " << i << std::endl;
            }
        }
    }

    // Function calls
    int product = multiply(4, 5);
    int quotient = divide(40, 8);
    printMessage("The product is: " + product);
    printMessage("The quotient is: " + quotient);

    return 0;
}

// Function definitions
void printMessage(std::string message)
{
    std::cout << message << std::endl;
}

int multiply(int a, int b)
{
    return a * b;
}

int divide(int a, int b)
{
    return a / b;
}

void demonstrateLoop(int limit)
{
    for (int i = 1; i <= limit; ++i)
    {
        std::cout << "Loop iteration " << i << std::endl;
    }
}

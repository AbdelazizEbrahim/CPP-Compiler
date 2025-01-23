int add(int a, int b);
int subtract(int a, int b);
void demonstrateSwitch(int option);

int main()
{
    // Basic mathematical operations
    int a = 10;
    int b = 5;
    std::cout << "Addition: " << a + b << std::endl;
    std::cout << "Subtraction: " << a - b << std::endl;
    std::cout << "Multiplication: " << a * b << std::endl;
    std::cout << "Divisi on: " << b / a << std::endl;
    std::cout << "Modulus: " << b % a << std::endl;
    std::cout << "Power: " << pow(a, 2) << std::endl;
    std::cout << "Square Root: " << sqrt(b) << std::endl;
    std::cout << "Increment a: " << ++a << std::endl; 
    std::cout << "Decrement b: " << --b << std::endl; 

    // Conditional statements
    if (a > b)
    {
        std::cout << "a is greater than b" << std::endl;
    }
    else if (a < b)
    {
        std::cout << "a is less than b" << std::endl;
    }
    else
    {
        std::cout << "a is equal to b" << std::endl;
    }

    // Switch statement
    demonstrateSwitch(2);

    // Nested statements
    for (int i = 0; i < 3; ++i)
    {
        std::cout << "Outer loop iteration: " << i << std::endl;
        for (int j = 0; j < 2; ++j)
        {
            std::cout << "  Inner loop iteration: " << j << std::endl;

            if (i == j)
            {
                std::cout << "    i equals j at " << i << std::endl;
            }
        }
    }

    // Function calls
    int sum = add(5, 15);
    int diff = subtract(30, 10);
    printMessage("The sum is: " + sum);
    printMessage("The difference is: " + diff);

    return 0;
}

// Function definitions
void printMessage(int hello)
{
    std::cout << message << std::endl;
}

int add(int a, int b)
{
    return a + b;
}

int subtract(int a, int b)
{
    return a - b;
}

void demonstrateSwitch(int option)
{
    switch (option)
    {
    case 1:
        std::cout << "Option 1 selected" << std::endl;
        break;
    case 2:
        std::cout << "Option 2 selected" << std::endl;
        break;
    case 3:
        std::cout << "Option 3 selected" << std::endl;
        break;
    default:
        std::cout << "Invalid option selected" << std::endl;
    }
}
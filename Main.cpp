int main()
{
    String name;
    std::cout << "Enter your name: ";
    std::cin >> name;
    std::cout << "Hello, " << name << "! Let's perform some mathematical operations." << std::endl;
    
    int num1;
    int num2;
    char operation;
    
    std::cout << "Enter the first number: ";
    std::cin >> num1;
    
    std::cout << "Enter the second number: ";
    std::cin >> num2;
    
    std::cout << "Enter the operation (+, -, *, /, %): ";
    std::cin >> operation;
    
    switch (operation)
    {
        case '+':
            std::cout << "Result: " << num1 + num2 << std::endl;
            break;
        case '-':
            std::cout << "Result: " << num1 - num2 << std::endl;
            break;
        case '*':
            std::cout << "Result: " << num1 * num2 << std::endl;
            break;
        case '/':
            if (num2 != 0)
            {
                std::cout << "Result: " << num1 / num2 << std::endl;
            }
            else
            {
                std::cout << "Error: Division by zero is not allowed." << std::endl;
            }
            break;
        case '%':
            if (num2 != 0)
            {
                std::cout << "Result: " << num1 % num2 << std::endl;
            }
            else
            {
                std::cout << "Error: Modulo by zero is not allowed." << std::endl;
            }
            break;
        default:
            std::cout << "Invalid operation entered." << std::endl;
    }

    return 0;
}



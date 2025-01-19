// Function prototypes
int addNumbers(int num1, int num2);
int subtractNumbers(int num1, int num2);
int multiplyNumbers(int num1, int num2);
double divideNumbers(int num1, int num2);
int modulusNumbers(int num1, int num2);
double powerNumbers(int num1, int num2);
double squareRoot(int num1);
void printEvenNumbers(int limit);

// Main function
int main() {
    String name;
    std::cout << "Enter your name: ";
    std::cin >> name;
    std::cout << "Hello, " << name << "! Let's perform some mathematical operations." << std::endl;

    int num1, num2;
    char operation;

    std::cout << "Enter the first number: ";
    std::cin >> num1;

    std::cout << "Enter the second number: ";
    std::cin >> num2;

    std::cout << "Enter the operation (+, -, *, /, %, ^, sqrt): ";
    std::cin >> operation;

    switch (operation) {
        case '+':
            std::cout << "Result: " << addNumbers(num1, num2) << std::endl;
            break;
        case '-':
            std::cout << "Result: " << subtractNumbers(num1, num2) << std::endl;
            break;
        case '*':
            std::cout << "Result: " << multiplyNumbers(num1, num2) << std::endl;
            break;
        case '/':
            if (num2 != 0) {
                std::cout << "Result: " << divideNumbers(num1, num2) << std::endl;
            } else {
                std::cout << "Error: Division by zero is not allowed." << std::endl;
            }
            break;
        case '%':
            if (num2 != 0) {
                std::cout << "Result: " << modulusNumbers(num1, num2) << std::endl;
            } else {
                std::cout << "Error: Modulo by zero is not allowed." << std::endl;
            }
            break;
        case '^':
            std::cout << "Result: " << powerNumbers(num1, num2) << std::endl;
            break;
        case 's':
            std::cout << "Square root of first number: " << squareRoot(num1) << std::endl;
            break;
        default:
            std::cout << "Invalid operation entered." << std::endl;
    }

    // Loop to print even numbers
    std::cout << "Enter a limit to print even numbers: ";
    int limit;
    std::cin >> limit;
    printEvenNumbers(limit);

    return 0;
}

// Function to print even numbers using loops
void printEvenNumbers(int limit) {
    std::cout << "Even numbers up to " << limit << ":" << std::endl;

    // For loop
    for (int i = 0; i <= limit; i = i + 2) {
        std::cout << i << " ";
    }
    std::cout << std::endl;

    // While loop
    int i = 0;
    std::cout << "Even numbers (while loop): ";
    while (i <= limit) {
        std::cout << i << " ";
        i += 2;
    }
    std::cout << std::endl;

    // Do-while loop
    i = 0;
    std::cout << "Even numbers (do-while loop): ";
    do {
        std::cout << i << " ";
        i += 2;
    } while (i <= limit);
    std::cout << std::endl;
}

// Function implementations
int addNumbers(int num1, int num2) {
    return num1 + num2;
}

int subtractNumbers(int num1, int num2) {
    return num1 - num2;
}

int multiplyNumbers(int num1, int num2) {
    return num1 * num2;
}

double divideNumbers(int num1, int num2) {
    return (num1) / num2;
}

int modulusNumbers(int num1, int num2) {
    return num1 % num2;
}

double powerNumbers(int num1, int num2) {
    double result = 1;
    for (int i = 0; i < num2; i = i+1) {
        result = result * num1;
    }
    return result;
}

double squareRoot(int num1) {
    double result = num1 / 2.0;
    double temp = 0;
    while (result != temp) {
        temp = result;
        result = (num1 / temp + temp) / 2;
    }
    return result;
}

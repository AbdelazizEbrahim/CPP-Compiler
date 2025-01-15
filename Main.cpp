#include <iostream>

class Main {
public:
    // Uncomment if needed: static const std::string name = "Nahom";

    static int add(int a, int b) {
        return a + b;
    }

    static void main() {
        std::cout << "Hello, World!" << std::endl;
        std::cout << add(1, 2) << std::endl;
    }
};

int main() {
    Main::main();
    return 0;
}

#include <iostream>

class Main {
public:
    // some comments goes here

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

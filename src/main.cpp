#include <iostream>
#include "Math.hpp"

#include <glm/glm.hpp>

using namespace std;

int main(int argc, char const *argv[])
{
    std::cout << "Hello, World" << std::endl;
    std::cout << 1 << " + " << 2 << " = " << add(1, 2) << std::endl;
    glm::vec3 a(1, 0, 0);
    std::cout << a.x << ", " << a.y << ", " << a.z << std::endl;
    return 0;
}

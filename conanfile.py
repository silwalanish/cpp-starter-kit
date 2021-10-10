from conans import ConanFile


class CppStarterKitConan(ConanFile):
    requires = [
        "glm/0.9.9.8",
        "gtest/1.11.0"
    ]
    generators = "make"

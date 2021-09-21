from conans import ConanFile


class CppStarterKitConan(ConanFile):
    requires = ["glm/0.9.9.8"]
    generators = "make"

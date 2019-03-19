from LibWithInit.ClassOne import ClassOne
from LibWithInit.ClassTwo import ClassTwo


class LibWithInit(ClassOne, ClassTwo):
    """This is a docstring that should be imported as overview"""

    ROBOT_LIBRARY_SCOPE = 'GLOBAL'


class SingleClassLib(object):
    """
    Overview that should be imported for SingleClassLib.
    """
    def __init__(self):
        self.b = None

    def single_class_lib_method_1(self):
        """Docstring for single_class_lib_method_1"""
        pass

    def single_class_lib_method_2(self):
        """Docstring for single_class_lib_method_2"""
        pass


class SingleClassLibThatShouldNotBeImported(object):
    """
        Overview that should not be imported for SingleClassLibThatShouldNotBeImported.
    """

    def __init__(self):
        self.b = None

    def single_class_lib_that_should_not_be_imported_method_1(self):
        """Docstring for single_class_lib_that_should_not_be_imported_method_1"""
        pass

    def single_class_lib_that_should_not_be_imported_method_2(self):
        """Docstring for single_class_lib_that_should_not_be_imported_method_2"""
        pass
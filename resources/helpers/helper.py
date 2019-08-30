from SeleniumLibrary.keywords import element

def get_webelements_intro_webelement(element, locator):
    """Returns the first WebElement matching the given ``locator``.
    See the `Locating elements` section for details about the locator
    syntax.
    """
    return element.find_elements_by_xpath(locator)

    
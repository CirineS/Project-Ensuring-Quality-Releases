#!/usr/bin/env python

from login import login
from login import print_with_timestamp
from login import By
from selenium.common.exceptions import NoSuchElementException


def add_items(driver):
    print_with_timestamp("Start test adding items to cart...")

    # Get all the items in the inventory list
    items = driver.find_elements(By.CSS_SELECTOR, '.inventory_item')

    # List to store added items
    added_items = []

    # Iterate through the items (maximum 6 or the actual number of items if less than 6)
    for item in items[:min(6, len(items))]:
        # Get the name of the item and add to cart
        item_name = item.find_element(
            By.CLASS_NAME, 'inventory_item_name').text
        button = item.find_element(By.CSS_SELECTOR, '.pricebar > button')
        button.click()
        added_items.append(item_name)

    # Print the list of added items
    print_with_timestamp("Items '{}' added.".format("', '".join(added_items)))

    # Show the number of items in the cart
    # Find the shopping cart badge element
    cart_badge = driver.find_element(By.CLASS_NAME, "shopping_cart_badge")

    # Get the text from the badge
    cart_items_count = cart_badge.text

    # Perform the assertion
    expected_count = len(added_items)
    actual_count = int(cart_items_count)
    assert expected_count == actual_count, f"Items count mismatch. Expected: {expected_count}, Actual: {actual_count}"
    print_with_timestamp(
        "6 Items successfully added to cart! Proceeding with removing those items from the cart.")


def remove_items(driver):
    print_with_timestamp("Start test removing items from the cart...")

    # Click on the shopping cart link
    cart_link = driver.find_element(By.CLASS_NAME, "shopping_cart_link")
    cart_link.click()

    # Find all items in the cart and remove them
    items = driver.find_elements(By.CLASS_NAME, 'cart_item')

    # List to store added items
    removed_items = []

    for item in items:
        # Get the name of the item and click the 'Remove' button
        item_name = item.find_element(
            By.CLASS_NAME, 'inventory_item_name').text
        button = item.find_element(By.CSS_SELECTOR, '.item_pricebar > button')
        button.click()
        removed_items.append(item_name)

    # Print the list of removed items
    print_with_timestamp("Items '{}' removed.".format(
        "', '".join(removed_items)))

    try:
        # Check if the shopping cart badge still exists
        cart_badge = driver.find_element(By.CLASS_NAME, "shopping_cart_badge")
    except NoSuchElementException:
        # If NoSuchElementException is raised, the element is not found (cart is empty)
        cart_badge = None

    # Assert that the cart badge element is None (i.e., it should not exist)
    assert cart_badge is None, "Still existing items in the cart."
    print_with_timestamp("All items removed from cart successfully!")


if __name__ == "__main__":
    driver = login('standard_user', 'secret_sauce')
    add_items(driver)
    remove_items(driver)
    print_with_timestamp("UI Tests completed successfully!")

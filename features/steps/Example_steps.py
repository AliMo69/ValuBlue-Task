import time

from behave import *
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


@when('I start the browser')
def step_start_browser(context):
    context.driver = webdriver.Chrome()
    context.driver.maximize_window()


@when("I Navigate to '{url}'")
def step_navigate_to(context,url):
    context.driver.get(url)


@when("I click on the '{link_text}' link")
def step_click_more_information(context, link_text):
    link = WebDriverWait(context.driver, 10).until(
        EC.element_to_be_clickable((By.LINK_TEXT, link_text))
    )
    link.click()


@then("a link with text '{RFC_text}' must be present")
def step_check_rfc_link(context, RFC_text):
    links = context.driver.find_elements(By.LINK_TEXT, RFC_text)
    assert len(links) > 0, f"Link with text '{RFC_text}' not found"


@then("the 'Domain Names' box must contain 'Root Zone Management' at index '2'")
def step_check_domain_names_box(context):
    link = WebDriverWait(context.driver, 10).until(
        EC.element_to_be_clickable((By.LINK_TEXT, "IANA-managed Reserved Domains"))
    )
    link.click()

    # Wait for the list to be present
    list_element = WebDriverWait(context.driver, 10).until(
        EC.presence_of_element_located((By.XPATH, "//*[@id='sidenav']/div/ul"))
    )

    # Get all list items
    list_items = list_element.find_elements(By.TAG_NAME, "li")

    # Check if there are at least two items in the list
    if len(list_items) >= 2:
        # Check the text of the second item (index 1)
        second_item_text = list_items[1].text.strip()
        if "Root Zone Management" in second_item_text:
            print("Text 'Root Zone Management' found in the second item of the list.")
        else:
            raise AssertionError(f"Expected 'Root Zone Management' in the second item, but found: {second_item_text}")
    else:
        raise AssertionError(f"List does not have at least two items. Found {len(list_items)} items.")

@then('I close the browser')
def step_close_browser(context):
    context.driver.quit()

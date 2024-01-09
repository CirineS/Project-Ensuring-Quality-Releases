from datetime import datetime
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options as ChromeOptions


def print_with_timestamp(message):
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{timestamp}] {message}")


def login(user, password):
    print_with_timestamp('Starting the browser...')
    # --uncomment when running in Azure DevOps.
    options = ChromeOptions()
    options.add_argument("--headless")
    driver = webdriver.Chrome(options=options)
    print_with_timestamp(
        'Browser started successfully. Navigating to the demo page to login.')
    driver.get('https://www.saucedemo.com/')

    print_with_timestamp('Logging in...')
    driver.find_element(
        By.CSS_SELECTOR, "input[id='user-name']").send_keys(user)
    driver.find_element(
        By.CSS_SELECTOR, "input[id='password']").send_keys(password)
    driver.find_element(By.ID, "login-button").click()
    print_with_timestamp('Login successful! Proceeding with tests.')
    return driver

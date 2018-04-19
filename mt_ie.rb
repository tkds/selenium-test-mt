require "selenium-webdriver"
require 'yaml'

config = YAML.load_file("config.yaml")

driver = Selenium::WebDriver.for :ie

driver.navigate.to config["setting"]["mt_url"]

driver.find_element(:xpath, '//*[@id="ja"]/p[1]/a').click

id = driver.find_element(:name, 'username')
pass = driver.find_element(:name, 'password')

id.send_keys config["setting"]["mt_login"]
pass.send_keys config["setting"]["mt_pass"]

driver.find_element(:id, 'sign-in-button').submit
driver.save_screenshot config["setting"]["capture"]

driver.find_element(:xpath, '//*[@id="website-1-control"]/li[2]/a').click

wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until { driver.find_element(:id => "menu-entry") }

driver.find_element(:xpath, '//*[@id="menu-entry"]/ul/li[2]/a').click

driver.find_element(:name, 'title').send_key "Selenium Test Entry!!"

sleep 1

a = "Selenium を使った自動投稿で記事公開"

driver.execute_script("tinyMCE.getInstanceById('editor-input-content').setContent('#{a}');")

driver.find_element(:id, 'editor-input-content_mt_insert_file_1').click

img_frame = driver.find_element(:id => 'mt-dialog-iframe')
driver.switch_to.frame(img_frame)

driver.find_element(:xpath, '//*[@id="list-assets-dialog"]/div[1]/a').click
upload_img = driver.find_element(:name, 'file')
upload_img.send_keys ("/Users/mbp/Desktop/selenium/selenium.png")
driver.find_element(:xpath, '//*[@id="upload-form"]/div[4]/button[1]').click
driver.find_element(:xpath, '//*[@id="content-body"]/form/div[3]/button[1]').click

#driver.find_element(:xpath, '//*[@id="entry-publishing-widget"]/div[2]/div[6]/div[1]/button').click

puts driver.title
puts driver.current_url

#driver.quit
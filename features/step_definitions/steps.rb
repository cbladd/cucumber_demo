#encoding: utf-8
require 'selenium-webdriver'

class Driver
  def initialize(username, password)
    @username = username
    @password = password
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end # initialize

  def setup(d)
    @driverType = d
    @driver = Selenium::WebDriver.for(
      :remote,
      url: 'http://hub:4444/wd/hub',
      desired_capabilities: :"#{@driverType}") # you can also use :chrome, :safari, etc.
  end # setup


  def teardown
    @driver.quit
  end
  def open_gmail_inbox
    @driver.get "https://accounts.google.com/ServiceLogin?service=mail&continue=https://mail.google.com/mail/#identifier"
    @element = @driver.find_element(:css, "input#Email")
    @element.send_keys(@username)
    @element = @driver.find_element(:css, "input#next.rc-button.rc-button-submit")
    @element.click()
    @wait.until {@driver.find_element(:id, "signIn")}
    @element = @driver.find_element(:css, "input#Passwd")
    @element.send_keys(@password)
    @element = @driver.find_element(:css, "input#signIn.rc-button.rc-button-submit")
    @element.click()
    @wait.until {@driver.find_element(:css, ".n1 > a:nth-child(1)")}
    puts "TITLE: "
    puts @driver.title
  end

  def read_first_email
    @element = @wait.until {@driver.find_element(:css, "div.xT>div.y6:first-child")}
    @element.click()
    @element = @wait.until {@driver.find_element(:css, "div.asa > div.ar6")}
    @src = @driver.page_source
    if (@src =~ /(.*)hello world(.*)/)
      puts "found hello world"
      return true
    else
      return false
    end
    # @text_found
  end

  def run
    setup
    open_gmail_inbox
    read_first_email
    # yield
    teardown
  end  # run

end  #Driver

myDriver = Driver.new("yesmailapptest@gmail.com", "Thisistheyesmailappaccount.")

Given(/^we have setup the webdriver$/) do
  puts ENV['DRIVER']
  myDriver.setup(ENV['DRIVER'])
end

Given(/^we have logged into gmail$/) do
  myDriver.open_gmail_inbox
end

Given(/^we can read the first email$/) do
  myDriver.read_first_email
end

Then(/^teardown the driver$/) do
  myDriver.teardown
end

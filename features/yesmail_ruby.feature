#encoding: utf-8
Feature: make sure we can log into gmail and read an email in the inbox
  In order to make sure that the webdriver is functional we must log into gmail and read the first email on the page.

  Scenario: read a gmail message in firefox
    Given we have setup the webdriver
    Given we have logged into gmail
    And we can read the first email
    Then teardown the driver

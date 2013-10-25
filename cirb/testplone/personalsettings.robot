*** Settings ***
Resource  plone/app/robotframework/selenium.robot
Resource  plone/app/robotframework/keywords.robot

Library  Remote  ${PLONE_URL}/RobotRemote

Suite Setup  Suite Setup
Suite Teardown  Close all browsers


*** Test Cases ***
Site Administrator can access control panel
    Go to homepage
    Open User Menu
    Element should be visible  css=#personaltools-plone_setup


*** Keywords ***
Suite Setup
    Open test browser
    Enable autologin as  'Site Administrator'

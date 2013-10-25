*** Settings ***
Resource  plone/app/robotframework/keywords.robot
Resource  plone/app/robotframework/selenium.robot

Library  Remote  ${PLONE_URL}/RobotRemote
Library  plone.app.robotframework.keywords.Debugging

Suite Setup  Suite Setup
Suite Teardown  Close all browsers


*** Test cases ***
Verify created and hosted by CIRB CIBG
    Go to homepage
    Page should contain "Created and hosted by CIRB-CIBG"

*** Keywords ***
Suite Setup
    Open test browser
    Enable autologin as  Manager

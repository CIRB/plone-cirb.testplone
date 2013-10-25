*** Settings ***
Resource  plone/app/robotframework/keywords.robot
Resource  plone/app/robotframework/selenium.robot

Library  Remote  ${PLONE_URL}/RobotRemote
Library  plone.app.robotframework.keywords.Debugging

Suite Setup  Suite Setup
Suite Teardown  Close all browsers


*** Test cases ***
Add some keywords
    ${location} =  Add document  Keywords test
    ${tag} =  set variable  my_incredible_tag
    Go to  ${location}/edit 
    Click link  css=a#fieldsetlegend-categorization
    Input text  css=textarea#subject_keywords  ${tag}
    Click button  name=form.button.save
    Page should contain element  css=a[href*='list=${tag}']
    /*Element should be visible  css=a[href*='list=${tag}']*/

    Go to  ${location}/edit 
    Click link  css=a#fieldsetlegend-categorization
    Click element  css=input[type='checkbox'][value='${tag}']
    Click button  name=form.button.save
    Page should not contain element  css=a[href*='list=${tag}']
 

*** Keywords ***
Suite Setup
    Open test browser
    Enable autologin as  Manager


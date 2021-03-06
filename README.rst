.. contents::


Introduction
============

This documentation is used to test some plone theme. It explain how to use this module to laucnh RobotFramework test into a Plone theme.

Information came from http://developer.plone.org/reference_manuals/external/plone.app.robotframework/happy.html

Example
=======

In this example, the Plone theme egg is called: **plonetheme.bric**

First you have to add some information into the **setup.py** file of your Plone theme (include plone.app.robotframework and cirb.testplone)::

    install_requires=[
        ...
        'cirb.testplone',
    ]

    extras_require={
      'test': [
          ...
          'plone.app.robotframework',
        ],
    },
    

You also have to add tests in your **buildout.cfg**::
    
    [buildout]
    parts +=
        test
        robot

    [test]
    recipe = zc.recipe.testrunner
    defaults = ['-s', 'plonetheme.bric', '--auto-color', '--auto-progress']
    eggs =
        Plone
        plone.app.upgrade
        plonetheme.bric [test]
      
    
    [robot]
    recipe = zc.recipe.egg
    eggs =
        Pillow
        ${test:eggs}
        plone.app.robotframework[reload]
        
        
And finaly add tests into Plone eggs

- First create a file **plonetheme/bric/testing.py**::

    from plone.testing import z2
    from plone.app.testing import PloneWithPackageLayer
    from plone.app.testing import FunctionalTesting
    
    from plone.app.robotframework.testing import AUTOLOGIN_LIBRARY_FIXTURE
    
    import plonetheme.bric
    
    PLONETHEME_BRIC = PloneWithPackageLayer(
            zcml_package=plonetheme.bric,
            zcml_filename='configure.zcml',
            gs_profile_id='plonetheme.bric:default',
            name='PLONETHEME_BRIC'
            )
    
    PLONETHEME_BRIC_ROBOT_TESTING = FunctionalTesting(
            bases=(PLONETHEME_BRIC, AUTOLOGIN_LIBRARY_FIXTURE, z2.ZSERVER_FIXTURE),
            name="PLONETHEME_BRIC_ROBOT_TESTING")
            
- Create too  **plonetheme/bric/test/** folder with 2 files in. An empty file **plonetheme/bric/test/__init__.py** and a test file **plonetheme/bric/test/test_robot.py**::

    from plone.testing import layered
    import unittest
    
    import robotsuite
    
    from plonetheme.bric.testing import PLONETHEME_BRIC_ROBOT_TESTING
    import cirb.testplone
    
    
    def test_suite():
        suite = unittest.TestSuite()
        robots_file = [
                    'keywords.robot',
                ]
        for robot_file in robots_file:
            rts = robotsuite.RobotTestSuite(robot_file, package=cirb.testplone)
            suite.addTests([
                layered(rts, layer=PLONETHEME_BRIC_ROBOT_TESTING)
            ])
        return suite
        
        
Launch tests
============

You can now restart buildout and launch [robot] test::
    
    ./bin/buildout -N
    ./bin/test
    

Adding local tests
==================

You can also adding specifics tests for your Plone theme. You just have to create a my_local_test.robot file (in tests folder) and call it in **test_robot.py** as here ::
    
    def test_suite():
        ...
        rts = robotsuite.RobotTestSuite('my_local_test.robot')
        suite.addTests([layered(rts, layer=PLONETHEME_BRIC_ROBOT_TESTING)])
        return suite

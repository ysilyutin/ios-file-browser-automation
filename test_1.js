#import "assertions.js"
#import "lang-ext.js"
#import "uiautomation-ext.js"
#import "screen.js"
#import "test.js"
#import "image_assertion.js"

    test("<<< Test - Registration with valid credentials >>>", function(target,app) {
     
     var window = app.mainWindow();
	 var target = UIATarget.localTarget();
	 var app = target.frontMostApp();
	
     app.logElementTree();
     
         target.frontMostApp().mainWindow().scrollViews()[0].textFields()["Server"].tap();
         target.frontMostApp().mainWindow().scrollViews()[0].textFields()["Server"].tap();
         target.frontMostApp().mainWindow().scrollViews()[0].textFields()["Server"].tap();
		 
		 UIALogger.logMessage("<<< Input Name of Server >>>");
		
         target.frontMostApp().keyboard().typeString("lp-web5.moka5qa.com");
         target.frontMostApp().mainWindow().scrollViews()[0].buttons()["Connect"].tap();

		 target.delay(4);
		
		 UIALogger.logMessage("<<< Input valid Username and valid Password >>>");

         target.frontMostApp().mainWindow().scrollViews()[0].textFields()["Username"].tap();
         target.frontMostApp().keyboard().typeString("iosuser1");
         target.frontMostApp().mainWindow().scrollViews()[0].secureTextFields()["Password"].tap();
         target.frontMostApp().keyboard().typeString("password");
         target.frontMostApp().mainWindow().scrollViews()[0].buttons()["OK"].tap();

 		 UIALogger.logMessage("<<< Wait 15 seconds... >>>");


         target.delay(15);
     
});

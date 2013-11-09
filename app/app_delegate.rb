class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    controller = MenuViewController.alloc.init
    navController = UINavigationController.alloc.initWithRootViewController(controller)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navController
    @window.makeKeyAndVisible
    true
  end
end

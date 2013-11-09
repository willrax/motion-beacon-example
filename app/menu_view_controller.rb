class MenuViewController < UIViewController
  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.whiteColor
    createMenu
  end

  def createMenu
    beacon = UIButton.buttonWithType(UIButtonTypeSystem)
    beacon.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    beacon.setTitle "Transmit", forState: UIControlStateNormal
    beacon.addTarget(self, action: :startBeacon, forControlEvents: UIControlEventTouchUpInside)

    finder = UIButton.buttonWithType(UIButtonTypeSystem)
    finder.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    finder.setTitle "Search", forState: UIControlStateNormal
    finder.addTarget(self, action: :startSearch, forControlEvents: UIControlEventTouchUpInside)

    Motion::Layout.new do |layout|
      layout.view self.view
      layout.metrics "space" => 100
      layout.subviews "beacon" => beacon, "finder" => finder
      layout.vertical "|-space-[beacon]-space-[finder]"
      layout.horizontal "|-[beacon]-|"
      layout.horizontal "|-[finder]-|"
    end
  end

  def startSearch
    controller = FinderViewController.alloc.init
    presentModal(controller)
  end

  def startBeacon
    controller = BeaconViewController.alloc.init
    presentModal(controller)
  end

  def presentModal(controller)
    navigator = UINavigationController.alloc.initWithRootViewController(controller)
    self.presentViewController(navigator, animated: true, completion: nil)
  end
end

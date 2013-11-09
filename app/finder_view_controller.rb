class FinderViewController < UIViewController
  UUID = NSUUID.alloc.initWithUUIDString("7cbff8c6-4d84-4e8c-8703-377e03d4f69f")

  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.whiteColor
    self.title = "Searching..."
    createLabel
    @beaconRegion = CLBeaconRegion.alloc.initWithProximityUUID(UUID, major: 1, minor: 1, identifier: "com.willrax.region")
    locationManager.startMonitoringForRegion(@beaconRegion)
  end

  def createLabel
    @beaconLabel = UILabel.alloc.init
    @beaconLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    @beaconLabel.textAlignment = NSTextAlignmentCenter
    @beaconLabel.text = "No Beacon"

    Motion::Layout.new do |layout|
      layout.view self.view
      layout.metrics "space" => 250
      layout.subviews "beacon" => @beaconLabel
      layout.vertical "|-space-[beacon]"
      layout.horizontal "|-[beacon]-|"
    end
  end

  def locationManager(manager, didEnterRegion: region)
    locationManager.startRangingBeaconsInRegion @beaconRegion
  end

  def locationManager(manager, didRangeBeacons: beacons, inRegion: region)
    beacon = beacons.last

    if beacon.proximity == CLProximityImmediate
      @beaconLabel.text = "Beacon Found"
    else
      @beaconLabel.text = "No Beacon"
    end
  end

  def locationManager
    @locationManager ||=
      begin
        manager = CLLocationManager.alloc.init
        manager.delegate = self
        manager
      end
  end
end

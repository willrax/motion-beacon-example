class FinderViewController < UIViewController
  UUID = NSUUID.alloc.initWithUUIDString("2E64F516-D4E9-429C-9C62-A129A5FB1D02")

  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.whiteColor
    self.title = "Searching..."
    createLabel
    @beaconRegion = CLBeaconRegion.alloc.initWithProximityUUID(UUID, major: 0, minor: 0, identifier: "com.willrax.region")
    @beaconRegion.notifyOnEntry = true
    @beaconRegion.notifyOnExit = true
    @beaconRegion.notifyEntryStateOnDisplay = true

    locationManager.startMonitoringForRegion(@beaconRegion)
    locationManager.requestStateForRegion(@beaconRegion)
  end

  def locationManager(manager, didDetermineState: state, forRegion: region)
    if state == CLRegionStateInside
      locationManager.startRangingBeaconsInRegion(region)
    end
  end

  def locationManager(manager, didEnterRegion: region)
    if region.isKindOfClass(CLBeaconRegion)
      locationManager.startRangingBeaconsInRegion(region)
    end
  end

  def locationManager(manager, didExitRegion: region)
    if region.isKindOfClass(CLBeaconRegion)
      locationManager.stopRangingBeaconsInRegion(region)
    end
  end

  def locationManager(manager, didRangeBeacons: beacons, inRegion: region)
    beacon = beacons.last

    if beacon
      @beaconLabel.text = case beacon.proximity
                          when CLProximityUnknown then "Unknown"
                          when CLProximityFar then "Far"
                          when CLProximityNear then "Near"
                          when CLProximityImmediate then "Immediate"
                          else
                            "Nothing"
                          end
    end
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

  def locationManager
    @locationManager ||=
      begin
        manager = CLLocationManager.alloc.init
        manager.delegate = self
        manager
      end
  end
end

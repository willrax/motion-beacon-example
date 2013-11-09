class BeaconViewController < UIViewController
  UUID = NSUUID.alloc.initWithUUIDString("7cbff8c6-4d84-4e8c-8703-377e03d4f69f")

  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.whiteColor
    self.title = "Transmitting.."
    @beaconRegion = CLBeaconRegion.alloc.initWithProximityUUID(UUID, major: 1, minor: 1, identifier: "com.willrax.region")
    @peripheralManager = CBPeripheralManager.alloc.initWithDelegate(self, queue: Dispatch::Queue.main.dispatch_object)
  end

  def peripheralManagerDidUpdateState(peripheral)
    if peripheral.state == CBPeripheralManagerStatePoweredOn
      @peripheralManager.startAdvertising @beaconRegion.peripheralDataWithMeasuredPower(nil)
    end
  end
end

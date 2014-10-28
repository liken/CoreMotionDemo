CoreMotionDemo
==============

Use MotionManager to motitor device orientation.

To use the demo, you just need to implement the delegate,and use the
delegate function to monitor device orientation.Don’t need to worry
about the device lock.

You can just use it as below:

Define the monitor:

var motionMonitor:MotionSynchronizer

In viewdidload func:

motionMonitor = MotionSynchronizer()
motionMonitor.delegate = self

To start monitor:

motionMonitor.startMonitorMotion()

To end monitor:

motionMonitor.stopMonitorMotion()

CoreMotionDemo
==============

Use MotionManager to motitor device orientation.

To use the demo, you just need to implement the delegate,and use the
delegate function to monitor device orientation.Don’t need to worry
about the device lock.

You can just use it as below:
//define the monitor
var motionMonitor:MotionSynchronizer

//in viewdidload
motionMonitor = MotionSynchronizer()
motionMonitor.delegate = self

// start monitor
motionMonitor.startMonitorMotion()

// End monitor
motionMonitor.stopMonitorMotion()

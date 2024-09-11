import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    override func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Safely unwrap mainFlutterWindow
        guard let window = mainFlutterWindow else {
        print("mainFlutterWindow is nil")
        return
        }

        // Get the screen where the cursor is located
        if let screen = getCurrentScreen() {
            let screenFrame = screen.visibleFrame // Visible frame excludes the menu bar and dock

            // Set the window's style mask to remove the title bar and action buttons
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true
            window.styleMask.insert(.fullSizeContentView)
            window.backgroundColor = NSColor.clear

            // Also hide the buttons
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true


            // Make the window appear on all workspaces
            window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]

            // Calculate the position aligned to the left and centered vertically
            let windowWidth: CGFloat = 500 // Replace with your desired window width
            let windowHeight: CGFloat = 900 // Replace with your desired window height
            let initialPosition = CGPoint(x: screenFrame.minX - window.frame.width - 50, 
                                            y: window.frame.origin.y)

            // Set window size and position, then display it
            window.setContentSize(NSSize(width: windowWidth, height: windowHeight))
            window.setFrameOrigin(initialPosition)
            window.makeKeyAndOrderFront(nil)

            self.hideWindowInCurrentWorkspace(window: window);
        }
        let controller: FlutterViewController = window.contentViewController as! FlutterViewController
        
        let methodChannel = FlutterMethodChannel(name: "com.vera.app", binaryMessenger: controller.engine.binaryMessenger)
        
        methodChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "showWindowInCurrentWorkspace" {
                self.showWindowInCurrentWorkspace(window: window)
                result(nil)
            } else if call.method == "hideWindowInCurrentWorkspace" {
                self.hideWindowInCurrentWorkspace(window: window)
                result(nil)
            } else if call.method == "resetWindowWidth" {
                self.setWindowWidth(window: window)
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        })
    }

    @objc func setWindowWidth(window: NSWindow) {
        let windowWidth: CGFloat = 500 // Replace with your desired window width
        let windowHeight: CGFloat = 900 // Replace with your desired window height
        window.setContentSize(NSSize(width: windowWidth, height: windowHeight))
    }

    @objc func showWindowInCurrentWorkspace(window: NSWindow) {
        if let screen = getCurrentScreen() {
            let windowHeight: CGFloat = 900
            let screenFrame = screen.frame
            
            // Calculate the starting position off-screen to the left
            let offScreenPosition = CGPoint(x: screenFrame.minX - window.frame.width, 
                                            y: screenFrame.minY) // Keep the current vertical position
            
            // Set the window's initial off-screen position
            window.setFrameOrigin(offScreenPosition)
            
            // Show the window (hidden by default)
            window.makeKeyAndOrderFront(nil)
            
            // Animate the window sliding into place
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.2 // Set the duration of the animation
                context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut) // Optional: adjust the timing function

                // Set the new position to the left side of the screen
                let newPosition = CGPoint(x: screenFrame.minX+50, y: screenFrame.minY + (screenFrame.height - windowHeight) / 2)
                window.animator().setFrameOrigin(newPosition)
            }
        }
    }

    func hideWindowInCurrentWorkspace(window: NSWindow) {
        if let screen = getCurrentScreen() {
            let screenFrame = screen.frame
            
            // Calculate the off-screen position (to the left of the visible screen)
            let offScreenPosition = CGPoint(x: screenFrame.minX - window.frame.width, 
                                            y: window.frame.origin.y) // Keep the current vertical position

            // Animate the window sliding out of view to the left
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.2 // Set the duration of the animation
                context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut) // Optional: adjust the timing function

                window.animator().setFrameOrigin(offScreenPosition)
            } completionHandler: {
                // After the animation is complete, hide the window
                window.orderOut(nil)
            }
        }
    }

    func getCurrentScreen() -> NSScreen? {
        let mouseLocation = NSEvent.mouseLocation
        return NSScreen.screens.first { screen in
            return screen.frame.contains(mouseLocation)
        }
    }
}

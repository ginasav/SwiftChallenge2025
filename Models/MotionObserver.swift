import SwiftUI
import CoreMotion

class MotionObserver: ObservableObject {
    
    //: MOTION MANAGER
    @Published var motionManager = CMMotionManager()
    
    //Storing Motion Data to animate the foreground
    @Published var xValue: CGFloat = 0
    @Published var yValue: CGFloat = 0
    
    //Moving Offset
    @Published var movingOffset: CGSize = .zero
    
    func fetchMotionData(duration: CGFloat) {
        
        //Calling Motion updates handler
        motionManager.startDeviceMotionUpdates(to: .main) {
            data, err in
            
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("ERROR IN DATA")
                return
            }
            
            withAnimation(){
                self.xValue = data.attitude.roll
                self.yValue = data.attitude.pitch
                self.movingOffset = self.getOffset(duration: duration)
            }
        }
    }
    
    func getOffset(duration: CGFloat) -> CGSize {
        let width = xValue * duration
        let height = yValue * duration
        
        return CGSize(width: width, height: height)
    }
}

import SwiftUI

struct AView: View {
    @StateObject var motionData = MotionObserver()
    
    var body: some View {
        
        ZStack {
            
            GeometryReader{proxy in
                
                let size = proxy.size
                
                Image("A_bg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.width, height: size.height)
                
            }//: BACKGROUND
            .ignoresSafeArea()
            
            GeometryReader{proxy in
            
                HStack {
                    Image("A_fg")
                        .resizable()
                        .scaledToFill()
                }
            }//: FOREGROUND
            
            //: MOTION UPDATER
            .onAppear(perform: {
                motionData.fetchMotionData(duration: 55)
            })
            
            //APPLY OFFSET
            .offset(motionData.movingOffset)
            
        }
        
    }
}

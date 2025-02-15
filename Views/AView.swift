import SwiftUI

struct AView: View {
    @StateObject var motionData = MotionObserver()
    
    init() {
        registerCustomFont(named: "Bolota Bold")
    }
    
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
            
            //TEXT ZONE
            VStack {
                HStack{
                    Text("A is for Amazement,\ntry to wiggle and play\nto see flowers dance freely\nwhile kites float away!").font(Font.custom("Bolota Bold", size: 42))
                        .foregroundColor(.red.opacity(0.9))
                        .padding()
                    Spacer()
                }
                .padding()
                Spacer()
            }
            

        }
        
    }
}

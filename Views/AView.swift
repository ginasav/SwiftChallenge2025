import SwiftUI
import Subsonic

struct AView: View {
    @StateObject var motionData = MotionObserver() //for gyroscope use
    @State private var isPlaying = false //to control the playing of the story
    @State var isVisibleiPad = true //to control the iPad be visible
    @State var isiPadWiggling = false //to control the iPad wiggling
    
    init() {
        registerCustomFont(named: "Bolota Bold")
    }
    
    var body: some View {
        
        NavigationStack{
            
            ZStack {
                
                GeometryReader{proxy in
                    
                    let size = proxy.size
                    
                    Image("A_bg")
                        .resizable()
                        .scaledToFill()
                        .frame(width: size.width, height: size.height)
                    
                    
                }//: IMAGE BACKGROUND
                
                GeometryReader{proxy in
                    
                    let size = proxy.size
                    
                    ZStack{
                        Image("A_fg")
                            .resizable()
                            .scaledToFill()
                            .frame(width: size.width, height: size.height)
                        
                        if isVisibleiPad{
                            
                            Image(systemName: "ipad.landscape")
                                .resizable()
                                .frame(width: 100, height: 70)
                                .rotationEffect(.degrees(isiPadWiggling ? 7 : -7))
                                .onAppear{
                                    withAnimation(
                                        Animation.easeInOut(duration: 0.15).repeatForever(autoreverses: true)){
                                            isiPadWiggling.toggle()
                                        }
                                    //Make iPad image disappear
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            isVisibleiPad = false
                                        }
                                    }
                                    
                                }
                            
                        }
                    }
                }
                
                //APPLY OFFSET
                .offset(motionData.movingOffset)
                
                //TEXT ZONE ON FOREGROUND
                ZStack{
                    VStack {
                        HStack{
                            Text("A is for Amazement,\ntry to wiggle and play\nto see flowers dance freely\nwhile kites float away!").font(Font.custom("Bolota Bold", size: 42))
                                .foregroundColor(.red.opacity(0.9))
                                .padding()
                            Spacer()
                            Button {
                                isPlaying.toggle()
                            } label: {
                                Image(systemName: isPlaying ? "speaker.wave.2" : "speaker.slash")
                                    .resizable()
                                    .frame(width: 65, height: 65)
                                    .padding(.bottom, 100)
                                    .padding(.trailing, 20)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            } .sound("a_rhyme.m4a", isPlaying: $isPlaying)
                        }
                        .padding()
                        Spacer()
                        
                        //NAVIGATION BUTTON
                        NavigationLink(destination: BView()) {
                            HStack {
                                Spacer()
                                Image("go_ahead_white")
                                    .resizable()
                                    .frame(width: 60, height: 59)
                                    .scaledToFit()
                                    .padding()
                            } .padding()
                        }
                    }
                    
                    .allowsHitTesting(true)
                }
            }
        }
        //: MOTION UPDATER
        .onAppear(perform: {
            motionData.fetchMotionData(duration: 55)
        })
    }
    
}

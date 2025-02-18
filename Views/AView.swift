import SwiftUI
import Subsonic

struct AView: View {
    @StateObject var motionData = MotionObserver() //for gyroscope use
    @State private var isPlaying = false //to control the playing of the story
    
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
                .ignoresSafeArea()
                
                GeometryReader{proxy in
                    
                    HStack {
                        Image("A_fg")
                            .resizable()
                            .scaledToFill()
                    }
                }//: IMAGE FOREGROUND
                
                //: MOTION UPDATER
                .onAppear(perform: {
                    motionData.fetchMotionData(duration: 55)
                })
                
                //APPLY OFFSET
                .offset(motionData.movingOffset)
                
                //TEXT ZONE ON FOREGROUND
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
                                .foregroundColor(.red.opacity(0.5))
                        } .sound("amazement_rhyme.m4a", isPlaying: $isPlaying)
                    }
                    .padding()
                    Spacer()
                    
                    //NAVIGATION BUTTON
                    NavigationLink(destination: BView()) {
                        HStack {
                            Spacer()
                            Image("go_ahead")
                                .resizable()
                                .opacity(0.8)
                                .frame(width: 60, height: 59)
                                .scaledToFit()
                                .padding()
                        } .padding()
                    }
                }
                
                
            }
        }
    }
}

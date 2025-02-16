import SwiftUI

struct BView: View {
    
    //Shared namespace for the matched Geometry Effect
    @Namespace var animationNamespace 
    @State var showFirstImage = true
    
    @State private var isPlaying = false //to control the play of the story
    
    init() {
        registerCustomFont(named: "Bolota Bold")
    }
    
    var body: some View {
        ZStack{
            
            GeometryReader{proxy in
                
                let size = proxy.size
                
                if showFirstImage {
                    Image("B_first")
                        .resizable()
                        .scaledToFill()
                        .frame(width: size.width, height: size.height)
                    //Applying the matchedGeometryEffect. IMPORTANT: unique id
                        .matchedGeometryEffect(id: "transitionImage", in: animationNamespace)
                    
                    //Toggle the image on tap
                        .onTapGesture{
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showFirstImage.toggle()
                            }
                        }
                } else {
                    Image("B_second")
                        .resizable()
                        .scaledToFill()
                        .frame(width: size.width, height: size.height)
                        .matchedGeometryEffect(id: "transitionImage", in: animationNamespace)
                        .onTapGesture{
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showFirstImage.toggle()
                            }
                        }
                }
            }
            
            //TEXT ZONE ON FOREGROUND
            VStack {
                HStack {
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
                            .foregroundColor(.white.opacity(0.5))
                    } .sound("bravery_rhyme.m4a", isPlaying: $isPlaying)
                } .padding(.top, 30).padding(.trailing, 20)
                Spacer()
                HStack{
                    Text("B is for Bravery\ntap torch to glow\nWhen light fills the darkness\nwatch shadows go!").font(Font.custom("Bolota Bold", size: 42))
                        .foregroundColor(.white.opacity(0.9))
                        .padding()
                    Spacer()
                }
                .padding()
            }
            
            
        }//: END OF ZSTACK
    }//: END OF BODY
}

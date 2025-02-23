import SwiftUI

struct BView: View {
    
    //Shared namespace for the matched Geometry Effect
    @Namespace var animationNamespace 
    @State var showFirstImage: Bool = true
    
    @State private var isPlaying: Bool = false //to control the play of the story
    @State var isPulsing: Bool = true //disappearing of hand tap animation
    
    init() {
        registerCustomFont(named: "Bolota Bold")
    }
    
    var body: some View {
        
        NavigationStack{
            
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
                ZStack{
                    
                    if isPulsing {
                        Image(systemName: "hand.tap")
                            .resizable()
                            .frame(width: 80, height: 100)
                            .symbolEffect(.pulse)
                        
                        //Make hand tap disappear
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        isPulsing = false
                                    }
                                }
                            }
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                isPlaying.toggle()
                            } label: {
                                Image(systemName: isPlaying ? "speaker.wave.2" : "speaker.slash")
                                    .resizable()
                                    .frame(width: 65, height: 65)
                                    .padding(.top, 40)
                                    .padding(.bottom, 100)
                                    .padding(.trailing, 20)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            } .sound("b_rhyme.m4a", isPlaying: $isPlaying)
                        } .padding(.trailing, 20)
                        Spacer()
                        HStack{
                            Text("B is for Bravery\ntap torch to glow\nWhen light fills the darkness\nwatch shadows go!").font(Font.custom("Bolota Bold", size: 42))
                                .foregroundColor(.white.opacity(0.9))
                                .padding()
                            Spacer()
                            //NAVIGATION BUTTON
                            NavigationLink(destination: CView()) {
                                HStack {
                                    Spacer()
                                    Image("go_ahead_white")
                                        .resizable()
                                        .frame(width: 60, height: 59)
                                        .scaledToFit()
                                        .padding()
                                } .padding(.top, 150)
                            }
                        }
                        .padding()
                    }
                }//: END OF TEXT ZSTACK
                .allowsHitTesting(true)
            }
        }//: END OF ZSTACK
        .navigationBarBackButtonHidden()
    }//: END OF BODY
}


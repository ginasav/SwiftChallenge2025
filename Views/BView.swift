import SwiftUI

struct BView: View {
    
    //Shared namespace for the matched Geometry Effect
    @Namespace var animationNamespace
    @State var showFirstImage = true
    
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
            
            //TEXT ZONE
            VStack {
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

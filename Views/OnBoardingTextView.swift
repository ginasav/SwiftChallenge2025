import SwiftUI

struct OnboardingTextView: View {
    @Binding var textCounter: Int
    @Binding var textOpacity: Double
    //to control the popping effect of the hand image
    @State var isPopping: Bool = false
    
    var body: some View {
        VStack {
            switch textCounter {
            case 0:
                Text("This project helps children learn English alphabet through emotions!\nEach letter is connected to a feeling that kids can explore through interactive scenes.")
                    .frame(width: 900, height: 200, alignment: .center)
            case 1:
                Text("Interact with your device to make things happen!\nWiggle, sway or tap to bring each scene to life.")
            case 2:
                Text("Listen or read along with some playful rhymes.")
            case 3:
                VStack {
                    Text("Let's start!")
                    .font(Font.custom("Bolota Bold", size: 40))
                    Image(systemName: "hand.tap")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    //ANIMATION FOR THE HAND
                        .scaleEffect(isPopping ? 1.2 : 1.0)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.6)
                                .repeatForever(autoreverses: true)) {
                                    isPopping.toggle()
                                }
                        }
                }
            default:
                Text("")
            }
        }
        .opacity(textOpacity) // Apply opacity here
    }
}

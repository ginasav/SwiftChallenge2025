import SwiftUI

struct OnboardingTextView: View {
    @Binding var textCounter: Int
    @Binding var textOpacity: Double
    
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
                    Image(systemName: "hand.tap")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
            default:
                Text("")
            }
        }
        .opacity(textOpacity) // Apply opacity here
    }
}

import SwiftUI

struct TitleScreenView: View {
    
    //to initiate the font
    init() {
        registerCustomFont(named: "Bolota Bold")
    } 
    
    @State var isWiggling: Bool = false //to check the wiggling animation
    @State var navigateToNextView: Bool = false //to control the navigation to the next view
    @State var textCounter: Int = 0 //to control the text that will appear on the screen for the on-boarding
    @State var showOnBoarding: Bool = false //to control the appearing of the onBoarding texts
    @State var textOpacity: Double = 0 // Controls text fade-in animation
    @State var showAView: Bool = false //to control the navigation to AView
    
    var body: some View{
        NavigationStack{
            GeometryReader{screen in //to read the size screen
                
                let size = screen.size
                ZStack{
                    
                    if !showAView { //to control the showing of TitleScreenView or AView
                        //TITLE SCREEN BACKGROUND
                        Image("background")
                            .resizable()
                            .scaledToFill()
                            .frame(width: size.width, height: size.height)
                        
                        if !showOnBoarding { //to handle the disappearing of the two following images
                            // Title & Action Text (Only Before Onboarding Starts)
                            //TITLE SCREEN BACKGROUND
                            Image("title")
                                .resizable()
                                .scaledToFill()
                                .frame(width: size.width, height: size.height)
                            
                            //ACTION TEXT
                            Image("action_text")
                                .resizable()
                                .scaledToFill()
                                .frame(width: size.width, height: size.height)
                        }
                        
                        //EMOTIONS MIDDLEGROUND
                        Image("emotions")
                            .resizable()
                            .scaledToFill()
                            .frame(width: size.width, height: size.height)
                        
                        //ALPHABET FOREGROUND
                        Image("ts_alphabet")
                            .resizable()
                            .scaledToFill()
                            .frame(width: size.width, height: size.height)
                        
                        //WIGGLING ANIMATION FOR ALPHABET
                            .rotationEffect(.degrees(isWiggling ? 1: -1))
                            .onAppear{
                                withAnimation(
                                    Animation.easeInOut(duration: 2)
                                        .repeatForever())
                                {
                                    isWiggling = true
                                }
                            }
                        
                        //Text of the on-boarding in a switch that is triggered by a textCounter
                        if showOnBoarding { //to handle the appearing of the OnBoardingTextView
                            OnboardingTextView(textCounter: $textCounter, textOpacity: $textOpacity)
                        }
                    } else {
                        AView()
                            .transition(.move(edge: .trailing))
                    }
                }
                .font(Font.custom("Bolota Bold", size: 30))
                .foregroundColor(.black)
                .onAppear{
                    withAnimation(
                        .easeInOut(duration: 0.5)
                    ) {
                        textOpacity = 1
                    }
                }
            }
        }
//        .animation(.easeInOut(duration: 0.5), value: showAView)
        .onTapGesture{
            if !showOnBoarding {
                //with First Tap the alphabet stop wiggling and the first text is shown
                isWiggling = false
                showOnBoarding = true
                textOpacity = 0 // Reset opacity before showing text
                withAnimation(.easeInOut(duration: 1)) {
                    textOpacity = 1 // Fade-in effect
                }
            } else if textCounter < 3 {
                
                withAnimation(.easeInOut(duration: 0.3)) {
                    textOpacity = 0
                }
                
                //Change text after fade-out delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    textCounter += 1
                    withAnimation(.easeInOut(duration: 0.5)) {
                        textOpacity = 1 // Fade-in new text
                    }
                }
            } else {
                    showAView = true //last tap: navigate to AView
            }
        }
    }
}

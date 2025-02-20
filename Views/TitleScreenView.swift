import SwiftUI

struct TitleScreenView: View {
    
    //to initiate the font
    init() {
        registerCustomFont(named: "Bolota Bold")
    } 
    
    @State var isWiggling = false //to check the wiggling animation
    @State var navigateToNextView = false //to control the navigation to the next view
    @State var textCounter: Int = 0 //to control the text that will appear on the screen for the on-boarding
    @State var showOnBoarding: Bool = false //to control the appearing of the onBoarding texts
    @State var textOpacity: Double = 0 // Controls text fade-in animation
    
    var body: some View{
        NavigationStack{
            GeometryReader{screen in
                
                let size = screen.size
                ZStack{
                    
                    //TITLE SCREEN BACKGROUND
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .frame(width: size.width, height: size.height)
                    
                    if !showOnBoarding {
                            // Title & Action Text (Only Before Onboarding Starts)
                            //TITLE SCREEN BACKGROUND
                            Image("title")
                                .resizable()
                                .scaledToFill()
                                .frame(width: size.width, height: size.height)
                                .transition(.opacity.combined(with: .scale(scale: 2))) // Fade + Shrink effect
                            
                            
                            //ACTION TEXT
                            Image("action_text")
                                .resizable()
                                .scaledToFill()
                                .frame(width: size.width, height: size.height)
                                .transition(.opacity.combined(with: .scale(scale: 2))) // Fade + Shrink effect
                            
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
                        if showOnBoarding {
                            //                        VStack{
                            //                            switch textCounter {
                            //                                
                            //                            case 0:
                            //                                Text("This project helps children learn English alphabet through emotions!\nEach letter is connected to a feeling that kids can explore through interactive scenes.")
                            //                                    .frame(width: 900, height: 200, alignment: .center)
                            //                                
                            //                            case 1:
                            //                                Text("Interact with your device to make things happen!\nWiggle, sway or tap to bring each scene to life.")
                            //                                
                            //                            case 2:
                            //                                Text("Listen or read along with some playful rhymes.")
                            //                                
                            //                            case 3:
                            //                                VStack{
                            //                                    Text("Let's start!")
                            //                                    Image(systemName: "hand.tap")
                            //                                        .resizable()
                            //                                        .scaledToFit()
                            //                                        .frame(width: 50, height: 50)
                            //                                }
                            //                                
                            //                            default:
                            //                                Text("")
                            //                                
                            //                            }
                            //                        }
                            OnboardingTextView(textCounter: $textCounter, textOpacity: $textOpacity)
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
                    //                .transition(.opacity)
                    
                }
            }
            
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
                    navigateToNextView.toggle()
                }
            }
            
        }
    }

import SwiftUI
import CoreText

func registerCustomFont(named fontName: String, withExtension ext: String = "ttf") {
    guard let fontURL = Bundle.module.url(forResource: fontName, withExtension: ext) else {
        print("⚠️ Font file \(fontName).\(ext) not found!")
        return
    }
    
    //ERROR MANAGER
    var error: Unmanaged<CFError>?
    if !CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error) {
        print("⚠️ Font registration failed: \(error?.takeRetainedValue().localizedDescription ?? "Unknown error")")
    }
}


//
//  SwiftUIAppleArchiveApp.swift
//  SwiftUIAppleArchive
//
//  Created by Angelos Staboulis on 22/11/24.
//

import SwiftUI

@main
struct SwiftUIAppleArchiveApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(sourceFileName: "", destinationFileName: "").frame(width: 450, height: 320)
                .windowResizeBehavior(.disabled)
        }.windowResizability(.contentSize)
    }
}

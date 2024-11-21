//
//  ContentView.swift
//  SwiftUIAppleArchive
//
//  Created by Angelos Staboulis on 22/11/24.
//

import SwiftUI
import AppleArchive
import System
struct ContentView: View {
    @State var sourceFileName:String
    @State var destinationFileName:String
    var body: some View {
        VStack {
            Text("Enter path to source file").frame(width:300,alignment: .leading)
            TextField("Enter path to source file",text: $sourceFileName).frame(width:300,alignment: .leading).padding(10)
            Text("Enter path to destination file").frame(width:300,alignment: .leading)
            TextField("Enter path to source file",text:$destinationFileName).frame(width:300,alignment: .leading).padding(10)
            Button {
                let archiveFilePath = FilePath(sourceFileName)
                guard let readFileStream = ArchiveByteStream.fileStream(
                        path: archiveFilePath,
                        mode: .readOnly,
                        options: [ ],
                        permissions: FilePermissions(rawValue: 0o644)) else {
                    return
                }
                defer {
                    try? readFileStream.close()
                }
                let archiveFilePathNew = FilePath(destinationFileName)


                guard let writeFileStream = ArchiveByteStream.fileStream(
                        path: archiveFilePathNew,
                        mode: .writeOnly,
                        options: [ .create ],
                        permissions: FilePermissions(rawValue: 0o644)) else {
                    return
                }
                defer {
                    try? writeFileStream.close()
                }
                guard let compressStream = ArchiveByteStream.compressionStream(
                        using: .lzfse,
                        writingTo: writeFileStream) else {
                    return
                }
                defer {
                    try? compressStream.close()
                }
                do {
                    _ = try ArchiveByteStream.process(readingFrom: readFileStream,
                                                      writingTo: compressStream)
                } catch {
                    print("Handle `ArchiveByteStream.process` failed.")
                }
            } label: {
                Text("Compress File")
            }.frame(width:300,alignment: .center)

        }
       
    }
}

#Preview {
    ContentView(sourceFileName: "", destinationFileName: "")
}

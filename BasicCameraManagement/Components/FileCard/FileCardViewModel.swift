//
//  FileCardViewModel.swift
//  BasicCameraManagement
//
//  Created by Kevin Marin on 13/3/24.
//

import Foundation

class FileCardViewModel: ObservableObject {
    @Published var fileURL: URL?
    @Published var fileName: String?
    @Published var fileExtension: String?
    @Published var fileData: Data?
    @Published var fileSize: Int?
    
    init(fileURL: URL? = nil,
         fileName: String? = nil,
         fileExtension: String? = nil,
         fileData: Data? = nil,
         fileSize: Int? = nil) {
        self.fileURL = fileURL
        self.fileName = fileName
        self.fileExtension = fileExtension
        self.fileData = fileData
        self.fileSize = fileSize
    }
    
    var formattedFileSize: String? {
        guard let fileSize = fileSize else {
            return nil
        }
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }
}

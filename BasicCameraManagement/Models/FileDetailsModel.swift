//
//  FileDetailsModel.swift
//  BasicCameraManagement
//
//  Created by Kevin Marin on 13/3/24.
//

import Foundation

struct FileDetailsModel {
    var url: URL?
    var fileName: String?
    var fileExtension: String?
    var fileData: Data?
    var fileSize: Int?
    
    init(url: URL? = nil,
         fileName: String? = nil,
         fileExtension: String? = nil,
         fileData: Data? = nil,
         fileSize: Int? = nil) {
        self.url = url
        self.fileName = fileName
        self.fileExtension = fileExtension
        self.fileData = fileData
        self.fileSize = fileSize
    }
}

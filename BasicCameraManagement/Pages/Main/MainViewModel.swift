//
//  MainViewModel.swift
//  BasicCameraManagement
//
//  Created by Kevin Marin on 13/3/24.
//

import Foundation
import UIKit

class MainViewModel: NSObject, ObservableObject {
    @Published var showCamera = false
    @Published var fileDetails: FileDetailsModel?
    
    func saveFileDetails(url: URL?) {
        guard let url = url else {
            // If the URL is nil, we cannot continue.
            // We might log an error or display an error message to the user.
            print("Error: URL is nil")
            return
        }
        
        do {
            let fileManager = Foundation.FileManager.default
            let fileName = url.lastPathComponent
            let fileExtension = url.pathExtension
            let fileData = try Data(contentsOf: url)
            let fileAttributes = try fileManager.attributesOfItem(atPath: url.path)
            var fileSize = 0
            if let size = fileAttributes[.size] as? Int {
                fileSize = size
            }
                
            // Create a FileDetails object with the obtained file details.
            fileDetails = .init(url: url,
                                fileName: fileName,
                                fileExtension: fileExtension,
                                fileData: fileData,
                                fileSize: fileSize)
        } catch {
            // Handle any error that may occur during getting file details.
            print("Error loading file details: \(error.localizedDescription)")
        }
    }
}

//
//  CameraViewModel.swift
//  BasicCameraManagement
//
//  Created by Kevin Marin on 13/3/24.
//

import Foundation
import UIKit

class CameraViewModel: ObservableObject {
    var didSelectImage: (UIImage?, URL?) -> Void
    var dismiss: () -> Void
    
    init(didSelectImage: @escaping (UIImage?, URL?) -> Void, dismiss: @escaping () -> Void) {
        self.didSelectImage = didSelectImage
        self.dismiss = dismiss
    }
}

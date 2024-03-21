//
//  CameraView.swift
//  BasicCameraManagement
//
//  Created by Kevin Marin on 13/3/24.
//

import SwiftUI
import UIKit

struct CameraView: UIViewControllerRepresentable {
    var viewModel: CameraViewModel
    
    init(viewModel: CameraViewModel) {
        self.viewModel = viewModel
    }
    
    typealias UIViewControllerType = UIImagePickerController
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let view = UIImagePickerController()
        // Verificar si la cámara está disponible
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            view.sourceType = .camera
            view.allowsEditing = false
            view.delegate = context.coordinator
        } else {
            // Manejar la situación en la que la cámara no está disponible
            print("La cámara no está disponible en este dispositivo.")
        }
        
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // empty
    }
    
    // MARK:
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image: UIImage = info[.originalImage] as? UIImage else {
                print("Error obteniendo la imagen")
                parent.viewModel.dismiss()
                return
            }
            
            // Crear el nombre del archivo con la extensión
            let fileName = createFileNameForPictureTakeWithCamera(info: info)
            
            // Ejemplo adicional: si necesitas la ruta de archivo local de la imagen guardada
            if let data = image.jpegData(compressionQuality: 1.0),
               let imageURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = imageURL.appendingPathComponent(fileName)
                do {
                    try data.write(to: fileURL)
                    print("Ruta de archivo local de la imagen guardada: \(fileURL)")
                    parent.viewModel.didSelectImage(fileURL)
                    parent.viewModel.dismiss()
                } catch {
                    print("Error al escribir la imagen en el sistema de archivos: \(error)")
                    parent.viewModel.dismiss()
                }
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.viewModel.dismiss()
        }
        
        // MARK: Methods
        func createFileNameForPictureTakeWithCamera(info: [UIImagePickerController.InfoKey : Any])-> String {
            // Generar un nombre de archivo único basado en la fecha y hora actual
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMddHHmmss"
            let timestamp = formatter.string(from: Date())
            
            // Obtener extension, por default es ".jpg"
            var fileExtension = ".jpg"
            if let mediaType = info[.mediaType] as? String, mediaType == "public.png" {
                fileExtension = ".png"
            }
            
            // Crear el nombre del archivo con la extensión
            let fileName = "CapturedImage_\(timestamp)" + fileExtension
            
            // Imprimir el nombre del archivo y la extensión
            print("Nombre del archivo: \(fileName)")
            return fileName
        }
    }
}

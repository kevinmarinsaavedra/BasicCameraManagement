//
//  MainView.swift
//  BasicCameraManagement
//
//  Created by Kevin Marin on 13/3/24.
//

import SwiftUI

struct FileCardView: View {
    @ObservedObject var viewModel: FileCardViewModel
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Data Image").fontWeight(.bold)
            }
            HStack(alignment: .top) {
                Text("url: ").fontWeight(.bold)
                Text(viewModel.fileURL?.description ?? Constant.stringDefault)
                Spacer()
            }
            HStack(alignment: .top)  {
                Text("name: ").fontWeight(.bold)
                Text(viewModel.fileName ?? Constant.stringDefault)
                Spacer()
            }
            HStack(alignment: .top)  {
                Text("extension: ").fontWeight(.bold)
                Text(viewModel.fileExtension ?? Constant.stringDefault)
                Spacer()
            }
            HStack(alignment: .top)  {
                Text("data: ").fontWeight(.bold)
                Text("\(viewModel.fileData != nil ? Constant.yes : Constant.no)")
                Spacer()
            }
            HStack(alignment: .top)  {
                Text("size: ").fontWeight(.bold)
                Text("\(viewModel.formattedFileSize ?? Constant.stringDefault)")
                Spacer()
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
        .shadow(radius: 5)
    }
}
            
// MARK: Constants
extension FileCardView {
    struct Constant {
        static let stringDefault = "-"
        static let yes = "Yes"
        static let no = "No"
    }
}

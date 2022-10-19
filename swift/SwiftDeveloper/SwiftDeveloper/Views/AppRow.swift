//
//  AppRow.swift
//  SwiftDeveloper
//
//  Created by zhe wu on 2022/10/19.
//

import SwiftUI

struct AppRow: View {
    var appModel: AppModel

    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: appModel.screenshotUrls[0])) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 48, height: 48)
            .clipShape(RoundedRectangle(cornerRadius: 6))

            VStack(alignment: .leading) {
                Text(appModel.trackName)
                    .font(.title3)
                    .bold()
                    .lineLimit(1)
                
                Text(appModel.description)
                    .font(.system(size: 14))
                    .lineLimit(2)
            }
            
            Spacer()

            Image(systemName: "heart")
        }
        .padding(10)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .padding(.vertical, 4)
    }
}

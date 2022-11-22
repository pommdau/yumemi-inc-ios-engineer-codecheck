//
//  AboutSection.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/21.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct AboutSection: View {
    
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("About")
                .font(.title2)
                .bold()
                .padding(.vertical)
            if let description = repository.description,
               !description.isEmpty {
                Text(description)
                    .padding(.bottom, 8)
            }            
            Grid(verticalSpacing: 8) {
                starsGridRow(starsCount: repository.starsCount)
//                wachersGridRow(watchersCount: repository.watchersCount)
                forksGridRow(forksCount: repository.forksCount)
                issuesGridRow(issuesCount: repository.openIssuesCount)
                websiteGridRow(website: repository.website)
            }
        }
    }
    
    // MARK: - @ViewBuilder
    
    @ViewBuilder
    private func starsGridRow(starsCount: Int) -> some View {
        GridRow {
            Image(systemName: "star")
                .foregroundColor(.secondary)
                .gridColumnAlignment(.center)
            Text("\(IntegerFormatStyle<Int>().notation(.compactName).format(starsCount))")
                .bold()
                .gridColumnAlignment(.trailing)
            Text("stars")
                .foregroundColor(.secondary)
                .gridColumnAlignment(.leading)
        }
    }
    
    @ViewBuilder
    private func wachersGridRow(watchersCount: Int) -> some View {
        GridRow {
            Image(systemName: "eye")
                .foregroundColor(.secondary)
            Text("\(IntegerFormatStyle<Int>().notation(.compactName).format(watchersCount))")
                .bold()
            Text("watching")
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder
    private func forksGridRow(forksCount: Int) -> some View {
        GridRow {
            Image(systemName: "arrow.triangle.branch")
                .foregroundColor(.secondary)
            Text("\(IntegerFormatStyle<Int>().notation(.compactName).format(forksCount))")
                .bold()
            Text("forks")
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder
    private func issuesGridRow(issuesCount: Int) -> some View {
        GridRow {
            Image(systemName: "circle.circle")
                .foregroundColor(.secondary)
            Text("\(IntegerFormatStyle<Int>().notation(.compactName).format(repository.openIssuesCount))")
                .bold()
            Text("issues")
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder
    private func websiteGridRow(website: String?) -> some View {
        if let website,
           !website.isEmpty {
            GridRow {
                Image(systemName: "link")
                    .foregroundColor(.secondary)
                Button {
                    guard let url = URL(string: website) else {
                        return
                    }
                    UIApplication.shared.open(url)
                } label: {
                    Text("\(website)")
                        .lineLimit(1)
                        .bold()
                }
                .gridCellColumns(3)
            }
        }
    }
}

struct AboutSection_Previews: PreviewProvider {
    static var previews: some View {
        AboutSection(repository: Repository.sampleData[0])
            .previewLayout(.fixed(width: 600, height: 400))
    }
}

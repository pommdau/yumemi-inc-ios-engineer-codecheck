//
//  AboutView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/21.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct AboutView: View {

    // MARK: - Properties

    let repository: Repository

    // MARK: - View

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
                websiteGridRow(websiteURL: repository.websiteURL)
            }
        }
    }

    // MARK: - @ViewBuilder

    @ViewBuilder
    private func starsGridRow(starsCount: Int) -> some View {
        GridRow {
            Image(systemName: "star")
                .accessibilityLabel(Text("Stars Image"))
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
    private func watchersGridRow(watchersCount: Int) -> some View {
        GridRow {
            Image(systemName: "eye")
                .accessibilityLabel(Text("Watchers Image"))
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
                .accessibilityLabel(Text("Forks Image"))
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
                .accessibilityLabel(Text("Issues Image"))
                .foregroundColor(.secondary)
            Text("\(IntegerFormatStyle<Int>().notation(.compactName).format(repository.openIssuesCount))")
                .bold()
            Text("issues")
                .foregroundColor(.secondary)
        }
    }

    @ViewBuilder
    private func websiteGridRow(websiteURL: URL?) -> some View {
        if let websiteURL {
            GridRow {
                Image(systemName: "link")
                    .accessibilityLabel(Text("Link Image"))
                    .foregroundColor(.secondary)
                Button {
                    UIApplication.shared.open(websiteURL)
                } label: {
                    Text("\(websiteURL.absoluteString)")
                        .lineLimit(1)
                        .bold()
                }
                .gridCellColumns(3)
            }
        }
    }
}

// MARK: - Previews

#Preview("通常", traits: .sizeThatFitsLayout) {
    AboutView(repository: Repository.sampleData[0])
        .padding()
}

#Preview("長い語句を含む場合", traits: .sizeThatFitsLayout) {
    AboutView(repository: Repository.sampleDataWithLongWord)
        .padding()
}

#Preview("空の情報がある場合", traits: .sizeThatFitsLayout) {
    AboutView(repository: Repository.sampleDataWithoutSomeInfo)
        .padding()
}

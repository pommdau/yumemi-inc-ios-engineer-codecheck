//
//  DescriptionView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/21.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct DescriptionView: View {

    // MARK: - Properties

    let repo: Repo

    // MARK: - View

    var body: some View {
        VStack(alignment: .leading) {
//            Text("About")
//                .font(.title2)
//                .bold()
//                .padding(.vertical)
            if let description = repo.description,
               !description.isEmpty {
                Text(description)
                    .padding(.bottom, 8)
            }
            Grid(verticalSpacing: 8) {
                starsGridRow(starsCount: repo.starsCount)
                //                wachersGridRow(watchersCount: repo.watchersCount)
                forksGridRow(forksCount: repo.forksCount)
                issuesGridRow(issuesCount: repo.openIssuesCount)
                websiteGridRow(websiteURL: repo.websiteURL)
            }
        }
    }

    // MARK: - @ViewBuilder

    @ViewBuilder
    private func starsGridRow(starsCount: Int) -> some View {
        GridRow {
            Image(systemName: "star")
                .accessibilityLabel(Text("Stars Image"))
                .foregroundStyle(.secondary)
                .gridColumnAlignment(.center)
            Text(String.compactName(starsCount))
                .bold()
                .gridColumnAlignment(.trailing)
            Text("stars")
                .foregroundStyle(.secondary)
                .gridColumnAlignment(.leading)
        }
    }

    @ViewBuilder
    private func watchersGridRow(watchersCount: Int) -> some View {
        GridRow {
            Image(systemName: "eye")
                .accessibilityLabel(Text("Watchers Image"))
                .foregroundStyle(.secondary)
            Text(String.compactName(watchersCount))
                .bold()
            Text("watching")
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private func forksGridRow(forksCount: Int) -> some View {
        GridRow {
            Image(systemName: "arrow.triangle.branch")
                .accessibilityLabel(Text("Forks Image"))
                .foregroundStyle(.secondary)
            Text(String.compactName(forksCount))
                .bold()
            Text("forks")
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private func issuesGridRow(issuesCount: Int) -> some View {
        GridRow {
            Image(systemName: "circle.circle")
                .accessibilityLabel(Text("Issues Image"))
                .foregroundStyle(.secondary)
            Text(String.compactName(repo.openIssuesCount))
                .bold()
            Text("issues")
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private func websiteGridRow(websiteURL: URL?) -> some View {
        if let websiteURL {
            GridRow {
                Image(systemName: "link")
                    .accessibilityLabel(Text("Link Image"))
                    .foregroundStyle(.secondary)
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
    DescriptionView(repo: Repo.sampleData[0])
        .padding()
}

#Preview("長い語句を含む場合", traits: .sizeThatFitsLayout) {
    DescriptionView(repo: Repo.sampleDataWithLongWord)
        .padding()
}

#Preview("空の情報がある場合", traits: .sizeThatFitsLayout) {
    DescriptionView(repo: Repo.sampleDataWithoutSomeInfo)
        .padding()
}

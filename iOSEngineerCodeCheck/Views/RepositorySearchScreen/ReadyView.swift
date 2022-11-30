//
//  SearchReadyView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/12/01.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct ReadyView: View {
    var body: some View {
        VStack {
            Text("検索してみましょう")
                .font(.title)
                .bold()
                .padding()
            Text("GitHub内のリポジトリが検索できます")
                .foregroundColor(.secondary)
        }
    }
}

struct ReadyView_Previews: PreviewProvider {
    static var previews: some View {
        ReadyView()
    }
}

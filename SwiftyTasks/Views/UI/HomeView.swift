//
//  HomeView.swift
//  SwiftyTasks
//
//  Created by Mico Infante on 8/11/22.
//

import SwiftUI

struct HomeView: View {

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section {

                } header: {

                }
            } // END: LazyVStack
        } // END: ScrollView
    }

    private func headerView() -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)

                Text("Today")
                    .font(.largeTitle.bold())
            }
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

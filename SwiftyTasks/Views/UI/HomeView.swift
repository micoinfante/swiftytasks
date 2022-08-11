//
//  HomeView.swift
//  SwiftyTasks
//
//  Created by Mico Infante on 8/11/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: TaskViewModel = TaskViewModel()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section {
                    currentWeekView()
                } header: {
                    headerView()
                }
            } // END: LazyVStack
        } // END: ScrollView
    }

    private func currentWeekView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.currentWeek, id: \.self) { day in
                    VStack(spacing: 10) {
                        Text(viewModel.formattedDate(day, format: "dd"))
                            .font(.system(size: 15))
                            .fontWeight(.semibold)

                        Text(viewModel.formattedDate(day, format: "EEE"))
                            .font(.system(size: 14))

                        Circle()
                            .fill(R.color.secondary.color)
                            .frame(width: 8, height: 8)
                            .opacity(viewModel.isToday(day) ? 1 : 0)
                    } // END: VStack
                    .frame(width: 45, height: 90)
                    .background(
                        ZStack {
                            Capsule()
                                .fill(R.color.primary.color)
                        }
                    )
                }// END: ForEach
            } // END: HStack
            .padding(.horizontal)
        } // END: ScrollView
    }
    
    private func headerView() -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)

                Text(R.string.localizable.homeToday())
                    .font(.largeTitle.bold())
            }
            .horizontalLeading()

            Button {

            } label: {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
        } // END: HStack
        .padding()
        .background(R.color.background.color)
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

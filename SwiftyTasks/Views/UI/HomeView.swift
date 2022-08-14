//
//  HomeView.swift
//  SwiftyTasks
//
//  Created by Mico Infante on 8/11/22.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel: TaskViewModel = TaskViewModel()
    @State var selectedItem: Task?

    @Namespace var animation

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section {
                    currentWeekView()
                        .unredacted(when: !viewModel.isLoading)
                    tasksView()
                        .unredacted(when: !viewModel.isLoading)
                } header: {
                    headerView()
                }
            } // END: LazyVStack
        } // END: ScrollView
        .ignoresSafeArea(.container, edges: .top)
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
                    // MARK: Capsule Foreground
                    .foregroundStyle(viewModel.isToday(day) ? .primary : .tertiary)
                    .foregroundColor(viewModel.isToday(day) ? .white : .secondary)
                    // MARK: Capsule Background
                    .frame(width: 45, height: 90)
                    .background(
                        ZStack {
                            if viewModel.isToday(day) {
                                Capsule()
                                    .fill(R.color.primary_variant.color)
                                    .matchedGeometryEffect(id: Constants.Key.currentDay,
                                                           in: animation)
                            }
                        }
                    )
                    .contentShape(Capsule())
                    .onTapGesture {
                        // Update Current Day
                        withAnimation {
                            viewModel.currentDay = day
                        }
                    }
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
                    .font(.caption2)

                Text(R.string.localizable.homeToday())
                    .font(.largeTitle.bold())
            }
            .horizontalLeading()

            Button {

            } label: {
                Image(systemName: "person.circle")
                    .font(.largeTitle)
                    .frame(width: 45, height: 45, alignment: .bottom)
                    .padding(.top)
            }
        } // END: HStack
        .padding()
        .padding(.top, getSafeArea().top)
        .background(R.color.background.color)
    }

    private func tasksView() -> some View {
        LazyVStack(spacing: 20) {
            if let tasks = viewModel.tasks {
                if tasks.isEmpty {
                     // MARK: Error View
                    if viewModel.error != nil {
                        errorView()
                    } else {
                        // MARK: Empty State
                        Text(R.string.localizable.homeNoTasksMessage())
                            .font(.system(size: 16))
                            .fontWeight(.regular)
                            .offset(y: 100)
                    }
                } else {
                    ForEach(tasks) { task in
                        taskCardView(task: task)
                    }
                }
            } else {
                ProgressView()
                    .offset(y: 100)
            }
        } // END: LazyVStack
        .padding()
        .padding(.top)
        // Reload base on selected day
        .onChange(of: viewModel.currentDay) { newValue in
            viewModel.filterTasks()
        }
    }

    @ViewBuilder
    private func taskCardView(task: Task) -> some View {
        HStack(alignment: .top, spacing: 30) {
            VStack(spacing: 10) {
                Circle()
                    .fill(selectedItem == task ? R.color.primary.color : .clear)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(R.color.primary.color, lineWidth: 1)
                            .frame(width: 18, height: 18)
                            .padding(-3)
                    )
                    .scaleEffect(selectedItem == task ? 0.8 : 1)

                Rectangle()
                    .fill(R.color.primary.color)
                    .frame(width: 3)
            }.opacity(viewModel.isLoading ? 0 : 1)

            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 0) {
                            Text(task.title)
                                .font(.title2.bold())
                            Spacer()
                            Text(task.date.formatted(date: .omitted, time: .shortened))
                                .font(.footnote)
                                .padding(.top, 2)
                        }

                        Text(task.description)
                            .font(.callout)
                    }
                }
            }
            .foregroundColor(selectedItem == task ? .white : .secondary)
            .padding(selectedItem == task ? 15 : 0)
            .padding(.bottom, selectedItem == task ? 0 : 10)
            .horizontalLeading()
            .background(
                R.color.primary.color
                    .cornerRadius(25)
                    .opacity(selectedItem == task ? 1 : 0)
            )
        } // END: HStack
        .horizontalLeading()
        .onTapGesture {
            selectedItem = task
        }
    }

    private func errorView() -> some View {
        VStack(alignment: .center, spacing: 8) {
            Text(R.string.localizable.homeErrorGeneral())
                .font(.system(size: 16))
                .fontWeight(.bold)
                .offset(y: 100)
            Text(R.string.localizable.homeFailedFetchingTasks())
                .font(.system(size: 16))
                .fontWeight(.regular)
                .offset(y: 100)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

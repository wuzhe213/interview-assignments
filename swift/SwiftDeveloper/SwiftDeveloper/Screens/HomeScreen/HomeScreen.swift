//
//  HomeScreen.swift
//  SwiftDeveloper
//
//  Created by zhe wu on 2022/10/18.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var homeViewModel = HomeViewModel()

    var body: some View {
        ZStack {
            if homeViewModel.firstLoading {
                ScreenLoadingView()
            } else {
                List {
                    ForEach(homeViewModel.appsModel.results, id: \.trackId) {
                        AppRow(appModel: $0,
                               isFavorited: homeViewModel.isFavorited(appId: $0.trackId)) { appId in
                            homeViewModel.toggleFavorite(appId: appId)
                        }
                    }
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)

                    if !homeViewModel.firstLoading {
                        LoadingMoreView(isFinished: homeViewModel.appsModel.resultCount == homeViewModel.appsModel.results.count)
                            .listRowInsets(.init())
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .onAppear {
                                homeViewModel.fetchData()
                            }
                    }
                }
                .listStyle(.plain)
                .environment(\.defaultMinListRowHeight, 1)
//                .padding(.horizontal)
                .refreshable {
                    homeViewModel.fetchData(isRerefeshing: true)
                }
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("App")
        .onAppear {
            homeViewModel.fetchFirstTime()
        }
        .animation(.easeInOut, value: homeViewModel.firstLoading)
    }
}

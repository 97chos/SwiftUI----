//
//  SideBard.swift
//  DesignCodCourse
//
//  Created by 조상호 on 2021/08/24.
//

import SwiftUI

struct SideBar: View {
    var body: some View {
      NavigationView {
        #if os(iOS)
        content
          .navigationTitle("Learn")
        #else
        content
          .frame(minWidth: 200, idealWidth: 250, maxWidth: 300)
        #endif

        // default View: iPadOS에서 화면 진입 시 SideBar와 함께 보여지는 기본 뷰
        CoursesView()
      }
    }

  var content: some View {
    List {
      NavigationLink(destination: CoursesView()) {
        Label("Courses", systemImage: "book.closed")
      }
      Label("Tutorials", systemImage: "list.bullet.rectangle")
      Label("LiveStreams", systemImage: "tv")
      Label("Certificates", systemImage: "mail.stack")
      Label("Search", systemImage: "magnifyingglass")
        .listStyle(SidebarListStyle())

    }
  }
}

struct SideBar_Previews: PreviewProvider {
    static var previews: some View {
        SideBar()
    }
}

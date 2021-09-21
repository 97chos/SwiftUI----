//
//  TabBar.swift
//  DesignCodCourse
//
//  Created by 조상호 on 2021/08/30.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
      TabView {
        NavigationView{
          CourseList()
        }
        .tabItem {
          Image(systemName: "book.closed")
          Text("Courses")
        }

        NavigationView {
          CourseList()
        }
        .tabItem {
          Image(systemName: "list.bullet.rectangle")
            Text("Tutorials")
        }

        NavigationView {
          CourseList()
        }
        .tabItem {
          Image(systemName: "tv")
          Text("LiveStreams")
        }

        NavigationView {
          CourseList()
        }
        .tabItem {
          Image(systemName: "mail.stack")
          Text("Certificates")
        }

        NavigationView {
          CourseList()
        }
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text("Search")
        }
      }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

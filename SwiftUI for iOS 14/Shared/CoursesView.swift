//
//  CoursesView.swift
//  DesignCodCourse
//
//  Created by 조상호 on 2021/08/24.
//

import SwiftUI

struct CoursesView: View {
  @State var show = false
  @Namespace var namespace
  @Namespace var detailNamespace
  @State var selectedItem: Course? = nil
  @State var isDisabled = false
  #if os(iOS)
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  #endif

  var body: some View {
    ZStack {
      #if os(iOS)
      if horizontalSizeClass == .compact {
        tabBar
      } else {
        sideBar
      }
      fullContent
        .background(VisualEffectBlur(blurStyle: .systemThickMaterial).edgesIgnoringSafeArea(.all))
      #else
      content
      fullContent
        .background(VisualEffectBlur().edgesIgnoringSafeArea(.all))
      #endif
    }
    .navigationTitle("Courses")
  }

  var content: some View {
    // 작은 뷰
    ScrollView {
      VStack(spacing: 0) {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)],
                  spacing: 16) {
          ForEach(courses) { item in
            VStack {
              CourseItem(course: item)
                // 연결되는 뷰의 기하학적인 구조만을 정의, frame 이전에 설정
                .matchedGeometryEffect(id: item.id, in: namespace, isSource: !show)
                .frame(height: 200)
                .onTapGesture {
                  // 애니메이션 도중 여러번 터치해도 부드럽게 동작됨.
                  // .animation을 사용할 경우 애니메이션이 느려지고, 스크롤 시 렉이 발생한다.
                  withAnimation(.spring(response: 0.7, dampingFraction: 1.0, blendDuration: 0)) {
                    show.toggle()
                    selectedItem = item
                    isDisabled = true
                  }
                }
                .disabled(isDisabled)
            }
            .matchedGeometryEffect(id: "container\(item.id)", in: namespace, isSource: !show)
          }
        }
        .padding(16)
        .frame(maxWidth: .infinity)

        Text("Latest sections")
          .fontWeight(.semibold)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding()

        LazyVGrid(columns: [GridItem(.adaptive(minimum: 240))]) {
          ForEach(courseSections) { item in
            #if os(iOS)
            NavigationLink(
              destination: CourseDetail(nameSpace: detailNamespace)) { 
              CourseRow(item: item)
            }
            #else
            CourseRow(item: item)
            #endif
          }
        }
      }
    }
    .zIndex(1)
    .navigationTitle("Courses")
  }

  @ViewBuilder
  var fullContent: some View {
    if selectedItem != nil {
      ZStack(alignment: .topTrailing) {
        CourseDetail(course: selectedItem!, nameSpace: namespace)

        CloseButton()
          .padding(16)
          .onTapGesture {
            withAnimation(.spring()) {
              show.toggle()
              selectedItem = nil
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                isDisabled = false
              }
            }
          }
      }
      .zIndex(2)
      .frame(maxWidth: 712)
      .frame(maxWidth: .infinity)
      .background(VisualEffectBlur().edgesIgnoringSafeArea(.all))
    }
  }

  var tabBar: some View {
    TabView {
      NavigationView{
        content
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

  @ViewBuilder
  var sideBar: some View {
    #if os(iOS)
    NavigationView {
      List {
        NavigationLink(destination: content) {
          Label("Courses", systemImage: "book.closed")
        }
        Label("Tutorials", systemImage: "list.bullet.rectangle")
        Label("LiveStreams", systemImage: "tv")
        Label("Certificates", systemImage: "mail.stack")
        Label("Search", systemImage: "magnifyingglass")
          .listStyle(SidebarListStyle())
          .navigationTitle("Learn")
          .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
              Image(systemName: "person.crop.circle")
            }
          }
        
        // default View: iPadOS에서 화면 진입 시 SideBar와 함께 보여지는 기본 뷰
        content
      }
    }
    #endif
  }
}

struct CoursesView_Previews: PreviewProvider {
  static var previews: some View {
    CoursesView()
  }
}

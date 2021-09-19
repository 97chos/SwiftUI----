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
  @State var selectedItem: Course? = nil
  @State var isDisabled = false

  var body: some View {
    ZStack {
      #if os(iOS)
      content
        .navigationBarHidden(true)
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
        Text("Courses")
          .font(.largeTitle)
          .bold()
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(16)
          .padding(.top, 54)

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
                  withAnimation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0)) {
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
          .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
          .padding()

        LazyVGrid(columns: [GridItem(.adaptive(minimum: 240))]) {
          ForEach(courseSections) { item in
            CourseRow(item: item)
          }
        }
      }
    }
    .zIndex(1)
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
}

struct CoursesView_Previews: PreviewProvider {
  static var previews: some View {
    CoursesView()
  }
}

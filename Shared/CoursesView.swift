//
//  CoursesView.swift
//  DesignCodCourse
//
//  Created by 조상호 on 2021/08/24.
//

import SwiftUI

struct CoursesView: View {
  @State var show = false
  @Namespace var nameSpace
  @State var selectedItem: Course? = nil
  @State var isDisable = false

  var body: some View {
    ZStack {
      // 작은 뷰
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)],
                  spacing: 16) {
          ForEach(courses) { item in
            VStack {
              CourseItem(course: item)
                // 연결되는 뷰의 기하학적인 구조만을 정의, frame 이전에 설정
                .matchedGeometryEffect(id: item.id, in: nameSpace, isSource: !show)
                .frame(height: 200)
                .onTapGesture {
                  // 두 애니메이션 방법 모두 사용 가능하나, 기하학적인 애니메이션은 이 방법이 더 적합하다고 판단,
                  // 애니메이션 도중 여러번 터치해도 부드럽게 동작됨.
                  // .animation을 사용할 경우 애니메이션이 느려지고, 스크롤 시 렉이 발생한다.
                  withAnimation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0)) {
                    show.toggle()
                    selectedItem = item
                    isDisable = true
                  }
                }
                .disabled(isDisable)
            }
            .matchedGeometryEffect(id: "container\(item.id)", in: nameSpace, isSource: !show)
          }
        }
        .padding(10)
        .frame(maxWidth: .infinity)
      }
      .zIndex(1)
      if selectedItem != nil {
        ZStack(alignment: .topTrailing) {
          VStack {
            ScrollView {
              // 큰 뷰
              CourseItem(course: selectedItem!)
                .matchedGeometryEffect(id: selectedItem!.id, in: nameSpace)
                .frame(height: 300)
                .transition(.opacity)


              VStack {
                ForEach(0 ..< 20) { item in
                  CourseRow()
                }
              }
              .padding()
            }
          }
          .background(Color("Background 1"))
          .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
          .matchedGeometryEffect(id: "container\(selectedItem!.id)", in: nameSpace)
          // safeArea 무시
          .edgesIgnoringSafeArea(.all)

          CloseButton()
            .padding(.trailing, 16)
            .onTapGesture {
              withAnimation(.spring()) {
                show.toggle()
                selectedItem = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                  isDisable = false
                }
              }
            }
        }
        .zIndex(2)
      }
    }
  }
}

struct CoursesView_Previews: PreviewProvider {
  static var previews: some View {
    CoursesView()
  }
}

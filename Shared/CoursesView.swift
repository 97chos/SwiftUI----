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

  var body: some View {
    ZStack {
      // 작은 뷰
      ScrollView {
        VStack(spacing: 20) {
          CourseItem()
            // 연결되는 뷰의 기하학적인 구조만을 정의, frame 이전에 설정
            .matchedGeometryEffect(id: "Card", in: nameSpace, isSource: !show)
            .frame(width: 335, height: 250)
          CourseItem()
            .frame(width: 335, height: 250)
        }
        .frame(maxWidth: .infinity)
      }

      if show {
        ScrollView {
          // 큰 뷰
          CourseItem()
            .matchedGeometryEffect(id: "Card", in: nameSpace)
            .frame(height: 300)
            .transition(.opacity)

          VStack {
            ForEach(0 ..< 20) { item in
              CourseRow()
            }
          }
          .padding()
        }
        .background(Color("Background 1"))
        .transition(
          // 비대칭형 애니메이션 구현시 사용 
          .asymmetric(insertion: AnyTransition.opacity.animation(Animation.spring().delay(0.3)),
                      removal: AnyTransition.opacity.animation(.spring())
          )
        )
        .edgesIgnoringSafeArea(.all)

        // safeArea 무시
      }
    }
    // 프리뷰에서는 노출 애니메이션이 제대로 동작하지 않으나, 앱에서는 정상적으로 동작됨
    .onTapGesture {
      // 두 애니메이션 방법 모두 사용 가능하나, 기하학적인 애니메이션은 이 방법이 더 적합하다고 판단,
      // 애니메이션 도중 여러번 터치해도 부드럽게 동작됨.
      // .animation을 사용할 경우 애니메이션이 느려지고, 스크롤 시 렉이 발생한다.
      withAnimation(.spring()) {
        show.toggle()
      }
    }
    //    .animation(.spring())
  }
}

struct CoursesView_Previews: PreviewProvider {
  static var previews: some View {
    CoursesView()
  }
}

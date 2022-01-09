# Ch10. Lazy Grid And Stack

## LazyGrid
- LazyGrid는 **유연하고 쉽제 적용할 수 있는 Grid Layout**을 생성하는데에 사용됩니다.
- Grid 방향이 수직일 경우에는 LazyVGrid를, 수평일 경우에는 LazyHGrid를 사용합니다.
- 이름에 Lazy가 붙은만큼, View가 화면에 나타나기 전까지는 해당 View를 그리지 않습니다.

 ```swift
struct LazyLayout: View {  
  var body: some View {
    ScrollView {
      VStack {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 30) {
          ForEach(0 ..< 20) { item in
            Rectangle()
              .frame(height: 100)
              .foregroundColor(.orange)
          }
        }
        .padding()
      }
    }
  }
}
```
> ![Simulator Screen Shot - iPhone 13 Pro Max - 2022-01-09 at 20 48 57](https://user-images.githubusercontent.com/59811450/148680936-cf681369-bc38-42ed-8cf9-20e4fbd927d7.png)

- columns에(LazyHGrid일 경우 rows) GridItem을 추가한 후, spacing을 통해 행간(LazyHGrid일 경우 열간)을 조정할 수 있습니다.
- GridItem은 .adpative, .flexible, .fixed 총 세 가지 타입을 갖습니다.
- 최소값이나 최대값을 주고 유연한 크기의 Item을 그리려면 adaptive, 화면 크기에 맞게 자동적으로 크기를 맞추고 싶으면 flexible, 고정된 크기로 그리려면 .fixed를 사용합니다. 
- ForEach 내부 파라미터 값으로 배열과 같은 데이터를 전달할 수 있습니다.

## LazyStack
- LazyVStack, LazyHStack은 일반적인 VStack, HStack과 달리 이름과 같이 **그리려는 콘텐츠가 화면에 보여질 때에 View를 그리는 Stack**입니다.
- 즉, ScrollView 내부에서 Stack을 구현하였을 때, Stack에 구현된 모든 View가 한 번에 load 되는 것이 아닌, Scroll을 통해 해당 화면이 보여지게 되었을 때 해당 View를 그리게 됩니다.

### VStack

 ```swift
struct LazyLayout: View {
  @State var appearedText: String = ""
  
  var body: some View {
    ZStack(alignment: .top) {
      ScrollView {
        VStack {
          Rectangle()
            .frame(maxWidth: 200, minHeight: 400)
            .foregroundColor(.red)
          
          Rectangle()
            .frame(maxWidth: 200, minHeight: 400)
            .foregroundColor(.blue)
          
          Rectangle()
            .frame(maxWidth: 200, minHeight: 400)
            .foregroundColor(.green)
          
          Rectangle()
            .frame(maxWidth: 200, minHeight: 400)
            .foregroundColor(.purple)
            .onAppear {
              // Purple 컬러의 Rectangle이 보여졌을 때, appearedText를 변경
              appearedText = "Pupple was appeared"
            }
        }
      }
      
      Text(appearedText)
        .font(.title)
        .foregroundColor(.white)
        .background(Color.black)
    }
  }
}
```

> ![Simulator Screen Recording - iPhone 13 Pro Max - 2022-01-09 at 20 26 17](https://user-images.githubusercontent.com/59811450/148680235-ac8466d6-2a71-4910-816f-98f6d7ebb69f.gif)

- 위 코드는 보라색의 사각형이 load 되었을 때 appearedText를 보여주는 코드입니다.
- 일반적인 VStack의 경우, 화면 진입과 동시에 "Pupple was appeared"라는 글자가 보여지게 됩니다.
- 이는 곧 화면의 모든 View들을 같은 타이밍에 그린다는 것을 의미합니다.
 
### LazyVStack
 ```swift
struct LazyLayout: View {
  @State var appearedText: String = ""
  
  var body: some View {
    ZStack(alignment: .top) {
      ScrollView {
        LazyVStack {
          Rectangle()
            .frame(maxWidth: 200, minHeight: 400)
            .foregroundColor(.red)
          
          Rectangle()
            .frame(maxWidth: 200, minHeight: 400)
            .foregroundColor(.blue)
          
          Rectangle()
            .frame(maxWidth: 200, minHeight: 400)
            .foregroundColor(.green)
          
          Rectangle()
            .frame(maxWidth: 200, minHeight: 400)
            .foregroundColor(.purple)
            .onAppear {
              // Purple 컬러의 Rectangle이 보여졌을 때, appearedText를 변경
              appearedText = "Pupple was appeared"
            }
        }
      }
      
      Text(appearedText)
        .font(.title)
        .foregroundColor(.white)
        .background(Color.black)
    }
  }
}
```
> ![Simulator Screen Recording - iPhone 13 Pro Max - 2022-01-09 at 20 32 24](https://user-images.githubusercontent.com/59811450/148680422-ff5f4cbb-cdd6-469b-9c2a-de33681bea97.gif)

- VStack을 LazyVStack으로 변경한 코드입니다.
- 화면 진입과 동시에 글자가 보여지는 VStack과 다르게 스크롤 후 보라색 사각형이 보여질 때 쯤 글자가 함께 나타납니다.
- 한 번에 모든 화면을 동시에 그리는 것이 아닌, **화면에 보여질 때 해당 View를 그리는 것을 확인**할 수 있습니다.
- 또한, 우측 Scroll Bar의 위치가 다른 것을 확인할 수 있는데, 이는 내부 View만큼의 너비를 갖는 Stack과는 달리, **자동적으로 남는 여유 너비 공간을 차지하는 LazyStack만의 특성** 또한 확인할 수 있습니다.



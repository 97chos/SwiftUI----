# Ch8. MatchedGeometryEffect

## MatcehdGeometryEffect
- MatchedGeometry는 서로 다른 View 사이에 요소들을 공유하여, 자연스러운 View 전환을 할 수 있도록 도와주는 메소드입니다.
- Text, Button, Background와 같은 요소들은 따로 애니메이션 상태를 지정하지 않고도 개별적으로 애니메이션 처리되며, 쉽고 부드러운 움직임을 지원합니다. 

> 이미지

```swift
// MatchedGeometry.swift

  @State var show = false
  @Namespace var namespace

  var body: some View {
    ZStack {
      if show == false {
        ScrollView {
          HStack {
            Text("Title").foregroundColor(.white)
              .matchedGeometryEffect(id: "title", in: namespace)
              .frame(width: 100, height: 100)
              .background(Rectangle().matchedGeometryEffect(id: "shape", in: namespace))
              .onTapGesture {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                  show.toggle()
                }
              }

            Rectangle()
              .frame(width: 100, height: 100)
            Spacer()
          }
          .padding()
        }
      } else {
        Text("Title").foregroundColor(.white)
          .matchedGeometryEffect(id: "title", in: namespace)
          .frame(maxWidth: .infinity, maxHeight: 400)
          .background(Rectangle().matchedGeometryEffect(id: "shape", in: namespace))
      }
    }
    .onTapGesture {
      withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
        show = false
      }
    }
  }
```
- 애니메이션 구현 때와 같이, 상단에 namespace라는 변수를 선언해주었습니다. MatchedGeometry로 연결된 View들은 namespace의 id로 엮여져서 관리됩니다.
- 위 코드에서는 Text와 background에 matchedGeometryEffect가 적용된 모습을 볼 수 있습니다. 모두 같은 namespace를 공유하고 있으며, Text는 Text끼리, background는 background끼리 id를 공유합니다. 즉, 서로 다른 View 간의 UI 요소를 공유하고 싶은 경우, 대상 요소의 id는 같아야합니다. 
- 이후 onTapGesture의 toggle을 통해 State 값을 변경해주어 애니메이션을 동작시킵니다.

### Namespace의 전달
- 같은 struct 내의 다른 View 간의 전환이 아닌, 다른 struct 간의 다른 View 전환이 필요한 경우 namespace를 전달하여 사용할 수도 있습니다.

```swift
// MusicPlayer.swift

struct MusicPlayer: View {
  @State var show = false
  @Namespace var namespace

  var body: some View {
    ZStack {
      if !show {
        SumarryView(namespace: namespace)
      } else {
        PlayView(namespace: namespace)
      }
    }
    .frame(maxHeight: .infinity, alignment: .bottom)
    .onTapGesture {
      withAnimation(.spring()) {
        show.toggle()
      }
    }
  }
}

struct SumarryView: View {
  var namespace: Namespace.ID

    var body: some View {
      VStack {
        HStack {
          RoundedRectangle(cornerRadius: 10)
            .matchedGeometryEffect(id: "shape", in: namespace)
            .frame(width: 44, height: 44)
          Text("Fever")
            .frame(minWidth: 80)
            .matchedGeometryEffect(id: "title", in: namespace)
            .foregroundColor(.white)
          Spacer()
          Image(systemName: "backward.fill")
            .matchedGeometryEffect(id: "backward", in: namespace)
            .font(.title)
          Image(systemName: "play.fill")
            .matchedGeometryEffect(id: "play", in: namespace)
            .font(.title)
          Image(systemName: "forward.fill")
            .matchedGeometryEffect(id: "forward", in: namespace)
            .font(.title)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: 50)
      .padding(8)
      .background(
        LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .leading, endPoint: .trailing)
          .matchedGeometryEffect(id: "background", in: namespace)
      )
    }
}

struct PlayView: View {
  var namespace: Namespace.ID

  var body: some View {
    VStack(alignment: .center) {
      RoundedRectangle(cornerRadius: 30)
        .matchedGeometryEffect(id: "shape", in: namespace)
        .frame(width: 300, height: 300)
        .padding()
      Text("Fever")
        .frame(minWidth: 80)
        .matchedGeometryEffect(id: "title", in: namespace)
        .foregroundColor(.white)
        .font(.title)
      HStack {
        Image(systemName: "backward.fill")
          .matchedGeometryEffect(id: "backward", in: namespace)
          .font(.title)
        Image(systemName: "play.fill")
          .matchedGeometryEffect(id: "play", in: namespace)
          .font(.title)
        Image(systemName: "forward.fill")
          .matchedGeometryEffect(id: "forward", in: namespace)
          .font(.title)
      }
      .padding()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(
      LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
        .matchedGeometryEffect(id: "background", in: namespace)
    )
    .ignoresSafeArea()
  }
}
```
- summaryView, PlayView의 struct를 생성하고, State에 따라 두 View 간의 전환이 이루어지는 방식입니다.
- 두 struct에는 각각 namespace가 생성되어 있으며, MusicPlayer에서 공통의 namespace를 전달하여 같은 namespace를 공유하게 됩니다.

> 이미지

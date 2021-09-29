# Ch7. Animations

## State, withAnimation
- State 값을 통해 애니메이션에 대한 상태값을 정의할 수 있습니다.

```swift
// animationButton.swift

  @State var show = false

  var body: some View {
    VStack {
      Text(show ? "View less" : "View more")
        .bold()
        .foregroundColor(.white)
        .frame(width: show ? 320 : 300, height: show ? 500 : 44)
        .background(Color.purple)
        .cornerRadius(30)
        .shadow(color: .purple.opacity(0.5), radius: 20)
        .onTapGesture {
          show.toggle()
        }

      if show {
        Pagenation()
          .frame(minHeight: 200)
          .transition(.move(edge: .leading))
          .zIndex(1)
      }
    }
  }
```
- 맨 위에서 선언된 show 변수는 애니메이션 상태값을 의미합니다. Bool 타입으로 정의되며, 해당 상태값에 따라 Text의 내용, frame의 크기가 달라지게 됩니다.
- 기본 View는 false인 상태의 View가 나오다가, true일 경우에는 true 상태 값의 View가 노출됩니다.
- 애니메이션 상태값은 .toogle() 메소드를 통해 true 혹은 false로 변경할 수 있습니다. 위 코드에서는 onTapGesture 내부에 show.toggle() 코드를 작성하여, Text를 Tap할 때마다 show 메소드가 toggle 되도록 구현하였습니다.

> <이미지>

- show.toggle() 코드를 withAnimation으로 감싸주어 show 변수 값에 영향을 받게되는 View에 애니메이션 효과를 줄 수 있습니다.

```swift
// animationButton.swift

  @State var show = false

  var body: some View {
    VStack {
      Text(show ? "View less" : "View more")
      ...
        .onTapGesture {
          withAnimation(.spring()) {
            show.toggle()
          }
  }
      ...
  }
```
> <이미지>

- withAnimation 인자값으로 spring 뿐만 아니라 easeIn, easeOut 등 다양한 애니메이션 속도 효과를 줄 수 있습니다.

## animation
- withAnimation은 주로 공통된 애니메이션 효과를 줄 때 많이 사용되지만, 만약 각 애니메이션마다 다른 타이밍이나 구체적인 효과를 주어야 하는 경우에는 animation 메소드를 사용하게 됩니다.
- animation 메소드는 모든 자식 요소에 적용되기 때문에, 관리의 편의성을 위해 Vstack, HStack과 같은 부모 Container에는 적용하지 않는 것이 좋습니다.

 ```swift
// viewTransition.swift

  @State var show = false

  var body: some View {
      ZStack {
        Color.black.ignoresSafeArea()
          .opacity(show ? 0.5 : 0.2)
          .animation(.linear(duration: 0.5))
        RoundedRectangle(cornerRadius: 40)
          .foregroundColor(.white)
          .frame(height: 300)
          .opacity(show ? 1 : 0.5)
          .padding(show ? 16 : 32)
          .offset(y: show ? 0 : 30)
          .animation(.spring(response: 0.4, dampingFraction: 0.4))
        RoundedRectangle(cornerRadius: 40)
          .frame(height: 300)
          .offset(y: show ? 600 : 0)
          .foregroundColor(.white)
          .shadow(radius: 40)
          .padding()
          .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
      }
      .onTapGesture {
        show.toggle()
      }
    }
```
 
- 위 코드는 show라는 State를 만들고 show의 값에 따라 배경의 불투명도, 둥근 사각형의 불투명도, y축 위치, padding 값이 달라지도록 구현한 코드입니다.
- 세 요소 모두 애니메이션 타이밍이나 효과를 다르게 설정하기 위해 withAnimation을 toggle()에 걸어주는 대신, animation 메소드를 사용하였습니다.

> <이미지>

### rotation, 3D Animation
- rotationEffect를 통해 각도를 조절함으로써 회전 애니메이션을 구현할 수 있습니다.
```swift
// View3DChange.swift

    var body: some View {
      ZStack {
        RoundedRectangle(cornerRadius: 30)
          .frame(width: 260, height: 200)
          .offset(y: 20)
        RoundedRectangle(cornerRadius: 30)
          .frame(width: 300, height: 200)
          .foregroundColor(Color.blue)
          .offset(y: show ? -200 : 0)
          .scaleEffect(show ? 1.2 : 1)
          .rotationEffect(Angle(degrees: show ? 30 : 0))
          .onTapGesture {
            withAnimation(.spring()) {
              show.toggle()
            }
          }
      }
    }
```

> <이미지>

- rotation3DEffect를 추가하여 3차원 입체 애니메이션을 구현할 수 있습니다.
```swift
// View3DChange.swift
    @State var show = false

    var body: some View {
      ZStack {
        RoundedRectangle(cornerRadius: 30)
          .frame(width: 260, height: 200)
          .offset(y: 20)
        RoundedRectangle(cornerRadius: 30)
          .frame(width: 300, height: 200)
          .foregroundColor(Color.blue)
          .offset(y: show ? -200 : 0)
          .scaleEffect(show ? 1.2 : 1)
          .rotation3DEffect(Angle(degrees: show ? 30 : 0),
                            axis: (x: 1, y: 0, z: 0)
          )
          .onTapGesture {
            withAnimation(.spring()) {
              show.toggle()
            }
          }
      }
    }
```
- rotation3DEffect의 각 수치들은 각도, 축, 원근감 등이 있으며, 본인이 원하는 각도나 원근 수치를 기입하면 됩니다.

> <이미지>


### Delay Animation
- DispatchQueue를 통한 thread 예약 구문으로 지연된 애니메이션을 구현할 수 있습니다.

```swift
// delayAnimation.swift

  @State var tap = false

  var body: some View {
    Text("View more").font(.title3.bold()).foregroundColor(.white)
      .frame(width: 200, height: 200)
      .background(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom))
      .clipShape(RoundedRectangle(cornerRadius: 30))
      .shadow(color: .blue.opacity(tap ? 0.5 : 0.3), radius: tap ? 20 : 10, x: 0, y: tap ? 10 : 20)
      .scaleEffect(tap ? 1.2 : 1)
      .animation(.spring(response: 0.4, dampingFraction: 0.6))
      .onTapGesture {
        tap = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
          tap = false
        }
      }
  }
```

> <이미지>

- onTapGesture 실행 후 0.2초 뒤에 tap을 false로 초기화시켜줌으로서 다시 View로 돌아오도록 구현하였습니다.

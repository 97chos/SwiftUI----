# Ch8. Gesture

## gesture
- gesture 메소드를 통해 다양한 gesture 이벤트에 반응하는 View를 구현할 수 있습니다.

### LongPressGesture
- LongPressGesture는 View를 길게 터치할 때 발생하는 이벤트를 구현할 수 있는 구조체입니다.

```swift
// Longgesture.swift

  @GestureState var press = false
  @State var show = false

  var body: some View {
      Image(systemName: "camera.fill")
        .foregroundColor(.white)
        .frame(width: 60, height: 60)
        .background(show ? Color.black : Color.blue)
        .mask(Circle())
        .scaleEffect(press ? 2 : 1)
        .animation(.spring())
        .gesture(LongPressGesture(minimumDuration: 1.0).updating($press) { currentState, gestureState, transaction in
          gestureState = currentState
        }.onEnded { value in
          show.toggle()
        })
  }
```
- 위에서 선언된 press는 Gesture State로, LongPressGesture 내부 메소드인 updating 메소드의 반환값을 이용하여 값을 변경합니다.
- LongPressGesture의 minimumduration 값을 이용하여 최소 터치 인식 시간을 정의할 수 있습니다.
- updating 메소드의 인자값으로는 GestureState를 전달하는데, 이 때 삽입된 인자값은 return으로 반환되는 값 중 하나가 되어 변경될 수 있으므로, 앞에 $을 표기하여 바인딩 작업을 처리해주어야 합니다.
- updating 메소드는 총 3개의 return 값을 갖는데, 이벤트 처리 중일 때의 LongPressGesture.Value(Bool) 값, 바인딩된 GestureState, 현재 애니메이션 상태에 대한 값을 전달(?)하는 Transaction이 return 됩니다.
- 위 코드는 LongPressGesture 이벤트 발생 시 press의 상태 값을 변경하여 Image의 Scale 값을 변경하고, 이벤트가 종료될 때(onEnded) State를 Toggle하여 Image의 background를 변경하는 코드입니다. 

### DragGesture
- LongPressGesture와 같이 DragGesture 이벤트 또한 구현할 수 있습니다.

```swift
// Longgesture.swift

  @State var viewState = CGSize.zero

  var body: some View {
    VStack(spacing: 50) {
      RoundedRectangle(cornerRadius: 50)
        .fill(Color.blue)
        .frame(width: 300, height: 400)
        .offset(x: viewState.width, y: viewState.height)
        .animation(.spring(response: 0.4, dampingFraction: 0.6))
        .gesture(DragGesture().onChanged { value in
          viewState = value.translation
        }.onEnded { value in
          viewState = .zero
        })
        ...
    }
  }
```
- DragGesture의 인스턴스를 생성한 뒤, onChanged 메소드 내부에 이벤트 발생 시 실행될 코드를 작성합니다.
- return 되는 value는 DragGesture.Value 타입으로, Drag 이벤트 발생 지점의 위치, 시간, velocity 등 다양한 정보들을 포함하고 있습니다.
- 위 코드는 CGSize 타입의 viewState를 value의 translation 값으로 삽입하여 현재 view의 위치를 translation의 위치값으로 변경하는 코드입니다.
- 만약, 드래그 이벤트가 종료되었을 경우(.onEnded) viewState는 다시 .zero로 초기화하여 원래의 자리로 돌아가도록 설정하였습니다.

> ![Simulator Screen Recording - iPhone 13 Pro Max - 2021-09-29 at 11 02 14](https://user-images.githubusercontent.com/59811450/135193353-30700e3d-d6b0-4c75-afb3-7bde2e7e629d.gif)


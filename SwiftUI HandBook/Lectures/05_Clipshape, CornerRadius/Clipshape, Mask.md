# Ch5. Clipshape, Mask

## ClipShape
- ClipShape를 이용하여 View를 도형 모양으로 maksing 처리할 수 있습니다.

```swift
// CloseButton.swift

  var body: some View {
    Color.indigo.ignoresSafeArea()
    .overlay {
      ZStack {
        Image(systemName: "xmark")
          .frame(width: 32, height: 32)
          .background(Circle().stroke())
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
          .padding([.trailing, .top])

        Text("App of the day")
          .font(.title).bold()
          .foregroundColor(.white)
          .shadow(radius: 10)
          .frame(width: 300, height: 400)
          .background(.pink)
          .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
      }
    }
  }
```
> <img width="300" alt="스크린샷 2021-09-27 오후 4 38 09" src="https://user-images.githubusercontent.com/59811450/134865948-f36c0669-fc21-4612-b43e-4831115c8598.png">

- clipShape 메소드의 인자값으로 RoundedRactangle을 전달하여 일반 사각형 모양을 둥근 사각형 모양으로 masking 처리한 모습입니다.
- 둥근 모서리를 만들 때 cornerRadius를 사용하는 것이 아닌 clipShape를 사용하면 좀 더 부드러운 모서리를 가진 View를 만들 수 있습니다.

### Shadow

- 도형에 Shadow 효과를 추가하여 좀 더 입체적인 형태로 만들 수 있습니다.

```swift
// CloseButton.swift

struct CloseButton: View {
  var body: some View {
        ...
        
        Text("App of the day")
          .font(.title).bold()
          .foregroundColor(.white)
          .shadow(radius: 10)
          .frame(width: 300, height: 400)
          .background(.pink)
          .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
          .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
          .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
      }
    }
  }
}
```
> <img width="300" alt="스크린샷 2021-09-27 오후 4 38 19" src="https://user-images.githubusercontent.com/59811450/134865983-b50a2d11-de4b-484b-8f5b-c82507e1be52.png">

## Mask
- Mask는 색상과 불투명도를 조절하여 콘텐츠를 자를 수 있기 때문에 clipShape보다 더 다양하게 사용할 수 있습니다.

```swift
// GradientList.swift

    var body: some View {
      ZStack {
        Color.blue.ignoresSafeArea()

        VStack {
          ForEach(0 ..< 5) { item in
            Text("Mask and Transparency")
              .font(.title3).bold()
              .padding(.vertical)
              .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
          }
        }
        .frame(height: 300, alignment: .top)
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .padding()
      }
    }
```
> <img width="453" alt="스크린샷 2021-09-27 오후 4 39 05" src="https://user-images.githubusercontent.com/59811450/134866021-e93c77fd-e7de-4bb9-9173-b23f82f4c026.png">

- 이처럼 콘텐츠가 중간에 잘리는 일이 발생하는 경우 Grdient mask를 통해 자연스럽게 처리할 수 있습니다.

```swift
// GradientList.swift

    var body: some View {
      ZStack {
        Color.blue.ignoresSafeArea()

        VStack {
          ForEach(0 ..< 5) { item in
            Text("Mask and Transparency")
              .font(.title3).bold()
              .padding(.vertical)
              .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
          }
        }
        .frame(height: 300, alignment: .top)
        .padding()
        .background(Color.white)
        .mask(LinearGradient(gradient: Gradient(colors: [.red, .yellow.opacity(0.8), .green.opacity(0)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(25)
        .padding()
      }
    }
```
 > <img width="485" alt="스크린샷 2021-09-27 오후 4 39 14" src="https://user-images.githubusercontent.com/59811450/134866111-41958808-9ec5-48c2-b3c0-30355c79b0ec.png">

- 위 코드에서는 LinearGradient를 사용하였으며, Grdient의 색상과 투명도, 시작 지점과 끝 지점을 정한 후 mask 처리한 모습입니다.

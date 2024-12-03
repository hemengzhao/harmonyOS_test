import  {MainPage} from "homelibrary"

@Entry
@Component
struct Index {
  @State message: string = 'Hello World 123';

  build() {
    RelativeContainer() {

      MainPage()
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%').backgroundColor(Color.Orange)
  }
}
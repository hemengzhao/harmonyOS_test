import { FileUpload } from '@ohos/common';

@Entry
@Component
struct DataPage {
  @State message: string = '数据中心';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('DataPageHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })

      Button('点击上传').onClick(() => {

        // FileUpload()
      })
    }
    .height('100%')
    .width('100%')
  }
}
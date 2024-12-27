import {reqPermissionsFromUser} from '../utils/PermissionsFromUser'
import { common } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  @State message: string = '医疗服务';

  aboutToAppear(): void {
    const context = getContext(this) as common.UIAbilityContext

    reqPermissionsFromUser(['ohos.permission.LOCATION'], context).then((data) => {
        console.log('reqPermissionsFromUser  '+data.toString())
    })
  }

  getCurrentPosittion(){
    
  }
  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })

      Button('点击上传').onClick(() => {
        console.log('开始 点击上传')
        // FileUpload()
      })

    }
    .height('100%')
    .width('100%')
  }
}
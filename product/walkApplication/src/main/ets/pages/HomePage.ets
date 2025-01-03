import { HomeBotBox } from '../view/HomeBot'
import { MapView } from '../view/Map';
import { TopBar } from '../view/TopBar';

@Entry
@Component
struct HomePage {
  @StorageProp('bottomRectHeight') bottomRectHeight: number = 0;
  @StorageProp('topRectHeight') topRectHeight: number = 0;
  @State message: string = 'Hello World';

  build() {
    Column(){
      Column(){
        TopBar()
      } .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
      Column(){
        RelativeContainer(){
          Column(){

            MapView()
          }
          .width('100%')
          .height('100%')
          .alignRules({
            'top': { 'anchor': '__container__', 'align': VerticalAlign.Top },
          })
          Column(){
            HomeBotBox()
          }
          .alignRules({
            'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom },
          }).height(320).margin({bottom: 30})

          // Column(){
          //
          // }.alignRules({
          //   'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom },
          // })
          // .width('100%')

          // 设置底部功能栏
          // .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
        }
        .width('100%')
      }.flexGrow(1)

    }.height('100%')
    .width('100%')

  }
}
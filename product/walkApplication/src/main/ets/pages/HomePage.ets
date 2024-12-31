import { HomeBotBox } from '../view/HomeBot'
import { TopBar } from '../view/TopBar';

@Entry
@Component
struct HomePage {
  @StorageProp('bottomRectHeight') bottomRectHeight: number = 0;
  @StorageProp('topRectHeight') topRectHeight: number = 0;
  @State message: string = 'Hello World';

  build() {
      RelativeContainer(){
        Column(){
          Button('asda').margin({top: 200}).onClick(() => {
            console.log('diaasdas')
          })
        }.backgroundColor(Color.Green)
        .width('100%')
        .height('100%')
        .alignRules({
          'top': { 'anchor': '__container__', 'align': VerticalAlign.Top },
        })

        Column(){
          TopBar()
        }
        // Row(){
        //   Text('西安').fontWeight(FontWeight.Bold)
        //     .fontSize(20)
        //     .fontColor(0x333333)
        //
        //   Column(){
        //     Image($r('app.media.home_my')).width(50)
        //   }
        // }.justifyContent(FlexAlign.SpaceBetween).width('100%')
        // .padding({
        //   left: 20,
        //   right: 20,
        //   top: 20
        // })
        // .alignRules({
        //   'top': { 'anchor': '__container__', 'align': VerticalAlign.Top },
        // })
        // .backgroundColor(Color.Orange)
        // 设置顶部绘制延伸到状态栏
        // .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])

        Column(){
          HomeBotBox()
        }
        .alignRules({
          'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom },
        }).height(320)

          Column(){

          }.alignRules({
            'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom },
          })
            .width('100%')

            // 设置底部功能栏
            // .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
      }
    .height('100%')
    .width('100%')
      // .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
  }
}
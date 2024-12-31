import { TopBar } from '../view/TopBar';

@Entry
@Component
struct TakeTaxiPage {
  @State message: string = 'Hello World';
  @State BoxHeight: number = 140
  @State list: string[] = ['1', '2', '3', '4', '5' ]
  @State moveY: number = 0
  build() {
    RelativeContainer() {
      Column() {
        Button('asda').margin({ top: 200 }).onClick(() => {
          console.log('diaasdas')
        })
      }.backgroundColor(Color.Green)
      .width('100%')
      .height('100%')
      .alignRules({
        'top': { 'anchor': '__container__', 'align': VerticalAlign.Top },
      })

      Column() {
        TopBar({
          isBack: true
        })
      }

      Flex({
        direction: FlexDirection.Column,
        justifyContent: FlexAlign.Center,
        alignItems: ItemAlign.Center
      }) {
        Column() {
          Column() {

          }.height(8)
          .width(100).borderRadius(4)
          .backgroundColor('#cccccc')
        }.padding({ top: 10, bottom: 15 }).width('100%')

        Column() {
          List({
            space: 10
          }) {
            ForEach(this.list, (item: string) => {
              ListItem() {
                Row() {
                  Row() {
                    Image($r('app.media.takeCart4')).width(60)
                    Column() {
                      Text('特惠专车').fontSize(18).fontColor('#333333')
                      Text('5分钟').fontSize(16).fontColor('#999999')
                    }
                    .alignItems(HorizontalAlign.Start)
                  }.alignItems(VerticalAlign.Center)
                  .height('100%')

                  Row() {
                    Text() {
                      Span('拼成').fontSize(12)
                      Span('12.5元').fontColor('#FF6B00')
                      Span('未拼成').fontSize(12)
                      Span('16.5元').fontColor('#333333')
                    }.fontSize(14).fontColor('#999999')

                    Checkbox({
                      name: 'cart1',
                      group: 'cartGroup'
                    }).shape(CheckBoxShape.ROUNDED_SQUARE).selectedColor(0x99DC64)
                  }
                }
                .height(50)
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)

              }.padding(10).width('100%')
            }, (item: string) => item)
          }.height('100%')

        }.flexGrow(1).width('100%')

        Row() {
          Button('出行设置')
            .type(ButtonType.Normal)
            .borderRadius(10)
            .width('40%')
            .backgroundColor('#F1F1F1')
            .fontColor('#666666')
            .fontSize(20)
            .height(50)
          Button('确认呼叫')
            .type(ButtonType.Normal)
            .borderRadius(10)
            .width('50%')
            .backgroundColor('#333333')
            .fontColor('#99DC64')
            .fontSize(20).height(50)
        }.justifyContent(FlexAlign.SpaceAround)
        .width('100%').flexShrink(0)
        .height(70)

      }
      .height(this.BoxHeight)
      .backgroundColor(Color.White)
      .width('100%')
      .borderRadius({
        topLeft: 30,
        topRight: 30
      })
      .onTouch((event?: TouchEvent) => {
        console.log('event.type.toString()')
        if(event){
          const nowMoveY = event.touches[0].windowY
          if (event.type === TouchType.Down) {
            console.log('Down')
          }

          if (event.type === TouchType.Up) {
            console.log('Up')
            this.BoxHeight = this.BoxHeight > 250 ? 500 : 160
          }
          if (event.type === TouchType.Move) {
            console.log('Move')
            const diff = this.moveY -  nowMoveY
            const h = this.BoxHeight + diff
            this.BoxHeight  =   h > 500  ? 500 : h < 160 ? 160 : h
          }

          this.moveY = event.touches[0].windowY
        }
      })
      .alignRules({
        'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom },
      })
    }
    .height('100%')
    .width('100%')
  }
}
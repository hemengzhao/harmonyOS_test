import { it } from '@ohos/hypium';
import { router } from '@kit.ArkUI';
import { ISearchPageParam } from '../viewModel/homeModel';

@Entry
@Component
struct SearchPage {
  @StorageProp('bottomRectHeight') bottomRectHeight: number = 0;
  @StorageProp('topRectHeight') topRectHeight: number = 0;

  @State List: string[] = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];
  @State type: string =  ''
  aboutToAppear(): void {
    const obj =  router.getParams() as ISearchPageParam
    this.type = obj.type
  }
  build() {
    Flex({
      direction: FlexDirection.Column
    }) {
      Column(){
        Text('<').fontSize(30).onClick(() => {
          router.back()
        })
      }.padding({left: 20, right: 20})

      Flex({
        alignItems: ItemAlign.Center
      }){
          Text('西安').width('15%')
          Image($r('app.media.login_dow')).width(20).margin({left: 5, right:5})
          TextInput({
            placeholder: this.type === 'to' ? '您要去哪儿？' :  '您要从哪儿出去发？'
          })
            .backgroundColor(Color.Transparent)
            .border({
              width: { left: 1 },
              color: '#E3E3E3'
            })
            .flexGrow(1)
            .borderRadius(0)
      }.borderRadius(10)
      .backgroundColor('#F1F1F1')

      .height(56)
      .margin({top: 10, bottom:10, left: 20, right: 20})
      .padding({left: 20, right: 20})

      List({
        space: 10
      }){
          ForEach(this.List, (item: string) => {
              ListItem(){
                Row(){
                  Image($r('app.media.mapPoint')).width(26).margin({right: 10})
                  Column(){
                    Text('万达广场').fontSize(18).fontColor('#333333').fontWeight(FontWeight.Bold).lineHeight(30)

                    Text('陕西省西安市雁塔区科技七路与唐延路交汇处').fontSize(16)
                      .fontColor('#999999').lineHeight(26)
                      .width('90%')
                      .textOverflow({ overflow: TextOverflow.Ellipsis }).maxLines(1)
                  }
                  .justifyContent(FlexAlign.Start)
                  .alignItems(HorizontalAlign.Start)

                }
                .alignItems(VerticalAlign.Center)

              }.padding({left: 20, right: 20, bottom: 15})
              .border({
                width: {
                  bottom: 1
                }, color: '#eee',
              })
          }, (item: string) => item)
      }
    }
    .height('100%')
    .width('100%')
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
  }
}

let storageUpdateRouter = new LocalStorage();

@Entry
@Component
struct Widget1Card {
  @LocalStorageProp('routerDetail') routerDetail: string = '播放进度';
  @LocalStorageProp('title') title: ResourceStr = 'title';

  /*
   * The title.
   */
  readonly TITLE: string = 'Hello World';
  /*
   * The action type.
   */
  readonly ACTION_TYPE: string = 'router';
  /*
   * The ability name.
   */
  readonly ABILITY_NAME: string = 'MapApplicationAbility';
  /*
   * The message.
   */
  readonly MESSAGE: string = 'add detail';
  /*
   * The width percentage setting.
   */
  readonly FULL_WIDTH_PERCENT: string = '100%';
  /*
   * The height percentage setting.
   */
  readonly FULL_HEIGHT_PERCENT: string = '100%';

  build() {
    Row() {
      Column() {
        Text(this.routerDetail)
          .fontSize($r('app.float.font_size'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.item_title_font'))

        Flex({
          justifyContent: FlexAlign.SpaceBetween,
          wrap: FlexWrap.Wrap
        }){
          Button('主页').onClick(() => {
            postCardAction(this, {
              action: this.ACTION_TYPE,
              abilityName: this.ABILITY_NAME,
              params: {
                targetPage: 'Index'
              }
            })
          })
          Button('数据').onClick(() => {
            postCardAction(this, {
              action: this.ACTION_TYPE,
              abilityName: this.ABILITY_NAME,
              params: {
                targetPage: 'DataPage'
              }
            })
          })

          Button('router更新').onClick(() => {
            postCardAction(this, {
              action: this.ACTION_TYPE,
              abilityName: this.ABILITY_NAME,
              params: {
                routerDetail: 'RouterFromCard',
              }
            })
          })

          Button('message更新').onClick(() => {
            postCardAction(this, {
              action: 'message',
              params: { msgTest: 'messageEvent' }
            });

              // 可以实现拉起ability
              postCardAction(this, {
                action: this.ACTION_TYPE,

                // ability名字
                abilityName: this.ABILITY_NAME,

                // 传递的参数
                params: {
                  message: this.MESSAGE
                }
              });
          })
        }.width('100%')
      }
      .width(this.FULL_WIDTH_PERCENT)
    }
    .height(this.FULL_HEIGHT_PERCENT)
    // 这里的图片不能是用网络图片
    // .backgroundImage('https://img1.baidu.com/it/u=1957757615,826252576&fm=253&fmt=auto&app=120&f=JPEG?w=1280&h=800')
    .backgroundImage($r('app.media.yuan'))
    .backgroundImageSize(ImageSize.Cover)
    // .onClick(() => {
    //   // 可以实现拉起ability
    //   postCardAction(this, {
    //     action: this.ACTION_TYPE,
    //
    //     // ability名字
    //     abilityName: this.ABILITY_NAME,
    //
    //     // 传递的参数
    //     params: {
    //       message: this.MESSAGE
    //     }
    //   });
    // })
  }
}
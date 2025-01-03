import { TopBarNav } from '../commons/TopBarNav';
import { formatDate } from '../utils/date';
import { IMessage } from '../viewModel/messageModel';

class LoremGenerator {
  private static readonly CHINESE_TEXTS: string[] = [
    '人生若只如初见',
    '春风十里不如你',
    '岁月静好，现世安稳',
    '温柔且长情',
    '山有木兮木有枝',
    '长风破浪会有时',
    '众里寻他千百度',
    '蓦然回首，那人却在灯火阑珊处'
  ]

  private static readonly PUNCTUATIONS: string[] = ['，', '。', '！', '？', '；']

  // 生成随机段落
  static generateParagraph(sentenceCount: number = 5): string {
    let result: string = ''

    for (let i = 0; i < sentenceCount; i++) {
      // 随机选择一句话
      const randomText = LoremGenerator.CHINESE_TEXTS[Math.floor(Math.random() * LoremGenerator.CHINESE_TEXTS.length)]
      // 随机选择标点
      const randomPunctuation = LoremGenerator.PUNCTUATIONS[Math.floor(Math.random() * LoremGenerator.PUNCTUATIONS.length)]

      result += randomText + randomPunctuation
    }

    return result
  }

  // 生成多个段落
  static generateArticle(paragraphCount: number = 3): string {
    let result: string[] = []

    for (let i = 0; i < paragraphCount; i++) {
      result.push(LoremGenerator.generateParagraph())
    }

    return result.join('\n\n')
  }
}

@Entry
@Component
struct MessagePage {
  @State messageList: IMessage[] = [];
  @State textMessage: string = ''
  aboutToAppear(): void {
    this.messageList = [{
      text: '您好，当前定位准确吗？',
      time: '10:32',
      date: '2025-01-02',
      userId: 1,
      id: 1
    }, {
      text: '定位准确无误',
      time: '10:33',
      date: '2025-01-02',
      userId: 2,
      id: 2
    }, {
      text: '您好，过来时请靠着路边停车？',
      time: '10:33',
      date: '2025-01-02',
      userId: 2,
      id: 3
    }, {
      text: '好的',
      time: '10:34',
      date: '2025-01-02',
      userId: 1,
      id: 4
    }, {
      text: '还有过来没看到人就名号两下',
      time: '10:36',
      date: '2025-01-02',
      userId: 2,
      id: 5
    }]
  }

  @Builder messageItem(str: string, isMy: boolean) {
    Column(){
      Text(str).backgroundColor('#F1F1F1').padding(10).borderRadius({
        topLeft: 10,
        topRight: 10,
        bottomLeft:isMy ? 10 : 0 ,
        bottomRight: isMy ? 0 : 10
      })
      Column().width(0).height(0)
        .border({
          width: 20,
          color: {
            left: isMy ? Color.Transparent : '#F1F1F1',
            right:isMy ? '#F1F1F1' :  Color.Transparent,
            top: Color.Transparent,
            bottom: Color.Transparent,
          }
        }).margin({
        top: -20
      })

    }.justifyContent(isMy ? FlexAlign.Start :  FlexAlign.End)
    .alignItems(isMy ? HorizontalAlign.End: HorizontalAlign.Start)
    .width('100%')
    .padding({left: 20, right: 20})

  }

  build() {
    Flex({
      direction: FlexDirection.Column
    }){
      Column(){
        TopBarNav({
          title: '消息'
        })
      }
      Column(){
        List(){
          ForEach(this.messageList, (item: IMessage, index: number) =>{
            if(index === 0 ){
              ListItem(){
                Text(item.time).width('100%').textAlign(TextAlign.Center).fontColor('#999999')
              }
            }
            ListItem(){
              this.messageItem(item.text, item.userId === 2)
            }.width('100%')
          }, (item: IMessage) => item.id.toString())
        }.height('100%')
      }.flexGrow(1)

      Column(){
        Flex({
          alignItems: ItemAlign.Center
        }){
          TextArea({
            placeholder: '请输入文字内容',
            text: $$this.textMessage
          }).flexGrow(1).backgroundColor(Color.Transparent)
          Button('发送').flexShrink(1).width(80).height(50)
            .type(ButtonType.Normal).backgroundColor('#99DC64')
            .borderRadius(10).fontSize(18).padding({top: 0, bottom: 0})
            .onClick(() => {
              this.messageList.push({
                text: this.textMessage,
                time: formatDate(new Date(), 'hh:mm'),
                date: formatDate(new Date(), 'YYYY-MM-DD'),
                userId: 2,
                id: this.messageList[this.messageList.length - 1].id + 1
              })
              this.textMessage = ''

              setTimeout(() => {
                this.messageList.push({
                  text:  LoremGenerator.generateArticle(1),
                  time: formatDate(new Date(), 'hh:mm'),
                  date: formatDate(new Date(), 'YYYY-MM-DD'),
                  userId: 1,
                  id: this.messageList[this.messageList.length - 1].id + 1
                })
              }, 1000)
            })
        }
        .width('100%')
        .borderRadius(10)
        .backgroundColor('#F1F1F1')
        .padding(5)
      }.width('100%')
      .padding({
        left: 20,
        right: 20,
        top: 10
      })
    }
    .height('100%')
    .width('100%')
  }
}
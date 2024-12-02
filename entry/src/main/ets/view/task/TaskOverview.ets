import { ETaskState, TaskItem, TaskOverviewItem } from '../../viewmodel/task'
import { OverviewItem } from './OverviewItem'

@Component
export struct TaskOverview{

  @Prop  @Watch('change')   list: TaskItem[];
  @State  arr: TaskOverviewItem[] = []
  // @Prop  @Watch('onCountUpdated') list: TaskItem[];
  // 不知道为什么监听找不到onCountUpdated
  // Cannot find name 'onCountUpdated' in struct 'TaskOverview'
  change(){
    this.countUpdated( )
  }
  countUpdated(): void {
    console.log('Watch ===> countUpdated', JSON.stringify(this.list))
    const obj: Record<ETaskState, number>  = {
      [ETaskState.DONE]: 0,
      [ETaskState.UNDONE]: 0,
      [ETaskState.WAIT]: 0,
      [ETaskState.FUTURE]: 0
    }
    this.list.forEach((item) => {
      obj[item.state]++
    })

    console.log('Watch ===> obj', JSON.stringify(obj))

    this.arr =  Object.values(ETaskState).map((item) => new TaskOverviewItem(item, obj[item], ''))
    console.log('Watch ===> obj  this.arr', this.arr[0].num, JSON.stringify(this.arr))

  }

  aboutToAppear(): void {
    // this.countUpdated( )
  }
  build() {
    Row(){
      Text(`${this.arr.length}`)

      if(this.arr.length){
        Text(`${this.arr?.[0]?.num}`)
        Column( {
          space: 10
        }){
          OverviewItem({
            color: this.arr[0].color,
            num: this.arr[1].num,
            title: this.arr[1].title,
          })
          OverviewItem(this.arr[2])
        }.width('48%')

        Column({
          space: 10
        }){
          OverviewItem(this.arr[1])
          OverviewItem(this.arr[3])

        } .width('48%')

      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)


  }
}

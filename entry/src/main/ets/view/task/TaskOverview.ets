import { ETaskState, TaskItem, TaskOverviewItem } from '../../viewmodel/task'
import { OverviewItem } from './OverviewItem'

@Component
export struct TaskOverview{

  @Prop  @Watch('change')   list: TaskItem[];
  @State  arr: TaskOverviewItem[] = []
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

    this.arr =  Object.values(ETaskState).map((item) => new TaskOverviewItem(item, obj[item], ''))
  }

  aboutToAppear(): void {
    this.countUpdated()
  }
  build() {
    Row(){
      if(this.arr.length){
        Column( {
          space: 10
        }){
          OverviewItem({
            color: this.arr[0].color,
            num: this.arr[0].num,
            title: this.arr[0].title,
            h: 150
          })
          OverviewItem({
            color: this.arr[2].color,
            num: this.arr[2].num,
            title: this.arr[2].title,
          })
        }.width('48%')

        Column({
          space: 10
        }){
          OverviewItem({
            color: this.arr[1].color,
            num: this.arr[1].num,
            title: this.arr[1].title,
          })
          OverviewItem({
            color: this.arr[3].color,
            num: this.arr[3].num,
            title: this.arr[3].title,
            h: 150
          })

        } .width('48%')

      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)


  }
}

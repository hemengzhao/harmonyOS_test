/**
 * 约束轮播图的数据格式
 * */
export class  SwipeDataModel {
  id: number = 0
  goods_id: number = 0
  image_src: string = ''
  navigator_url: string = ''
  open_type: string = ''
  createdAt: string = ''
  updatedAt: string = ''
}
/**
 * 约束数据楼层的数据格式
 * */
export class  ActivityDataModel {
  id: number = 0
  name: string = ''
  image_src: string = ''
  navigator_url: string = ''
  open_type: string = ''
  createdAt: string = ''
  updatedAt: string = ''
}

/**
 * 约束数据楼层的数据格式
 * */
export class  ProductDataModel {
  id: string = ''
  add_time: string = ''
  cat_id: string = ''
  cat_one_id: string = ''
  cat_three_id: string = ''
  cat_two_id: string = ''
  goods_big_logo: string = ''
  goods_id: string = ''
  goods_name:string = ''
  goods_number: string = ''
  goods_price: string = ''
  goods_small_logo: string = ''
  goods_weight: string = ''
  hot_number: string = ''
  is_promote: boolean = false
  upd_time: string = ''
}
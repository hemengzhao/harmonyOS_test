export class ProductDetailData {
  id: string = ''
  add_time: string = ''
  cat_id: string = ''
  cat_one_id: string = ''
  cat_three_id: string = ''
  cat_two_id: string = ''
  goods_big_logo: string = ''
  goods_id: string = ''
  goods_name: string = ''
  goods_number: string = ''
  goods_price: string = ''
  goods_small_logo: string[] = []
  goods_weight: string = ''
  hot_number: string = ''
  is_promote: string = ''
  upd_time: string = ''
  evaluate: Evaluate[] = []
}

export class Evaluate {
  userId?: string
  userIcon?: string
  userNumber?: string
  rating?: number
  desc?: string
}


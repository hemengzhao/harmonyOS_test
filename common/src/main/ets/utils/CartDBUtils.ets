import { relationalStore } from "@kit.ArkData";
import { BusinessError } from "@kit.BasicServicesKit";
import {CartModel} from '../viewModel/CartModel'

class  CartDBUtils {
  private rdbStore: relationalStore.RdbStore | null = null

  /**
   * 初始化数据库
   * @param content 上下文
   * @param  tableName  创建表的名字
   * */
  initCartDB(context: Context, tableName: string){

    // (1) 初始化数据库配置
    const STORE_CONFIG :relationalStore.StoreConfig= {
      name: 'myHarmony.db', // 数据库文件名
      securityLevel: relationalStore.SecurityLevel.S3, // 数据库安全级别
      encrypt: false, // 可选参数，指定数据库是否加密，默认不加密
      customDir: 'customDir/subCustomDir', // 可选参数，数据库自定义路径。数据库将在如下的目录结构中被创建：context.databaseDir + '/rdb/' + customDir，其中context.databaseDir是应用沙箱对应的路径，'/rdb/'表示创建的是关系型数据库，customDir表示自定义的路径。当此参数不填时，默认在本应用沙箱目录下创建RdbStore实例。
      isReadOnly: false // 可选参数，指定数据库是否以只读方式打开。该参数默认为false，表示数据库可读可写。该参数为true时，只允许从数据库读取数据，不允许对数据库进行写操作，否则会返回错误码801。
    };

    // (2) 定义sql语句
    // IF NOT EXISTS  如果没有查到数据表就创建
    const SQL_CREATE_TABLE = `CREATE TABLE IF NOT EXISTS ${tableName}
    (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    GOODS_NAME TEXT NOT NULL,
    GOODS_COUNT INTEGER,
    GOODS_BIG_LOGO TEXT,
    GOODS_CODE REAL,
    GOODS_PRICE INTEGER,
    GOODS_CHECKED INTEGER
    )`; // 建表Sql语句，IDENTITY为bigint类型，sql中指定类型为UNLIMITED INT

    // (3) 初始化数据库 异步代码操作
    relationalStore.getRdbStore(context, STORE_CONFIG,(err, store) => {
      if (err) {
        console.error(`获取store失败. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.log('获取rdbStore成功');
      this.rdbStore = store

      // 有了数据库就可以创建表格了
      store.executeSql(SQL_CREATE_TABLE, (error) => {
        if(!error){
          console.log(`${tableName}创建成功`)
        } else {
          console.log(`${tableName}创建失败`)
        }
      })
    })
  }
  /**
   * 添加数据到数据库
   * @param  tableName  创建表的名字
   * @param  value       要添加的数据
   * */
  insertDataDB(tableName: string, value: relationalStore.ValuesBucket){
      if(this.rdbStore !== null){
        this.rdbStore.insert(tableName, value, (err: BusinessError, rowId: number) => {
          if(err){
            console.log(`往${tableName}中添加数据失败}, ${err.code}-- ${err.name}-- ${err.message}`)
            return
          }
          console.log(`往${tableName}中添加数据成功}, rowId: ${rowId}`)
        })
      }
  }

  /**
   * 查询数据
   * @param  column  投影列 ['ID', 'NAME']
   * @param  tableName  创建表的名字
   * */
  async queryDataDB(column: Array<string>, tableName: string, id?: number){
    //   获取要操作的对象
    let predicates1 = new relationalStore.RdbPredicates(tableName);
    if(id){
      // 筛选条件, 选中的指定数据
      predicates1.equalTo('ID', id);
    }

    let carts: Array<CartModel> = [];
    // 查询数据得到是一个结果集
    // 想办法将结果集转化为CartModel
   const resultSet = await (this.rdbStore as relationalStore.RdbStore).query(predicates1, column)
    while (resultSet.goToNextRow()){
       // getColumnIndex找到数据库中指定某一行的列名
       // getString将指定列表的数据获取到
       const id = resultSet.getLong(resultSet.getColumnIndex('ID'))
      const goods_name = resultSet.getString(resultSet.getColumnIndex('GOODS_NAME'))
      const goods_big_logo = resultSet.getString(resultSet.getColumnIndex('GOODS_BIG_LOGO'))
      const goods_code = resultSet.getString(resultSet.getColumnIndex('GOODS_CODE'))
      const goods_price = resultSet.getDouble(resultSet.getColumnIndex('GOODS_PRICE'))
      const goods_count = resultSet.getLong(resultSet.getColumnIndex('GOODS_COUNT'))
      const goods_checked = resultSet.getLong(resultSet.getColumnIndex('GOODS_CHECKED'))

      const temp =new CartModel()
      temp.id = id
      temp.goods_name = goods_name
      temp.goods_big_logo = goods_big_logo
      temp.goods_code = goods_code
      temp.goods_price = goods_price
      temp.goods_count = goods_count
      temp.goods_checked = goods_checked

      carts.push(temp)
    }
    // 释放内存结果集
    resultSet.close()
    return carts
  }
  /**
   * 修改数据
   * @param  tableName  投影列
   * @param  id  修改的商品编号
   * @param  value  修改的字段
   * @returns rows  修改影响行
   * */
  updateById(tableName: string, id: number, value: relationalStore.ValuesBucket){
    //   获取要操作的对象
    let predicates1 = new relationalStore.RdbPredicates(tableName);
    // 筛选条件, 选中的指定数据
    predicates1.equalTo('ID', id);
    if (this.rdbStore !== null) {
      this.rdbStore.update(value, predicates1, (err: BusinessError, rows: number) => {
        if (err) {
          console.error(`修改失败. Code:${err.code}, message:${err.message}`);
          return;
        }
        console.info(`修改成功 rows: ${rows}`);
      })
    }
  }

  /**
 * 删除指定数据
 * @param  tableName   表的名字
 *  @param  id
 * */
 deleteById(tableName: string, id: number){
  //   获取要操作的对象
  let predicates1 = new relationalStore.RdbPredicates(tableName);
   // 筛选条件, 选中的指定数据
   predicates1.equalTo('ID', id);

   if (this.rdbStore !== null) {
     (this.rdbStore as relationalStore.RdbStore).delete(predicates1, (err: BusinessError, rows: number) => {
       if (err) {
         console.error(`删除失败. Code:${err.code}, message:${err.message}`);
         return;
       }
       console.info(`删除成功 rows: ${rows}`);
     })
   }
 }
}

const cartDBUtils = new CartDBUtils()
export  {
  cartDBUtils
}
import { relationalStore } from "@kit.ArkData";

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
   * */
  insertDataDB(tableName: string){

  }

  /**
   * 查询数据
   * @param  column  投影列
   * @param  tableName  创建表的名字
   * */
  queryDataDB(column: Array<string>, tableName: string){

  }

}

const cartDBUtils = new CartDBUtils()
export  {
  cartDBUtils
}
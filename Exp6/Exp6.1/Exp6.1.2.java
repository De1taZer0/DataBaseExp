/*
 本关任务：用 JDBC 编程实现 finance 数据库的连接，并且实现第6小题第一步（银行发售新的理财产品）的插入数据操作。
 第一步： 银行发售新的理财产品。
 2022/12/1日，银行发售1年期的理财产品，编号为4，开始封闭时间2023/1/6，价格为8.0元，状态为0(0表示正常）。
 提示：需要给 finances_product 表插入合适的记录。
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class JDBCTest02 {

    public static void main(String[] args) throws Exception {

        Connection conn = null;
        PreparedStatement prepareStatement = null;

        try {

            // 加载驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 获取连接
            String url = "jdbc:mysql://127.0.0.1:3306/finance?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC";
            String user = "root";
            String password = "123123";
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("数据库连接成功");
            // 获取statement，preparedStatement
            String sql = "insert into finances_product values(4,'aaaa','bbbb','2022/12/1','2023/1/6',8.0,1,0)";
            prepareStatement = conn.prepareStatement(sql);
            // 执行查询
            System.out.println("开始插入数据");
            int ret = prepareStatement.executeUpdate();

            // 处理结果
            if (ret >= 0)
                System.out.format("插入成功(%s条理财产品数据) \n", ret);
            else
                System.out.println("插入失败");

        } catch (Exception ex) {
            System.out.println(ex.toString());
        } finally {
            // 关闭连接，释放资源
            if (prepareStatement != null) {
                prepareStatement.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
}
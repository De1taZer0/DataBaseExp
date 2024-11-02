/*
 本关任务：
 用 JDBC编程实现 finance 数据库的连接，
 并且实现查询卡号为 6222021302020000002 的银行卡的基本信息，
 包括卡号 b_number,持卡人 c_name, 卡类型 b_type, 余额 b_balance。
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JDBCTest01 {

    public static void main(String[] args) throws Exception {

        Connection conn = null;
        PreparedStatement prepareStatement = null;
        ResultSet rs = null;

        try {
            // 加载驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 获取连接
            String url = "jdbc:mysql://127.0.0.1:3306/finance?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC";
            String user = "root";
            String password = "123123";
            conn = DriverManager.getConnection(url, user, password);
            // 获取statement，preparedStatement
            String sql = "select * from bank_card, customer where b_number = ? and c_id = b_c_id";
            prepareStatement = conn.prepareStatement(sql);
            // 设置参数
            prepareStatement.setString(1, "6222021302020000002");
            // 执行查询
            rs = prepareStatement.executeQuery();
            // 处理结果集
            System.out.println("卡号:" + "6222021302020000002");
            while (rs.next()) {
                System.out.println("持卡人:" + rs.getString("c_name"));
                System.out.println("卡类型:" + rs.getString("b_type"));
                System.out.println("余额:" + rs.getString("b_balance"));
            }
        } catch (Exception ex) {
            System.out.println(ex.toString());
        } finally {
            // 关闭连接，释放资源
            if (rs != null) {
                rs.close();
            }
            if (prepareStatement != null) {
                prepareStatement.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
}
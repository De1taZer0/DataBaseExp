/*
 本关任务：用 JDBC 编程实现 finance 数据库的连接，并且实现第6小题第二步（客户购买4号理财产品，注意购买并从对应的银行卡扣钱），本关需要在JDBC的Java程序中调用事先已经创建好的存储过程 buy_fp 。
 本关只需要调用存储过程buy_fp实现：
 2023/1/5 13:00:00： 客户 3 用银行卡 '6222021302020000002' 购买了 1000 份 4 号理财产品。
 */

import com.mysql.cj.exceptions.CJException;
import com.mysql.cj.jdbc.exceptions.SQLExceptionsMapping;

import java.sql.*;
import java.text.SimpleDateFormat;

public class JDBCTest03 {

    public static void main(String[] args) throws Exception {

        Connection conn = null;
        PreparedStatement prepareStatement = null;
        CallableStatement cStmt = null;
        boolean suss = false;

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
            String sql = "{call buy_fp(?, ?, ?, ?, ?)}";
            prepareStatement = conn.prepareCall(sql);
            // 执行存储过程
            //设置参数
            prepareStatement.setInt(1, 3);
            prepareStatement.setInt(2, 4);
            prepareStatement.setInt(3, 1000);
            prepareStatement.setTimestamp(4, new Timestamp(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").parse("2023/1/5 13:00:00").getTime()));
            prepareStatement.setString(5, "6222021302020000002");

            //方法1：executeUpdate() 方法
            System.out.format("开始购买理财产品, 顾客:%s, 理财产品:%s，数量：%s, 卡号:%s, 购买时间:%s \n",
                    3, 4, 1000, "6222021302020000002", "2023/10/15 15:00:00");
            //执行
            int ret = prepareStatement.executeUpdate();
            if (ret >= 0)
                System.out.println("购买成功");
            else
                System.out.println("购买失败");



        } catch (Exception ex) {
            System.out.println("购买失败：" + ex.getMessage());
        } finally {
            // 关闭连接，释放资源
            if (cStmt != null) {
                cStmt.close();
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
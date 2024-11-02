/*
 本关任务：
 随着业务增加，人们对基金查询的需求大幅度增加。为了提高查询速度，在基金购买表（ c_fund ）上创建复合索引（ IX_ciq ）：c_id ASC , f_id ASC , f_quantity  DESC 。
 */

create index IX_ciq on c_fund(c_id, f_id, f_quantity desc);

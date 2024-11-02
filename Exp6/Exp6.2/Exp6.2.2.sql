/*
 本关任务：根据具体的业务需要添加相关数据约束。
 在银行卡表，理财产品购买表，保险购买表，基金购买表中，
 添加正确的外键约束：客户编号设置为外键，参照客户表的客户编号；
 理财产品编号，保险编号，基金编号分别参照对应的表中的编号；
 支付银行卡号参考银行卡表的卡号;

 在以上基本表中，存在金额或者价格相关的6个属性。
 在现实生活中，金额或者价格不会存在负数。因此针对这些属性，添加其值大于0的约束条件。
 注意，对于银行卡是“信用卡”的情况余额可以为负，所以不要设定余额大于0的约束。
 */
/*
 添加对表的外键约束:
 （1）bank_card 表的命名约束 fk_bc_cid ，外键 b_c_id 参照  customer 表的 c_id；
 （2）c_finances 表的命名约束 fk_cf_cid ，外键 c_id 参照 customer 表的c_id；
 c_finances 表的命名约束 fk_cf_pid ，外键 p_id 参照 finances_product 表的 p_id；
 c_finances 表的命名约束 fk_cf_bcid ，外键 b_number 参照 bank_card 表的 b_number。
 （3）c_insurance 表的命名约束 fk_ci_cid ，外键 c_id 参照 customer 表的 c_id；
 c_insurance 表的命名约束 fk_ci_iid ，外键 i_id 参照 insurance 表的 i_id；
 c_insurance 表的命名约束 fk_ci_bcid ，外键 b_number 参照 bank_card 表的 b_number 。
 （4）c_fund 表的命名约束 fk_cfn_cid ，外键 c_id 参照 customer 表的 c_id；
 c_fund 表的命名约束 fk_cfn_pid ，外键 f_id 参照 fund 表的 f_id ；
 c_fund 表的命名约束 fk_cfn_bcid ，外键 b_number 参照 bank_card 表的 b_number 。
 添加金额或价格相关属性的约束
 为表 finances_product 添加对金额 p_price 的命名约束 ck_pp_gzero；
 为表 insurance 添加对金额 i_price 的命名约束 ck_ip_gzero；
 为表 fund 添加对金额 f_price 命名约束 ck_fp_gzero；
 为表 c_finances 添加对金额 p_income 的命名约束 ck_pi_gzero；
 为表 c_insurance 添加对金额 i_income 的命名约束 ck_ii_gzero；
 为表 c_fund 添加对金额 f_income 的命名约束 ck_fi_gzero。
 */
alter table bank_card
add constraint fk_bc_cid foreign key (b_c_id) references customer(c_id);

alter table c_finances
add constraint fk_cf_cid foreign key (c_id) references customer(c_id),
add constraint fk_cf_pid foreign key (p_id) references finances_product(p_id),
add constraint fk_cf_bcid foreign key (b_number) references bank_card(b_number);

alter table c_insurance
add constraint fk_ci_cid foreign key (c_id) references customer(c_id),
add constraint fk_ci_iid foreign key (i_id) references insurance(i_id),
add constraint fk_ci_bcid foreign key (b_number) references bank_card(b_number);

alter table c_fund
add constraint fk_cfn_cid foreign key (c_id) references customer(c_id),
add constraint fk_cfn_pid foreign key (f_id) references fund(f_id),
add constraint fk_cfn_bcid foreign key (b_number) references bank_card(b_number);

alter table finances_product
add constraint ck_pp_gzero check (p_price >= 0);

alter table insurance
add constraint ck_ip_gzero check (i_price >= 0);

alter table fund
add constraint ck_fp_gzero check (f_price >= 0);

alter table c_finances
add constraint ck_pi_gzero check (p_income >= 0);

alter table c_insurance
add constraint ck_ii_gzero check (i_income >= 0);

alter table c_fund
add constraint ck_fi_gzero check (f_income >= 0);

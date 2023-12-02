package dao.admin;

import context.DBContext;
import entity.Discount;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class DiscountDAO {
    public static List<Discount> getListDiscount(){
        Jdbi me = DBContext.me();
        String query = "SELECT id,nameDiscount,description,codeDiscount,percentage,quantity,startTime,endTime,status,createAt,updateAt FROM discounts where isDelete = 0;";
        return me.withHandle(handle -> handle.createQuery(query).mapToBean(Discount.class).list());
    }
    public static Discount getDiscountById(String id){
        Jdbi me = DBContext.me();
        String query = "SELECT id,nameDiscount,description,codeDiscount,percentage,quantity,startTime,endTime,status,createAt,updateAt FROM discounts where isDelete = 0 and id =?;";
        return me.withHandle(handle -> handle.createQuery(query).bind(0,id).mapToBean(Discount.class).findFirst().orElse(null));
    }
    public static boolean updateDiscount(Discount discount){
        Jdbi me = DBContext.me();
        String query = "update discounts set nameDiscount= ?,description= ?,codeDiscount= ?,percentage= ?,quantity= ?,startTime= ?,endTime= ?,status= ? where id = ?";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0,discount.getNameDiscount()).bind(1,discount.getDescription()).bind(2,discount.getCodeDiscount()).bind(3,discount.getPercentage()).bind(4,discount.getQuantity()).bind(5,discount.getStartTime()).bind(6,discount.getEndTime()).bind(7,discount.getStatus()).bind(8,discount.getId()).execute()==1);
    }
    public static boolean insertDiscount(Discount discount){
        Jdbi me = DBContext.me();
        String query = "insert into discounts (nameDiscount, description, codeDiscount, percentage, quantity, startTime, endTime, status,isDelete) values (?, ?, ?, ?, ?, ?, ?, ?,0)";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, discount.getNameDiscount()).bind(1, discount.getDescription()).bind(2, discount.getCodeDiscount()).bind(3, discount.getPercentage()).bind(4, discount.getQuantity()).bind(5, discount.getStartTime()).bind(6, discount.getEndTime()).bind(7, discount.getStatus()).execute() == 1);
    }
    public static boolean deleteDiscount(String id){
        Jdbi me = DBContext.me();
        String query = "update discounts set isDelete = 1 where id = ?";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0,id).execute()==1);
    }

    public static void main(String[] args) {
        System.out.println(getDiscountById("1"));
    }
 }

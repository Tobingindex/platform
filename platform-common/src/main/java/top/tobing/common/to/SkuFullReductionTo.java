package top.tobing.common.to;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

/**
 * @Author tobing
 * @Date 2021/3/9 16:15
 * @Description 用于远程调用间传输信息：满减、优惠等
 */
@Data
public class SkuFullReductionTo implements Serializable {
    /**
     * 满打折：满 fullCount 打 discount 折
     */
    private Integer fullCount;
    /**
     * 满打折：满 fullCount 打 discount 折
     */
    private BigDecimal discount;
    /**
     * 优惠是否可叠加
     */
    private int countStatus;
    /**
     * 满减：满 fullPrice 减去 reducePrice
     */
    private BigDecimal fullPrice;
    /**
     * 满减：满 fullPrice 减去 reducePrice
     */
    private BigDecimal reducePrice;
    /**
     * 优惠是否可叠加
     */
    private int priceStatus;
    /**
     * 不同类型的会员价格
     */
    private List<MemberPrice> memberPrice;

    public Integer getFullCount() {
        return fullCount;
    }

    public void setFullCount(Integer fullCount) {
        this.fullCount = fullCount;
    }

    public BigDecimal getDiscount() {
        return discount;
    }

    public void setDiscount(BigDecimal discount) {
        this.discount = discount;
    }

    public int getCountStatus() {
        return countStatus;
    }

    public void setCountStatus(int countStatus) {
        this.countStatus = countStatus;
    }

    public BigDecimal getFullPrice() {
        return fullPrice;
    }

    public void setFullPrice(BigDecimal fullPrice) {
        this.fullPrice = fullPrice;
    }

    public BigDecimal getReducePrice() {
        return reducePrice;
    }

    public void setReducePrice(BigDecimal reducePrice) {
        this.reducePrice = reducePrice;
    }

    public int getPriceStatus() {
        return priceStatus;
    }

    public void setPriceStatus(int priceStatus) {
        this.priceStatus = priceStatus;
    }

    public List<MemberPrice> getMemberPrice() {
        return memberPrice;
    }

    public void setMemberPrice(List<MemberPrice> memberPrice) {
        this.memberPrice = memberPrice;
    }
}

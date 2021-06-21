package top.tobing.platform.product.vo;

import lombok.Data;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/9 19:14
 * @Description
 */
@Data
public class Catalog2Vo {

    private String catalog1Id;
    private String id;
    private String name;
    private List<Catalog3Vo> catalog3List;

    public Catalog2Vo() {
    }

    public Catalog2Vo(String catalog1Id, String id, String name, List<Catalog3Vo> catalog3List) {
        this.catalog1Id = catalog1Id;
        this.id = id;
        this.name = name;
        this.catalog3List = catalog3List;
    }
}

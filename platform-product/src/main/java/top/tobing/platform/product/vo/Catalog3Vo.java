package top.tobing.platform.product.vo;

import lombok.Data;

/**
 * @Author tobing
 * @Date 2021/4/9 19:16
 * @Description 三级分类Vo
 */

@Data
public class Catalog3Vo {

    private String catalog2Id;
    private String id;
    private String name;

    public Catalog3Vo() {
    }

    public Catalog3Vo(String catalog2Id, String id, String name) {
        this.catalog2Id = catalog2Id;
        this.id = id;
        this.name = name;
    }
}

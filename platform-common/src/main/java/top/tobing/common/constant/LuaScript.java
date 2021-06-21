package top.tobing.common.constant;

/**
 * @Author tobing
 * @Date 2021/4/24 17:15
 * @Description 操作Redis的Lua脚本
 */
public class LuaScript {

    // 原子性比较 KEYS[1] 与 ARGV[1]，相同则删除，返回1，否则返回0；
    public static final String REDIS_ATOMIC_COMPARE_AND_DELETE =
            "if redis.call('get',KEYS[1]) == ARGV[1] then\n" +
                    "    return redis.call('del', KEYS[1])\n" +
                    "else\n" +
                    "    return 0\n" +
                    "end";

}

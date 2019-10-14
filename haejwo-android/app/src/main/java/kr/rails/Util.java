package kr.rails;

public class Util {
    public static Util util;
    private static boolean ignorePushFlag = false;

    public static Util getInstance(){
        if(util == null) {
            util = new Util();
        }
        return util;
    }

    boolean getIgnorePushFlag() {
        return ignorePushFlag;
    }

    void setIgnorePushFlag(boolean flag) {
        Util.ignorePushFlag = flag;
    }
}

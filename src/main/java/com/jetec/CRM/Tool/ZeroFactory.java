package com.jetec.CRM.Tool;

public class ZeroFactory {

    public static ResultBean buildResultBean(Integer code) {
        return new ResultBean(code);
    }

    public static ResultBean buildResultBean(Integer code, String message) {
        return new ResultBean(code, message);
    }

    public static ResultBean buildResultBean(Integer code, String message, Object data) {
        return new ResultBean(code, message, data);
    }


}

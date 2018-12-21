/*! common.js
 * ===============================================
 * 框架共用js封装
 * ===============================================
 *
 * @Author  殷帅
 * @version 1.0.0
 */
var layer_loading;//加载框
var layer_window;//弹出框
var layer_confirm;//询问框

/**
 * 显示加载框
 */
function loading() {
    layer_loading = top.layer.load({
        shade: 0.5
    });
}

/**
 * 关闭加载框
 */
function closeloading() {
    top.layer.close(layer_loading);
}

/**
 * 询问框
 * @param tips
 * @param fun
 */
function confirmx(tips, fun) {
    layer_confirm = top.layer.confirm(tips, {
        btn: ['确定', '取消']
        //按钮
    }, fun, function () {
        layer.close(layer_confirm);
    });
}

/**
 * 打开对话框
 * @param title 标题
 * @param url 地址
 * @param width 宽度
 * @param height 高度
 * @param isMax 是否最大化
 */
function openDialog(title, url, width, height, isMax) {
    layer_window = top.layer.open({
        type: 2,
        area: [width, height],
        title: title,
        maxmin: true, //开启最大化最小化按钮
        content: url,
        btn: ['确定', '关闭'],
        yes: function (index, layero) {
            var iframeWin = layero.find('iframe')[0]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
            iframeWin.contentWindow.doSubmit();
        },
        cancel: function (index) {
            top.layer.close(layer_window);
        }
    });
    if (navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)) {//如果是移动端，直接最大化
        top.layer.full(layer_window);
    } else {
        if (isMax) {
            top.layer.full(layer_window);
        }
    }
}

/**
 * 打开查看对话框
 * @param title
 * @param url
 * @param width
 * @param height
 */
function openDialogView(title, url, width, height, isMax) {
    layer_window = top.layer.open({
        type: 2,
        area: [width, height],
        title: title,
        maxmin: true, //开启最大化最小化按钮
        content: url,
        btn: ['关闭'],
        cancel: function (layer_window) {
            top.layer.close(layer_window);
        }
    });
    if (navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)) {//如果是移动端，直接最大化
        top.layer.full(layer_window);
    } else {
        if (isMax) {
            top.layer.full(layer_window);
        }
    }
}

/**
 * 刷新Iframe
 */
function refreshIframe() {
    var target = top.$(".J_iframe:visible");
    if (target[0] == null || target[0] == 'undefined') {
        parent.location.href = parent.location.href;
    } else {
        var url = target[0].contentWindow.location.href;
        //显示loading提示
        var loading = layer.load();
        target.attr('src', url).load(function () {
            //关闭loading提示
            layer.close(loading);
        });
    }
}

/**
 * 刷新dataTable
 * @param datatableObj
 */
function refreshTable(datatableObj) {
    if (datatable == null || datatable == 'undefined') {//添加、修改
        var target = top.$(".J_iframe:visible");
        if (target[0] == null || target[0] == 'undefined') {
            var datatable = parent.window.datatable;
            datatable.ajax.reload(null, false);
        } else {
            var datatable = target[0].contentWindow.datatable;
            datatable.ajax.reload(null, false);
        }
    } else {//删除
        start = $("#datatable").dataTable().fnSettings()._iDisplayStart;
        total = $("#datatable").dataTable().fnSettings().fnRecordsDisplay();
        if ((total - start) == 1) {
            if (start > 0) {
                $("#datatable").dataTable().fnPageChange('previous', true);
            }
        }
        datatableObj.ajax.reload(null, false);
    }
}


/**
 * ajax session失效
 */
$.ajaxSetup({
    complete: function (XMLHttpRequest, textStatus) {
        if (XMLHttpRequest.getResponseHeader('Session-Status') == 'timeout') {
            top.layer.msg("登陆超时！请重新登陆！");
            setTimeout(function () {
                top.location.href = top.location.href;
            }, 1000);
        } else if (textStatus == "parsererror") {
            top.layer.msg("JSON解析错误！");
        }
    }
});

/**
 * pace监听ajax
 * 使用前一定要先引入pace.min.js
 */
$(document).ajaxStart(function () {
    Pace.restart();
});

/**
 * 转驼峰
 * @param str
 * @returns {XML|string|*|void}
 */
function underline2Camel(str) {
    var re = /-(\w)/g;
    return str.replace(re, function ($0, $1) {
        return $1.toUpperCase();
    });
}

/**
 * 转下划线
 * @param str
 * @returns {string|*}
 */
function  camel2Underline(str) {
    str = str.replace(/([A-Z])/g,"_$1").toLowerCase();
    return str;
}

/**
 * null 返回 ""
 * @param str
 * @returns {*}
 */
function isNull(str) {
    if (str == null || str == 'null') {
        return "";
    } else {
        return str;
    }
}

/**
 * js获取basePath
 * @returns {string}
 */
function getBasePath() {
    var local = window.location;
    var contextPath = local.pathname.split("/")[1];
    var basePath = local.protocol + "//" + local.host + "/" + contextPath+ "/";
    console.log(basePath);
    return basePath;
}
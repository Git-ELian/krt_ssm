/**
 * Created by Administrator on 2017/10/11 0011.
 */

/**
 * icheck初始化
 */
$(document).ready(function () {
    $('.i-checks').iCheck({
        checkboxClass: 'icheckbox_minimal-blue',
        radioClass: 'iradio_minimal-blue'
    });
});

/**
 * dataTable全选
 */
function checkAll() {
    $("#checkAll").iCheck('uncheck');
    $(".iCheck").unbind();
    $('.iCheck').iCheck({
        checkboxClass: 'icheckbox_minimal-blue',
        radioClass: 'iradio_minimal-blue'
    });
    $("#checkAll").on('ifChecked', function (event) {
        $(".check").iCheck('check');
    }).on('ifUnchecked', function (event) {
        $(".check").iCheck('uncheck');
    });
}

/**
 * 获取复选的ids
 * @returns {string}
 */
function getIds(){
    var ids= '';
    $(".check").each(function () {
        if ($(this).prop("checked")) {
            ids = ids + ($(this).val()) + ","
        }
    });
    return ids;
}

/**
 * 获取点击的属性
 */
function getCheckAttrs(){
    $(".check").each(function () {
        if ($(this).prop("checked")) {
            ids = ids + ($(this).val()) + ","
        }
    });
}

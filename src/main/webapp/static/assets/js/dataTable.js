/**
 * dataTable全局默认配置
 */
$.extend( $.fn.dataTable.defaults, {
    "dom": 'rt<"dataTables_page"<"col-sm-6 col-xs-12"il><"col-sm-6 col-xs-12"p>>',
    "lengthChange": true,//选择lenth
    "autoWidth": false,//自动宽度
    "searching": false,//搜索
    "processing": false,//loding
    "serverSide": true,//服务器模式
    "ordering": false,//排序
    "aLengthMenu": [ 10, 25, 50, 100 ], //可以切换的每页显示条数
    "pageLength": 10,//初始化lenth
    "deferRender": true,//延迟加载
    "oLanguage": {
        "sProcessing":   "处理中...",
        "sLengthMenu":   "每页显示 _MENU_ 条结果",
        "sZeroRecords":  "没有匹配结果",
        "sInfo":         "显示第 _START_ 至 _END_ 条结果，共 _TOTAL_ 条,",
        "sInfoEmpty":    "显示第 0 至 0 结果,共 0 条,",
        "sInfoFiltered": "",
        "sInfoPostFix":  "",
        "sSearch":       "搜索:",
        "sUrl":          "",
        "sEmptyTable":     "表中数据为空",
        "sLoadingRecords": "加载中...",
        "sInfoThousands":  ",",
        "oPaginate": {
            "sFirst":    "首页",
            "sPrevious": "上一页",
            "sNext":     "下一页",
            "sLast":     "末页"
        },
        "oAria": {
            "sSortAscending":  ": 以升序排列此列",
            "sSortDescending": ": 以降序排列此列"
        }
    },
    "fnDrawCallback": function () {
        checkAll();//复选框渲染
    }
} );
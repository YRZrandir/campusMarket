/**
 * 页面内弹出编辑窗口 //需要引入 layui.js layui.css文件
 * @param {} title 标题 不显示为false
 * @param {} area 大小 ["400px","500px"] 或者 "400px"--->只设置宽度
 * @param {} path 弹出页面路径
 * @param {} sucFunName 执行保存操作后再弹出页面中的保存方法名称
 * @param {} callBack 执行保存操作之后的其他操作
 * @returns {} 
 */
function openDetial(title, area, path, sucFunName, callBack) {
    layer.open({
        type: 2,
        title: title, //不显示标题栏
        closeBtn: 2,
        area: area,
        shade: 0.8,
        id: (new Date()).valueOf(), //设定一个id，防止重复弹出 时间戳1280977330748
        btn: ['保存', '取消'],
        btnAlign: 'r',
        moveType: 1, //拖拽模式，0或者1
        content: path,
        yes: function (index, layero) {
            var btn = layero.find('.layui-layer-btn').find('.layui-layer-btn0');
            alert("-----");
            try {
                var _ifr = btn[0].parentNode.parentNode.getElementsByClassName("layui-layer-content")[0].children[0].contentWindow ||
                     btn[0].parentNode.parentNode.getElementsByClassName("layui-layer-content")[0].children[0].children[0].contentWindow;
                var func = new Function('_ifr', "return _ifr." + sucFunName + "();");
                var flg = func(_ifr);
                if (flg == false) {
                    return false;
                } else {
                    if (callBack != null) callBack();
                    window.location.reload();
                }
            } catch (ex) {
 
            }
        },
        btn2: function (index, layero) {
        }
    });
}
//
 
 
/**
 * 初始化表格及表格相关的简单操作 //需要引入 layui.js layui.css文件
 * @param {} t  table参数形如 {id:'test',indexName:'ID',heigt:'full-30',url:'Account?GetTableJson|&',page:true,cols:[ { field: 'ID', title: 'ID', width: 80 },]}
 * @param {} editor  编辑方法
 * @param {} deltes 删除方法
 * @param {} read 查看方法
 * @returns {} 
 */
function createTable(t, editor, deltes, read) {
    var bodys = document.getElementsByTagName("body")[0];
    bodys.innerHTML += '<table class="layui-hide" id="test" lay-filter="demo"></' + 'table>' +
						'<script type="text/html" id="barDemo">' +
						'  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</' + 'a>' +
						'  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</' + 'a>' +
						'  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</' + 'a>' +
						'</' + 'script>';
 
    layui.use(['laypage', 'table'], function () {
        var laypage = layui.laypage, //分页
            table = layui.table; //表格
        //执行一个 table 实例
        table.render({
            elem: '#' + (t.id || 'test'),
            id: t.indexName || ID,
            height: t.heigt || 'full-30',
            url: t.url, //数据接口
            page: t.page, //开启分页
            cols: [
                t.cols
            ]
        });
 
        table.on('tool(demo)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data, //获得当前行数据
				layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'detail') {
                if (read != null) read(obj);
            } else if (layEvent === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del(obj); //删除对应行（tr）的DOM结构
                    layer.close(index);
                    //向服务端发送删除指令
                    if (deltes != null) deltes(obj);
                });
            } else if (layEvent === 'edit') {
                editor(obj);
            }
        });
    });
}
<!DOCTYPE html>
<html>
<head>
<%@ page 
language="java" 
pageEncoding="UTF-8"
import="java.util.*,java.net.*,model.product.Product,model.user.User"
%>

<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">

<title>上架商品</title>
<link rel="stylesheet" type="text/css" href="res/static/css/main.css">
<link rel="stylesheet" type="text/css" href="res/layui/css/layui.css">
<script type="text/javascript" src="res/layui/layui.js"></script>
<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.2/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>

</head>
<body>
<%!User me;%>
<%
	me = (User)session.getAttribute("me");
	if(me != null)
		out.println("<div class=\"login\"><a href=\"managePage\">我的小拍</a></div>");
	else {
		out.println("<script>window.location.href=\"index\" </script>");
	}
%>
<div>
    <div class="layui-container" style="width:45%">
        <div>
            <h1 align="center" style="font-family: 华文彩云;font-size: 25px;margin-top: 10px;margin-bottom: 10px">商品上架</h1>
        </div>
        <div class="layui-card"  style="background-color:rgba(210,210,210,0.5) ">
            <div class="layui-card-body">
                <form id="addProductForm" class="layui-form"  action="">
                    <div class="layui-form-item">
                        <div class="layui-input-block" style="margin-left: 10px">
                            <label class="layui-form-label-col" >名字</label>
                            <input type="text" name="name" class="layui-input">
                        </div>

                        <div class="layui-input-block" style="margin-left: 10px">
                            <label class="layui-form-label-col">价格</label>
                            <input type="text" name="price" class="layui-input">
                        </div>

                        <div class="layui-input-block" style="margin-left: 10px">
                            <label class="layui-form-label-col">描述</label>
                            <textarea name="description" required lay-verify="required" placeholder="请输入" class="layui-textarea"></textarea>
                        </div>

                        <div class="layui-input-block" style="margin-left: 10px">
                            <label class="layui-form-label-col">类别</label>
                            <select>
                                <option value="fruit">fruit</option>
                                <option value="weapon">weapon</option>
                            </select>
                        </div>

                        <div class="layui-input-block" style="margin-left: 10px">
                            <label class="layui-form-label-col">图片1</label>
                            <input class="layui-input" type="file" accept=".jpg,.png" name="file" >
                        </div>
                        <div class="layui-input-block" style="margin-left: 10px">
                            <label class="layui-form-label-col">图片2</label>
                            <input class="layui-input" type="file" name="file" >
                        </div>
                        <div class="layui-input-block" style="margin-left: 10px">
                            <label class="layui-form-label-col">图片3</label>
                            <input class="layui-input" type="file" name="file" >
                        </div>
                    </div>

                    <div class="layui-form-item" style="margin-left: 10px">
                        <div class="layui-input-block" style="margin-left:0" >
                            <button  class="layui-btn"  id="addProductButton" lay-submit="" 
                            lay-filter="demo1" onclick="return false"> 确认修改
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
layui.config({
    base: 'res/static/js/util'
}).use(['jquery','form'],function() {
    var $ = layui.$, form = layui.form;
});
$("#addProductButton").click(function() {
	var form = new FormData(document.getElementById("addProductForm"));
	var userId = <%=me.getId()%>;
	var time = new Date().toUTCString();
	form.append("userId", userId);
	form.append("time", time);
	$.ajax({
		url:"/campusMarket/addProduct",
		type:"post",
		data:form,
		processData:false,
		contentType:false,
		success: function(ret) {
			alert("上架成功！")
			window.location.href = "manage";
		},
		error: function(ret) {
			alert("上架失败，请稍后再试");
		}
	})
})
</script>
</body>
</html>
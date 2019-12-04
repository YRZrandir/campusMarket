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

<style>
	.layui-input {
		border-radius:10px;
		font-size: 18px;
		padding: 5px;
		height: 50px;
	}
	.layui-textarea {
		border-radius:10px;
		font-size:15px;
	}
	.layui-input-block {
		margin-top:8px;
		margin-bottom:8px;
	}
	.layui-btn {
		width: 120px;
		height: 50px;
		font-size: 20px;
	}
</style>

</head>
<body>
<%!User me;%>
<%
	me = (User)session.getAttribute("me");
%>
    <div class="header" >
        <div class="headerLayout w1200">
            <div class="headerCon">
                <h1 class="mallLogo">
                    <a href="index" title="校园小拍">
                        <img src="res/static/img/logo.png">
                    </a>
                </h1>
            </div>
            <div class="layui-container">
                <div class=" layui-layout-right">
                    <a href="">
                    <img src=<%=String.format("\"Image/%s\"",me.getIconPath()) %> class="layui-nav-img">
                    <%=me.getName() %>
                    </a>
                </div>
            </div>
        </div>
    </div>
<div>
    <div class="layui-container" style="width:45%;margin-top:40px;">
        <div>
            <h1 align="center" style="font-family: 华文彩云;font-size: 25px;margin-top: 10px;margin-bottom: 10px">商品上架</h1>
        </div>
        <div class="layui-card"  style="background-color:rgba(255, 255, 255, 0.7) ">
            <div class="layui-card-body">
                <form id="addProductForm" class="layui-form">
                    <div class="layui-form-item">
                        <div class="layui-input-block" style="margin-left: 10px">
                            <label class="layui-form-label-col" >商品名称</label>
                            <input type="text" name="name" class="layui-input">
                        </div>

                        <div class="layui-input-block" style="margin-left: 10px">
                            <label class="layui-form-label-col">价格</label>
                            <input type="text" name="price" class="layui-input">
                        </div>

                        <div class="layui-input-block" style="margin-left: 10px">
                            <label class="layui-form-label-col">商品详情</label>
                            <textarea name="description" required lay-verify="required" placeholder="请输入" class="layui-textarea"></textarea>
                        </div>

                        <div class="layui-input-block" style="margin-left: 10px">
                            <label class="layui-form-label-col">类别</label>
                            <select name="directory">
                                <option value="食品">食品</option>
                                <option value="电子">电子</option>
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

                    <div class="layui-form-item" align="center">
                        <div class="layui-input-block" style="margin-left:0" >
                            <button  class="layui-btn"  id="addProductButton" lay-submit="" 
                            lay-filter="demo1" onclick="return false"> 上架商品
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
			window.location.href = "managePage";
		},
		error: function(ret) {
			alert("上架失败，请稍后再试");
		}
	})
})
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="model.user.User,model.product.Product,java.util.Arrays"
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修改商品信息</title>
<link rel="stylesheet" type="text/css" href="res/static/css/main.css">
<link rel="stylesheet" type="text/css" href="res/layui/css/layui.css">
<script type="text/javascript" src="res/layui/layui.js"></script>
<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.2/dist/jquery.min.js"></script>

<%!User me;Product product; %>
<%
	me = (User)request.getAttribute("me");
	product = (Product)request.getAttribute("product");
%>
</head>
<body>
	<div>
		<div class="layui-container" style="width: 45%">
			<div>
				<h1 align="center"
					style="font-family: 华文彩云; font-size: 25px; margin-top: 10px; margin-bottom: 10px">修改商品</h1>
			</div>
			<div class="layui-card"
				style="background-color: rgba(210, 210, 210, 0.5)">
				<div class="layui-card-body">
					<form id="updataProductForm" class="layui-form" action="">
						<div class="layui-form-item">
							<div class="layui-input-block" style="margin-left: 10px">
								<label class="layui-form-label-col">商品名称</label> 
								<input type="text" name="name" class="layui-input" value=<%=product.getName() %>>
							</div>

							<div class="layui-input-block" style="margin-left: 10px">
								<label class="layui-form-label-col">价格</label> <input
									type="text" name="price" class="layui-input" value=<%=product.getPrice() %>>
							</div>

							<div class="layui-input-block" style="margin-left: 10px">
								<label class="layui-form-label-col">商品详情</label>
								<textarea name="description" required lay-verify="required"
									class="layui-textarea"><%=product.getDescription() %></textarea>
							</div>

							<div class="layui-input-block" style="margin-left: 10px">
								<label class="layui-form-label-col">类别</label>
								<select name="directory">
									<%
										String directory = product.getDirectory();
										out.println(String.format("<option value='%s'>%s</option>", directory, directory));
										for(String dir: Product.DIRS) {
											if(!dir.equals(directory)) {
												out.println(String.format("<option value='%s'>%s</option>", dir, dir));
											}
										}
									%>
								</select>
							</div>

							<div class="layui-input-block" style="margin-left: 10px">
								<label class="layui-form-label-col">图片1</label> <input
									type="file" accept=".jpg,.png,.gif" name="file">
							</div>
							<div class="layui-input-block" style="margin-left: 10px">
								<label class="layui-form-label-col">图片2</label> <input
									type="file" accept=".jpg,.png,.gif" name="file">
							</div>
							<div class="layui-input-block" style="margin-left: 10px">
								<label class="layui-form-label-col">图片3</label> <input
									type="file" accept=".jpg,.png,.gif" name="file">
							</div>
						</div>

						<div class="layui-form-item" style="margin-left: 10px;">
							<div class="layui-input-block" style="margin-left: 0px">
								<button class="layui-btn" id="addProductButton" lay-submit=""
									lay-filter="demo1" onclick="return false">修改</button>
								<button class="layui-btn" id="delProductButton"
									lay-filter="demo1">下架</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>

    layui.config({
        base: '../res/static/js/util' //你存放新模块的目录，注意，不是layui的模块目录
    }).use(['jquery','form','layer'],function() {
        var $ = layui.$, layer=layui.layer,form = layui.form;
       $("#delProductButton").click(function () {
           layer.confirm
           (
               '是否下架'
               ,{btn:['确认','再想想']}
               ,function () {
                   var json = JSON.stringify();
                   $.ajax({
                       url:"#",
                       type:"post",
                       data:json,
                       dataType:"json",
                       async:false,
                       success:function(data) {
                           if(data.success){
                               layer.msg('删除成功', {icon: 1});
                           }else{
                               layer.msg('删除失败', {icon: 2});
                           }
                       }
                   })
               }
           )
       })

        $("#addProductButton").click(function() {
            var form = new FormData(document.getElementById("updataProductForm"));
            var time = new Date().toUTCString();
            var userId = <%=me.getId() %>
            var id = <%=product.getId() %>
            form.append("time", time);
            form.append("userId", userId);
            form.append("id", id);
            $.ajax({
                url:"/campusMarket/updateProduct",
                type:"post",
                data:form,
                processData:false,
                contentType:false,
                success: function(ret) {
                    alert("更改成功！");
                    window.location.href = "managePage";
                },
                error: function(ret) {
                	alert("更改失败，请稍后再试");
                }

            })

        })


    })
</script>
</body>
</html>
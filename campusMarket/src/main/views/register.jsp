<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html><head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<title>注册</title>
	<link rel="stylesheet" type="text/css" href="res/static/css/main.css">
	<link rel="stylesheet" type="text/css" href="res/layui/css/layui.css">
	<script type="text/javascript" src="res/layui/layui.js"></script>

	<style>
		body{background: url("res/static/img/th.jpg")}
	</style>
</head>
<body>
<div >
	<div class="layui-container" style="width: 45%;">
		<div class="layui-card" style="margin-top: 50px">

		<div>
			<h3 align="center">注册</h3>
		</div>

			<form id="registerForm" class="layui-form" action="">
				<div class="layui-form-item">


					<div class="layui-input-block"  style="margin: 10px">
						<label  class="layui-form-label">学号</label>
						<input placeholder="userid" type="text" name="id" lay-verify="required" autocomplete="off" class="layui-input">
					</div>


					<div class="layui-input-block"  style="margin: 10px">
						<label class="layui-form-label">姓名</label>
						<input placeholder="name" type="text" name="name" value="" lay-verify="required" autocomplete="off" class="layui-input">
					</div>


					<div class="layui-input-block"  style="margin: 10px">
						<label class="layui-form-label">密码</label>
						<input placeholder="password" type="password" name="password" lay-verify="required" autocomplete="off" class="layui-input">
					</div>


					<div class="layui-input-block"  style="margin: 10px">
						<label class="layui-form-label">性别</label>
						<div class="layui-form">
							<select name="gender" id="gender" lay-filter="myselect">
								<option value="none">未知</option>
								<option value="female">女</option>
								<option value="male">男</option>
							</select>
						</div>
					</div>

					<div class="layui-input-block"  style="margin: 10px">
						<label class="layui-form-label">学校</label>
						<input placeholder="school" type="text" name="school" lay-verify="required" autocomplete="off" class="layui-input">
					</div>



					<div class="layui-input-block"  style="margin: 10px">
						<label class="layui-form-label" >校区</label>
						<input type="text" placeholder="campus" name="campus" value="" lay-verify="required" autocomplete="off" class="layui-input">
					</div>


					<div class="layui-input-block" style="margin: 10px">
						<label class="layui-form-label">电话</label>
						<input type="text" placeholder="telephone" name="telephone" value="" lay-verify="required" autocomplete="off" class="layui-input">
					</div>


					<div class="layui-input-block" style="margin: 10px">
						<label class="layui-form-label">头像</label>
						<input type="file" name="file" lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item"  align="left">

					<button class="layui-btn" style="margin:10px" id="registerButton"
					 value=""  lay-submit="" lay-filter="registerButton" >注册</button>

				</div>

			</form>
		</div>

	</div>
</div>

<script>
	layui.config({
		base: '../res/static/js/util' //你存放新模块的目录，注意，不是layui的模块目录
	})
</script>
<script>
layui.use(['form', 'jquery', 'layer'], function() {
	var form = layui.form;
	var $ = layui.jquery;
	form.on('submit(registerButton)', function() {
		$.ajax({
			url:"/campusMarket/register",
			type:"POST",
			data:new FormData(document.getElementById("registerForm")),
			processData:false,
			contentType:false,
			success: function(ret) {
				if(ret != "fail") {
					window.location.href = "index";
				} else {
					alert("注册错误");
				}
			},
			error: function(ret) {
				alert("注册错误");
			}
		});
		return false;
	});
})
</script>


</div>

</body></html>
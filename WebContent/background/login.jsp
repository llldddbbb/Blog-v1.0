<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<META content="IE=11.0000" http-equiv="X-UA-Compatible">

<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>登录页面</TITLE>
<SCRIPT src="../js/jquery.js" type="text/javascript"></SCRIPT>
<link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" />

<SCRIPT type="text/javascript">
$(function(){
	//得到焦点
	$("#password").focus(function(){
		$("#left_hand").animate({
			left: "150",
			top: " -38"
		},{step: function(){
			if(parseInt($("#left_hand").css("left"))>140){
				$("#left_hand").attr("class","left_hand");
			}
		}}, 2000);
		$("#right_hand").animate({
			right: "-64",
			top: "-38px"
		},{step: function(){
			if(parseInt($("#right_hand").css("right"))> -70){
				$("#right_hand").attr("class","right_hand");
			}
		}}, 2000);
	});
	//失去焦点
	$("#password").blur(function(){
		$("#left_hand").attr("class","initial_left_hand");
		$("#left_hand").attr("style","left:100px;top:-12px;");
		$("#right_hand").attr("class","initial_right_hand");
		$("#right_hand").attr("style","right:-112px;top:-12px");
	});
});
function checkForm(){
	var userName=$("#userName").val();
	var password=$("#password").val();
	if(userName==''||userName==null){
		$("#error").html("用户名不能为空!")
		return false;
	}
	if(password==''||password==null){
		$("#error").html("密码不能为空!")
		return false;
	}
	return true;
}
</SCRIPT>

<META name="GENERATOR" content="MSHTML 11.00.9600.17496">
</HEAD>
<BODY>
	<DIV class="top_div"></DIV>
	<form id="fm" action="${pageContext.request.contextPath }/bloger/login.do" method="post" onsubmit="return checkForm()">
	<DIV
		style="background: rgb(255, 255, 255); margin: -100px auto auto; border: 1px solid rgb(231, 231, 231); border-image: none; width: 400px; height: 200px; text-align: center;">
		<DIV style="width: 165px; height: 96px; position: absolute;">
			<DIV class="tou"></DIV>
			<DIV class="initial_left_hand" id="left_hand"></DIV>
			<DIV class="initial_right_hand" id="right_hand"></DIV>
		</DIV>
		<P style="padding: 30px 0px 10px; position: relative;">
			<SPAN class="u_logo"></SPAN> <INPUT class="ipt" type="text" id="userName" name="userName" placeholder="请输入用户名" value="${userName }">
		</P>
		<P style="position: relative;">
			<SPAN class="p_logo"></SPAN> <INPUT class="ipt" id="password" type="password" name="password" placeholder="请输入密码" value="${password }">
		</P>
		<DIV
			style="height: 50px; line-height: 50px; margin-top: 30px; border-top-color: rgb(231, 231, 231); border-top-width: 1px; border-top-style: solid;">
			<P style="margin: 0px 35px 20px 45px;">
			<SPAN style="float:left;margin-top: -7px"><font id="error" color=red>${error }</font></SPAN> 
				<SPAN style="float: right;"><input type="submit" style="background: rgb(0, 142, 173); padding: 5px 10px; border-radius: 4px; border: 1px solid rgb(26, 117, 152); border-image: none; color: rgb(255, 255, 255); font-weight: bold;" value="登录"/> </SPAN>
			</P>
		</DIV>
	</DIV>
	</form>
</BODY>
</HTML>

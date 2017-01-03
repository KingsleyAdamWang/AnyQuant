$(function () {  //页面加载的操作处理
    //需要做一个针对mid或者password或者again输入的字段丢失焦点的事件处理
    $("#new_mid").on("blur", function () {
        validateMid()
    });
    $("#new_password").on("blur", function () {
        validatePassword()
    });
    $("#again").on("blur", function () {
        validateEqual()
    });
    //对于整个表单需要进行提交前的检查操作
    $("#loginForm").on("submit", function () {
        return validateMid() && validatePassword() && validateAgain();  //验证都通过后可以提交
    });
});

function validateMid() {
    return validateEmpty("new_mid");
}

function validatePassword() {
    return validateEmpty("new_password");
}

function validateAgain() {
    return validateEmpty("again");
}

/**
 * 判断输入元素是否为空，如果为空用过has-error提示错误
 * 在xxSpan中显示为空的错误信息
 * @param eleId
 */
function validateEmpty(eleId) {
    if ($("#" + eleId).val() == "") {  //为空
        $("#" + eleId + "Div").attr("class", "form-group has-error");
        $("#" + eleId + "Span").html("<span class = 'text-danger'>X</span>");
        return false;
    } else {  //不为空
        $("#" + eleId + "Div").attr("class", "form-group has-success");
        $("#" + eleId + "Span").html("<span class = 'text-success'>√</span>");
        return true;
    }
}

/**
 * 判断密码与密码重复的输入是否相同
 * @returns {boolean}
 */
function validateEqual() {
    if ($("#new_password").val() == $("#again").val()) {
        if($("#again").val() != "") {
            $("#againDiv").attr("class", "form-group has-success");
            $("#againSpan").html("<span class = 'text-success'>√</span>");
            return true;
        }else{
            $("#againDiv").attr("class", "form-group has-error");
            $("#againSpan").html("<span class = 'text-danger'>X</span>");
            return false;
        }
    } else {
        $("#againDiv").attr("class", "form-group has-error");
        $("#againSpan").html("<span class = 'text-danger'>密码不相同！</span>");
        return false;
    }
}
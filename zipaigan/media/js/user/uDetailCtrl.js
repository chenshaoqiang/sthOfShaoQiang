/*
* 用户管理--用户详情
* */
mainModule.controller('uDetailCtrl',function($scope,$rootScope,util,httpServices,$state){

    (function initSetting(){

        if( util.getSession("u_Name") && util.getSession("u_account") && util.getSession("u_resTime") ){

            $scope.currentUser={
                "userName":util.getSession("u_Name"),
                "account":util.getSession("u_account"),
                "resTime":parseInt(util.getSession("u_resTime"))
            };

        }else{

            layer.alert("获取用户信息失败！");

        }

        //控制tab标签选中

        if(util.getSession("cur")){

            $scope.cur=util.getSession("cur");

        }else{

            $scope.cur="wks";


        }

        //监听$scope.current
        var watch = $scope.$watch('cur',function(newValue,oldValue, scope){

            util.setSession("cur",newValue);

        });

    })();


});
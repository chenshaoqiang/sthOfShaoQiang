/*
* 主控制器
* */
mainModule.controller('mainCtrl',function($scope,$rootScope,util,$location,$state){
    //主控制器，先于其他控制器

    (function initSetting(){

        //控制左侧菜单栏选中
        $scope.current='';

        if(util.getSession("current")){

            $scope.current=util.getSession("current");

        }else{

            $scope.current='';

        }

        //监听$scope.current
        var watch = $scope.$watch('current',function(newValue,oldValue, scope){

            util.setSession("current",newValue);

        });


    })();

    //监听路由变化,设置对应的面包屑
    $rootScope.$on('$stateChangeSuccess',function(event, toState, toParams, fromState, fromParams){

        //面包屑数值对,只保存需要用于面包屑设置的路由对,按面包屑顺序存值
        var bread=[
            [{'userManager':'用户管理'},{'userManager.uLi':'用户列表'},{'userManager.uDt':'用户详情'}],
            [{'worksManager':'作品管理'},{'worksManager.wList':'作品列表'}],
            [{'customerServiceManager':'客服管理'}],
            [{'systemManager':'系统管理'}]
        ];
        if(toState.name=='userManager'){

            $state.go('userManager.uLi');

        }else if(toState.name=='worksManager'){

            $state.go('worksManager.wList');

        }else if(toState.name=='userManager.uDt'){

            //面包屑点击用户详情
            $state.go('userManager.uDt.' + util.getSession("cur"));

        }

        var path=$location.path();
        var arr=path.split("/");//获取路由组
        var lastState=arr[arr.length-1]; //最后的路由

        if(lastState=='worksManager.sub_ing'){

            bread[1].push({'worksManager.sub_ing':'投稿中的作品'});

        }else if(lastState=='worksManager.sub_success'){

            bread[1].push({'worksManager.sub_success':'投稿成功的作品'});

        }else if(lastState=='worksManager.published'){

            bread[1].push({'worksManager.published':'已发布的作品'});

        }
        //面包屑设置
        $rootScope.breadcrumbs=[];

        $(bread).each(function(){

            var curArr=$(this);
            var curTit=[]; //用于保存面包屑key值组以便循环的时候用于设置

            for(var i=0;i<curArr.length;i++){

                for(key in curArr[i]){

                    curTit[curTit.length]=key;


                    if(lastState=='wks'||lastState=='ucm'||lastState=='ucr'||lastState=='upm'||lastState=='upr'){

                        //用户管理详情Tab部分不做面包屑
                        lastState='userManager.uDt';

                    }

                    if(key==lastState){


                        //获取到当前面包屑的索引值了 --> i

                        for(var j=0;j<=i;j++){

                            $rootScope.breadcrumbs[$rootScope.breadcrumbs.length]={"title":curArr[j][curTit[j]],"state":curTit[j]};

                        }


                        return; //找到对应的面包屑了就中断循环
                    }
                }

            }

        });

    });

    //返回
    $rootScope.goBackState=function(state){

        if(state){

            $state.go(state);

        }

    };


});
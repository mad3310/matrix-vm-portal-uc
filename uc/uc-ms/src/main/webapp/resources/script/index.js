﻿
$(function () {
    // 关闭其它Tab页
    $("#btn_close_other").click(function () {
        var curPanel = $('#tt').tabs('getSelected');
        var curTitle = curPanel.panel('options').title;
        var toClose = new Array();

        var tabs = $('#tt').tabs('tabs');
        for (var i = 0; i < tabs.length; i++) {
            var title = tabs[i].panel('options').title;
            if (title != curTitle && title != "首页") {
                toClose.push(title);
            }
        }

        for (var i in toClose) {
            $('#tt').tabs('close', toClose[i]);
        }
        $('#tt').tabs('select', curTitle);
    });

    // 关闭所有Tab页
    $("#btn_close_all").click(function () {
        var toClose = new Array();

        var tabs = $('#tt').tabs('tabs');
        for (var i = 0; i < tabs.length; i++) {
            var title = tabs[i].panel('options').title;
            if (title != "首页") {
                toClose.push(title);
            }
        }

        for (var i in toClose) {
            $('#tt').tabs('close', toClose[i]);
        }
    });

    //重置用户设置按钮单击事件
    $("#btn_reset_usersetting").click(function () {
        $('#dlg_setUserInfo').dialog('open');
    });
});

//创建页面左侧菜单树
function createMenuTree($menu, url) {
    $menu.tree({
        url: url,
        method: 'get',
        onClick: function (node) {
            var url = node.attributes.path;
            if (node.attributes.isLeaf) {
                addTab(node.text, url, node.attributes.id, true);
            }
        },
        onContextMenu: function (e, node) {
            e.preventDefault();
            $(this).tree('select', node.target);
            curMenuTree = $(this);
            if (node.attributes.isLeaf) {
                $('#mm1').menu('show', {
                    left: e.pageX,
                    top: e.pageY
                });
            }
        }
    });
}

//添加Tab页
function addTab(title, url, id, closable) {
    id = title + id;
    var content = '<iframe ' + 'id=' + id + ' scrolling="auto"  frameborder="0"  src="'
        + url
        + '" style="width:99%;height:99.4%;margin: 0;border: 0 none #FFFFFF; background-color:#FFFFFF;"></iframe>';

    if ($('#tt').tabs('exists', title)) {
        $('#tt').tabs('select', title);
        $("#" + id).attr("src", url);
    } else {

        $('#tt').tabs('add', {
            title: title,
            content: content,
            closable: closable,
            tools: [{
                iconCls: 'icon-mini-refresh',
                handler: function () {
                    $("#" + id).attr("src", $("#" + id).attr("src"));
                }
            }]
        });
    }
}
